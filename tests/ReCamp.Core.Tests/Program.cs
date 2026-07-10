using ReCamp.Core;

var tests = new (string Name, Action Run)[]
{
    ("run flow awards rewards and returns to lobby", RunFlowAwardsRewards),
    ("camp upgrade consumes resources and applies player stats", UpgradeAppliesStats),
    ("upgrade fails outside lobby or with insufficient resources", UpgradeGuards),
    ("player victory awards its enemy reward exactly once", VictoryClaimsRewardOnce),
    ("a surviving enemy damages the player and defeat cannot claim rewards", DefeatDoesNotClaimReward),
    ("save restores resources and persistent facility effects", SaveRestoresProgress),
    ("service-ready repository versions saves and rejects stale writes", RepositoryVersionsSaves),
    ("skill draft is deterministic and does not repeat selections", SkillDraftIsDeterministic),
    ("active skills respect cooldown and passive skills stack by level", SkillRuntimeRules),
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
    var result = session.CompleteRun();
    session.ReturnToLobby();

    Assert(session.State == RunState.Lobby, "session should return to lobby");
    Assert(session.DefeatedEnemies == 1, "defeated enemy count should be retained for the result");
    Assert(session.Resources[ResourceType.Scrap] == 12, "scrap reward should be retained");
    Assert(result.DefeatedEnemies == 1, "result should contain defeated enemy count");
    Assert(result.Rewards[ResourceType.Rations] == 3, "result should contain only this run's rewards");
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

static void VictoryClaimsRewardOnce()
{
    var session = new GameSession();
    session.StartRun();
    var encounter = session.StartEncounter(MvpEnemies.ScavengerStalker);

    encounter.ResolvePlayerAttack(enemyAttack: 5);
    encounter.ResolvePlayerAttack(enemyAttack: 5);

    Assert(encounter.IsWon, "two attacks should defeat a 20 health enemy");
    Assert(session.TryClaimVictory(encounter), "victory should claim the reward");
    Assert(!session.TryClaimVictory(encounter), "reward cannot be claimed twice");
    Assert(session.Resources[ResourceType.Scrap] == 5, "MVP enemy reward should be granted once");
    Assert(session.DefeatedEnemies == 1, "victory should count as one defeat");
}

static void DefeatDoesNotClaimReward()
{
    var session = new GameSession();
    session.StartRun();
    var enemy = new Enemy("EN-LETHAL", 100, new Dictionary<ResourceType, int> { [ResourceType.Scrap] = 50 });
    var encounter = session.StartEncounter(enemy);

    encounter.ResolvePlayerAttack(enemyAttack: 100);

    Assert(encounter.IsLost, "lethal enemy attack should defeat the player");
    Assert(!session.TryClaimVictory(encounter), "defeat must not claim an enemy reward");
    Assert(session.Resources[ResourceType.Scrap] == 0, "defeat must not grant resources");
}

static void SaveRestoresProgress()
{
    var path = Path.Combine(Path.GetTempPath(), $"recamp-{Guid.NewGuid():N}.json");
    try
    {
        var original = new GameSession();
        original.Resources.Add(ResourceType.Scrap, 15);
        original.Resources.Add(ResourceType.DataFragment, 2);
        original.Resources.Add(ResourceType.Rations, 10);
        Assert(original.TryUpgrade(FacilityType.Workshop), "workshop upgrade should succeed before saving");
        Assert(original.TryUpgrade(FacilityType.RationStorage), "storage upgrade should succeed before saving");

        SaveFileStore.Save(path, original);
        var restored = SaveFileStore.Load(path);

        Assert(restored.Resources[ResourceType.Scrap] == 0, "spent scrap should remain spent after loading");
        Assert(restored.Facility(FacilityType.Workshop).Level == 1, "workshop level should be restored");
        Assert(restored.Player.Attack == 12, "workshop effect should be restored");
        Assert(restored.Player.MaxHealth == 110, "storage effect should be restored");
    }
    finally
    {
        if (File.Exists(path)) File.Delete(path);
    }
}

static void RepositoryVersionsSaves()
{
    var directory = Path.Combine(Path.GetTempPath(), $"recamp-saves-{Guid.NewGuid():N}");
    try
    {
        var repository = new LocalJsonSaveRepository(directory);
        var data = new GameSession().CreateSave();
        var first = repository.SaveAsync("guest-001", data, expectedRevision: 0).GetAwaiter().GetResult();
        var loaded = repository.LoadAsync("guest-001").GetAwaiter().GetResult();

        Assert(first.Revision == 1, "first save should start at revision one");
        Assert(loaded?.Revision == 1, "saved revision should load back");
        AssertThrows<SaveConflictException>(
            () => repository.SaveAsync("guest-001", data, expectedRevision: 0).GetAwaiter().GetResult(),
            "stale writes should be rejected");
    }
    finally
    {
        if (Directory.Exists(directory)) Directory.Delete(directory, recursive: true);
    }
}

static void SkillDraftIsDeterministic()
{
    var loadout = new SkillLoadout(MvpSkills.Catalog);
    var draft = new SkillDraftService();
    var first = draft.CreateOffer(MvpSkills.Catalog, loadout, seed: 42);
    var second = draft.CreateOffer(MvpSkills.Catalog, loadout, seed: 42);

    Assert(first.Select(skill => skill.Id).SequenceEqual(second.Select(skill => skill.Id)), "same seed should produce the same offer");
    Assert(first.Select(skill => skill.Id).Distinct().Count() == first.Count, "an offer must not repeat skills");
    Assert(loadout.TrySelect(first[0].Id), "selected offer should be accepted");
}

static void SkillRuntimeRules()
{
    var loadout = new SkillLoadout(MvpSkills.Catalog);
    Assert(loadout.TrySelect("SK001"), "passive skill should be selectable");
    Assert(loadout.TrySelect("SK001"), "passive skill should level up");
    Assert(Math.Abs(loadout.PassiveValue(SkillEffectType.AttackMultiplier) - 0.10) < 0.0001, "two passive levels should stack");

    Assert(loadout.TrySelect("SK003"), "active skill should be selectable");
    Assert(loadout.TryActivate("SK003", out var activation), "ready active skill should activate");
    Assert(activation?.Cooldown == TimeSpan.FromSeconds(20), "active skill should use configured cooldown");
    Assert(!loadout.TryActivate("SK003", out _), "active skill cannot activate during cooldown");
    loadout.Tick(TimeSpan.FromSeconds(20));
    Assert(loadout.TryActivate("SK003", out _), "active skill should be ready after cooldown");
}

static void Assert(bool condition, string message)
{
    if (!condition) throw new InvalidOperationException(message);
}

static void AssertThrows<TException>(Action action, string message) where TException : Exception
{
    try { action(); }
    catch (TException) { return; }
    throw new InvalidOperationException(message);
}
