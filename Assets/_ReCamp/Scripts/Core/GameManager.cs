using System;
using ReCamp.Camp;
using ReCamp.Data;
using ReCamp.Domain;
using ReCamp.GameFlow;
using ReCamp.Item;
using UnityEngine;

namespace ReCamp.Runtime
{
    public sealed class GameManager : MonoBehaviour
    {
        public static GameManager Instance { get; private set; }

        public event Action<CharacterDefinition> SelectedCharacterChanged;
        public event Action<RunResolvedEvent> RunResolved;

        public RunState CurrentRunState { get; private set; } = RunState.Lobby;
        public bool HasActiveRun { get; private set; }
        public int CurrentRunId { get; private set; }
        public int LastSettledRunId { get; private set; }
        public int LastRunResourceCount { get; private set; }
        public ResourceLedger CurrentRunRewards { get; private set; } = new();
        public ResourceLedger LastRunRewards { get; private set; } = new();
        public RunResolvedEvent LastRunSettlement { get; private set; }
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
            CurrentRunId = ++nextRunId;
            LastRunResourceCount = 0;
            CurrentRunRewards = new ResourceLedger();
            LastRunSettlement = null;
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
            CompleteRun(BattleResolutionReason.ManualExtraction);
        }

        public void CompleteRun(BattleResolutionReason reason)
        {
            if (!HasActiveRun || CurrentRunId <= 0)
            {
                return;
            }

            var command = new ResolveRunCommand(
                CurrentRunId,
                ToRunOutcome(reason),
                CurrentRunRewards.Scrap,
                CurrentRunRewards.Food,
                CurrentRunRewards.DataFragments);
            var settlement = RunSettlementPolicy.Resolve(command);

            CurrentRunState = RunState.Result;
            HasActiveRun = false;
            LastSettledRunId = settlement.RunId;
            LastRunSettlement = settlement;
            LastRunRewards = ToRuntimeLedger(settlement);
            LastRunResourceCount = LastRunRewards.Total;
            CampManager.Instance?.Deposit(LastRunRewards);
            RunResolved?.Invoke(settlement);
            SceneLoader.Load(GameScene.Result);
        }

        public void CompleteRun(int collectedResources)
        {
            CurrentRunRewards = new ResourceLedger();
            CurrentRunRewards.Add(ResourceType.Scrap, Mathf.Max(0, collectedResources));
            CompleteRun(BattleResolutionReason.ManualExtraction);
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

        private static RunOutcome ToRunOutcome(BattleResolutionReason reason)
        {
            return reason switch
            {
                BattleResolutionReason.Defeat => RunOutcome.Defeated,
                BattleResolutionReason.TimeExpired => RunOutcome.Expired,
                _ => RunOutcome.Extracted,
            };
        }

        private static ResourceLedger ToRuntimeLedger(RunResolvedEvent settlement)
        {
            var ledger = new ResourceLedger();
            ledger.Add(ResourceType.Scrap, settlement.Scrap);
            ledger.Add(ResourceType.Food, settlement.Rations);
            ledger.Add(ResourceType.DataFragment, settlement.DataFragments);
            return ledger;
        }

        private int nextRunId;
    }
}
