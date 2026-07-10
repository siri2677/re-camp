using System.Text.Json;
using System.Text.Json.Serialization;
using System.Security.Cryptography;
using System.Text;

namespace ReCamp.Core;

public sealed record GameSaveData(
    int Version,
    IReadOnlyDictionary<ResourceType, int> Resources,
    IReadOnlyDictionary<FacilityType, int> FacilityLevels)
{
    public const int CurrentVersion = 1;
}

public sealed record PlayerSaveSnapshot(string PlayerId, long Revision, GameSaveData Data);

public interface IPlayerSaveRepository
{
    Task<PlayerSaveSnapshot?> LoadAsync(string playerId, CancellationToken cancellationToken = default);
    Task<PlayerSaveSnapshot> SaveAsync(
        string playerId,
        GameSaveData data,
        long expectedRevision,
        CancellationToken cancellationToken = default);
}

public sealed class SaveConflictException : Exception
{
    public SaveConflictException(string playerId) : base($"Save data for '{playerId}' changed on another client.") { }
}

public sealed class LocalJsonSaveRepository : IPlayerSaveRepository
{
    private readonly string _rootDirectory;

    public LocalJsonSaveRepository(string rootDirectory)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(rootDirectory);
        _rootDirectory = rootDirectory;
    }

    public async Task<PlayerSaveSnapshot?> LoadAsync(string playerId, CancellationToken cancellationToken = default)
    {
        ValidatePlayerId(playerId);
        var path = PathFor(playerId);
        if (!File.Exists(path)) return null;

        var json = await File.ReadAllTextAsync(path, cancellationToken);
        return JsonSerializer.Deserialize<PlayerSaveSnapshot>(json, SaveFileStore.JsonOptions)
            ?? throw new InvalidDataException("The save file is empty or invalid.");
    }

    public async Task<PlayerSaveSnapshot> SaveAsync(
        string playerId,
        GameSaveData data,
        long expectedRevision,
        CancellationToken cancellationToken = default)
    {
        ValidatePlayerId(playerId);
        ArgumentNullException.ThrowIfNull(data);
        if (expectedRevision < 0) throw new ArgumentOutOfRangeException(nameof(expectedRevision));

        var current = await LoadAsync(playerId, cancellationToken);
        var currentRevision = current?.Revision ?? 0;
        if (currentRevision != expectedRevision) throw new SaveConflictException(playerId);

        var snapshot = new PlayerSaveSnapshot(playerId, currentRevision + 1, data);
        Directory.CreateDirectory(_rootDirectory);
        var path = PathFor(playerId);
        var temporaryPath = $"{path}.{Guid.NewGuid():N}.tmp";
        await File.WriteAllTextAsync(temporaryPath, JsonSerializer.Serialize(snapshot, SaveFileStore.JsonOptions), cancellationToken);
        File.Move(temporaryPath, path, overwrite: true);
        return snapshot;
    }

    private string PathFor(string playerId)
    {
        var hash = Convert.ToHexString(SHA256.HashData(Encoding.UTF8.GetBytes(playerId))).ToLowerInvariant();
        return Path.Combine(_rootDirectory, $"{hash}.json");
    }

    private static void ValidatePlayerId(string playerId) => ArgumentException.ThrowIfNullOrWhiteSpace(playerId);
}

public static class SaveFileStore
{
    internal static readonly JsonSerializerOptions JsonOptions = new()
    {
        WriteIndented = true,
        Converters = { new JsonStringEnumConverter() },
    };

    public static void Save(string path, GameSession session)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(path);
        ArgumentNullException.ThrowIfNull(session);

        var directory = Path.GetDirectoryName(Path.GetFullPath(path));
        if (!string.IsNullOrEmpty(directory)) Directory.CreateDirectory(directory);
        File.WriteAllText(path, JsonSerializer.Serialize(session.CreateSave(), JsonOptions));
    }

    public static GameSession Load(string path)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(path);
        var json = File.ReadAllText(path);
        var save = JsonSerializer.Deserialize<GameSaveData>(json, JsonOptions)
            ?? throw new InvalidDataException("The save file is empty or invalid.");
        return GameSession.FromSave(save);
    }
}
