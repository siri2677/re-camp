# CH104 Shion Tategami - Production Handoff REVIEW v001

> Date: 2026-08-12
> Branch: `art/current-roster-gate-a-ch102`
> Status: `APPROVED 2D SHEET / Gate B preparation`
> Upstream approval: `art_source/manifests/CH104_Shion_Production_Sheet_Approval_20260812.md`
> Gate B preflight: `art_source/manifests/CH104_Shion_GateB_Preflight_REVIEW_v001.md`
> Translation contract: `art_source/manifests/CH104_Shion_2DTo3D_Translation_REVIEW_v001.md`

This document hands the approved CH104 2D sheet into Gate B preparation. It is a 2D production contract and does not approve a 3D Blockout, Blender/FBX export, Unity import, or Runtime roster replacement.

## 1. Package and source lock

- `art_refs/characters/shion/concept/CH104_Shion_CharacterSheet_APPROVED_v001.png`
- `art_refs/characters/shion/concept/CH104_Shion_CharacterSheet_REVIEW_v001.png`
- `art_source/manifests/CH104_Shion_StateReference_v001.md`
- `art_refs/characters/shion/concept/CH104_Shion_Face128_WIP_A_v001.png`
- `art_refs/characters/shion/concept/CH104_Shion_Silhouette_ON_OFF_WIP_A_v001.png`
- `art_refs/characters/shion/concept/CH104_Shion_ExpressionSheet_REVIEW_v001.png`
- `art_refs/characters/shion/concept/CH104_Shion_EquipmentSheet_REVIEW_v001.png`
- `art_refs/characters/shion/concept/CH104_Shion_MaterialPalette_REVIEW_v001.png`
- `art_source/manifests/CH104_Shion_2DTo3D_Translation_REVIEW_v001.md`
- `art_source/manifests/CH104_Shion_GateB_Preflight_REVIEW_v001.md`

The visual anchor remains the fourth figure from the left in `CH101-105_Roster_FaceDiversity_WIP_v003.png`, from morning source commit `418ef96`. The approved sheet preserves the same Shion identity across A/B/C.

## 2. State contract

| State | Use | Prism fan read | Map-ring read | 2D-to-3D implication |
|---|---|---|---|---|
| `A Neutral` | idle, profile, roster, neutral production reference | folded/quiet | lowered/quiet | one compact fan root and the same ring object |
| `B Ready` | surveying preparation and transition | half-open | active near the hand | same fan root with controlled partial deployment |
| `C Full Survey` | precision mapping presentation | fully open with narrow beam cue | one active ring | same fan root and ring; state change, not new equipment |

A/B/C must keep the same face, indigo hair with magenta tips, ivory/indigo outfit, adult vertical silhouette, one prism fan, and one single map ring. No state may introduce a new costume, body type, unrelated weapon, or independent orbit-ring system.

## 3. 2D-to-3D translation handoff

| 2D element | Keep | Enlarge or clarify | Simplify / remove | Risk to verify |
|---|---|---|---|---|
| Face and hair | angular face, narrow eyes, asymmetrical bangs, large indigo hair mass | face planes and front/side hair silhouette for `5.2~5.8H` readability | micro-strands, tiny lashes, hair physics | face readability and camera clipping |
| Ivory/indigo outfit | major ivory ground, indigo geometric panels, tall vertical read | collar, waist break, lower panel silhouette, boots | micro trim, repeated seams, hidden hardware | joint deformation and material count |
| Prism fan | folded/half-open/full-open outer silhouette, grip, pivot, narrow cue | pivot, hand clearance, major facet groups | tiny hinges, internal facet lines, beam mesh | overdraw, hand clearance, state transforms |
| Single map ring | one oval frame and one faceted map core | carry position, diameter, core center | micro trim, glints, duplicate ring structures | socket transform and camera overlap |
| Magenta activation | restrained edge/tip cue | readable C-state edge and map-core cue | large glow, floating symbols, extra geometry | emission budget and state sync |

The authoritative keep/enlarge/simplify/remove table remains in `CH104_Shion_2DTo3D_Translation_REVIEW_v001.md`.

## 4. Proposed hierarchy and sockets

These names are Gate B proposals, not imported assets:

```text
CHR_ShionTategami
  VisualRoot
    GEO_Body_LOD0
    GEO_Hair_LOD0
    GEO_Outfit_LOD0
    Socket_Equipment_Primary
      PRP_ShionTategami_PrismFan
        Socket_FanGrip
        Socket_FanPivot
        Socket_FanBeam
    Socket_MapRing_Carry
      PRP_ShionTategami_MapRing
        Socket_MapRingCore
    Socket_VFXCenter
    Socket_CameraFocus
```

The fan and map ring remain one controlled presentation object each. Final hand side, transforms, collider policy, object names, and prefab boundaries require Gate B proof.

## 5. Material and performance direction

The material palette proposes six starting categories: `Face`, `Hair`, `Skin`, `Outfit`, `Equipment`, and `PrismEmission`. The source-faithful roles are porcelain ivory matte fabric, deep indigo matte panels/hair masses, restrained hot-magenta activation, smoke-gray trim, translucent lavender-ivory prism, and muted warm gold hardware.

Carry the common starting budget from `CHARACTER_3D_SPEC.md`: character `LOD0 <=18,000` triangles, representative equipment addition `LOD0 <=2,000`, material slots `<=6`, deform bones `<=55`, helper bones/drivers `<=8`, and Cloth/Cable Physics `0`. Final shader values, texture sizes, overdraw, LOD transitions, Android memory, and socket measurements remain Gate B proof.

## 6. Gate B handoff readiness

- `CHA-B01~B03`: `READY FOR GATE B REVIEW` from approved 2D evidence and the translation contract.
- `CHA-B04`, `CHA-B06`, `CHA-B07`, `CHA-B10`: `CONDITIONAL` until proportion, import, camera, and measured budget proof exists.
- `CHA-B05`: `NOT TESTED` until a 3D pose blockout exists.
- `CHA-B08`: no-physics policy is ready for review; penetration/performance proof is missing.
- `CHA-B09`: expression and surveying motion direction only; clips/thumbnails are not tested.

## 7. Boundary

This handoff does not authorize Blender/FBX export, 3D Blockout, Unity import, Runtime roster replacement, or release. Those actions require the missing 3D proof environment and separate human Gate B approval.
