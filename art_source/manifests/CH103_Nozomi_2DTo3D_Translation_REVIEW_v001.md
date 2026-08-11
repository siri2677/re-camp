# CH103 Kanade Nozomi - 2D-to-3D Translation REVIEW v001

> Date: 2026-08-11
> Branch: `art/current-roster-gate-a-ch102`
> Status: `REVIEW / 2D-to-3D contract / Gate B not approved`
> Backlog: `ART-1208`
> Source package: `art_source/manifests/CH103_Nozomi_StateReference_v001.md`
> Common contract: `docs/05_art_concept/CHARACTER_3D_SPEC.md`

This document converts the approved CH103 2D identity and current REVIEW support sheets into a controlled 3D planning contract. It defines what must survive the reduction from the 2D production target to the common `5.2~5.8H` stylized 3D target. It does not claim a model, rig, blockout, Unity import, or Gate B approval.

## 1. Identity and state lock

- The morning roster source remains the visual authority: third figure from the left in `CH101-105_Roster_FaceDiversity_WIP_v003.png`, source commit `418ef96`.
- The approved A/B/C character sheet is the identity anchor; Face128, turnaround, expression, equipment, and material sheets are supporting references.
- A/B/C are states of one character and one controlled equipment package:

| State | 2D read | 3D presentation rule |
|---|---|---|
| `A Neutral` | baton lowered; veil folded/quiet | compact stored baton and folded panel group on one equipment root |
| `B Ready` | baton raised; one curved panel partly open | controlled partial deployment on the same baton/veil objects |
| `C Full Protection` | broad curved veil panels opened | expanded panel presentation on the same veil group; no opaque shield |

No state may add a new costume, body type, unrelated weapon, or independent cloth system.

## 2. Keep / enlarge / simplify / remove table

| 2D element | Keep | Enlarge or clarify | Simplify | Remove from first proof | Verification risk |
|---|---|---|---|---|---|
| Face | round cheeks, rounded jaw, coral eyes, adult expression direction | face plane and eye read at `5.2~5.8H` quarter view | lashes, tiny skin marks, micro highlights | none beyond micro detail | face readability and blendshape deformation |
| Coral hair and braid | overall long wave mass, cream-rose→coral gradient, one thin side braid | front silhouette, braid root, major side/back locks | group loose strands into a few large cards/clumps | micro-strands and hair physics | camera clipping and helper-bone count |
| Ivory/coral outfit | high-neck base, asymmetric wrap jacket, split tails, adult body read | jacket hem, waist break, boot silhouette, major coral pattern | small print and seam density into texture/mask | duplicate micro-trim and loose panels | joint clipping and overdraw |
| Black utility blocks | shorts, belt, ampoule/tool pouches, one readable chain | waist and leg separation at quarter view | buckle count and thin dangling pieces | non-silhouette hardware | material slots and leg clipping |
| Resonance baton | turquoise orb, shaft, grip, connector rings, end cap | orb, grip, hand clearance, end-cap silhouette | micro rings and hidden internals | free-floating parts and cable physics | hand socket and overdraw |
| Emergency veil | few large curved aqua panels, translucent material, coral edge accents | panel root, edge frame, upper-back/waist attachment | hinge layers, repeated facets, small frames | many cloth panels, opaque shield geometry | transparency overdraw and root transforms |

## 3. Subject-specific hierarchy and sockets

The following names are proposed for Gate B proof and are not imported assets:

```text
CHR_KanadeNozomi
  VisualRoot
    GEO_Body_LOD0
    GEO_Hair_LOD0
    GEO_Outfit_LOD0
    Socket_Equipment_R
      PRP_KanadeNozomi_ResonanceBaton
        Socket_BatonGrip
        Socket_BatonOrb
    Socket_VeilRoot_L
    Socket_VeilRoot_R
    Socket_VeilWaist_L
    Socket_VeilWaist_R
    Socket_VFXCenter
    Socket_CameraFocus
```

Rules:

