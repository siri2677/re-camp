namespace ReCamp.Core;

public enum SkillRarity { Common, Rare }
public enum SkillActivation { Passive, Active }
public enum SkillEffectType
{
    AttackMultiplier,
    PickupRadiusMultiplier,
    DamageShield,
    DroneAttack,
    DashDistance,
    LowHealthMoveSpeedMultiplier,
}

public sealed record SkillDefinition(
    string Id,
    string DisplayName,
    SkillRarity Rarity,
    SkillActivation Activation,
    SkillEffectType Effect,
    double ValuePerLevel,
    int CooldownSeconds,
    int MaxLevel)
{
    public void Validate()
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(Id);
        ArgumentException.ThrowIfNullOrWhiteSpace(DisplayName);
        if (ValuePerLevel <= 0) throw new ArgumentOutOfRangeException(nameof(ValuePerLevel));
        if (MaxLevel < 1) throw new ArgumentOutOfRangeException(nameof(MaxLevel));
        if (Activation == SkillActivation.Active && CooldownSeconds < 1)
            throw new ArgumentException("Active skills must have a cooldown.", nameof(CooldownSeconds));
        if (Activation == SkillActivation.Passive && CooldownSeconds != 0)
            throw new ArgumentException("Passive skills cannot have a cooldown.", nameof(CooldownSeconds));
    }
}

public sealed record SkillState(string SkillId, int Level, TimeSpan RemainingCooldown)
{
    public bool IsReady => RemainingCooldown <= TimeSpan.Zero;
}

public sealed record SkillActivationResult(string SkillId, SkillEffectType Effect, double Value, TimeSpan Cooldown);

public sealed class SkillCatalog
{
    private readonly Dictionary<string, SkillDefinition> _definitions;

    public SkillCatalog(IEnumerable<SkillDefinition> definitions)
    {
        ArgumentNullException.ThrowIfNull(definitions);
        _definitions = new Dictionary<string, SkillDefinition>(StringComparer.Ordinal);
        foreach (var definition in definitions)
        {
            definition.Validate();
            if (!_definitions.TryAdd(definition.Id, definition))
                throw new ArgumentException($"Duplicate skill id '{definition.Id}'.", nameof(definitions));
        }
    }

    public IReadOnlyCollection<SkillDefinition> All => _definitions.Values;
    public SkillDefinition Get(string skillId) => _definitions.TryGetValue(skillId, out var skill)
        ? skill
        : throw new KeyNotFoundException($"Unknown skill '{skillId}'.");
}

public sealed class SkillLoadout
{
    public const int MaxSkillSlots = 6;
    private readonly SkillCatalog _catalog;
    private readonly Dictionary<string, SkillState> _skills = new(StringComparer.Ordinal);

    public SkillLoadout(SkillCatalog catalog) => _catalog = catalog ?? throw new ArgumentNullException(nameof(catalog));
    public IReadOnlyCollection<SkillState> Skills => _skills.Values;
    public bool HasFreeSlot => _skills.Count < MaxSkillSlots;

    public bool CanSelect(string skillId)
    {
        var definition = _catalog.Get(skillId);
        return _skills.TryGetValue(skillId, out var state)
            ? state.Level < definition.MaxLevel
            : HasFreeSlot;
    }

    public bool TrySelect(string skillId)
    {
        if (!CanSelect(skillId)) return false;
        var definition = _catalog.Get(skillId);
        if (_skills.TryGetValue(skillId, out var state))
            _skills[skillId] = state with { Level = state.Level + 1 };
        else
            _skills.Add(skillId, new SkillState(definition.Id, Level: 1, TimeSpan.Zero));
        return true;
    }

    public void Tick(TimeSpan elapsed)
    {
        if (elapsed < TimeSpan.Zero) throw new ArgumentOutOfRangeException(nameof(elapsed));
        foreach (var state in Skills.ToArray())
        {
            var remaining = state.RemainingCooldown - elapsed;
            _skills[state.SkillId] = state with { RemainingCooldown = remaining < TimeSpan.Zero ? TimeSpan.Zero : remaining };
        }
    }

    public bool TryActivate(string skillId, out SkillActivationResult? result)
    {
        result = null;
        if (!_skills.TryGetValue(skillId, out var state)) return false;
        var definition = _catalog.Get(skillId);
        if (definition.Activation != SkillActivation.Active || !state.IsReady) return false;

        var cooldown = TimeSpan.FromSeconds(definition.CooldownSeconds);
        _skills[skillId] = state with { RemainingCooldown = cooldown };
        result = new SkillActivationResult(skillId, definition.Effect, definition.ValuePerLevel * state.Level, cooldown);
        return true;
    }

    public double PassiveValue(SkillEffectType effect) => Skills.Sum(state =>
    {
        var definition = _catalog.Get(state.SkillId);
        return definition.Activation == SkillActivation.Passive && definition.Effect == effect
            ? definition.ValuePerLevel * state.Level
            : 0;
    });
}

public sealed class SkillDraftService
{
    public IReadOnlyList<SkillDefinition> CreateOffer(SkillCatalog catalog, SkillLoadout loadout, int seed, int offerSize = 3)
    {
        ArgumentNullException.ThrowIfNull(catalog);
        ArgumentNullException.ThrowIfNull(loadout);
        if (offerSize < 1) throw new ArgumentOutOfRangeException(nameof(offerSize));

        var candidates = catalog.All.Where(skill => loadout.CanSelect(skill.Id)).OrderBy(skill => skill.Id).ToList();
        var random = new DeterministicRandom(seed);
        for (var index = candidates.Count - 1; index > 0; index--)
        {
            var swapIndex = random.Next(index + 1);
            (candidates[index], candidates[swapIndex]) = (candidates[swapIndex], candidates[index]);
        }

        return candidates.Take(offerSize).ToArray();
    }
}

internal sealed class DeterministicRandom
{
    private uint _state;

    public DeterministicRandom(int seed) => _state = unchecked((uint)seed);

    public int Next(int maxExclusive)
    {
        if (maxExclusive < 1) throw new ArgumentOutOfRangeException(nameof(maxExclusive));
        _state = unchecked(_state * 1_664_525u + 1_013_904_223u);
        return (int)(_state % (uint)maxExclusive);
    }
}

public static class MvpSkills
{
    public static SkillCatalog Catalog { get; } = new(new[]
    {
        new SkillDefinition("SK001", "Energy Blade Upgrade", SkillRarity.Common, SkillActivation.Passive, SkillEffectType.AttackMultiplier, 0.05, 0, 5),
        new SkillDefinition("SK002", "Resource Magnet", SkillRarity.Common, SkillActivation.Passive, SkillEffectType.PickupRadiusMultiplier, 0.10, 0, 5),
        new SkillDefinition("SK003", "Shield Deployment", SkillRarity.Rare, SkillActivation.Active, SkillEffectType.DamageShield, 1, 20, 3),
        new SkillDefinition("SK004", "Drone Summon", SkillRarity.Rare, SkillActivation.Active, SkillEffectType.DroneAttack, 10, 15, 3),
        new SkillDefinition("SK005", "Emergency Dash", SkillRarity.Rare, SkillActivation.Active, SkillEffectType.DashDistance, 4, 8, 3),
        new SkillDefinition("SK006", "Survival Instinct", SkillRarity.Common, SkillActivation.Passive, SkillEffectType.LowHealthMoveSpeedMultiplier, 0.15, 0, 5),
    });
}
