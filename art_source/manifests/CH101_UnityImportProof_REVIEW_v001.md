# CH101 Unity Import Proof — Review v001

- Status: `BLOCKED / UNITY LICENSED EDITOR UNAVAILABLE`
- Gate: `Gate B/C preflight only`
- Source repository: `siri2677/re-camp`
- Source branch: `art/current-roster-gate-a`
- Source commit: `183b0f0983969937d779f70b2ac51e53fc976203`
- Previous asset: `Assets/_ReCamp/Art/Characters/CH101/CH101_Blockout_REVIEW_v007.fbx` (kept for comparison)
- Previous asset: `Assets/_ReCamp/Art/Characters/CH101/CH101_Blockout_REVIEW_v008.fbx` (kept for comparison)
- Previous asset: `Assets/_ReCamp/Art/Characters/CH101/CH101_Blockout_REVIEW_v009.fbx` (LOD review comparison)
- Expected asset: `Assets/_ReCamp/Art/Characters/CH101/CH101_Blockout_REVIEW_v010.fbx`
- Local v010 FBX: `8,161,084 bytes / SHA-256 E4F06F7360E65B5F0EE5082CF3CFAC339C17E00B40C1C34D750224F7FDAA5515`
- Validator: `Assets/_ReCamp/Editor/ReCampCharacterImportProof.cs`
- Report: `Assets/_ReCamp/Art/Characters/CH101/Reports/CH101_UnityImportProof_REVIEW_v003.json`

## Checks implemented

The editor validator is read-only and records the following when the FBX is
present:

- `ModelImporter` animation type and material import mode
- Humanoid animation type requirement
- the eight Gate B socket names
- mesh and triangle counts
- skinned renderer and bone counts
- imported animation asset count
- the combined review budget of 18,000 body tris + 2,000 equipment tris

## Current evidence

The locked Blender v010 production-skinning-review FBX has now been generated and copied to the
expected Unity path. LOD0 measures 19,090 triangles and passes the combined
20,000-triangle review budget; LOD1/LOD2 measure 10,383/5,704 triangles. It uses six named material slots and deterministic two-bone review weights (maximum two influences per vertex). Unity `6000.5.3f1` is installed, but the batch editor currently
returns a missing-license error before asset import, so the validator could not
run and no importer settings are claimed as verified.

## Remaining Gate B evidence

1. Import the locked v010 FBX and capture importer settings.
2. Confirm Humanoid mapping, sockets, material slots and quarter-view scale.
3. Create a temporary CH101 prefab and capture front/side/back plus pose and
   equipment ON/OFF evidence.
4. Create and configure a Unity `LODGroup` from the exported LOD0/LOD1/LOD2
   objects and reconcile the measured result with `CHARACTER_3D_SPEC.md`.
5. Add Unity Animator clips and Android device performance evidence.

This document is a review record, not human Gate B approval.
