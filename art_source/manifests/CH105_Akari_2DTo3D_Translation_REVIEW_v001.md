# CH105 Kurogane Akari — 2D-to-3D Translation REVIEW v001

> Date: 2026-08-12  
> Branch: `art/current-roster-gate-a-ch102`  
> Status: `REVIEW / 2D-to-3D planning contract / Gate B not approved`  
> Backlog: `ART-1408`  
> Source package: `art_source/manifests/CH105_Akari_GateA_Review_v001.md`  
> Common contract: `docs/05_art_concept/CHARACTER_3D_SPEC.md`

This document translates the current CH105 2D REVIEW package into a controlled 3D planning contract. It defines what must survive
the reduction from the source-faithful 2D target to the common `5.2~5.8H` stylized 3D target. It does not claim an approved
2D sheet, model, rig, blockout, Unity import, or Gate B approval.

## 1. Identity and state lock

- The morning roster remains the visual authority: the fifth figure from the left in `CH101-105_Roster_FaceDiversity_WIP_v003.png`, source commit `418ef96`.
- The CH105 unified character-sheet REVIEW is the current identity anchor; Face128, silhouette, expression, equipment, and material boards are supporting references.
- CH105's locked visual hook is a grounded anchor warden: black hair with teal inner/back hair, mature amber eyes, black/forest-green utility layers, copper-gold hardware, broad shoulders, and a low defensive stance.
- A/B/C are states of one identity and one controlled equipment package:

| State | 2D read | 3D presentation rule |
|---|---|---|
| `A Neutral` | ring lowered/quiet; gauntlets stowed | one compact ring object and the same gauntlet pair remain on the primary equipment root |
| `B Ready` | one ring lifted; one gauntlet active; short cable line | controlled ring presentation and gauntlet pose on the same objects; no duplicate ring |
| `C Full Guard` | one compact ring brace; both gauntlet reads active; restrained cable line | state-driven brace presentation; no giant shield, ring swarm, or physics cable |

No state may add a new costume, body type, unrelated weapon, second ring, independent orbit system, or full-body armor redesign.

## 2. Keep / enlarge / simplify / remove table

| 2D element | Keep | Enlarge or clarify | Simplify | Remove from first proof | Verification risk |
|---|---|---|---|---|---|
| Face | mature amber eyes, strong brows, stable adult face read | eye/brow plane and jaw read at `5.2~5.8H` quarter view | lashes, tiny skin marks, micro highlights | none beyond micro detail | face readability and blendshape deformation |
| Black hair + teal inner/back hair | large black outer mass, teal under-layer, copper hair pin | front silhouette, major side/back locks, teal boundary | group loose strands into a few cards/clumps | micro-strands and hair physics | camera clipping and helper-bone count |
| Body proportion | broad shoulders, grounded hips/legs, low defensive stance | shoulder-to-waist break, boot and coat-tail contour | small anatomy transitions into large stylized planes | exaggerated armor anatomy | shared Humanoid proportion and pose clearance |
| Black/forest-green utility outfit | black crop layer, forest-green coat/lining, shorts, straps, boots | collar, shoulder line, waist break, coat-tail silhouette | seam density, tiny buckles, repeated chain links | hidden hardware and loose micro straps | joint clipping, value collapse, material slots |
| Copper-gold hardware | ring frame, gauntlet edges, buckles, limited chain accents | major anchor points, wrist/knuckle breaks, large buckle shapes | tiny fasteners, bevels, repeated glints | decorative micro-metal | metal overdraw and silhouette noise |
| Kinetic gauntlets | paired heavy gauntlet identity, articulated forearm and knuckle mass | wrist joint, hand clearance, knuckle block, forearm contour | plates into a few large segments; hidden mechanisms into masks | independent mechanical parts and cable physics | elbow/wrist penetration and hand readability |
| Single anchor ring | one oval ring, major anchor points, one cable attachment | carry diameter, active center, cable attach, outer contour | small trim, repeated chain links, micro connectors | second ring, orbit clones, giant barrier/shield geometry | camera overlap, hand clearance, state transforms |
| Anchor line | restrained short line/cable signal | attachment point and two readable end positions | use one/two large transform or shader-driven line segments | Cloth/Cable simulation and dangling micro links | penetration, overdraw, state sync |
| Copper/teal activation cues | small teal insert and restrained copper highlight | C-state ring/gauntlet cue | glow radius and particles into shader/VFX cue | floating symbol field and full-screen glow | emission budget and value hierarchy |

## 3. Subject-specific hierarchy and socket proposal

The following names are proposed for future Gate B proof and are not imported assets:

```text
CHR_KuroganeAkari
  VisualRoot
    GEO_Body_LOD0
    GEO_Hair_LOD0
    GEO_Outfit_LOD0
    Socket_Equipment_Primary
      PRP_KuroganeAkari_Gauntlets
        Socket_Gauntlet_L_Wrist
        Socket_Gauntlet_R_Wrist
        Socket_Gauntlet_L_Knuckle
        Socket_Gauntlet_R_Knuckle
      PRP_KuroganeAkari_AnchorRing
        Socket_AnchorRing_Carry
        Socket_AnchorRing_Active
        Socket_AnchorRing_CableAttach
    Socket_VFXCenter
    Socket_CameraFocus
```

