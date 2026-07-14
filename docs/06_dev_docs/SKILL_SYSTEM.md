# Skill system

The MVP catalog defines six skills from `tables/skill_table.md`. Skill definitions are data objects with stable IDs, rarity, activation type, effect, level cap, and cooldown. Unity UI should render these definitions rather than owning duplicate values.

## Runtime guarantees

- A draft uses an explicit linear-congruential seed algorithm, enabling replay/debugging and future server validation across runtimes.
- A draft never contains duplicate skills.
- A loadout contains at most six unique skills.
- Selections upgrade an existing skill only until its configured maximum level.
- Active skills cannot be used during cooldown; passive skills cannot have a cooldown.

## Future service integration

Persist selected skill IDs and levels in the active run snapshot. A future authoritative run validator can generate the same draft offers from the stored seed and verify selections without trusting client-provided effect values.
