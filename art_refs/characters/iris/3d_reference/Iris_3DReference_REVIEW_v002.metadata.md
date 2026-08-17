# Iris 3D Reference REVIEW v002 Metadata

```yaml
Asset Name: Iris_3DReference_REVIEW_v002.png
Character: CH004 Iris
Purpose: Selected 5.7-5.8H stylized 3D concept reference
Status: REVIEW / CONCEPT ONLY
Generated Date: 2026-08-04
Generation Lineage: Pre-existing concept followed by deterministic image-space correction
Deterministic Tool: tools/art/Build-IrisProportionCorrections.ps1
Input: Iris_3DReference_REVIEW_v001.png
Canvas: 887x1774 RGB PNG
3D Target: 5.70-5.80 heads
Landmarks: crown y=188, chin y=410, sole y=1464
Measured Proportion: 1276 / 222 = 5.75 heads
Correction: Chin-to-sole vertical scale 0.8827; head region preserved
Usage Restriction: REVIEW and Blender blockout reference only; not a mesh or runtime asset
Reviewer: Pending
Approval: NOT GRANTED
```

Rebuild with:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools/art/Build-IrisProportionCorrections.ps1 -Force
```
