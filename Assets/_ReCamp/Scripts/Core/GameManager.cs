using System;
using ReCamp.Camp;
using ReCamp.Domain;
using ReCamp.Data;
using ReCamp.GameFlow;
using ReCamp.Item;
using ReCamp.UnityAdapter;
using UnityEngine;

namespace ReCamp.Runtime
{
    public sealed class GameManager : MonoBehaviour
    {
        public static GameManager Instance { get; private set; }

        public event Action<CharacterDefinition> SelectedCharacterChanged;

        public RunState CurrentRunState { get; private set; } = RunState.Lobby;
        public bool HasActiveRun { get; private set; }
        public int LastRunResourceCount { get; private set; }
        public RunOutcome LastRunOutcome { get; private set; } = RunOutcome.Extracted;
        public ResourceLedger CurrentRunRewards { get; private set; } = new();
        public ResourceLedger LastRunRewards { get; private set; } = new();

        private readonly RunSettlementService runSettlement = new();
        private string activeRunId;
        public CharacterId SelectedCharacterId { get; private set; } = CharacterId.Luna;
        public CharacterDefinition SelectedCharacter => CharacterRoster.Get(SelectedCharacterId);

        private void Awake()
        {
            if (Instance != null && Instance != this)
            {
                Destroy(gameObject);
                return;
            }

            Instance = this;
            DontDestroyOnLoad(gameObject);
            if (CampManager.Instance == null)
            {
                gameObject.AddComponent<CampManager>();
            }
        }

        private void OnDestroy()
        {
            if (Instance == this)
            {
                Instance = null;
            }
        }

        public bool SelectCharacter(CharacterId id)
        {
            if (!CharacterRoster.TryGet(id, out var definition))
            {
                return false;
            }

            if (SelectedCharacterId == id)
            {
                return true;
            }

            SelectedCharacterId = id;
            SelectedCharacterChanged?.Invoke(definition);
            return true;
        }

        public CharacterDefinition SelectPreviousCharacter()
        {
            var definition = CharacterRoster.GetPrevious(SelectedCharacterId);
            SelectCharacter(definition.Id);
            return definition;
        }

        public CharacterDefinition SelectNextCharacter()
        {
            var definition = CharacterRoster.GetNext(SelectedCharacterId);
            SelectCharacter(definition.Id);
            return definition;
        }

        public void StartRun()
        {
            CurrentRunState = RunState.Battle;
            HasActiveRun = true;
            activeRunId = Guid.NewGuid().ToString("N");
            LastRunResourceCount = 0;
            CurrentRunRewards = new ResourceLedger();
            SceneLoader.Load(GameScene.Battle);
        }

        public void AddRunReward(ResourceType type, int amount)
        {
            if (HasActiveRun)
            {
                CurrentRunRewards.Add(type, amount);
            }
        }

        public void CompleteRun()
        {
            SettleRun(RunOutcome.Extracted);
        }

        public void FailRun(RunOutcome outcome)
        {
            if (outcome == RunOutcome.Extracted)
            {
                throw new ArgumentException("An extracted run must use CompleteRun.", nameof(outcome));
            }

            SettleRun(outcome);
        }

        public void CompleteRun(int collectedResources)
        {
            CurrentRunRewards = new ResourceLedger();
            CurrentRunRewards.Add(ResourceType.Scrap, Mathf.Max(0, collectedResources));
            CompleteRun();
        }

        private void SettleRun(RunOutcome outcome)
        {
            if (!HasActiveRun || string.IsNullOrEmpty(activeRunId))
            {
                return;
            }

            var command = DomainCampSaveAdapter.ToRunSettlementCommand(
                activeRunId,
                outcome,
                CurrentRunRewards.Scrap,
                CurrentRunRewards.Food,
                CurrentRunRewards.DataFragments);
            var result = runSettlement.Settle(command);
            var depositedRewards = DomainCampSaveAdapter.ToUnityRunRewards(result);

            CurrentRunState = RunState.Result;
            HasActiveRun = false;
            LastRunOutcome = result.Outcome;
            LastRunRewards = new ResourceLedger();
            LastRunRewards.Add(ResourceType.Scrap, depositedRewards.scrap);
            LastRunRewards.Add(ResourceType.Food, depositedRewards.food);
            LastRunRewards.Add(ResourceType.DataFragment, depositedRewards.dataFragments);
            LastRunResourceCount = LastRunRewards.Total;
            if (result.Deposited)
            {
                CampManager.Instance?.Deposit(LastRunRewards);
            }

            activeRunId = null;
            SceneLoader.Load(GameScene.Result);
        }

        public void ReturnToLobby()
        {
            CurrentRunState = RunState.Lobby;
            SceneLoader.Load(GameScene.Lobby);
        }

        public void GoToTitle()
        {
            CurrentRunState = RunState.Title;
            HasActiveRun = false;
            SceneLoader.Load(GameScene.Title);
        }
    }
}
