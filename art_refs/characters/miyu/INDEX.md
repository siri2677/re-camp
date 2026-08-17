# Miyu Character Design Review Package

- Package scope: `ART-1101` through `ART-1108`
- Package status: `STYLE REJECTED / HISTORY ONLY`
- Style status: `USER GATE A FAIL — 2026-08-07`
- Generated/reviewed: 2026-08-07
- Human reviewer: `Failed; revision required`
- Approval: `NOT GRANTED`
- Runtime implementation: `Not Tested`

## Locked direction

Miyu is an adult, attractive and feminine drone technician. Her quiet baseline is sleepy and deadpan; machine talk is the single strong enthusiasm switch. The locked 2D construction is `6.8–7.0H`, and the 3D translation is `5.2–5.3H`.

Identity locks:

- smoky-lilac asymmetric jaw-length bob with one neon-blue inner streak;
- graphite maintenance inner plus asymmetric cropped work bomber;
- exactly one oversized sleeve;
- asymmetric tool belt, short panel and chunky low-heel boots;
- exactly two drones: one round expressive scanner/pickup unit and one angular targeting/fire unit;
- right control gauntlet, holo pad and compact tool kit;
- no rifle, shield, medical motif, cat motif, long purple hair or symmetric sleeves.

## Review artifact map

| ART ID | Deliverable | Review artifact | State |
|---|---|---|---|
| ART-1101 | Three direction candidates and selection | `concept/Miyu_FullBodyCandidates_REVIEW_v002.png` | `REVIEW` |
| ART-1102 | Adult face and asymmetric smoky-lilac hair | `concept/Miyu_KeyArt_REVIEW_v002.png`, `face/Miyu_Face128_REVIEW_v002.png` | `REVIEW` |
| ART-1103 | Asymmetric technician fashion and silhouette | Key Art plus `silhouette/Miyu_SilhouetteTest_REVIEW_v001.png` | `REVIEW` |
| ART-1104 | Strict front/left/back turnaround | `turnaround/Miyu_Turnaround_REVIEW_v002.png` | `REVIEW / Conditional` |
| ART-1105 | Exactly eight expressions | `expressions/Miyu_ExpressionSheet_REVIEW_v002.png` | `REVIEW` |
| ART-1106 | Equipment construction | `equipment/Miyu_EquipmentSheet_REVIEW_v002.png` | `REVIEW` |
| ART-1107 | Palette and material definition | `palette/Miyu_MaterialPalette_REVIEW_v001.png` | `REVIEW` |
| ART-1108 | 2D-to-3D translation and implementation notes | `3d_reference/Miyu_2DTo3DTranslation_REVIEW_v002.png`, `3d_reference/Miyu_3DNotes_REVIEW_v001.md` | `REVIEW / Conditional` |

Package index artifact: `Miyu_CharacterSheet_REVIEW_v002.png`. Supporting proportion evidence is under `proportion/`; the integrated sheet is not assigned a separate ART-1101–1108 backlog row.

## Measured evidence

| Artifact | Crown | Chin | Sole | Ratio | Gate |
|---|---:|---:|---:|---:|---|
| 2D Key Art | 86 | 286 | 1464 | `6.890H` | image-space pass |
| Turnaround front | 70 | 196 | 940 | `6.905H` | deterministic image-space pass |
| Turnaround left | 70 | 196 | 940 | `6.905H` | deterministic image-space pass |
| Turnaround back | 70 | 196 | 940 | `6.905H` | deterministic image-space pass |
| 3D volume reference | 205 | 458 | 1532 | `5.245H` | deterministic image-space pass |

The table records the deterministic image-space baseline. The v002 Japanese-subculture style-reset artifacts preserve the same target bands and replace v001 as the current face/rendering anchors. They are review evidence, not proof of production topology or rig deformation.

## Human and implementation gates still open

- subjective attractiveness, femininity and subculture appeal;
- five-character face, palette, motif and silhouette collision review;
- originality and rights review;
- actual mesh topology, materials, Humanoid rig, joint clearance and gameplay-camera readability;
- drone sockets, VFX anchors, physics limits and the Idle/Attack/Skill/Victory motion set.

Nothing in this package is `APPROVED`. Human approval remains `Pending` and approval is `NOT GRANTED`.

## A2 supplemental evidence

- `concept/Miyu_PoseLayerPlan_REVIEW_v001.png`: three representative pose-intent blockouts, hair structure/physics groups and Base/Mid/Outer/Gear/VFX layer stack.
- This is a deterministic `BLOCKOUT DIAGRAM`; anatomy, model clearance, rig, sockets, physics and runtime camera proof remain pending.
