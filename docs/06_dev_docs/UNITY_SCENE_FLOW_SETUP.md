# Unity Scene Flow Setup

## Goal

Wire the current M1 scripts into a minimal playable scene loop:

`Bootstrap -> Title or Lobby -> Battle -> Result -> Lobby`

## Required Scenes

Create these scenes with exact names:

- `00_Bootstrap`
- `01_Title`
- `02_Lobby`
- `03_Battle`
- `04_Result`

## Bootstrap Scene

1. Create an empty object named `BootstrapController`.
2. Attach `BootstrapSceneController`.
3. Optionally assign a `GameManager` prefab.
4. Set `Next Scene` to `Lobby` for the fastest MVP loop.

## Title Scene

1. Create an empty object named `TitleController`.
2. Attach `TitleSceneController`.
3. Connect a start button to `TitleSceneController.EnterLobby()`.

## Lobby Scene

1. Create an empty object named `LobbyController`.
2. Attach `LobbySceneController`.
3. Connect the battle start button to `LobbySceneController.StartBattle()`.
4. Optionally connect a back button to `LobbySceneController.GoToTitle()`.

## Battle Scene

1. Create an empty object named `BattleController`.
2. Attach `BattleSceneController`.
3. For a temporary flow test, set `Auto Complete After Seconds` to a small value such as `3`.
4. Add a debug complete button wired to `BattleSceneController.CompleteBattle()`.
5. Add a debug abort button wired to `BattleSceneController.AbortBattle()`.

## Result Scene

1. Create an empty object named `ResultController`.
2. Attach `ResultSceneController`.
3. Connect the continue button to `ResultSceneController.ReturnToLobby()`.
4. Read `LastCollectedResources` from a future UI presenter to show rewards.

## Build Settings

Add the scenes to Build Settings in this order:

1. `00_Bootstrap`
2. `01_Title`
3. `02_Lobby`
4. `03_Battle`
5. `04_Result`

## Expected Test

With no combat system yet, this should still work:

1. Launch from `00_Bootstrap`
2. Move to `02_Lobby`
3. Start battle
4. Auto-complete or click complete in battle
5. Land on result
6. Return to lobby
