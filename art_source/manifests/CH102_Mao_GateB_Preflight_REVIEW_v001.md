# CH102 Kisaragi Mao - Gate B Preflight REVIEW v001

> Date: 2026-08-11
> Branch: `art/current-roster-gate-a-ch102`
> Status: `CONDITIONAL / Gate B not approved`
> Source: `CH102_Mao_CharacterSheet_APPROVED_v001`
> Checklist: `docs/05_art_concept/ART_REVIEW_CHECKLIST.md`
> 3D spec: `docs/05_art_concept/CHARACTER_3D_SPEC.md`

This preflight records the documentation and 2D evidence currently available after CH102 Gate A approval. It deliberately separates source-backed checks from untested 3D/runtime checks. No fabricated Blender or Unity proof is included.

## 1. Evidence map

| ID | Gate B requirement | Evidence | Preflight result | Missing proof |
|---|---|---|---|---|
| `CHA-B01` | Front/Side/Back face, hair, outfit and proportion consistency | `CH102_Mao_Turnaround_REVIEW_v001.png` + approved sheet | `READY FOR GATE B REVIEW` | 3D proportion and blockout cross-check |
| `CHA-B02` | Bow size, grip, fold/deploy states and attachment structure | Approved A/B/C sheet + handoff | `CONDITIONAL` | Equipment detail sheet, socket transforms, collider probe |
| `CHA-B03` | Explicit 2D-to-3D keep/enlarge/simplify/remove table | `CH102_Mao_Production_Handoff_REVIEW_v001.md` | `READY FOR GATE B REVIEW` | Technical implementation proof |
| `CHA-B04` | 5.2-5.3H adult readability and common Humanoid compatibility | Current Baseline + 3D spec | `CONDITIONAL` | CH102 proportion guide and blockout |
| `CHA-B05` | Major joint and outfit collision check | None | `NOT TESTED` | 3D pose blockout |
| `CHA-B06` | Face, hair, outfit and bow material-slot separation | Handoff proposed slot table | `CONDITIONAL` | Imported material-slot proof |
| `CHA-B07` | Camera, rig and animation clearance | Approved sheet + handoff | `CONDITIONAL` | Quarter-view and pose proof |
| `CHA-B08` | Hair, straps and bow physics/penetration budget | Handoff no-physics policy | `READY FOR GATE B REVIEW` | Runtime performance and penetration probe |
| `CHA-B09` | Idle/Attack/Skill/Victory bow motion and sockets | `ANIMATION_GUIDE.md` direction only | `NOT TESTED` | CH102 motion thumbnails or clips |
| `CHA-B10` | Polygon, texture, bone, blendshape, LOD and shader budget | `CHARACTER_3D_SPEC.md` contract | `CONDITIONAL` | Measured Android proof |

## 2. Current decision

- Gate A: `PASS` - user approval recorded in `CH102_Mao_Production_Sheet_Approval_20260811.md`.
- 2D Production Sheet: `APPROVED` - A/B/C are one inclusive state package.
- Gate B: `CONDITIONAL / NOT APPROVED`.
- 3D Blockout: `NOT STARTED`.
- Unity Import / Runtime roster replacement: `BLOCKED`.

## 3. Next implementation order

1. Review the new CH102 turnaround against the approved sheet and keep A/B/C identity synchronized.
2. Create the missing expression, equipment-detail, and palette evidence as 2D review assets.
3. Re-run `CHA-B01~B10` after actual 3D proof exists; request separate human Gate B approval.

## 4. Boundary

No Blender or Unity executable is used by this preflight. The approved 2D sheet, handoff, and this document do not authorize a model, FBX, prefab, animation clip, Runtime material, or roster replacement.
