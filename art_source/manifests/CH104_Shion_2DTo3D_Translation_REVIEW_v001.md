# CH104 Shion Tategami - 2D-to-3D Translation REVIEW v001

> Date: 2026-08-11
> Branch: `art/current-roster-gate-a-ch102`
> Status: `REVIEW / 2D-to-3D planning contract / Gate B not approved`
> Backlog: `ART-1308`
> Source package: `art_source/manifests/CH104_Shion_StateReference_v001.md`
> Common contract: `docs/05_art_concept/CHARACTER_3D_SPEC.md`

This document translates the current CH104 2D REVIEW package into a controlled 3D planning contract. It defines what must survive reduction from the source-faithful 2D target to the common `5.2~5.8H` stylized 3D target. It does not claim an approved 2D sheet, model, rig, blockout, Unity import, or Gate B approval.

## 1. Identity and state lock

- The morning roster remains the visual authority: the fourth figure from the left in `CH101-105_Roster_FaceDiversity_WIP_v003.png`, source commit `418ef96`.
- The CH104 unified character-sheet REVIEW is the current identity anchor; Face128, silhouette, expression, equipment, and material boards are supporting evidence.
- A/B/C are states of one Shion identity and one controlled equipment package:

| State | 2D read | 3D presentation rule |
|---|---|---|
| `A Neutral` | folded prism fan; lowered quiet map ring | compact fan on one equipment root; the same ring remains lowered/quiet |
| `B Ready` | half-open fan; map ring active near the hand | controlled partial fan deployment on the same pivot; same ring activation cue |
| `C Full Survey` | fully open faceted fan; one active map ring | expanded fan presentation and one ring cue; no extra orbit object |

No state may add a new costume, body type, unrelated weapon, second fan, or independent orbit-ring system.

## 2. Keep / enlarge / simplify / remove table

| 2D element | Keep | Enlarge or clarify | Simplify | Remove from first proof | Verification risk |
|---|---|---|---|---|---|
| Face | narrow indigo eyes, angular jaw, asymmetrical bangs, adult analytical direction | face plane and eye read at `5.2~5.8H` quarter view | lashes, tiny skin marks, micro highlights | none beyond micro detail | face readability and blendshape deformation |
| Indigo hair with magenta tips | large layered mass, front framing, magenta end read | front silhouette, major side/back locks, tip boundary | group loose strands into large cards/clumps | micro-strands and hair physics | camera clipping and helper-bone count |
| Ivory/indigo outfit | ivory jacket-dress ground, indigo geometric waist/lower panels, tall vertical read | collar, waist break, panel edges, boot silhouette | seam density, tiny trim, repeated gold lines | non-silhouette hardware | joint clipping, overdraw, material slots |
| Smoke-gray utility trim | low-sheen secondary surfaces and value separation | major trim bands if lost at quarter view | micro texture and tiny fasteners | hidden hardware | value collapse against indigo |
| Prism fan | one folded/half-open/full-open faceted fan, grip, pivot, narrow beam cue | outer fan silhouette, grip clearance, central pivot, readable facet groups | internal facet lines, tiny bevels, small hinge hardware | free-floating panels and beam geometry | hand clearance, overdraw, state transforms |
| Single map ring | one oval frame and one faceted map core | ring diameter, carry position, map-core center, active cue | small trim, repeated glints, micro connectors | independent orbit clones and extra rings | camera overlap, socket transform, overdraw |
| Hot-magenta activation | restrained hair-tip/edge cue and controlled prism/ring activation | edge read at C state and map-core cue | glow radius and micro particles into shader/VFX | floating neon symbol field | emission budget and state sync |

## 3. Subject-specific hierarchy and socket proposal

The following names are proposed for future Gate B proof and are not imported assets:

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

Rules:

