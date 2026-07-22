using System;
using System.Collections.Generic;

namespace ReCamp.Domain
{
    public enum ResourceKind { Scrap, Rations, DataFragment }
    public enum FacilityKind { Generator, Workshop, RationStorage }
    public enum RunOutcome { Extracted, Defeated, Expired }

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
            if (facility == FacilityKind.RationStorage) MaxHealth += 10;
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
                if (Kind == FacilityKind.Generator) cost.Add(ResourceKind.Scrap, 10 * (Level + 1));
                if (Kind == FacilityKind.Workshop)
                {
                    cost.Add(ResourceKind.Scrap, 15 * (Level + 1));
                    cost.Add(ResourceKind.DataFragment, 2 * (Level + 1));
                }
                if (Kind == FacilityKind.RationStorage) cost.Add(ResourceKind.Rations, 10 * (Level + 1));
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
