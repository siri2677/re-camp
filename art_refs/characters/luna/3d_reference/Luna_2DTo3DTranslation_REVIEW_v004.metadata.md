# Luna 2D to 3D Translation REVIEW v004 Metadata

```yaml
Asset Name: Luna_2DTo3DTranslation_REVIEW_v004.png
Character/Environment: CH001 Luna
Purpose: Selected 2D identity to 3D stylization translation review board
Status: REVIEW
Generated Date: 2026-08-04
Generation Tool: tools/art/Build-Luna2DTo3DTranslationReview.ps1
Renderer: System.Drawing
Canvas: 2048x1440 RGBA PNG
Input 2D: art_refs/characters/luna/concept/Luna_KeyArt_REVIEW_v001.png
Input 3D: art_refs/characters/luna/3d_reference/Luna_3DReference_REVIEW_v001.png
Human Edits: None; deterministic layout only
Usage Restriction: REVIEW and Blockout handoff only
Reviewer: Pending
Approval: NOT GRANTED
```

## Proportion Inputs

| Source | Source size | Crown | Chin | Sole | Head unit | Crown-to-sole | Result |
|---|---:|---:|---:|---:|---:|---:|---:|
| 2D Key Art | 866x1817 | `(409,116)` | `(419,339)` | `(611,1698)` | 223 px | 1582 px | 7.09H PASS |
| 3D Reference | 1024x1536 | `(524,153)` | `(512,392)` | `(425,1442)` | 239 px | 1289 px | 5.39H PASS |

The board normalizes both crown-to-sole spans to the same display height. Mechanical sensor-ear tips are not
counted as the anatomical crown. Head-unit guides are calculated from each source's measured ratio, not from a
manual visual approximation.

## Reproduction

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools/art/Build-Luna2DTo3DTranslationReview.ps1
```

Use `-Force` only when intentionally rebuilding the same deterministic REVIEW output.
