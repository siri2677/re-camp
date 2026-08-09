using System;
using System.Collections.Generic;

namespace ReCamp.Domain
{
    public enum ResourceKind { Scrap, Rations, DataFragment }
    public enum FacilityKind { Generator, Workshop, RationStorage }
    public enum RunOutcome { Extracted, Defeated, Expired }

    public sealed class RunSettlementCommand
    {
        public RunSettlementCommand(
            string runId,
            RunOutcome outcome,
            IDictionary<ResourceKind, int> rewards)
        {
            if (string.IsNullOrWhiteSpace(runId))
                throw new ArgumentException("A run must have a stable identifier.", nameof(runId));
            if (!Enum.IsDefined(typeof(RunOutcome), outcome))
                throw new ArgumentOutOfRangeException(nameof(outcome));
            if (rewards == null)
                throw new ArgumentNullException(nameof(rewards));

            RunId = runId;
            Outcome = outcome;
            Rewards = new Dictionary<ResourceKind, int>();
            foreach (ResourceKind resource in Enum.GetValues(typeof(ResourceKind)))
            {
                int amount;
                if (!rewards.TryGetValue(resource, out amount) || amount < 0)
                    throw new ArgumentException(
                        "A run must provide non-negative rewards for every resource.",
                        nameof(rewards));
                Rewards.Add(resource, amount);
            }
        }

        public string RunId { get; private set; }
        public RunOutcome Outcome { get; private set; }
        public Dictionary<ResourceKind, int> Rewards { get; private set; }
    }

    public sealed class RunSettlementResult
    {
        internal RunSettlementResult(
            string runId,
            RunOutcome outcome,
            bool applied,
            bool deposited,
            IDictionary<ResourceKind, int> depositedRewards)
        {
            RunId = runId;
            Outcome = outcome;
            Applied = applied;
            Deposited = deposited;
            DepositedRewards = new Dictionary<ResourceKind, int>();
            foreach (ResourceKind resource in Enum.GetValues(typeof(ResourceKind)))
            {
                int amount;
                if (!depositedRewards.TryGetValue(resource, out amount))
                    amount = 0;
                DepositedRewards.Add(resource, amount);
            }
        }

        public string RunId { get; private set; }
        public RunOutcome Outcome { get; private set; }
        public bool Applied { get; private set; }
        public bool Deposited { get; private set; }
        public Dictionary<ResourceKind, int> DepositedRewards { get; private set; }
    }

    public sealed class RunSettlementService
    {
        private readonly HashSet<string> settledRunIds = new HashSet<string>();

        public RunSettlementResult Settle(RunSettlementCommand command)
        {
            if (command == null)
                throw new ArgumentNullException(nameof(command));

            if (!settledRunIds.Add(command.RunId))
            {
                return new RunSettlementResult(
                    command.RunId,
                    command.Outcome,
                    false,
                    false,
                    new Dictionary<ResourceKind, int>());
            }

            var depositedRewards = new Dictionary<ResourceKind, int>();
            foreach (ResourceKind resource in Enum.GetValues(typeof(ResourceKind)))
            {
                depositedRewards.Add(
                    resource,
                    command.Outcome == RunOutcome.Extracted ? command.Rewards[resource] : 0);
            }

            return new RunSettlementResult(
                command.RunId,
                command.Outcome,
                true,
                command.Outcome == RunOutcome.Extracted,
                depositedRewards);
        }
    }

    public enum SkillSlot { Signature, Utility }

    public enum SkillCommandRejection { None, Cooldown }

    public sealed class SkillCommand
    {
        public SkillCommand(SkillSlot slot, float now, float cooldownSeconds)
        {
            if (!Enum.IsDefined(typeof(SkillSlot), slot))
                throw new ArgumentOutOfRangeException(nameof(slot));
            if (float.IsNaN(now) || float.IsInfinity(now) || now < 0f)
                throw new ArgumentOutOfRangeException(nameof(now));
            if (float.IsNaN(cooldownSeconds) || float.IsInfinity(cooldownSeconds) || cooldownSeconds < 0f)
                throw new ArgumentOutOfRangeException(nameof(cooldownSeconds));

            Slot = slot;
            Now = now;
            CooldownSeconds = cooldownSeconds;
        }

        public SkillSlot Slot { get; private set; }
        public float Now { get; private set; }
        public float CooldownSeconds { get; private set; }
    }

