# Coplay Unity MCP Handoff

## Goal

Continue development of the Re:Camp Unity project through Coplay Unity MCP.

For every change:

1. Use Coplay MCP to inspect or change Unity state where possible.
2. Run a Unity compile verification.
3. Run a Play Mode regression check through MCP.
4. Inspect Unity Console errors through MCP.
5. Report only verified results.

Do not claim that a feature was MCP-tested if only a batch compile completed.

## Project

- Workspace: `C:\Users\shp80\project\re-camp`
- Unity: `6000.5.3f1`
- Main scenes:
  - `Assets/_ReCamp/Scenes/00_Bootstrap.unity`
  - `Assets/_ReCamp/Scenes/01_Title.unity`
  - `Assets/_ReCamp/Scenes/02_Lobby.unity`
  - `Assets/_ReCamp/Scenes/03_Battle.unity`
  - `Assets/_ReCamp/Scenes/04_Result.unity`

## Coplay MCP Configuration

The project uses the open-source Coplay Unity MCP, not Unity's official relay MCP.

- Unity package: `com.coplaydev.unity-mcp` version `10.0.0`
- Unity bridge: stdio, last verified on `127.0.0.1:6401` (the bridge port can change after an Editor restart)
- Codex MCP server name: `unityMCP`
- Server command:

```text
C:\Users\shp80\AppData\Local\Programs\Python\Python313\Scripts\uvx.exe
--from mcpforunityserver==10.0.0 mcp-for-unity --transport stdio
```

The global Codex configuration is in `C:\Users\shp80\.codex\config.toml`.

## Current Connection Status

Verified previously:

- Coplay package is installed in the Unity project.
- Unity bridge reports `ready` on port `6400`.
- A Coplay `debug_request_context` call succeeded and returned:
  - Unity instance: `re-camp@f2ed6dca`
  - MCP server version: `10.0.0`

Verified on 2026-07-13:

- Unity `6000.5.3f1` reconnected as `re-camp@f2ed6dca` on port `6401`.
- Script compilation completed with no `_ReCamp` errors.
- Direct Battle Play Mode verified the runtime UGUI HUD, robot proxies, camera-relative movement vectors, arena clamp, and XZ resource pickup.
- Full Play Mode flow completed through `Bootstrap -> Lobby -> Battle -> Result -> Lobby`.
- Test rewards `Scrap 2 / Food 1 / Data 0` reached Result and remained in the camp inventory after returning to Lobby.
- The active Editor scene was restored to `Assets/_ReCamp/Scenes/03_Battle.unity` after testing.

Verified on 2026-07-14:

- Added named runtime and test assemblies (`ReCamp.Runtime`, `ReCamp.Tests.EditMode`, `ReCamp.Tests.PlayMode`).
- Unity recompiled the project without `_ReCamp` compilation errors.
- Final EditMode tests: 23 passed, 0 failed, 0 skipped.
- Final PlayMode tests: 18 passed, 0 failed, 0 skipped.
- Automated coverage includes resource ledger behavior, damage/death/healing/mitigation/shields, five-character roster and selection invariants, arena clamps, SceneLoader/Build Settings, enemy lifecycle, camp settlement persistence, five-character role abilities, the exploration timer, and hold-to-extract resolution.
- Added five-character selection/data/signature-ability Gray Box foundation. A Bootstrap → Lobby selection of Iris persisted into Battle as `Iris / Focus Shot / HP 85 / Move 4.8 / Attack 15 / Range 11`.
- Direct `03_Battle` Play Mode verified the runtime HUD/canvas, `05:00` countdown, Luna's scan state, and forced `TimeExpired` resolution with `_ReCamp` Console errors at 0.
- Full scene transitions and result settlement still rely on the 2026-07-13 manual Play Mode regression and should receive deeper automated coverage later.

Verified on 2026-07-19:

- Unity `6000.5.3f1` was launched directly and reconnected as `re-camp@f2ed6dca` on port `6401`.
- `Assets/_ReCamp/Editor/ReCampMcpAutoConnect.cs` now starts the stdio bridge once per Editor session when automatic registration is missing.
- The portable `ReCamp.Domain` and `ReCamp.UnityAdapter` assemblies compiled with `_ReCamp` Console errors at 0.
- EditMode tests: 25 passed, 0 failed, 0 skipped. PlayMode tests: 18 passed, 0 failed, 0 skipped.
- Contract coverage now includes Food↔Rations mapping, domain facility save restoration, and PlayerPrefs v1→v2 migration.
- The active Editor scene was restored to `Assets/_ReCamp/Scenes/03_Battle.unity`.

Important limitation:

- `codex exec` has a known issue where MCP action calls can fail with
  `user cancelled MCP tool call`.
- This is not proof that Coplay is disconnected. Unity logs showed Coplay
  forwarding the command to Unity's main-thread dispatcher.
- Do not use `codex exec` as the authoritative MCP action-test surface.
- Start a new interactive Codex task so `unityMCP` tools are registered at task startup.
- Stdio reconnects can add `MCP-FOR-UNITY: Client handler exited` entries that Unity classifies as exceptions. Filter Console checks to `_ReCamp` when validating project errors, and inspect the MCP log separately when diagnosing transport failures.

