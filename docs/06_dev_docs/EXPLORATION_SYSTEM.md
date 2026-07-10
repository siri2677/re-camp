# Exploration system

`ExplorationRun` is a deterministic stage scheduler with explicit terminal states. Unity is responsible for turning each `SpawnRequest` into a spawned prefab; it must not recalculate wave timing itself.

## Rules

- Every stage validates duration, extraction time, boss time, and every scheduled wave at construction.
- The scheduler returns each scheduled wave once, in timestamp order.
- The boss can be emitted only once.
- Extraction, player defeat, and time expiry are mutually exclusive terminal states.
- Ticks after a terminal state return no new spawns.

`ST001` uses the five-minute duration specified in the stage table. Its concrete wave counts and timestamps are intentionally represented as data so balancing can change them without altering runtime rules.

## Production follow-up

Before online leaderboards or ranked rewards, persist a run seed, stage version, timeline of skill selections, and terminal state. A backend can then reject results that do not conform to the published stage schedule.
