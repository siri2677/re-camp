# CH105 Kurogane Akari - Gate B Preflight REVIEW v001

> Date: 2026-08-12
> Branch: `art/current-roster-gate-a-ch102`
> Status: `CONDITIONAL / Gate B not approved`
> Source: `art_refs/characters/akari/concept/CH105_Akari_CharacterSheet_APPROVED_v001.png`
> Approval: `art_source/manifests/CH105_Akari_Production_Sheet_Approval_20260812.md`
> Translation contract: `art_source/manifests/CH105_Akari_2DTo3D_Translation_REVIEW_v001.md`
> Checklist: `docs/05_art_concept/ART_REVIEW_CHECKLIST.md`
> 3D spec: `docs/05_art_concept/CHARACTER_3D_SPEC.md`

This document prepares the approved CH105 2D package for a later Gate B review. It separates source-backed planning evidence from untested 3D/runtime evidence. No Blender, FBX, Unity, or Runtime proof is claimed.

## 1. Evidence map

| ID | Gate B requirement | Evidence | Preflight result | Missing proof |
|---|---|---|---|---|
| `CHA-B01` | Front/Side/Back face, hair, outfit, and proportion consistency | Approved sheet + unified turnaround read | `READY FOR GATE B REVIEW` | 3D proportion and blockout cross-check |
| `CHA-B02` | Gauntlet, single anchor ring, restrained cable, state transitions, and attachment structure | Equipment sheet + A/B/C state contract + translation socket proposals | `READY FOR GATE B REVIEW` | socket transforms, hand clearance, and collider probe |
| `CHA-B03` | Explicit 2D-to-3D keep/enlarge/simplify/remove table | `CH105_Akari_2DTo3D_Translation_REVIEW_v001.md` | `READY FOR GATE B REVIEW` | technical implementation proof |
| `CHA-B04` | `5.7-5.8H` adult readability and common Humanoid compatibility | Approved sheet + common 3D spec | `CONDITIONAL` | proportion guide and Humanoid blockout |
| `CHA-B05` | Major joint and outfit/equipment collision check | No 2D proof can pass this item | `NOT TESTED` | shoulder, elbow, wrist, hip, and knee pose blockout |
| `CHA-B06` | Face, hair, outfit, gauntlet, ring, and activation material-slot separation | Material palette + six-slot proposal | `READY FOR GATE B REVIEW` | imported material-slot and shader proof |
| `CHA-B07` | Camera, rig, hand, foot, and equipment clearance | Approved sheet + turnaround + camera/socket proposal | `CONDITIONAL` | quarter-view pose and clearance captures |
| `CHA-B08` | Hair, coat, ring, cable, and gauntlet physics/penetration budget | No-physics policy in translation contract | `READY FOR GATE B REVIEW` | runtime penetration and performance probe |
| `CHA-B09` | Idle/Attack/Skill/Victory equipment motion and sockets | Animation direction + A/B/C state contract | `NOT TESTED` | motion thumbnails or clips |
| `CHA-B10` | Polygon, texture, bone, BlendShape, LOD, and shader budget | `CHARACTER_3D_SPEC.md` common contract | `CONDITIONAL` | measured Android proof |

## 2. Current decision

- Gate A: `PASS` - user approval is recorded in `CH105_Akari_Production_Sheet_Approval_20260812.md`.
- 2D Production Sheet: `APPROVED` - A/B/C are one inclusive Akari identity package.
- Five-person 2D cross-roster: `PASS` - recorded separately; Face128 and comparison boards remain REVIEW evidence.
- Gate B: `CONDITIONAL / NOT APPROVED`.
- 3D Blockout: `NOT STARTED`.
- Unity Import / Runtime roster replacement: `BLOCKED`.

## 3. CH105 handoff order

1. Use the approved CharacterSheet as the visual identity anchor; keep the REVIEW boards as supporting evidence.
2. Build only one controlled gauntlet pair, one anchor ring, and one/two restrained line segments for the first proof.
3. Validate `Socket_Equipment_Primary`, `Socket_Gauntlet_L`, `Socket_Gauntlet_R`, `Socket_AnchorRing_Carry`, `Socket_AnchorRing_Active`, `Socket_LineAttach`, `Socket_VFXCenter`, and `Socket_CameraFocus` in a temporary blockout.
4. Capture Front/Side/Back, quarter-view, A/B/C state, joint-intersection, material-slot, and budget evidence.
5. Re-run `CHA-B01~B10` and request separate human Gate B approval.

## 4. Boundary and blocker

No Blender or Unity executable is used by this preflight. The approved 2D sheet, this document, and the translation contract do not authorize Blender/FBX export, 3D Blockout, Unity import, Runtime roster replacement, Android proof, or release use. Actual technical work remains blocked until the 3D proof environment and separate Gate B approval are available.
