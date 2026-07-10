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
}

public sealed class GameSession
{
    private readonly Dictionary<FacilityType, CampFacility> _facilities = Enum.GetValues<FacilityType>()
        .ToDictionary(type => type, type => new CampFacility(type));

    public GameSession() => Player = new PlayerStats(BaseMaxHealth: 100, BaseAttack: 10);
    public RunState State { get; private set; } = RunState.Lobby;
    public PlayerStats Player { get; }
    public ResourceWallet Resources { get; } = new();
    public int DefeatedEnemies { get; private set; }

    public CampFacility Facility(FacilityType type) => _facilities[type];

    public void StartRun()
    {
        if (State != RunState.Lobby) throw new InvalidOperationException("A run can only start from the lobby.");
        DefeatedEnemies = 0;
        State = RunState.Exploring;
    }

    public void DefeatEnemy(Enemy enemy)
    {
        if (State != RunState.Exploring) throw new InvalidOperationException("Enemies can only be defeated while exploring.");
        foreach (var reward in enemy.Reward) Resources.Add(reward.Key, reward.Value);
        DefeatedEnemies++;
    }

    public void CompleteRun()
    {
        if (State != RunState.Exploring) throw new InvalidOperationException("Only an active run can be completed.");
        State = RunState.Result;
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
}