- `Socket_Equipment_R` owns the single baton presentation object.
- Veil roots are controlled attachment references for a small panel group; they are not cloth bones.
- `Socket_VFXCenter` is the cue origin for resonance waves and veil presentation effects; gameplay healing, cleansing, and damage reduction remain code-owned.
- Do not add separate physics bones for panel edges, loose chains, baton rings, or hair micro-strands in the first proof.

## 4. Material and proof budget contract

Use the common proof budget from `CHARACTER_3D_SPEC.md`:

- Character mesh: `LOD0 <=18,000`, `LOD1 <=10,000`, `LOD2 <=5,000` triangles.
- Representative equipment addition: `LOD0 <=2,000`, `LOD1 <=1,200`, `LOD2 <=600` triangles.
- Texture atlas: `2048²` max for LOD0, `1024²` for LOD1, `512²` for LOD2.
- Material slots: `<=6` at LOD0/LOD1, `<=4` at LOD2.
- Deform bones: common `<=55`; helper bones/drivers `<=8` initially.
- Face BlendShapes: `<=8` at LOD0/LOD1 and `0~4` at LOD2.
- Physics: Cloth/Cable `0`; use transforms, one state driver, and shader/VFX cues.

Initial six-slot mapping:

1. `MAT_KanadeNozomi_Face`
2. `MAT_KanadeNozomi_Hair`
3. `MAT_KanadeNozomi_Skin`
4. `MAT_KanadeNozomi_Outfit` - ivory/coral/black masks.
5. `MAT_KanadeNozomi_Equipment` - baton and warm hardware.
6. `MAT_KanadeNozomi_VeilEmission` - translucent aqua veil and controlled glow.

Final shader values, texture sizes, emission, SetPass, overdraw, Android memory, and LOD transitions remain measured Gate B work.

## 5. Animation and state boundary

- Shared locomotion, hit, and down motion remain common Humanoid motion.
- CH103 direction is recorded in `ANIMATION_GUIDE.md`: `ANM_KanadeNozomi_Idle_Signature`, `ANM_KanadeNozomi_Attack_Command`, `ANM_KanadeNozomi_PulseCode`, `ANM_KanadeNozomi_HushVeil`, `ANM_KanadeNozomi_Victory`, and `ANM_KanadeNozomi_Select`.
- Baton and veil state presentation may send equipment, SFX, or VFX cues only. Healing, cleansing, protection, cooldown, and resource logic remain code-owned.
- No cloth, cable, or multi-part mechanical simulation is required for the first proof.

## 6. Gate B evidence mapping

| Gate B item | Contract evidence | Current status | Missing proof |
|---|---|---|---|
| `CHA-B01` | Approved sheet + turnaround | `READY FOR GATE B REVIEW` | 3D proportion/blockout cross-check |
| `CHA-B02` | Equipment sheet + state contract + proposed sockets | `READY FOR GATE B REVIEW` | socket transforms and collider probe |
| `CHA-B03` | This translation table + equipment handoff notes | `READY FOR GATE B REVIEW` | technical implementation proof |
| `CHA-B04` | Common `5.2~5.8H` target + 3D spec | `CONDITIONAL` | proportion guide and Humanoid blockout |
| `CHA-B05` | No 2D proof can pass this item | `NOT TESTED` | pose/joint intersection blockout |
| `CHA-B06` | Material palette + six-slot mapping | `READY FOR GATE B REVIEW` | imported material-slot proof |
| `CHA-B07` | Camera focus and equipment socket rules | `CONDITIONAL` | quarter-view pose proof |
| `CHA-B08` | No-physics hair/veil/baton policy | `READY FOR GATE B REVIEW` | runtime penetration/performance probe |
| `CHA-B09` | Animation guide direction only | `NOT TESTED` | motion thumbnails or clips |
| `CHA-B10` | Common 3D budget contract | `CONDITIONAL` | measured Android proof |

## Boundary and next action

This translation contract is ready for human Gate B review as a 2D planning input. It does not authorize Blender/FBX export, 3D Blockout, Unity import, Runtime roster replacement, or release. The next technical action requires the missing 3D proof environment and separate Gate B approval.
