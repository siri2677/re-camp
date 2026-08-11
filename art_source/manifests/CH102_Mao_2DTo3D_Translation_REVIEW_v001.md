# CH102 Kisaragi Mao - 2D-to-3D Translation REVIEW v001

> Date: 2026-08-11
> Branch: `art/current-roster-gate-a-ch102`
> Status: `REVIEW / 2D-to-3D contract / Gate B not approved`
> Backlog: `ART-1108`
> Source package: `art_refs/characters/mao/CH102_Mao_ART-1101-1108_REVIEW_Package.md`
> Common contract: `docs/05_art_concept/CHARACTER_3D_SPEC.md`

This document converts the approved CH102 2D identity and REVIEW support sheets into a controlled 3D production contract. It defines what must survive the reduction from the current 2D target of `6.8-7.0H` to the Baseline 3D target of `5.2-5.3H`. It does not claim a model, rig, blockout, Unity import, or Gate B approval.

## 1. Identity and state lock

- The morning roster source remains the visual authority: second figure from the left in `CH101-105_Roster_FaceDiversity_WIP_v003.png`, source commit `418ef96`.
- The approved A/B/C character sheet is the identity anchor; turnaround, expression, equipment, palette, Face128, and silhouette evidence are supporting references.
- A/B/C are states of one character and one bow object:

| State | 2D read | 3D presentation rule |
|---|---|---|
| `A Neutral` | folded bow carried at the side | compact stored pose on one bow root |
| `B Ready` | half-deployed bow, combat preparation | controlled deployment pose on the same bow object |
| `C Full Deploy` | fully deployed bow, aim/attack setup | expanded frame presentation on the same bow object |

No state may add a new costume, body type, unrelated weapon, independent floating frame, or separate physics system.

## 2. Keep / enlarge / simplify / remove table

| 2D element | Keep | Enlarge or clarify | Simplify | Remove from first proof | Verification risk |
|---|---|---|---|---|---|
| Face | eye placement, face shape, adult expression direction | face area and front-plane readability at 5.2-5.3H | micro lashes, tiny skin lines | none beyond micro detail | 128px face read, blendshape deformation |
| Hair | long silver-lavender mass, front framing, overall wave rhythm | front silhouette and major side/back locks | group into a few large cards or mesh clumps | loose micro-strands and cloth-like motion | camera clipping, helper-bone count |
| Black outfit | black color blocks, neckline, waist, shorts, boots | neckline, waist break, boot silhouette, major seam contrast | stitching, tiny buckles, hidden seams | non-silhouette hardware | joint clipping, material slots |
| Purple outfit panels | large purple panels, long split coat read, contrast with black | panel edges and readable lower-body rhythm | repeated small trim into texture or one broad strip | duplicate micro-trim | overdraw and deformation |
| Thigh straps / hardware | silhouette-critical strap bands and one or two anchor points | strap width if lost at quarter view | buckle count and small chains | dangling non-read pieces | leg clipping, bone budget |
| Bow body | one large purple mechanical compound bow, central grip, outer frame | bow root, grip, outer limb silhouette and state read | internal braces, tiny fasteners, duplicate cams | independent rings, free-floating mechanisms | hand clearance, overdraw, socket transforms |
| Bow string / active cue | one readable string path and restrained purple active cue | string path and active edge at C | use shader/VFX cue instead of extra geometry | cable simulation and multiple trails | Android overdraw, state sync |

## 3. Subject-specific hierarchy and sockets

The following names are proposed for the Gate B proof and are not imported assets:

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

Rules:

- `Socket_Weapon_R` owns the single bow presentation object; the left grip is a controlled hand-contact reference, not a second weapon mount.
- `Socket_BowRoot` is the state-driver origin for A/B/C fold/deploy transforms.
- `Socket_BowGrip_L` and `Socket_BowGrip_R` are hand-contact proposals; final transforms require pose blockout.
- `Socket_CameraFocus` keeps face and bow in the fixed orthographic quarter-view read.
- Do not add separate physics bones for cams, strings, loose chains, or frame rings in the first proof.

## 4. Material and budget contract

The REVIEW palette proposes six subject slots, staying within the common `<=6` material-slot starting budget:

1. `MAT_KisaragiMao_Face`
2. `MAT_KisaragiMao_Hair`
3. `MAT_KisaragiMao_Skin`
4. `MAT_KisaragiMao_Outfit`
5. `MAT_KisaragiMao_BowMetal`
6. `MAT_KisaragiMao_BowPurple`

The purple active cue should be a controlled shader/emission parameter on `BowPurple` before adding dynamic geometry. Final shader values, texture sizes, SetPass, overdraw, Android memory, and LOD transitions remain measured Gate B work.

Initial common-contract checks to carry into the proof:

- Character mesh: `LOD0 <=18,000`, `LOD1 <=10,000`, `LOD2 <=5,000` triangles.
- Representative equipment addition: `LOD0 <=2,000`, `LOD1 <=1,200`, `LOD2 <=600` triangles.
- Deform bones: common `<=55`; helper bones/drivers `<=8` initially.
- Face BlendShapes: `<=8` at LOD0/LOD1 and `0-4` at LOD2.
- Physics: cloth/cable `0`; use transforms, one state driver, and shader/VFX cues.

## 5. Animation and state boundary

- Shared locomotion, hit, and down motion remains common Humanoid motion.
- Mao-specific motion direction is `Idle_Signature`, `Attack_Command`, `ScrapBloom`, `ReclaimNet`, `Victory`, and `Select` from `ANIMATION_GUIDE.md`.
- Bow deployment is a presentation state driven by the equipment object; gameplay damage, cooldown, resource, and target logic remain outside animation events.
- Animation events may send equipment, SFX, or VFX presentation cues only.
- No cloth, cable, or multi-part mechanical simulation is required for the first proof.

## 6. Gate B evidence mapping

| Gate B item | Contract evidence | Current status | Missing proof |
|---|---|---|---|
| `CHA-B01` | Turnaround + approved sheet | `READY FOR GATE B REVIEW` | 3D proportion/blockout cross-check |
| `CHA-B02` | Equipment sheet + state contract + proposed sockets | `READY FOR GATE B REVIEW` | socket transforms and collider probe |
| `CHA-B03` | This translation table + production handoff | `READY FOR GATE B REVIEW` | technical implementation proof |
| `CHA-B04` | Baseline `5.2-5.3H` + common 3D spec | `CONDITIONAL` | proportion guide and Humanoid blockout |
| `CHA-B05` | No 2D proof can pass this item | `NOT TESTED` | pose/joint intersection blockout |
| `CHA-B06` | Material palette + six-slot proposal | `READY FOR GATE B REVIEW` | imported material-slot proof |
| `CHA-B07` | Camera focus and bow socket rules | `CONDITIONAL` | quarter-view pose proof |
| `CHA-B08` | No-physics policy and hair/bow simplification | `READY FOR GATE B REVIEW` | runtime penetration/performance probe |
| `CHA-B09` | Animation direction only | `NOT TESTED` | motion thumbnails or clips |
| `CHA-B10` | Common 3D budget contract | `CONDITIONAL` | measured Android proof |

## Boundary and next action

This translation contract is ready for human Gate B review as a 2D planning input. It does not authorize Blender/FBX export, 3D Blockout, Unity import, Runtime roster replacement, or release. The next technical action requires the missing 3D proof environment and a separate Gate B approval.
