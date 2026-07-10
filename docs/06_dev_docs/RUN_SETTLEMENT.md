# Run settlement

Combat rewards are provisional during an exploration run. They become permanent only when `GameSession.SettleRun` receives a terminal outcome.

| Outcome | Default retention | Rationale |
|---|---:|---|
| Extracted | 100% | Player safely leaves the stage. |
| Defeated | 50% | Failure has a meaningful cost without invalidating the session. |
| Expired | 75% | Time pressure has a cost distinct from combat defeat. |

The retention policy is an injected, validated value rather than a hard-coded combat rule. It can later be served as versioned remote configuration. A run can be settled exactly once, and returning to the lobby is blocked until settlement completes; this prevents duplicate reward grants and incomplete persistence.
