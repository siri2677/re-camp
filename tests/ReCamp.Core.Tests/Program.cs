using ReCamp.Core;

var tests = new (string Name, Action Run)[]
{
    ("run flow awards rewards and returns to lobby", RunFlowAwardsRewards),
    ("camp upgrade consumes resources and applies player stats", UpgradeAppliesStats),
    ("upgrade fails outside lobby or with insufficient resources", UpgradeGuards),
};

var failures = new List<string>();
foreach (var test in tests)
{
    try { test.Run(); Console.WriteLine($"PASS: {test.Name}"); }
    catch (Exception exception) { failures.Add($"FAIL: {test.Name} - {exception.Message}"); }
}

if (failures.Count > 0)
{
    failures.ForEach(Console.Error.WriteLine);
    Environment.ExitCode = 1;
}

static void RunFlowAwardsRewards()
{
    var session = new GameSession();
    session.StartRun();
    session.DefeatEnemy(new Enemy("EN001", 20, new Dictionary<ResourceType, int>
    {
        [ResourceType.Scrap] = 12,
        [ResourceType.Rations] = 3,
    }));
    session.CompleteRun();
    session.ReturnToLobby();

    Assert(session.State == RunState.Lobby, "session should return to lobby");
    Assert(session.DefeatedEnemies == 1, "defeated enemy count should be retained for the result");
    Assert(session.Resources[ResourceType.Scrap] == 12, "scrap reward should be retained");
}

static void UpgradeAppliesStats()
{
    var session = new GameSession();
    session.Resources.Add(ResourceType.Scrap, 15);
    session.Resources.Add(ResourceType.DataFragment, 2);

    Assert(session.TryUpgrade(FacilityType.Workshop), "workshop upgrade should succeed");
    Assert(session.Facility(FacilityType.Workshop).Level == 1, "facility level should increase");
    Assert(session.Player.Attack == 12, "workshop should raise attack by 2");
    Assert(session.Resources[ResourceType.Scrap] == 0, "upgrade should spend scrap");
}

static void UpgradeGuards()
{
    var session = new GameSession();
    Assert(!session.TryUpgrade(FacilityType.Generator), "upgrade should fail without resources");
    session.Resources.Add(ResourceType.Scrap, 10);
    session.StartRun();
    Assert(!session.TryUpgrade(FacilityType.Generator), "upgrade should fail during a run");
}

static void Assert(bool condition, string message)
{
    if (!condition) throw new InvalidOperationException(message);
}