## Required First Checks in a New Task

1. Confirm that `unityMCP` tools are visible.
2. Run `debug_request_context` and confirm the active Unity instance.
3. Use a non-destructive action call to enter and exit Play Mode.
4. Read the Unity Console and confirm no compilation errors.
5. If any action call fails, stop feature work and diagnose Coplay before editing gameplay code.

## Development State

The MVP loop has been implemented:

```text
Lobby -> Battle -> resource drops/pickups -> Result -> Camp upgrade -> Lobby
```

Implemented systems:

- Scene flow and shared `GameManager`
- Player movement and automatic attack
- Enemy spawning, chase, death, and a boss after the normal wave
- Resource drops: Scrap, Food, Data Fragment
- Automatic pickup near the player
- Result reward summary
- Camp facilities:
  - Generator: +30 seconds of exploration time per level
  - Workbench: attack bonus
  - Food Storage: max-health bonus
- Local camp save/load using `PlayerPrefs`
- True orthographic quarter-view camera (`35.3° / 45°`) and camera-relative XZ movement mapping
- Bounded battle arena with actor and camera clamps
- Colored ground, boundary, camp, ruin, and barricade proxy materials
- Temporary SD player proxy and multi-part scrap-robot enemy/boss proxies
- Runtime Screen Space UGUI battle HUD with safe-area handling
- Victory and defeat resolution with automatic Result transition
- Five-minute exploration timer, 60-second warning, `R` hold/manual-button extraction, and explicit resolution reasons
- Character role Gray Box: Luna combo/scan, Miyu persistent drone/overclock, Coco shield, Iris charge/mark, Noah barrier/knockback
- Hitch-safe resource attraction using `Vector3.MoveTowards`

Relevant scripts:

- `Assets/_ReCamp/Scripts/Core/GameManager.cs`
- `Assets/_ReCamp/Scripts/GameFlow/BattleArenaBounds.cs`
- `Assets/_ReCamp/Scripts/GameFlow/BattleSceneController.cs`
- `Assets/_ReCamp/Scripts/Player/`
- `Assets/_ReCamp/Scripts/Enemy/`
- `Assets/_ReCamp/Scripts/Item/`
- `Assets/_ReCamp/Scripts/Camp/`
- `Assets/_ReCamp/Scripts/Save/SaveManager.cs`
- `Assets/_ReCamp/Scripts/UI/PrototypeSceneUI.cs`
- `Assets/_ReCamp/Scripts/UI/BattleHudController.cs`

Battle no longer uses `PrototypeSceneUI`; that component remains only for the non-Battle prototype scenes.

Visual references:

- `docs/05_art_concept/BATTLE_VISUAL_TARGET.md`
- `art_refs/moodboard/battle_vertical_slice_concept.png`
- `Assets/_ReCamp/Captures/battle_quarter_view_hud.png`

## Execution Source

이 문서는 Unity MCP 연결·복구·회귀 절차만 소유한다. 제품 방향과 실행 우선순위를 여기에서
중복 관리하지 않는다.

- 제품·플랫폼·비주얼·현재 Gate: `docs/00_project/CURRENT_PROJECT_BASELINE.md`
- 현재 실행 순서와 상태: `planning/sprint_backlog.md`
- 구현·테스트 근거: `planning/IMPLEMENTATION_STATUS.md`
- v003 캐릭터 판정: `art_refs/art_direction/ReCamp_CharacterLineup_REVIEW_v003.review.md`

MCP 작업을 재개할 때는 위 실행 큐에서 선택된 ID만 수행하고, 이 문서의 연결 절차와 검증
명령을 적용한다. 테스트 개수·다음 작업·아트 승인 상태를 이 파일에 다시 복사하지 않는다.

## ComfyUI / ComfyUI MCP

ComfyUI is deferred and optional at the current development stage. Do not block Unity gameplay work, initial concept review, Luna's production-sheet planning, or the neutral Blender export test on installing ComfyUI, downloading model weights, or preparing a local GPU.

Continue with the currently available image-generation path. Re-evaluate ComfyUI only when one of these needs becomes a demonstrated production bottleneck:

- large batches that must preserve the same character's face, hair, outfit, and equipment;
- precise inpainting or repeated partial corrections;
- a reproducible Seed/LoRA/ControlNet/IP-Adapter workflow;
- batch expression, pose, or equipment variants whose current production cost is excessive.

If a trigger occurs, compare local GPU inference with a cloud-hosted ComfyUI workflow before choosing an installation path. Until then, its backlog state is `Deferred`, not `Blocked`.

## Blender MCP

Blender MCP is separate from Coplay Unity MCP.

- Blender 4.5 LTS was installed.
- The `blender-mcp` add-on was installed and enabled.
- Runtime Blender MCP connection was not verified because Blender exited during subsequent launch attempts.
- Do not register Blender MCP in Codex until it is needed and its Blender socket connection is verified.
