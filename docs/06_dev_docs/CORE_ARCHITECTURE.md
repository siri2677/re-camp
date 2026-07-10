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

## Unity integration later

Unity `MonoBehaviour` components should call this layer rather than reproducing its rules. For example, `EnemyController` creates an `Enemy` reward on death, and the result/camp UI reads `GameSession` state. Persistence can serialize the session's resource and facility values into a Unity save adapter.

## Verification

Run the dependency-free executable test suite from the repository root:

```powershell
dotnet run --project tests/ReCamp.Core.Tests
```