- `Socket_Equipment_Primary` owns the one prism-fan presentation object; the final hand side and transform require pose blockout.
- `Socket_FanPivot` drives the A/B/C fan deployment read. `Socket_FanBeam` is a cue origin, not a required beam mesh.
- `Socket_MapRing_Carry` owns the single map ring. `Socket_MapRingCore` is the map-core reference on that same object.
- `Socket_VFXCenter` may drive a restrained prism/map cue. It does not own independent orbit geometry.
- `Socket_CameraFocus` keeps Shion's face, long vertical silhouette, and equipment readable in the fixed orthographic quarter view.
- Do not add physics bones for hair micro-strands, fan facets, ring trim, chains, or beam lines in the first proof.

## 4. Material and proof budget contract

Carry the common starting budget from `CHARACTER_3D_SPEC.md`:

- Character mesh: `LOD0 <=18,000`, `LOD1 <=10,000`, `LOD2 <=5,000` triangles.
- Representative equipment addition: `LOD0 <=2,000`, `LOD1 <=1,200`, `LOD2 <=600` triangles.
- Texture atlas: `2048^2` max for LOD0, `1024^2` for LOD1, `512^2` for LOD2.
- Material slots: `<=6` at LOD0/LOD1, `<=4` at LOD2.
- Deform bones: common `<=55`; helper bones/drivers `<=8` initially.
- Face BlendShapes: `<=8` at LOD0/LOD1 and `0~4` at LOD2.
- Physics: Cloth/Cable `0`; use transforms, one state driver, and shader/VFX cues.

Initial six-slot mapping from the color-material REVIEW board:

1. `MAT_ShionTategami_Face`
2. `MAT_ShionTategami_Hair`
3. `MAT_ShionTategami_Skin`
4. `MAT_ShionTategami_Outfit`
5. `MAT_ShionTategami_Equipment`
6. `MAT_ShionTategami_PrismEmission`

Final shader values, texture sizes, SetPass, overdraw, Android memory, and LOD transitions remain measured Gate B work.

## 5. Animation and state boundary

- Shared locomotion, hit, and down motion remain common Humanoid motion.
- Shion-specific motion direction may cover analytical idle, surveying preparation, precision presentation, victory, and select reads, but exact clips remain separate work.
- Fan deployment and map-ring activation are presentation states. Damage, mark, cooldown, resource, target, and path logic remain code/data-owned.
- Animation events may send equipment, SFX, or VFX presentation cues only.
- No cloth, cable, multi-part mechanical, or orbit-ring simulation is required for the first proof.

## 6. Gate B evidence mapping

| Gate B item | Contract evidence | Current status | Missing proof |
|---|---|---|---|
| `CHA-B01` | Character-sheet REVIEW + turnaround read | `CONDITIONAL` | human 2D approval and 3D proportion cross-check |
| `CHA-B02` | Equipment sheet + A/B/C state contract + socket proposal | `CONDITIONAL` | socket transforms and collider probe |
| `CHA-B03` | This translation table + keep/simplify rules | `READY FOR GATE B REVIEW` | technical implementation proof |
| `CHA-B04` | Common `5.2~5.8H` target + 3D spec | `CONDITIONAL` | proportion guide and Humanoid blockout |
| `CHA-B05` | 2D evidence cannot pass this item | `NOT TESTED` | pose/joint intersection blockout |
| `CHA-B06` | Material palette + six-slot proposal | `CONDITIONAL` | imported material-slot proof |
| `CHA-B07` | Camera focus and fan/ring socket rules | `CONDITIONAL` | quarter-view pose proof |
| `CHA-B08` | No-physics hair/fan/ring policy | `READY FOR GATE B REVIEW` | runtime penetration and performance probe |
| `CHA-B09` | Expression and motion direction only | `NOT TESTED` | motion thumbnails or clips |
| `CHA-B10` | Common 3D budget contract | `CONDITIONAL` | measured Android proof |

## Boundary and next action

This contract is a 2D planning input for later Gate B review. It does not authorize Blender/FBX export, 3D Blockout, Unity import, Runtime roster replacement, or release. Human Gate A and the missing 3D proof environment remain prerequisites for technical implementation.
