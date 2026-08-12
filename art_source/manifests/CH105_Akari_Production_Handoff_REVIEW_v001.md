# CH105 Kurogane Akari - Production Handoff REVIEW v001

> Date: 2026-08-12
> Branch: `art/current-roster-gate-a-ch102`
> Status: `APPROVED 2D SHEET / Gate B preparation`
> Upstream approval: `art_source/manifests/CH105_Akari_Production_Sheet_Approval_20260812.md`
> Gate B preflight: `art_source/manifests/CH105_Akari_GateB_Preflight_REVIEW_v001.md`
> Translation contract: `art_source/manifests/CH105_Akari_2DTo3D_Translation_REVIEW_v001.md`

This document hands the approved CH105 2D sheet into Gate B preparation. It is a controlled 2D production contract and does not approve a 3D Blockout, Blender/FBX export, Unity import, Runtime roster replacement, or release use.

## 1. Package and source lock

- `art_refs/characters/akari/concept/CH105_Akari_CharacterSheet_APPROVED_v001.png`
- `art_refs/characters/akari/concept/CH105_Akari_CharacterSheet_REVIEW_v001.png`
- `art_refs/characters/akari/concept/CH105_Akari_Face128_WIP_A_v001.png`
- `art_refs/characters/akari/concept/CH105_Akari_Silhouette_ON_OFF_WIP_A_v001.png`
- `art_refs/characters/akari/concept/CH105_Akari_ExpressionSheet_REVIEW_v001.png`
- `art_refs/characters/akari/concept/CH105_Akari_EquipmentSheet_REVIEW_v001.png`
- `art_refs/characters/akari/concept/CH105_Akari_MaterialPalette_REVIEW_v001.png`
- `art_source/manifests/CH105_Akari_GateA_Review_v001.md` and `art_source/manifests/CH105_Akari_Production_Sheet_Approval_20260812.md`
- `art_source/manifests/CH105_Akari_2DTo3D_Translation_REVIEW_v001.md`
- `art_source/manifests/CH105_Akari_GateB_Preflight_REVIEW_v001.md`

The visual anchor remains the fifth figure from the left in `CH101-105_Roster_FaceDiversity_WIP_v003.png`, from morning source commit `418ef96`. The approved sheet preserves the same Akari identity across A/B/C.

## 2. State contract

| State | Use | Equipment read | 2D-to-3D implication |
|---|---|---|---|
| `A Neutral` | idle, profile, roster, neutral production reference | gauntlets quiet; single anchor ring lowered | one compact equipment root and quiet stored presentation |
| `B Ready` | frontline preparation and transition | one active gauntlet; one ring lifted; short restrained line | same equipment objects with controlled state transforms |
| `C Full Guard` | full protection presentation | paired gauntlet read; one ring brace; restrained line | same objects and one state driver; no shield swarm or cable physics |

A/B/C must keep the same mature face, black outer hair with teal inner/back hair, broad grounded protector read, black/forest-green utility layers, copper-gold hardware, and one anchor-ring identity. No state may introduce a new costume, body type, second ring, unrelated weapon, or full-body armor redesign.

## 3. 2D-to-3D translation handoff

| 2D element | Keep | Enlarge or clarify | Simplify / remove | Risk to verify |
|---|---|---|---|---|
| Face and hair | mature amber eyes, strong brows, black outer hair, teal inner/back boundary | eye/brow plane, jaw, front silhouette, major back locks | micro-strands, tiny highlights, hair physics | face readability and camera clipping |
| Body and utility outfit | broad shoulders, grounded hips/legs, black/forest-green utility blocks, boots | shoulder/waist break, collar, boot and coat-tail contour | seam density, tiny buckles, hidden straps | joint clipping and value collapse |
| Paired gauntlets | forearm/knuckle mass and paired identity | wrist joint, hand clearance, large plate breaks | hidden mechanisms and independent micro parts | elbow/wrist penetration |
| Single anchor ring | one oval ring, major anchor points, one line attach | diameter, carry position, active center, outer contour | small trim, duplicate rings, orbit clones | camera overlap and hand clearance |
| Restrained anchor line | one/two readable line segments and attachment points | end positions and state visibility | dangling links and Cloth/Cable simulation | penetration, overdraw, state sync |
| Copper/teal activation | restrained material/emission cues | C-state ring and gauntlet read | floating symbols, full-screen glow, excess particles | mobile overdraw and value hierarchy |

The authoritative reduction table remains in `CH105_Akari_2DTo3D_Translation_REVIEW_v001.md`.

## 4. Proposed hierarchy and sockets

These names are Gate B proposals, not imported assets:

```text
CHR_KuroganeAkari
  VisualRoot
    GEO_Body_LOD0
    GEO_Hair_LOD0
    GEO_Outfit_LOD0
    Socket_Equipment_Primary
      PRP_KuroganeAkari_Gauntlet_L
      PRP_KuroganeAkari_Gauntlet_R
      PRP_KuroganeAkari_AnchorRing
        Socket_AnchorRing_Carry
        Socket_AnchorRing_Active
        Socket_LineAttach
    Socket_Gauntlet_L
    Socket_Gauntlet_R
    Socket_VFXCenter
    Socket_CameraFocus
```

The pair of gauntlets and the single anchor ring remain controlled presentation objects. Final hand side, transforms, colliders, object names, and prefab boundaries require Gate B proof. Do not add physics bones for cable links, hair micro-strands, ring trim, or hidden gauntlet mechanisms in the first proof.

## 5. Material and performance direction

The material palette proposes six starting categories: `Face`, `Hair`, `Skin`, `Outfit`, `GauntletMetal`, and `AnchorRingActivation`. Carry the common starting budget from `CHARACTER_3D_SPEC.md`: character `LOD0 <=18,000` triangles, representative equipment addition `LOD0 <=2,000`, material slots `<=6`, deform bones `<=55`, helper bones/drivers `<=8`, Face BlendShapes `<=8`, and Cloth/Cable Physics `0`.

Final shader values, texture sizes, emission, SetPass, overdraw, LOD transitions, Android memory, and socket measurements remain Gate B proof.

## 6. Gate B handoff readiness

- `CHA-B01~B03`: `READY FOR GATE B REVIEW` from approved 2D evidence and the translation contract.
- `CHA-B04`, `CHA-B06`, `CHA-B07`, `CHA-B10`: `CONDITIONAL` until proportion, import, camera, and measured budget proof exists.
- `CHA-B05`: `NOT TESTED` until a 3D pose blockout exists.
- `CHA-B08`: no-physics policy is ready for review; penetration/performance proof is missing.
- `CHA-B09`: A/B/C equipment direction only; clips/thumbnails are not tested.

## 7. Boundary

This handoff does not authorize Blender/FBX export, 3D Blockout, Unity import, Runtime roster replacement, Android proof, or release. Those actions require the missing 3D proof environment and separate human Gate B approval.
