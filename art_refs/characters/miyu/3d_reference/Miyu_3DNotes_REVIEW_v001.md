# Miyu 3D Translation Notes REVIEW v001

- Status: `REVIEW`
- Human reviewer: `Pending`
- Approval: `NOT GRANTED`
- 2D source: `Miyu_KeyArt_REVIEW_v001.png` / `6.890H`
- 3D concept source: `Miyu_3DReference_REVIEW_v001.png` / `5.245H`
- Actual mesh, rig and Unity proof: `Not Tested`

## Identity lock

The adult woman read, sleepy mature eyes, asymmetric smoky-lilac bob, single blue inner streak, exactly one oversized sleeve, right control gauntlet and two differentiated drones must survive every simplification. The round drone owns pickup, scan and expressive response; the angular drone owns targeting and fire. Miyu becomes visibly animated only when machinery is the subject.

## Expand / delete / combine

| Rule | 3D translation |
|---|---|
| Expand | Enlarge head, hands and boots for the 5.2–5.3H gameplay read; strengthen drone face planes and gauntlet controls. |
| Delete | Remove micro seams, redundant straps, tiny fasteners and the 2D long-leg fashion exaggeration. |
| Combine | Merge bomber and maintenance-inner edge reads; consolidate belt and tool-kit masses; treat gauntlet and holo emitter as one command family. |
| Preserve | Keep the one-sleeve asymmetry, short side panel, exposed waist break, chunky low heel and exactly two drone silhouettes. |

## Material slots

Recommended separable slots for Character Proof:

1. `MAT_FaceSkin`
2. `MAT_Eye`
3. `MAT_HairLilacBlue`
4. `MAT_ClothGraphite`
5. `MAT_BomberLilac`
6. `MAT_HardSurfaceGraphite`
7. `MAT_DroneCeramic`
8. `MAT_EmissiveCyanBlue`

Final material count and texture budget remain pending until an actual mesh exists.

## Humanoid and deformation intent

- Standard Humanoid shoulder, elbow, wrist, hip, knee and ankle chains.
- Keep both shoulder lines readable even though the left sleeve has oversized volume.
- Give the right gauntlet clearance for wrist flexion, finger pointing and holo interaction.
- Preserve adult pelvis and chest landmarks while using the locked `5.245H` image-space target.
- Test crouch, dash, two-handed repair, overhead reach and one-knee service poses before costume freeze.

## Sockets and prefab boundaries

| Socket | Parent intent | Use |
|---|---|---|
| `Socket_DroneRound` | upper-spine or character drone-root helper | round scanner orbit origin |
| `Socket_DroneAngular` | upper-spine or character drone-root helper | angular combat orbit origin |
| `Socket_Gauntlet` | right wrist/forearm | command VFX and interaction origin |
| `Socket_HoloPad` | right palm/gauntlet | holo panel origin |
| `Socket_ToolKit` | left/asymmetric belt | tool-kit attachment |
| `Socket_DroneTarget` | head/chest aim helper | shared drone look target |

The drones should be separate prefabs with their own animation/VFX roots. They must not be baked into Miyu's body mesh.

## Physics and penetration budget

- Simulate only hair tips, oversized sleeve hem and the short side panel.
- Clamp sleeve swing before it obscures the gauntlet or penetrates the torso.
- Clamp side-panel travel before thigh and tool-kit intersection.
- Drones use authored orbit paths and avoidance, not unconstrained cloth or rigidbody motion.
- The angular drone must clear the holo pad; the round drone must clear hair and the oversized sleeve.

## Motion intent

| Motion | Read target |
|---|---|
| Idle | sleepy posture, minimal gaze movement, drones quietly maintaining formation |
| Attack | angular drone snaps to target while the round drone holds support distance |
| Skill | eyes brighten, torso opens and both hands become precise and energetic around machinery |
| Victory | private small smile toward the drones, not broad audience-facing celebration |

## Quarter-view priorities

Gameplay front three-quarter must retain face, blue hair streak, both drone types and the one-sleeve asymmetry. Rear three-quarter must retain belt/tool-kit separation and both orbit paths. Side view must keep the gauntlet and short panel from merging into a single dark mass.

## Conditional boundary

This file closes the paper translation definition only. It does not prove topology, deformation, material implementation, socket coordinates, physics stability, gameplay-camera readability or runtime performance. Those gates remain `Pending`/`Not Tested`; approval remains `NOT GRANTED`.
