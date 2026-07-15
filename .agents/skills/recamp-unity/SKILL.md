---
name: recamp-unity
description: Continue and verify the Re:Camp Unity project with compact Coplay/unityMCP usage. Use for Re:Camp gameplay, scenes, C# scripts, tests, planning/art/docs continuation, MCP recovery, vertical-slice work, or requests such as "개발 계속" in this repository.
---

# Re:Camp Unity

Use this workflow to continue the project without reloading the full history or forwarding large MCP payloads.

## 1. Establish the current task

1. Follow the user's explicitly named content, file, or task before selecting anything from the backlog.
2. Read `planning/README.md` first.
3. Use `rg` in `planning/sprint_backlog.md` and `planning/IMPLEMENTATION_STATUS.md` to locate only the selected item's completion criteria. Without an explicit selection, choose the highest-priority `In Progress` item, then the first `Ready` item.
4. Treat `planning/sprint_backlog.md` as the execution-status source of truth when it differs from `IMPLEMENTATION_STATUS.md`; the latter records implementation evidence.
5. Read other planning, art, or docs files only when the selected work item references them. Open `planning/COPLAY_MCP_HANDOFF.md` only for connection, stale-job, or regression recovery.
6. Inspect `git status --short` before editing and preserve all unrelated user changes. Do not start implementation with unresolved merge conflicts; resolve the in-scope conflicts or report them first.

Keep adjacent backlog IDs separate unless the selected completion criteria explicitly join them. Finish an audit/decision task before expanding into its implementation task.

Keep these product decisions fixed unless the user changes them: five adult women; male-oriented subculture presentation; normal-proportion 2D art; 4–5-head SD-lite 3D; the original `battle_vertical_slice_concept.png` is the battle visual anchor. Treat current primitives and gray-box visuals as implementation scaffolding, not final art.

## 2. Use Unity MCP economically

Read [references/mcp-compact-workflow.md](references/mcp-compact-workflow.md) before substantial Unity MCP work.

1. Confirm the Unity instance and editor state; set the active instance only when needed.
2. Keep the default core tool group active. Activate `testing` for verification and `scripting_ext` only for runtime probes. Activate docs, profiling, UI, animation, VFX, ProBuilder, or asset-generation groups only for a task that needs them; deactivate optional groups afterward.
3. Use `batch_execute` for two or more independent or repetitive Unity operations.
4. Request small result pages and targeted fields. Never print or relay a complete MCP response when a status, count, path, failed-test list, or error summary is enough.

## 3. Implement safely

- Edit repository sources with `apply_patch`; use formatters only for mechanical formatting.
- Do not edit `Library/`, `Temp/`, package caches, installed MCP/plugin caches, or generated IDE state.
- Prefer deterministic C# and Unity-native assets over runtime-only editor mutations. If an editor mutation creates durable state, save the intended scene or asset explicitly.
- Keep code, tests, and the smallest relevant planning/status entry aligned. Avoid duplicating the full project state across documents.
- Do not upgrade placeholder art to final or `APPROVED` status without human review. Keep ComfyUI/local diffusion as an optional later detail pass.

## 4. Verify proportionally

1. Refresh Unity and wait for compilation.
2. Read only error-level Console entries relevant to `_ReCamp`; include stack traces only for failures being diagnosed.
3. Run EditMode and PlayMode suites with compact details. Report totals and failed names; fetch per-test detail only when a test fails.
4. For gameplay or scene changes, perform the smallest direct PlayMode probe that proves the affected behavior.
5. Save intended scene changes before restoring `Assets/_ReCamp/Scenes/03_Battle.unity` as the active scene unless the task intentionally changes the handoff scene. Never discard an unrelated dirty scene to perform the restore.
6. Record the verification result in the relevant status/backlog entry.

Commit or push only when the user explicitly requests it.
