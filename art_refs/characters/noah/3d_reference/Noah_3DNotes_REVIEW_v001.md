# Noah 3D Translation Notes REVIEW v001

- Status: `REVIEW`
- Human Approval: `NOT GRANTED`
- 2D source: `Noah_KeyArt_REVIEW_v002.png` at `7.30H`
- 3D concept source: `Noah_3DReference_REVIEW_v002.png` at `5.75H`

## Identity lock

- Preserve the calm adult feminine face, clear waist and powerful shoulders/legs; never bury them in heavy armor.
- Preserve the short midnight-navy bob with amber underlight and the navy/steel/amber hierarchy.
- Preserve the folded vertical equipment case that becomes a door-sized wall shield.
- Keep the asymmetric half-cape secondary to the shield rectangle.

## Expand, delete, combine

- Expand the head, eyes, hands, boots, shield frame, grip and amber emission for gameplay-camera readability.
- Delete micro buckles, repeated seam noise and 2D long-leg exaggeration.
- Combine waist layers into one rig-safe belt hierarchy and small armor plates into larger readable groups.
- Limit shield deployment to three states: `Back_Case`, `Arm_Guard`, `Wall_Root`.

## Materials and VFX

- Separate Toon Face, Eyes, Hair, Outfit, Armor, Shield Frame, Barrier Glass and Amber Emission slots.
- Barrier Glass is translucent amber grid energy; the physical frame remains matte graphite/steel.
- Counter timing uses a short amber impact pulse, not a permanent bloom that hides the character.

## Rig, sockets and physics

- Use the common Humanoid shoulder, elbow, wrist, hip, knee and ankle landmarks.
- Keep shoulder armor below arm-raise arcs and preserve shield clearance at elbow/wrist.
- Physics candidate: half-cape tip only. The bob and shield have no loose long-chain physics.
- Required sockets: `Back_Case`, `Arm_Guard`, `Wall_Root`, `Shield_Grip`, `Barrier_VFX`.

## Motion thumbnails / CHA-B09 handoff

- Idle: shield folded at back/left side, weight centered, one calm protective glance.
- Attack: short shield-edge strike or guarded counter; no generic sword motion.
- Skill: case unfolds through three beats and locks into a door-sized wall.
- Victory: wall retracts to case; Noah checks ally safety before relaxing.

These are documented motion and socket intentions. Blender pose, animation and Unity camera proof remain `NOT TESTED`.
