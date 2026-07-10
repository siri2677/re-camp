namespace ReCamp.Core;

public enum ResourceType { Scrap, Rations, DataFragment }
public enum FacilityType { Generator, Workshop, RationStorage }
public enum RunState { Lobby, Exploring, Result }

public sealed class ResourceWallet
{
    private readonly Dictionary<ResourceType, int> _amounts = Enum.GetValues<ResourceType>()
        .ToDictionary(resource => resource, _ => 0);

    public int this[ResourceType resource] => _amounts[resource];

    public void Add(ResourceType resource, int amount)
    {
        if (amount < 0) throw new ArgumentOutOfRangeException(nameof(amount));
        _amounts[resource] += amount;
    }

    public bool TrySpend(IReadOnlyDictionary<ResourceType, int> cost)
    {
        if (cost.Any(pair => pair.Value < 0 || this[pair.Key] < pair.Value)) return false;
        foreach (var pair in cost) _amounts[pair.Key] -= pair.Value;
        return true;
    }

    internal IReadOnlyDictionary<ResourceType, int> Snapshot() =>
        new Dictionary<ResourceType, int>(_amounts);

    internal void Restore(IReadOnlyDictionary<ResourceType, int> amounts)
    {
        foreach (var resource in Enum.GetValues<ResourceType>())
        {
            if (!amounts.TryGetValue(resource, out var amount) || amount < 0)
                throw new ArgumentException("A save must include non-negative values for every resource.", nameof(amounts));
            _amounts[resource] = amount;
        }
    }
}

public sealed record PlayerStats(int BaseMaxHealth, int BaseAttack)
{
    public int MaxHealth { get; private set; } = BaseMaxHealth;
    public int Attack { get; private set; } = BaseAttack;

    public void ApplyFacility(FacilityType facility)
    {
        if (facility == FacilityType.Workshop) Attack += 2;
        if (facility == FacilityType.RationStorage) MaxHealth += 10;
    }
}

public sealed record Enemy(string Id, int Health, IReadOnlyDictionary<ResourceType, int> Reward);
public sealed record ExplorationResult(int DefeatedEnemies, IReadOnlyDictionary<ResourceType, int> Rewards);

public sealed class BattleEncounter
{
    private bool _rewardClaimed;

    public BattleEncounter(PlayerStats player, Enemy enemy)
    {
        Enemy = enemy ?? throw new ArgumentNullException(nameof(enemy));
        PlayerHealth = player.MaxHealth;
        EnemyHealth = enemy.Health;
        PlayerAttack = player.Attack;
    }

    public Enemy Enemy { get; }
    public int PlayerHealth { get; private set; }
    public int PlayerAttack { get; }
    public int EnemyHealth { get; private set; }
    public bool IsWon => EnemyHealth == 0;
    public bool IsLost => PlayerHealth == 0;
    public bool IsComplete => IsWon || IsLost;
    internal bool RewardClaimed => _rewardClaimed;

    public void ResolvePlayerAttack(int enemyAttack)
    {
        if (enemyAttack < 0) throw new ArgumentOutOfRangeException(nameof(enemyAttack));
        if (IsComplete) throw new InvalidOperationException("The encounter has already finished.");

        EnemyHealth = Math.Max(0, EnemyHealth - PlayerAttack);
        if (!IsWon) PlayerHealth = Math.Max(0, PlayerHealth - enemyAttack);
    }

    internal void MarkRewardClaimed() => _rewardClaimed = true;
}

public static class MvpEnemies
{
    public static Enemy ScavengerStalker { get; } = new("EN001", 20, new Dictionary<ResourceType, int>
    {
        [ResourceType.Scrap] = 5,
    });

    public static Enemy DashBug { get; } = new("EN002", 12, new Dictionary<ResourceType, int>
    {
        [ResourceType.Scrap] = 3,
        [ResourceType.Rations] = 1,
    });

    public static Enemy SmokeDrone { get; } = new("EN003", 28, new Dictionary<ResourceType, int>
    {
        [ResourceType.Scrap] = 4,
        [ResourceType.DataFragment] = 1,
    });
}

public sealed class CampFacility
{
    public CampFacility(FacilityType type) => Type = type;
    public FacilityType Type { get; }
    public int Level { get; private set; }

