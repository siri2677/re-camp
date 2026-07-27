---
name: recamp-unity
description: Continue and verify the Re:Camp Unity project with compact Coplay/unityMCP usage. Use for gameplay, scenes, C# scripts, tests, planning, art, documentation, MCP recovery, and vertical-slice work in this repository.
---

# Re:Camp Unity Workflow

Use this workflow without reloading the full repository history or duplicating project decisions.

## 1. Establish the active context

1. Follow the user's explicitly named task first.
2. Check the current branch, short HEAD, and `git status --short`.
3. Read `docs/00_project/CURRENT_PROJECT_BASELINE.md` first. It is the only source for product, platform, global visual direction, roster, current Gate, document precedence, and required read sets.
4. Read the selected row in `planning/sprint_backlog.md`. Without an explicit task, choose the first `In Progress`, then the first `Ready` item.
5. Read only the domain documents listed by the Baseline for that task type and the relevant section of `planning/IMPLEMENTATION_STATUS.md`.
6. Treat `planning/sprint_backlog.md` as the execution-status source of truth. `IMPLEMENTATION_STATUS.md` records evidence and must not independently reprioritize work.
7. Historical, rejected, invalid, or Gate-failed documents and assets are comparison evidence only.

Do not restate global project decisions in this Skill. When a decision changes, update the Baseline and the directly owning domain document.

## 2. Use Unity MCP economically

Read [references/mcp-compact-workflow.md](references/mcp-compact-workflow.md) before substantial Unity MCP work.

1. Confirm the active Unity instance and Editor state.
2. Keep only the required tool groups active. Enable testing, profiling, UI, animation, VFX, or asset tools only for tasks that need them.
3. Batch independent or repetitive operations.
4. Request compact fields and pages. Report status, counts, paths, failures, and evidence rather than complete MCP payloads.
5. Do not treat a transport error as proof of a Unity project error without checking the Editor and `_ReCamp` Console entries.

## 3. Implement safely

- Preserve unrelated user changes and stop on unresolved in-scope merge conflicts.
- Edit repository sources, not `Library/`, `Temp/`, package caches, installed plugin caches, or generated IDE state.
- Prefer deterministic C# and versioned Unity assets over unrecorded Editor-only mutations.
- Save intended Scene or asset changes explicitly.
- Keep code, tests, and the smallest owning status entry aligned.
- Do not copy the Baseline's product decisions into Roadmaps, Backlogs, README, AGENTS, or this Skill.
- Do not promote placeholder or generated art to `APPROVED` without human review and the required metadata/review evidence.

## 4. Verify proportionally

1. Refresh Unity and wait for compilation.
2. Check error-level Console entries relevant to `_ReCamp`.
3. Run the smallest EditMode and PlayMode suites that prove the change; run the full suites for shared runtime, domain, scene-flow, or save changes.
4. For gameplay and Scene work, perform a focused direct Play Mode probe.
5. Save intended Scene changes before restoring the agreed handoff Scene when appropriate.
6. Record environment, result, failure details, and remaining limitations in `planning/IMPLEMENTATION_STATUS.md`.
7. For document changes, run `python scripts/validate_project_docs.py`.

## 5. Finish the task

- Update only the owning Backlog/status/document.
- Never mark implementation `Done` from code existence alone.
- Never mark art `APPROVED` from generation quality alone.
- Commit, push, create PRs, close superseded PRs, or merge only when the user explicitly requests it.
