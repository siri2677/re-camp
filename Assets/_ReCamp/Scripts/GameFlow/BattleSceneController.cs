using System.Collections;
using ReCamp.Domain;
using RunOutcome = ReCamp.Domain.RunOutcome;
using RuntimePlayerStats = ReCamp.Player.PlayerStats;
using ReCamp.Camp;
using ReCamp.Combat;
using ReCamp.Runtime;
using ReCamp.Item;
using ReCamp.Player;
using ReCamp.Input;
using UnityEngine;
namespace ReCamp.GameFlow
{
    public sealed class BattleSceneController : MonoBehaviour
    {
        [SerializeField] private int collectedResources;
        [SerializeField] private float autoCompleteAfterSeconds = -1f;
        [SerializeField, Min(1f)] private float explorationDurationSeconds = 300f;
        [SerializeField, Min(1f)] private float timeWarningThresholdSeconds = 60f;
        [SerializeField] private bool explorationTimerEnabled = true;
        [SerializeField, Min(0.1f)] private float manualExtractionHoldSeconds = 1.25f;
        [SerializeField, Min(0f)] private float resolvedReturnDelay = 3f;

        private float elapsedTime;
        private float effectiveExplorationDurationSeconds;
        private float explorationTimeRemaining;
        private float manualExtractionHeldSeconds;
        private Damageable playerHealth;
        private CharacterAbilityController playerAbility;
        private readonly ResourceLedger localRewards = new();
        private BattleInputRouter inputRouter;

        public int CollectedResources => GameManager.Instance == null
            ? collectedResources
            : GameManager.Instance.CurrentRunRewards.Total;

        public bool IsBattleResolved { get; private set; }
        public bool WasVictory { get; private set; }
        public float ReturnCountdown { get; private set; }
        public SkillActivatedEvent LastSkillActivation { get; private set; }
        public BattleResolutionReason ResolutionReason { get; private set; }
        public float ExplorationDuration => effectiveExplorationDurationSeconds > 0f
            ? effectiveExplorationDurationSeconds
            : explorationDurationSeconds;
        public float ExplorationTimeRemaining => explorationTimerEnabled
            ? explorationTimeRemaining
            : float.PositiveInfinity;
        public float ExplorationTimeNormalized => explorationTimerEnabled && ExplorationDuration > 0f
            ? Mathf.Clamp01(explorationTimeRemaining / ExplorationDuration)
            : 1f;
        public bool IsTimeWarning => explorationTimerEnabled && !IsBattleResolved &&
            explorationTimeRemaining <= timeWarningThresholdSeconds;
        public bool IsManualExtractionCharging => !IsBattleResolved && manualExtractionHeldSeconds > 0f;
        public float ManualExtractionProgress => manualExtractionHoldSeconds <= 0f
            ? 0f
            : Mathf.Clamp01(manualExtractionHeldSeconds / manualExtractionHoldSeconds);

        public ResourceLedger CollectedRewards => GameManager.Instance == null
            ? localRewards
            : GameManager.Instance.CurrentRunRewards;

        private void Awake()
        {
            inputRouter = BattleInputRouter.EnsureInstance();
            inputRouter.ExtractStarted += HandleExtractStarted;
            inputRouter.ExtractCancelled += HandleExtractCancelled;
        }

        private void Start()
        {
            var campTimeBonus = CampManager.Instance == null
                ? 0f
                : CampManager.Instance.ExplorationTimeBonusSeconds;
            effectiveExplorationDurationSeconds = Mathf.Max(
                1f,
                explorationDurationSeconds + campTimeBonus);
            explorationTimeRemaining = effectiveExplorationDurationSeconds;
            var playerStats = FindAnyObjectByType<RuntimePlayerStats>();
            playerHealth = playerStats == null ? null : playerStats.Health;
            BindPlayerAbility(playerStats == null ? null : playerStats.Ability);
            if (playerHealth != null)
            {
                playerHealth.Died += HandlePlayerDied;
            }
        }

        private void OnDestroy()
        {
            if (playerHealth != null)
            {
                playerHealth.Died -= HandlePlayerDied;
            }

            if (inputRouter != null)
            {
                inputRouter.ExtractStarted -= HandleExtractStarted;
                inputRouter.ExtractCancelled -= HandleExtractCancelled;
                inputRouter.ResetTransientInput();
            }

            BindPlayerAbility(null);
        }

        private void Update()
        {
            var playerStats = FindAnyObjectByType<RuntimePlayerStats>();
            BindPlayerAbility(playerStats == null ? null : playerStats.Ability);
            if (!IsBattleResolved && explorationTimerEnabled)
            {
                explorationTimeRemaining = Mathf.Max(0f, explorationTimeRemaining - Time.deltaTime);
                if (explorationTimeRemaining <= 0f)
                {
                    BeginResolution(true, BattleResolutionReason.TimeExpired);
                    return;
                }
            }

            if (!IsBattleResolved)
            {
                UpdateManualExtraction();
            }

            if (autoCompleteAfterSeconds <= 0f)
            {
                return;
            }

            elapsedTime += Time.deltaTime;
            if (elapsedTime < autoCompleteAfterSeconds)
            {
                return;
            }

            autoCompleteAfterSeconds = -1f;
            CompleteBattle();
        }