Rules:

- `Socket_Equipment_Primary` owns the paired gauntlets and the single anchor-ring presentation object; final hand side and transforms require pose blockout.
- `Socket_Gauntlet_*` are attachment/readability references, not separate gameplay hitbox ownership.
- `Socket_AnchorRing_Carry` and `Socket_AnchorRing_Active` represent two transforms of one ring object; they do not authorize two runtime objects.
- `Socket_AnchorRing_CableAttach` is the origin for a restrained line cue. It must not become a cable-physics chain.
- `Socket_VFXCenter` may drive a narrow anchor/brace cue. Guard, knockback, damage reduction, and placement logic remain code/data-owned.
- `Socket_CameraFocus` keeps the face, broad shoulder line, ring, and gauntlet silhouette readable in the fixed orthographic quarter view.
- Do not add physics bones for hair micro-strands, chain links, ring trim, or cable lines in the first proof.

## 4. Material and proof budget contract

Carry the common starting budget from `CHARACTER_3D_SPEC.md`:

- Character mesh: `LOD0 <=18,000`, `LOD1 <=10,000`, `LOD2 <=5,000` triangles.
- Representative equipment addition: `LOD0 <=2,000`, `LOD1 <=1,200`, `LOD2 <=600` triangles.
- Texture atlas: `2048^2` max for LOD0, `1024^2` for LOD1, `512^2` for LOD2.
- Material slots: `<=6` at LOD0/LOD1, `<=4` at LOD2.
- Deform bones: common `<=55`; helper bones/drivers `<=8` initially.
- Face BlendShapes: `<=8` at LOD0/LOD1 and `0~4` at LOD2.
- Physics: Cloth/Cable `0`; use transforms, one state driver, and shader/VFX cues.

Initial six-category mapping from the CH105 color-material REVIEW board:

1. `MAT_Akari_Face`
2. `MAT_Akari_Hair`
3. `MAT_Akari_Skin`
4. `MAT_Akari_Outfit`
5. `MAT_Akari_Equipment`
6. `MAT_Akari_Accent`

Final shader values, texture sizes, emission, SetPass, overdraw, Android memory, and LOD transitions remain measured Gate B work.

## 5. Animation and state boundary

- Shared locomotion, hit, and down motion remain common Humanoid motion.
- CH105-specific motion direction is already documented as analytical/grounded presentation: signature idle, three gauntlet attacks,
  anchor drop, brace line, victory, and select. Exact clips remain separate work.
- Ring deployment, gauntlet presentation, and anchor-line cues may send equipment, SFX, or VFX presentation events only.
- Guard, knockback, counter, damage reduction, anchor placement, cooldown, resource, and target logic remain code/data-owned.
- The anchor line may be represented by one/two large transform- or shader-driven line segments. No Cloth/Cable simulation is required for the first proof.
- Equipment motion must be checked for elbow, wrist, hand, ring, and torso penetration before any Gate B approval.

## 6. Gate B evidence mapping

| Gate B item | Contract evidence | Current status | Missing proof |
|---|---|---|---|
| `CHA-B01` | CH105 character-sheet REVIEW + turnaround read | `CONDITIONAL` | human 2D approval and 3D proportion cross-check |
| `CHA-B02` | Equipment sheet + A/B/C state contract + proposed sockets | `CONDITIONAL` | socket transforms, hand clearance, and collider probe |
| `CHA-B03` | This translation table + keep/simplify rules | `READY FOR GATE B REVIEW` | technical implementation proof |
| `CHA-B04` | Common `5.2~5.8H` target + 3D spec | `CONDITIONAL` | proportion guide and Humanoid blockout |
| `CHA-B05` | 2D evidence cannot pass this item | `NOT TESTED` | pose/joint intersection blockout |
| `CHA-B06` | Material palette + six-category proposal | `CONDITIONAL` | imported material-slot proof |
| `CHA-B07` | Camera focus and ring/gauntlet socket rules | `CONDITIONAL` | quarter-view pose proof |
| `CHA-B08` | No-physics hair/ring/cable policy | `READY FOR GATE B REVIEW` | runtime penetration and performance probe |
| `CHA-B09` | Expression and motion direction only | `NOT TESTED` | motion thumbnails or clips |
| `CHA-B10` | Common 3D budget contract | `CONDITIONAL` | measured Android proof |

## Boundary and next action

This contract is a 2D planning input for later Gate B review. It does not authorize Blender/FBX export, 3D Blockout, Unity import,
Runtime roster replacement, or release. Human Gate A, the five-person same-scale review, and the missing 3D proof environment remain prerequisites.

Next 2D action after this document is human review of the complete CH105 package. If Gate A is approved, prepare a separate Gate B preflight;
do not promote this REVIEW contract or any WIP image to an APPROVED runtime asset.
