using System.Text.Json;
using System.Text.Json.Serialization;

namespace ReCamp.Core;

public sealed record GameSaveData(
    int Version,
    IReadOnlyDictionary<ResourceType, int> Resources,
    IReadOnlyDictionary<FacilityType, int> FacilityLevels)
{
    public const int CurrentVersion = 1;
}

public static class SaveFileStore
{
    private static readonly JsonSerializerOptions JsonOptions = new()
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