    public sealed class SkillCommandResult
    {
        internal SkillCommandResult(
            SkillSlot slot,
            bool accepted,
            SkillCommandRejection rejection,
            float cooldownEndsAt)
        {
            Slot = slot;
            Accepted = accepted;
            Rejection = rejection;
            CooldownEndsAt = cooldownEndsAt;
        }

        public SkillSlot Slot { get; private set; }
        public bool Accepted { get; private set; }
        public SkillCommandRejection Rejection { get; private set; }
        public float CooldownEndsAt { get; private set; }
    }

    public sealed class SkillActivatedEvent
    {
        internal SkillActivatedEvent(SkillSlot slot, float activatedAt, float cooldownEndsAt)
        {
            Slot = slot;
            ActivatedAt = activatedAt;
            CooldownEndsAt = cooldownEndsAt;
        }

        public SkillSlot Slot { get; private set; }
        public float ActivatedAt { get; private set; }
        public float CooldownEndsAt { get; private set; }
    }

    public sealed class SkillCommandProcessor
    {
        private readonly Dictionary<SkillSlot, float> cooldownEndsAt = new Dictionary<SkillSlot, float>();

        public SkillCommandResult TryBegin(SkillCommand command)
        {
            if (command == null)
                throw new ArgumentNullException(nameof(command));

            float existingCooldownEndsAt;
            if (cooldownEndsAt.TryGetValue(command.Slot, out existingCooldownEndsAt) &&
                existingCooldownEndsAt > command.Now)
            {
                return new SkillCommandResult(
                    command.Slot,
                    false,
                    SkillCommandRejection.Cooldown,
                    existingCooldownEndsAt);
            }

            var nextCooldownEndsAt = command.Now + command.CooldownSeconds;
            cooldownEndsAt[command.Slot] = nextCooldownEndsAt;
            return new SkillCommandResult(
                command.Slot,
                true,
                SkillCommandRejection.None,
                nextCooldownEndsAt);
        }

        public float CooldownRemaining(SkillSlot slot, float now)
        {
            float endTime;
            if (!cooldownEndsAt.TryGetValue(slot, out endTime))
                return 0f;
            return Math.Max(0f, endTime - now);
        }

        public void Cancel(SkillSlot slot)
        {
            cooldownEndsAt.Remove(slot);
        }

        public void Reset()
        {
            cooldownEndsAt.Clear();
        }

        public SkillActivatedEvent CreateActivatedEvent(SkillCommand command, SkillCommandResult result)
        {
            if (command == null)
                throw new ArgumentNullException(nameof(command));
            if (result == null)
                throw new ArgumentNullException(nameof(result));
            if (!result.Accepted || result.Slot != command.Slot)
                throw new ArgumentException("Only an accepted matching command can emit an activation event.");

            return new SkillActivatedEvent(command.Slot, command.Now, result.CooldownEndsAt);
        }
    }

    public sealed class ResourceWallet
    {
        private readonly Dictionary<ResourceKind, int> amounts = new Dictionary<ResourceKind, int>();

        public ResourceWallet()
        {
            foreach (ResourceKind resource in Enum.GetValues(typeof(ResourceKind))) amounts.Add(resource, 0);
        }

        public int this[ResourceKind resource] { get { return amounts[resource]; } }

        public void Add(ResourceKind resource, int amount)
        {
            if (amount < 0) throw new ArgumentOutOfRangeException(nameof(amount));
            amounts[resource] += amount;
        }

        public bool TrySpend(IDictionary<ResourceKind, int> cost)
        {
            foreach (KeyValuePair<ResourceKind, int> pair in cost)
            {
                if (pair.Value < 0 || this[pair.Key] < pair.Value) return false;
            }
            foreach (KeyValuePair<ResourceKind, int> pair in cost) amounts[pair.Key] -= pair.Value;
            return true;
        }

        public Dictionary<ResourceKind, int> Snapshot()
        {
            return new Dictionary<ResourceKind, int>(amounts);
        }

        internal void Restore(IDictionary<ResourceKind, int> savedAmounts)
        {
            foreach (ResourceKind resource in Enum.GetValues(typeof(ResourceKind)))
            {
                int amount;
                if (!savedAmounts.TryGetValue(resource, out amount) || amount < 0)
                    throw new ArgumentException("A save must include non-negative values for every resource.", nameof(savedAmounts));
                amounts[resource] = amount;
            }
        }
    }