    public IReadOnlyDictionary<ResourceType, int> NextCost => Type switch
    {
        FacilityType.Generator => new Dictionary<ResourceType, int> { [ResourceType.Scrap] = 10 * (Level + 1) },
        FacilityType.Workshop => new Dictionary<ResourceType, int> { [ResourceType.Scrap] = 15 * (Level + 1), [ResourceType.DataFragment] = 2 * (Level + 1) },
        FacilityType.RationStorage => new Dictionary<ResourceType, int> { [ResourceType.Rations] = 10 * (Level + 1) },
        _ => throw new InvalidOperationException()
    };

    public void Upgrade() => Level++;

    internal void RestoreLevel(int level)
    {
        if (level < 0) throw new ArgumentOutOfRangeException(nameof(level));
        Level = level;
    }
}

public sealed class GameSession
{
    private readonly Dictionary<FacilityType, CampFacility> _facilities = Enum.GetValues<FacilityType>()
        .ToDictionary(type => type, type => new CampFacility(type));
    private readonly ResourceWallet _runRewards = new();

    public GameSession() => Player = new PlayerStats(BaseMaxHealth: 100, BaseAttack: 10);
    public RunState State { get; private set; } = RunState.Lobby;
    public PlayerStats Player { get; }
    public ResourceWallet Resources { get; } = new();
    public int DefeatedEnemies { get; private set; }
    public ExplorationResult? LatestResult { get; private set; }

    public CampFacility Facility(FacilityType type) => _facilities[type];

    public void StartRun()
    {
        if (State != RunState.Lobby) throw new InvalidOperationException("A run can only start from the lobby.");
        DefeatedEnemies = 0;
        _runRewards.Restore(Enum.GetValues<ResourceType>().ToDictionary(resource => resource, _ => 0));
        LatestResult = null;
        State = RunState.Exploring;
    }

    public void DefeatEnemy(Enemy enemy)
    {
        if (State != RunState.Exploring) throw new InvalidOperationException("Enemies can only be defeated while exploring.");
        foreach (var reward in enemy.Reward)
        {
            Resources.Add(reward.Key, reward.Value);
            _runRewards.Add(reward.Key, reward.Value);
        }
        DefeatedEnemies++;
    }

    public BattleEncounter StartEncounter(Enemy enemy)
    {
        if (State != RunState.Exploring) throw new InvalidOperationException("Encounters can only start while exploring.");
        return new BattleEncounter(Player, enemy);
    }

    public bool TryClaimVictory(BattleEncounter encounter)
    {
        if (State != RunState.Exploring || !encounter.IsWon || encounter.RewardClaimed) return false;
        DefeatEnemy(encounter.Enemy);
        encounter.MarkRewardClaimed();
        return true;
    }

    public ExplorationResult CompleteRun()
    {
        if (State != RunState.Exploring) throw new InvalidOperationException("Only an active run can be completed.");
        State = RunState.Result;
        LatestResult = new ExplorationResult(DefeatedEnemies, _runRewards.Snapshot());
        return LatestResult;
    }

    public void ReturnToLobby()
    {
        if (State != RunState.Result) throw new InvalidOperationException("Only a completed run can return to the lobby.");
        State = RunState.Lobby;
    }

    public bool TryUpgrade(FacilityType type)
    {
        if (State != RunState.Lobby) return false;
        var facility = Facility(type);
        if (!Resources.TrySpend(facility.NextCost)) return false;
        facility.Upgrade();
        Player.ApplyFacility(type);
        return true;
    }

    public GameSaveData CreateSave() => new(
        Version: GameSaveData.CurrentVersion,
        Resources: Resources.Snapshot(),
        FacilityLevels: _facilities.ToDictionary(pair => pair.Key, pair => pair.Value.Level));

    public static GameSession FromSave(GameSaveData save)
    {
        if (save.Version != GameSaveData.CurrentVersion)
            throw new NotSupportedException($"Save version {save.Version} is not supported.");

        var session = new GameSession();
        session.Resources.Restore(save.Resources);

        foreach (var type in Enum.GetValues<FacilityType>())
        {
            if (!save.FacilityLevels.TryGetValue(type, out var level) || level < 0)
                throw new ArgumentException("A save must include non-negative levels for every facility.", nameof(save));

            session.Facility(type).RestoreLevel(level);
            for (var index = 0; index < level; index++) session.Player.ApplyFacility(type);
        }

        return session;
    }
}
