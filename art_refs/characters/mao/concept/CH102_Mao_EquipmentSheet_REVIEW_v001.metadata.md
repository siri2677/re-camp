# CH102 Mao Equipment Sheet REVIEW v001 - Metadata

| Field | Value |
|---|---|
| Asset | `CH102_Mao_EquipmentSheet_REVIEW_v001.png` |
| Scope | CH102 representative equipment detail: one folding compound bow across A/B/C states |
| Backlog | `ART-1106` |
| Generated | 2026-08-11 |
| Tool | Built-in Codex `image_gen.imagegen` |
| Source reference | Approved CH102 character sheet and source-faithful candidate board v002 |
| Source commit | `418ef96` - `art: refine current roster gate A visuals` |
| Status | `REVIEW / 2D SHEET PACKAGE SUPPORT` |
| Human approval | Not separately approved; Gate A unified package is approved |
| Runtime use | Not permitted; production review evidence only |

## Included evidence

- Top row: `A` folded/neutral, `B` half-deployed/ready, and `C` full-deployed/aim states.
- Bottom row: enlarged bow study showing the central grip, folding pivots, curved limbs, cams, string path, dark metal, purple panels, and restrained gold hardware.
- All panels represent one controlled bow object, not three weapons.

## 2D-to-3D handoff notes

- Keep: overall purple compound-bow silhouette, central grip, two curved limbs, cams, string path, and one readable fold/deploy mechanism.
- Enlarge or clarify: grip, bow root, outer frame, and active purple state read at quarter view.
- Simplify: micro-fasteners, duplicate internal braces, tiny cams, and hidden mechanical layers.
- Remove from first proof: independent floating rings, cable physics, and separate free-moving bow parts.
- Proposed attachment references remain `Socket_Weapon_R`, `Socket_BowRoot`, `Socket_BowGrip_L`, and `Socket_BowGrip_R`.

## Open review points

- Confirm exact socket transforms, collider policy, and state transition implementation during Gate B.
- Confirm final material-slot count and active-state shader/emission budget.
- This image is not a standalone Gate B approval and must not drive Unity import.
