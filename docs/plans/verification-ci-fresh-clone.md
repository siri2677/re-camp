# CI and Fresh Clone Verification Plan

## Goal

Make the Unity EditMode and PlayMode regression suites reproducible in GitHub Actions and verify the tracked Unity project from a clean checkout without touching the developer working tree.

## Existing Architecture

The Unity project is the repository root (`.`) on Unity `6000.5.3f1`. The project owns `ReCamp.Domain`, `ReCamp.UnityAdapter`, `ReCamp.Runtime`, EditMode tests, and PlayMode tests. GameCI's Unity Test Runner is the repository CI transport.

## Files to Modify

- `.github/workflows/unity-tests.yml`
- `.github/workflows/docs-consistency.yml`
- `scripts/validate_gate_b_preflight.py`
- `planning/DEV-0113_CORE_INTEGRATION_RESULT.md`
- `planning/IMPLEMENTATION_STATUS.md`
- `planning/sprint_backlog.md`

## Verification Flow

1. Run both Unity test modes locally from the current working tree.
2. Clone the current branch into a temporary directory.
3. Apply only the working-tree source snapshot needed for verification without changing the source checkout.
4. Compile and run both test modes in the clean directory.
5. Keep CI credentials in GitHub Secrets; never put Unity license material in the repository.

## Edge Cases

- The local project may have no Android module; this workflow remains Windows/editor regression only.
- GameCI requires Unity license secrets on the GitHub repository; a workflow file alone is not evidence of a hosted run.
- Generated `Library`, `Logs`, and `TestResults` must stay out of the clean source snapshot.


## Verification Results

- Working tree Unity compile: exit code `0`.
- Working tree EditMode: `31/31` passed.
- Working tree PlayMode: `19/19` passed.
- Fresh clone Unity `6000.5.3f1` compile: exit code `0`.
- Fresh clone EditMode: `31/31` passed.
- Fresh clone PlayMode: `19/19` passed.
- Workflow YAML was inspected locally. Hosted Unity CI has not succeeded because the repository Unity credentials are missing; the workflow now reports this as a blocked preflight and skips the runner instead of failing during license activation.
- Current-generation Gate B documentation is validated separately by `scripts/validate_gate_b_preflight.py`.

## Completion Criteria

- Workflow runs EditMode and PlayMode with Unity `6000.5.3f1` when credentials are available, and uploads the fixed `artifacts/` directory on failure or success.
- Workflow reports a successful blocked-preflight status when credentials are unavailable; this is not a Unity test pass.
- A clean checkout compiles and passes the same `31` EditMode and `19` PlayMode tests.
- Status documents distinguish local and hosted CI evidence.
