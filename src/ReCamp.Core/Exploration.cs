namespace ReCamp.Core;

public enum ExplorationState { Running, Extracted, Defeated, Expired }
public enum SpawnKind { Wave, Boss }

public sealed record SpawnSchedule(int AtSecond, string EnemyId, int Count)
{
    public void Validate()
    {
        if (AtSecond < 0) throw new ArgumentOutOfRangeException(nameof(AtSecond));
        ArgumentException.ThrowIfNullOrWhiteSpace(EnemyId);
        if (Count < 1) throw new ArgumentOutOfRangeException(nameof(Count));
    }
}

public sealed record ExplorationDefinition(
    string Id,
    int DurationSeconds,
    int ExtractionAvailableAtSecond,
    int BossAppearsAtSecond,
    string BossEnemyId,
    IReadOnlyList<SpawnSchedule> Waves)
{
    public void Validate()
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(Id);
        if (DurationSeconds < 1) throw new ArgumentOutOfRangeException(nameof(DurationSeconds));
        if (ExtractionAvailableAtSecond < 0 || ExtractionAvailableAtSecond > DurationSeconds)
            throw new ArgumentOutOfRangeException(nameof(ExtractionAvailableAtSecond));
        if (BossAppearsAtSecond < 0 || BossAppearsAtSecond > DurationSeconds)
            throw new ArgumentOutOfRangeException(nameof(BossAppearsAtSecond));
        ArgumentException.ThrowIfNullOrWhiteSpace(BossEnemyId);
        foreach (var wave in Waves)
        {
            wave.Validate();
            if (wave.AtSecond > DurationSeconds)
                throw new ArgumentException("Waves cannot start after the stage duration.", nameof(Waves));
        }
    }
}

public sealed record SpawnRequest(SpawnKind Kind, string EnemyId, int Count, int AtSecond);

public sealed class ExplorationRun
{
    private readonly ExplorationDefinition _definition;
    private readonly List<SpawnSchedule> _pendingWaves;
    private bool _bossSpawned;

    public ExplorationRun(ExplorationDefinition definition)
    {
        _definition = definition ?? throw new ArgumentNullException(nameof(definition));
        definition.Validate();
        _pendingWaves = definition.Waves.OrderBy(wave => wave.AtSecond).ToList();
    }

    public ExplorationState State { get; private set; } = ExplorationState.Running;
    public TimeSpan Elapsed { get; private set; }
    public bool IsExtractionAvailable => State == ExplorationState.Running && Elapsed.TotalSeconds >= _definition.ExtractionAvailableAtSecond;
    public bool BossSpawned => _bossSpawned;

    public IReadOnlyList<SpawnRequest> Tick(TimeSpan elapsed)
    {
        if (elapsed < TimeSpan.Zero) throw new ArgumentOutOfRangeException(nameof(elapsed));
        if (State != ExplorationState.Running || elapsed == TimeSpan.Zero) return Array.Empty<SpawnRequest>();

        var previousSecond = (int)Math.Floor(Elapsed.TotalSeconds);
        Elapsed = TimeSpan.FromSeconds(Math.Min(_definition.DurationSeconds, Elapsed.TotalSeconds + elapsed.TotalSeconds));
        var currentSecond = (int)Math.Floor(Elapsed.TotalSeconds);
        var requests = new List<SpawnRequest>();

        while (_pendingWaves.Count > 0 && _pendingWaves[0].AtSecond <= currentSecond)
        {
            var wave = _pendingWaves[0];
            _pendingWaves.RemoveAt(0);
            if (wave.AtSecond > previousSecond || previousSecond == 0 && wave.AtSecond == 0)
                requests.Add(new SpawnRequest(SpawnKind.Wave, wave.EnemyId, wave.Count, wave.AtSecond));
        }

        if (!_bossSpawned && _definition.BossAppearsAtSecond <= currentSecond)
        {
            _bossSpawned = true;
            requests.Add(new SpawnRequest(SpawnKind.Boss, _definition.BossEnemyId, 1, _definition.BossAppearsAtSecond));
        }

        if (Elapsed.TotalSeconds >= _definition.DurationSeconds) State = ExplorationState.Expired;
        return requests;
    }

    public bool TryExtract()
    {
        if (!IsExtractionAvailable) return false;
        State = ExplorationState.Extracted;
        return true;
    }

    public bool MarkDefeated()
    {
        if (State != ExplorationState.Running) return false;
        State = ExplorationState.Defeated;
        return true;
    }
}

public static class MvpStages
{
    public static ExplorationDefinition AbandonedStreet { get; } = new(
        Id: "ST001",
        DurationSeconds: 300,
        ExtractionAvailableAtSecond: 120,
        BossAppearsAtSecond: 240,
        BossEnemyId: "EN004",
        Waves: new[]
        {
            new SpawnSchedule(0, "EN001", 2),
            new SpawnSchedule(30, "EN002", 3),
            new SpawnSchedule(75, "EN003", 2),
            new SpawnSchedule(150, "EN001", 4),
            new SpawnSchedule(210, "EN002", 5),
        });
}