    public sealed class PlayerStats
    {
        public PlayerStats(int baseMaxHealth, int baseAttack)
        {
            BaseMaxHealth = baseMaxHealth;
            BaseAttack = baseAttack;
            MaxHealth = baseMaxHealth;
            Attack = baseAttack;
        }

        public int BaseMaxHealth { get; private set; }
        public int BaseAttack { get; private set; }
        public int MaxHealth { get; private set; }
        public int Attack { get; private set; }

        public void ApplyFacility(FacilityKind facility)
        {
            if (facility == FacilityKind.Workshop) Attack += 2;
            if (facility == FacilityKind.RationStorage) MaxHealth += 20;
        }
    }

    public sealed class CampFacility
    {
        public CampFacility(FacilityKind kind) { Kind = kind; }
        public FacilityKind Kind { get; private set; }
        public int Level { get; private set; }

        public Dictionary<ResourceKind, int> NextCost
        {
            get
            {
                var cost = new Dictionary<ResourceKind, int>();
                if (Kind == FacilityKind.Generator) cost.Add(ResourceKind.Scrap, 3 + Level * 2);
                if (Kind == FacilityKind.Workshop)
                {
                    cost.Add(ResourceKind.Scrap, 2 + Level * 2);
                    cost.Add(ResourceKind.DataFragment, 1 + Level);
                }
                if (Kind == FacilityKind.RationStorage) cost.Add(ResourceKind.Rations, 3 + Level * 2);
                return cost;
            }
        }

        public void Upgrade() { Level++; }
        internal void RestoreLevel(int level)
        {
            if (level < 0) throw new ArgumentOutOfRangeException(nameof(level));
            Level = level;
        }
    }

    public sealed class GameSaveData
    {
        public const int CurrentVersion = 1;
        public GameSaveData(int version, Dictionary<ResourceKind, int> resources, Dictionary<FacilityKind, int> facilityLevels)
        {
            Version = version;
            Resources = resources;
            FacilityLevels = facilityLevels;
        }

        public int Version { get; private set; }
        public Dictionary<ResourceKind, int> Resources { get; private set; }
        public Dictionary<FacilityKind, int> FacilityLevels { get; private set; }
    }

    public sealed class GameSession
    {
        private readonly Dictionary<FacilityKind, CampFacility> facilities = new Dictionary<FacilityKind, CampFacility>();

        public GameSession()
        {
            foreach (FacilityKind kind in Enum.GetValues(typeof(FacilityKind))) facilities.Add(kind, new CampFacility(kind));
            Player = new PlayerStats(100, 10);
            Resources = new ResourceWallet();
        }

        public PlayerStats Player { get; private set; }
        public ResourceWallet Resources { get; private set; }
        public CampFacility Facility(FacilityKind kind) { return facilities[kind]; }
        public int AttackBonus { get { return Player.Attack - Player.BaseAttack; } }
        public int MaxHealthBonus { get { return Player.MaxHealth - Player.BaseMaxHealth; } }
        public float ExplorationTimeBonusSeconds { get { return Facility(FacilityKind.Generator).Level * 30f; } }
        public bool TryUpgrade(FacilityKind kind)
        {
            CampFacility facility = Facility(kind);
            if (!Resources.TrySpend(facility.NextCost)) return false;
            facility.Upgrade();
            Player.ApplyFacility(kind);
            return true;
        }

        public GameSaveData CreateSave()
        {
            var levels = new Dictionary<FacilityKind, int>();
            foreach (KeyValuePair<FacilityKind, CampFacility> pair in facilities) levels.Add(pair.Key, pair.Value.Level);
            return new GameSaveData(GameSaveData.CurrentVersion, Resources.Snapshot(), levels);
        }

        public static GameSession FromSave(GameSaveData save)
        {
            if (save == null) throw new ArgumentNullException(nameof(save));
            if (save.Version != GameSaveData.CurrentVersion) throw new NotSupportedException("Unsupported domain save version.");
            var session = new GameSession();
            session.Resources.Restore(save.Resources);
            foreach (FacilityKind kind in Enum.GetValues(typeof(FacilityKind)))
            {
                int level;
                if (!save.FacilityLevels.TryGetValue(kind, out level) || level < 0) throw new ArgumentException("A save must include non-negative levels for every facility.", nameof(save));
                session.Facility(kind).RestoreLevel(level);
                for (var index = 0; index < level; index++) session.Player.ApplyFacility(kind);
            }
            return session;
        }
    }
}
