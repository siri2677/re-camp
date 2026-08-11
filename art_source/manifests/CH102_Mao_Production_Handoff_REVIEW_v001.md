# CH102 Kisaragi Mao - Production Handoff REVIEW v001

> Date: 2026-08-11
> Branch: `art/current-roster-gate-a-ch102`
> Status: `APPROVED 2D SHEET / Gate B preparation`
> Upstream approval: `art_source/manifests/CH102_Mao_Production_Sheet_Approval_20260811.md`

This document hands the approved CH102 2D sheet into Gate B preparation. It is a 2D production contract and does not approve a 3D Blockout, Unity import, or Runtime roster replacement.

## 1. Package and source lock

- `art_refs/characters/mao/concept/CH102_Mao_CharacterSheet_APPROVED_v001.png`
- `art_refs/characters/mao/concept/CH102_Mao_CharacterSheet_REVIEW_v001.png`
- `art_source/manifests/CH102_Mao_StateReference_v001.md`
- `art_refs/characters/mao/concept/CH102_Mao_Face128_WIP_A_v001.png`
- `art_refs/characters/mao/concept/CH102_Mao_Silhouette_ON_WIP_A_v001.png`
- `art_refs/characters/mao/concept/CH102_Mao_Silhouette_OFF_WIP_A_v001.png`
- `art_refs/characters/mao/concept/CH102_Mao_Desaturated_WIP_A_v001.png`

The visual anchor remains the second figure from the left in `CH101-105_Roster_FaceDiversity_WIP_v003.png`, from morning source commit `418ef96`. The approved sheet preserves the same identity across A/B/C.

## 2. State contract

| State | Use | Bow read | 2D-to-3D implication |
|---|---|---|---|
| `A Neutral` | idle, profile, roster, neutral production reference | folded/closed bow carried at the side | one weapon root, compact stored state |
| `B Ready` | workshop shot, combat preparation, transition | half-deployed bow | same weapon root with a controlled deployment pose |
| `C Full Deploy` | aim, attack setup, full equipment read | fully deployed mechanical bow | same weapon root; frame expansion is a state change, not a second weapon |

A/B/C must keep the same face, long silver-lavender hair, black/purple outfit direction, adult maker silhouette, and large purple mechanical bow identity. No state may introduce a new costume, body type, or unrelated weapon.

## 3. 2D-to-3D translation contract

| 2D element | Keep | Enlarge or clarify | Simplify / remove | Risk to verify |
|---|---|---|---|---|
| Face and hair | face shape, eye read, long silver-lavender hair mass | face planes and front hair silhouette for 5.2-5.3H readability | micro-strands and tiny highlights | face readability and camera clipping |
| Black/purple outfit | large color blocks, neckline, waist and leg silhouette | major purple panels and high-contrast seams | tiny fasteners, micro-stitching, hidden seams | joint deformation and material count |
| Folded bow | one recognizable bow body and grip | bow outline at quarter view | small internal hardware and duplicate frame parts | state A silhouette remains readable |
| Deployed bow | primary frame shape, grip, string/energy read if retained | outer frame and active purple read | separate independent rings, tiny mechanisms, free physics pieces | overdraw and hand clearance |
| Straps and small hardware | only silhouette-critical bands | none unless lost at 5.2-5.3H | buckle count, thin loose pieces | clipping and bone budget |

## 4. Proposed hierarchy and sockets

These names are Gate B proposals, not imported assets:

```text
CHR_KisaragiMao
  VisualRoot
    GEO_Body_LOD0
    GEO_Hair_LOD0
    GEO_Outfit_LOD0
    Socket_Weapon_R
      PRP_KisaragiMao_FoldingBow
        Socket_BowRoot
        Socket_BowGrip_L
        Socket_BowGrip_R
    Socket_CameraFocus
```

The bow should be one controlled equipment object with A/B/C presentation states. Do not build separate independently simulated frame rings or cable physics. Final socket transforms, collider policy, and naming remain Gate B work.

## 5. Material and performance direction

Proposed slots are `Face`, `Hair`, `Skin`, `Outfit`, `BowMetal`, and `BowPurple`. The final slot count, texture sizes, shader values, LOD transitions, and Android measurements must be proven during Gate B. Use shader/emission cues for the active bow read before adding dynamic geometry.

Physics policy: cloth, cable, and free-hanging multi-part bow physics are out of scope for the first proof. Prefer transforms, a single controlled driver, or a shader/VFX cue. `Hurtbox_Body` may be a temporary Gate B probe only.

## 6. Gate B readiness

- `CHA-B01` Front/Side/Back identity consistency: `NOT TESTED` - turnaround is not yet created.
- `CHA-B02` Equipment structure and state transitions: `CONDITIONAL` - state sheet exists; equipment detail and socket proof remain.
- `CHA-B03` 2D-to-3D simplification: `READY FOR GATE B REVIEW` - this handoff records the first controlled table.
- `CHA-B04` 5.2-5.3H adult readability and Humanoid compatibility: `CONDITIONAL` - proportion guide and blockout remain.
- `CHA-B05` Joint and outfit collision: `NOT TESTED` - no 3D pose blockout.
- `CHA-B06` Material slot separation: `CONDITIONAL` - proposed slots only; import proof missing.
- `CHA-B07` Camera, rig, and animation clearance: `CONDITIONAL` - quarter-view proof missing.
- `CHA-B08` Hair/equipment physics and penetration budget: `READY FOR GATE B REVIEW` - no physics is the current policy; runtime probe missing.
- `CHA-B09` Idle/Attack/Skill/Victory equipment motion: `NOT TESTED` - motion thumbnails/clips missing.
- `CHA-B10` Polygon/texture/bone/blendshape/LOD/shader budget: `CONDITIONAL` - common spec exists; measured proof missing.

## 7. Boundary

This handoff does not authorize Blender/FBX export, 3D Blockout, Unity import, Runtime roster replacement, or release. Those actions require a separate Gate B review and approval.
