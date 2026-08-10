---
name: recamp-unity
description: Continue and verify the active Re:Camp Current Generation with compact Unity MCP usage. Use for gameplay, scenes, C# scripts, tests, planning, art, documentation, MCP recovery, and vertical-slice work in this repository.
---

# Re:Camp Current Generation Workflow

## 1. Establish active context

1. Follow the user's explicitly named task first.
2. Check current branch, short HEAD, and `git status --short`.
3. Active integration branch is `current/recamp-unified`. `legacy/recamp-pre-generation` is read-only historical reference unless the user explicitly requests Legacy maintenance.
4. Read `docs/00_project/CURRENT_PROJECT_BASELINE.md` first. It is the only source for generation separation, product, platform, global visual direction, active roster, global proportions, solo-production budget, current Gate, document precedence, and required read sets.
5. Read only the selected row in `planning/sprint_backlog.md` and the domain documents required by the Baseline. Without an explicit task, choose the first `In Progress`, then the first `Ready` item.
6. Use `planning/IMPLEMENTATION_STATUS.md` only for implementation and verification evidence; it does not redefine product direction.
7. Date-stamped reset/alignment notes are decision history. They never outrank the Baseline.
8. Historical, Legacy, rejected, invalid, or Gate-failed assets are comparison evidence only.

Do not restate global project decisions in this Skill, README, Roadmap, or Backlog.

## 2. Use Unity MCP economically

Read [references/mcp-compact-workflow.md](references/mcp-compact-workflow.md) before substantial Unity MCP work.

1. Confirm active Unity instance and Editor state.
2. Enable only tool groups needed for the current task.
3. Batch independent or repetitive operations.
4. Request compact status, counts, paths, failures, and evidence instead of full MCP payloads.
5. Do not treat transport errors as Unity project errors without checking Editor state and `_ReCamp` Console entries.

## 3. Implement safely

- Preserve unrelated user changes and do not work through unresolved in-scope merge conflicts.
- Edit repository sources, not `Library/`, `Temp/`, package caches, installed plugin caches, or generated IDE state.
- Prefer deterministic C# and versioned Unity assets over unrecorded Editor-only mutation.
- Save intended Scene and asset changes explicitly.
- Keep code, tests, and the smallest owning status entry aligned.
- Reuse verified Gray Box gameplay rules where they fit the Current Generation; do not recreate systems merely because the character presentation changed.
- Follow the Baseline solo-production budget: shared Rig/Animation/Shader foundations, limited dynamic equipment, no mandatory cloth/cable physics, and no unnecessary per-character subsystem.
- Do not promote generated art to `APPROVED` without human Gate evidence.

## 4. Verify proportionally

1. Refresh Unity and wait for compilation.
2. Check error-level Console entries relevant to `_ReCamp`.
3. Run the smallest EditMode/PlayMode suites proving the change; use full suites for shared runtime, Domain, save, Scene-flow, or input changes.
4. For gameplay/Scene work, perform a focused direct Play Mode probe.
5. Save intended Scene changes before restoring the agreed handoff Scene when appropriate.
6. Record actual environment, result, failures, and limitations in `planning/IMPLEMENTATION_STATUS.md`.
7. For documentation changes run `python scripts/validate_project_docs.py`.

## 5. Branch and completion rules

- Branch new work from `current/recamp-unified` using short `feature/*`, `art/*`, `docs/*`, or `fix/*` branches when needed.
- Merge Current work back into `current/recamp-unified`; do not merge Legacy directly into Current.
- Update only the owning Backlog/status/domain document.
- Code existence alone is not `Done`; generated image quality alone is not `APPROVED`.
- Merge to `main` only after an explicit Current Generation integration review.