        public void AddCollectedResource(int amount)
        {
            var previousTotal = collectedResources;
            collectedResources = Mathf.Max(0, collectedResources + amount);
            var appliedAmount = collectedResources - previousTotal;
            localRewards.Add(ResourceType.Scrap, appliedAmount);
            GameManager.Instance?.AddRunReward(ResourceType.Scrap, appliedAmount);
        }

        public void SetCollectedResources(int amount)
        {
            collectedResources = Mathf.Max(0, amount);
            var delta = collectedResources - localRewards.Scrap;
            localRewards.Add(ResourceType.Scrap, delta);
        }

        public void CollectResource(ResourceType type, int amount)
        {
            if (amount <= 0)
            {
                return;
            }

            collectedResources += amount;
            localRewards.Add(type, amount);
            GameManager.Instance?.AddRunReward(type, amount);
        }

        public void CompleteBattle()
        {
            if (GameManager.Instance == null)
            {
                return;
            }

            if (ResolutionReason == BattleResolutionReason.None)
            {
                ResolutionReason = BattleResolutionReason.ManualExtraction;
            }

            GameManager.Instance.CompleteRun();
        }

        public void ResolveVictory()
        {
            BeginResolution(true, BattleResolutionReason.Victory);
        }

        public void ResolveDefeat()
        {
            BeginResolution(false, BattleResolutionReason.Defeat);
        }

        public void AbortBattle()
        {
            if (GameManager.Instance == null)
            {
                return;
            }

            var outcome = ResolutionReason == BattleResolutionReason.TimeExpired
                ? RunOutcome.Expired
                : RunOutcome.Defeated;
            GameManager.Instance.FailRun(outcome);
        }

        public void ConfigureExplorationTimer(float durationSeconds, float warningThresholdSeconds = 60f)
        {
            explorationDurationSeconds = Mathf.Max(0.01f, durationSeconds);
            effectiveExplorationDurationSeconds = explorationDurationSeconds;
            timeWarningThresholdSeconds = Mathf.Clamp(
                warningThresholdSeconds,
                0f,
                explorationDurationSeconds);
            explorationTimerEnabled = true;
            explorationTimeRemaining = effectiveExplorationDurationSeconds;
        }

        public void DisableExplorationTimer()
        {
            explorationTimerEnabled = false;
        }

        public void ConfigureResolvedReturnDelay(float delaySeconds)
        {
            resolvedReturnDelay = Mathf.Max(0f, delaySeconds);
        }

        public void ConfigureManualExtraction(float holdSeconds)
        {
            manualExtractionHoldSeconds = Mathf.Max(0.01f, holdSeconds);
            manualExtractionHeldSeconds = 0f;
        }

        public void SetManualExtractionHeld(bool isHeld)
        {
            var router = inputRouter ??= BattleInputRouter.EnsureInstance();
            if (isHeld)
            {
                router.SubmitExtractPressed();
            }
            else
            {
                router.SubmitExtractReleased();
            }
        }

        public void ResolveManualExtraction()
        {
            BeginResolution(true, BattleResolutionReason.ManualExtraction);
        }

        private void BeginResolution(bool victory, BattleResolutionReason reason)
        {
            if (IsBattleResolved)
            {
                return;
            }

            IsBattleResolved = true;
            WasVictory = victory;
            ResolutionReason = reason;
            ReturnCountdown = resolvedReturnDelay;
            StartCoroutine(ReturnAfterResolution());
        }

        private void UpdateManualExtraction()
        {
            if (inputRouter == null || !inputRouter.IsExtractionHeld)
            {
                manualExtractionHeldSeconds = 0f;
                return;
            }

            manualExtractionHeldSeconds = Mathf.Min(
                manualExtractionHoldSeconds,
                manualExtractionHeldSeconds + Time.deltaTime);
            if (manualExtractionHeldSeconds >= manualExtractionHoldSeconds)
            {
                ResolveManualExtraction();
            }
        }

        private IEnumerator ReturnAfterResolution()
        {
            while (ReturnCountdown > 0f)
            {
                ReturnCountdown = Mathf.Max(0f, ReturnCountdown - Time.deltaTime);
                yield return null;
            }

            if (WasVictory && ResolutionReason != BattleResolutionReason.TimeExpired)
            {
                CompleteBattle();
            }
            else
            {
                AbortBattle();
            }
        }

        private void HandleExtractStarted()
        {
            manualExtractionHeldSeconds = 0f;
        }

        private void HandleExtractCancelled()
        {
            manualExtractionHeldSeconds = 0f;
        }
        private void HandleSkillActivated(SkillActivatedEvent activation)
        {
            LastSkillActivation = activation;
        }

        private void BindPlayerAbility(CharacterAbilityController ability)
        {
            if (playerAbility == ability)
            {
                return;
            }

            if (playerAbility != null)
            {
                playerAbility.SkillActivated -= HandleSkillActivated;
            }

            playerAbility = ability;
            LastSkillActivation = null;
            if (playerAbility != null)
            {
                playerAbility.SkillActivated += HandleSkillActivated;
            }
        }

        private void HandlePlayerDied(Damageable _)
        {
            ResolveDefeat();
        }
    }
}
