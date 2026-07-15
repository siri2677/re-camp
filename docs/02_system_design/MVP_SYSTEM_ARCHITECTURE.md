# MVP System Architecture

## Current Focus

The first implementation slice targets the documented M1 flow:

`Bootstrap -> Lobby -> Battle -> Result`

## Scene Naming Contract

- `00_Bootstrap`
- `01_Title`
- `02_Lobby`
- `03_Battle`
- `04_Result`

## Initial Runtime Roles

### `BootstrapSceneController`

- runs in the bootstrap scene
- ensures a single `GameManager` exists
- forwards the player into the next scene

### `GameManager`

- persists across scenes
- owns high-level run state
- starts a battle run and returns the player to the lobby/result scenes

### `SceneLoader`

- centralizes scene-name mapping
- prevents hard-coded scene strings from spreading across scripts

### Scene Controllers

- `TitleSceneController`: moves the player from title to lobby
- `LobbySceneController`: starts a battle run
- `BattleSceneController`: tracks temporary collected resources and ends a run
- `ResultSceneController`: exposes the latest reward count and returns to lobby

## Next Integration Steps

1. Create the five Unity scenes with the exact names above.
2. Place `BootstrapSceneController` in `00_Bootstrap`.
3. Add lobby UI that calls `GameManager.Instance.StartRun()`.
4. Add battle-end logic that calls `GameManager.Instance.CompleteRun(collectedResources)`.
5. Add result UI that calls `GameManager.Instance.ReturnToLobby()`.

## Temporary Wiring Notes

- `BattleSceneController.autoCompleteAfterSeconds` can be used for an early no-combat scene-flow test.
- `BattleSceneController.CompleteBattle()` is suitable for a debug button until combat logic exists.
- `ResultSceneController.LastCollectedResources` can be read by a future UI presenter.
