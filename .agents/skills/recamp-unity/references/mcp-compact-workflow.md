# Compact Unity MCP Workflow

Load this reference only while performing Unity MCP operations.

## Tool groups

- `core`: keep active for scene, GameObject, component, asset, editor, and Console work.
- `testing`: activate immediately before `run_tests` / `get_test_job`; deactivate after verification if no longer needed.
- `scripting_ext`: activate only for `execute_code` or ScriptableObject runtime probes.
- `docs`, `profiling`, `ui`, `animation`, `vfx`, `probuilder`, `asset_gen`: activate only for a matching task.

If an allowlisted tool is unavailable, first use `manage_tools` to activate its group. Change `.codex/config.toml` only when the tool itself is not allowlisted and is repeatedly required across sessions.

## Minimize returned context

- Batch two or more independent/repetitive operations with `batch_execute`.
- Use `functions.exec` as a projection layer: extract only `success`, `error`, counts, relevant paths/IDs, and short summaries before calling `text(...)`.
- Never call `text(JSON.stringify(result))` on a raw Unity response.
- Cap direct output with a small `max_output_tokens`; increase it only after a compact response proves insufficient.
- Query hierarchy/search results with narrow roots, patterns, and pages. Fetch component metadata before serialized values.
- Filter Console by severity and `_ReCamp`; omit full stacks unless investigating a failure.
- For tests, request summary data first (`include_details=false` where supported), then request only failed-test details.
- For images/screenshots, inspect the image itself instead of forwarding its encoded payload as text.

## Recommended sequence

1. Inspect editor/instance state.
2. Batch read-only discovery.
3. Apply repository patches or a small durable Unity mutation.
4. Refresh/compile once after a coherent change set.
5. Read filtered errors.
6. Activate `testing`, run EditMode and PlayMode, and summarize totals plus failed names.
7. Run a targeted PlayMode probe only when tests cannot prove scene behavior.
8. Stop Play Mode, restore the Battle scene, save intended assets, and deactivate optional groups.

## Recovery

- On a stale test job, query the existing job once before retrying. Retry only after confirming the editor is idle.
- On an instance mismatch, enumerate instances and select the exact project/editor pair; do not guess a persisted identifier.
- On compilation failure, fix the first causal `_ReCamp` error before requesting broad logs.
- If MCP is unavailable, continue with local source inspection and clearly separate verified facts from unverified Unity state.
