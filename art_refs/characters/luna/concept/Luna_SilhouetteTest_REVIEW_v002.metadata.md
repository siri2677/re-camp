# Luna Silhouette Test REVIEW v002 — Metadata

- Asset: `Luna_SilhouetteTest_REVIEW_v002.png`
- Status: `REVIEW`
- Human approval: `Pending`
- APPROVED: `NOT GRANTED`
- Builder: `tools/art/Build-LunaSelectedDesignEvidence.ps1`
- Output dimensions: `1600x960`

## Sources and normalization

- Equipment-included source: `Luna_KeyArt_REVIEW_v001.png` (`866x1817`)
  - image-space crown: `y=116`
  - image-space sole: `y=1698`
  - source span: `1582 px`
  - silhouette includes backpack, cable tail, and paired daggers
- Gear-minimal source: `../turnaround/Luna_Turnaround_REVIEW_v001.png` (`1672x941`)
  - front-view image-space crown: `y=53`
  - front-view image-space sole: `y=910`
  - source span: `857 px`
  - silhouette removes weapon load and emphasizes costume/front-view readability
- Both silhouettes are rendered to the same `600 px` crown-to-sole span.
- Sensor ears extend above the anatomical crown guide and are intentionally retained as identity equipment.

## Deterministic segmentation

- KeyArt dark-background classifier: bright `>=125`; neutral floor `42` within range `15`; warm/cyan preservation; close radius `2`; minimum component `8 px`.
- Turnaround classifier: per-row edge-background distance, close radius `2`, minimum component `16 px`.
- Bounded internal holes are filled; exterior negative space is retained.

This comparison is silhouette evidence, not a human approval record.
