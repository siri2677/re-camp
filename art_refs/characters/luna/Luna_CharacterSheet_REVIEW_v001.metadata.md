# Luna Integrated Character Production Sheet REVIEW v001 — Metadata

- Asset: `Luna_CharacterSheet_REVIEW_v001.png`
- Status: `REVIEW ONLY`
- Human approval: `Pending`
- APPROVED: `NOT GRANTED`
- Dimensions: `4096x4608`
- Builder: `tools/art/Build-LunaCharacterSheetReview.ps1`
- Composition: six production-source frames, three validation-evidence panels, Gate A `16`-row precheck, Gate B `9`-row precheck

## Deterministic inputs

| Frame / evidence | Source | Dimensions |
|---|---|---:|
| Key Art | `concept/Luna_KeyArt_REVIEW_v001.png` | `866x1817` |
| Turnaround | `turnaround/Luna_Turnaround_REVIEW_v003.png` | `1672x941` |
| Expressions | `expressions/Luna_ExpressionSheet_REVIEW_v001.png` | `1717x916` |
| Equipment | `equipment/Luna_EquipmentSheet_REVIEW_v001.png` | `1536x1024` |
| Material Palette | `concept/Luna_MaterialPalette_REVIEW_v001.png` | `1600x1050` |
| 2D to 3D Translation | `3d_reference/Luna_2DTo3DTranslation_REVIEW_v004.png` | `2048x1440` |
| 128px Face | `concept/Luna_Face128_REVIEW_v002.png` | `128x128` |
| Silhouette | `concept/Luna_SilhouetteTest_REVIEW_v002.png` | `1600x960` |

The tool rejects a build if any source dimensions change, uses fixed frame geometry and fonts, and emits a 24-bit PNG. Turnaround `v003` is the current integrated-sheet input; earlier turnaround versions remain separate failed `REVIEW` history.

## Locked proportion evidence

- 2D target: `6.90–7.10 H`; measured Key Art: `7.09 H`, automated image-space `PASS`
- 3D target: `5.30–5.40 H`; translation concept: `5.39 H`, concept precheck only
- Blender/Unity character proof: `NOT TESTED`

## Precheck-state contract

- `PRECHECK PASS` and `AUTO PASS` mean required evidence is present and internally readable; they do not grant Gate approval.
- Subjective human approval is `Pending`.
- Five-character face, silhouette, palette, and motif cross-review is `Pending`.
- Blender/Unity proportion, rig, joint, pose, camera, animation, physics, and socket proof is `Not Tested`.
- The board must always display `REVIEW ONLY / HUMAN APPROVAL NOT GRANTED`.
