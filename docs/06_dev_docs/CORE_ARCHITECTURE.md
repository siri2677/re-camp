# Core architecture (Unity-independent)

`src/ReCamp.Core` is the game-rule layer for the MVP loop. It deliberately has no Unity references, so it can be built and tested before a Unity project is installed.

```text
Lobby -> StartRun -> Exploring -> CompleteRun -> Result -> ReturnToLobby
  ^                                                        |
  +------------------ camp facility upgrade ---------------+
```

## Current responsibilities

- `GameSession`: validates the loop state and coordinates rewards and upgrades.
- `ResourceWallet`: owns scrap, rations, and data fragments; it prevents unaffordable spending.
- `CampFacility`: calculates the next upgrade cost for the generator, workshop, and ration storage.
- `PlayerStats`: receives persistent workshop and storage effects.
- `BattleEncounter`: resolves a single attack exchange, victory/defeat, and one-time reward claiming.
- `MvpEnemies`: exposes the three P0 enemy stat/reward definitions from the content table.
- `SaveFileStore`: stores resource and facility progress in a versioned local JSON file.
- `ExplorationResult`: freezes the current run's enemy count and rewards for the future result UI.

## Persistence decision

The MVP does not require a database. It is an offline, single-device game, so a JSON save file is the appropriate first implementation. Introduce a server database only when the project needs authenticated accounts, cross-device sync, rankings, purchases, or live operations.

## Unity integration later

Unity `MonoBehaviour` components should call this layer rather than reproducing its rules. For example, `EnemyController` creates an `Enemy` reward on death, and the result/camp UI reads `GameSession` state. Persistence can serialize the session's resource and facility values into a Unity save adapter.

## Verification

Run the dependency-free executable test suite from the repository root:

```powershell
dotnet run --project tests/ReCamp.Core.Tests
```
