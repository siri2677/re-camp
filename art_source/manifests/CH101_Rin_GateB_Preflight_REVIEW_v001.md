# CH101 아마사와 린 — Gate B Preflight REVIEW v001

> Date: 2026-08-12
> Branch: `art/current-roster-gate-a-ch102`
> Source commit: `418ef96` - `art: refine current roster gate A visuals`
> Status: `CONDITIONAL / Gate B not approved`
> Source: `art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_APPROVED_v001.png`
> Checklist: `docs/05_art_concept/ART_REVIEW_CHECKLIST.md`
> 3D spec: `docs/05_art_concept/CHARACTER_3D_SPEC.md`

이 문서는 승인된 2D 제작 시트로 Gate B 증거를 준비하는 preflight 기록이다. 현재 저장소에 Blender/Unity 실행 도구와 실제 CH101 Blockout이 없으므로, 문서·2D 근거가 있는 항목과 아직 테스트하지 않은 항목을 분리한다. `CONDITIONAL` 상태이며 사람 Gate B 승인이 아니다.

## 1. Evidence map

| ID | Gate B requirement | Evidence | Preflight result | Missing proof |
|---|---|---|---|---|
| CHA-B01 | 약 7등신 Front/Side/Back의 얼굴·헤어·의상 절개 일치 | `CH101_Rin_Turnaround_REVIEW_v001.png` + APPROVED 2D sheet | `READY FOR GATE B REVIEW` | 3D proportion/blockout cross-check |
| CHA-B02 | 장비 크기·결합·접힘·손잡이·발광부 정의 | `CH101_Rin_EquipmentSheet_REVIEW_v001.png` | `READY FOR GATE B REVIEW` | socket transform/collider proof |
| CHA-B03 | 2D→3D 확대·삭제·결합 명시 | `CH101_Rin_Production_Handoff_REVIEW_v001.md` + 3D spec | `READY FOR GATE B REVIEW` | approved technical implementation |
| CHA-B04 | 5~6등신·성인 여성 가독성·공용 Humanoid 관절 | Baseline `5.3~5.4H` + 3D spec | `CONDITIONAL` | proportion guide and humanoid blockout |
| CHA-B05 | 주요 관절과 의상 충돌 없음 | 없음 | `NOT TESTED` | Blender/Unity pose blockout |
| CHA-B06 | 얼굴·헤어·의상·장비 Material slot 분리 | 3D spec slot baseline + palette | `READY FOR GATE B REVIEW` | imported material slot proof |
| CHA-B07 | 카메라·리그·애니메이션을 막지 않는 강조점 | 2D sheet + 3D spec camera/socket notes | `CONDITIONAL` | quarter-view blockout captures |
| CHA-B08 | 긴 헤어·천·케이블 physics/관통 예산 | 2D→3D handoff + 3D spec | `READY FOR GATE B REVIEW` | runtime performance probe |
| CHA-B09 | Idle/Attack/Skill/Victory 장비 동작·소켓 | `ANIMATION_GUIDE.md` direction only | `NOT TESTED` | CH101 motion thumbnails / clips |
| CHA-B10 | Polygon/Texture/Bone/BlendShape/LOD/Shader budget | `CHARACTER_3D_SPEC.md` v001 | `READY FOR GATE B REVIEW` | measured Android proof |

## 2. Current decision

- Gate A: `PASS` — user approval recorded in `CH101_Rin_GateA_Approval_20260811.md`.
- 2D Production Sheet: `APPROVED` — user approval recorded in `CH101_Rin_Production_Sheet_Approval_20260811.md`.
- Gate B: `CONDITIONAL / NOT APPROVED`.
- 3D Blockout: `NOT STARTED`.
- Unity Import / Runtime roster replacement: `BLOCKED`.

## 3. Next implementation order

1. Create the common Base Mesh/Rig/Toon Material proof under the approved technical contract.
2. Create CH101 Blockout only in the temporary `Assets/_ReCamp/Art/Blockout/` scope.
3. Capture Front/Side/Back, quarter-view, pose, equipment ON/OFF, joint-intersection, and material-slot evidence.
4. Add CH101 motion thumbnails for Idle, Attack, `Slipstream`, `BeaconThread`, and Victory/Select.
5. Re-run `CHA-B01~B10`; request separate human Gate B approval.

## 4. Blockers and boundaries

- No Blender or Unity executable is available in the current workspace session; this record does not fabricate 3D evidence.
- `CHARACTER_3D_SPEC.md` is a proof contract, not a measured Android performance result.
- No final Model, FBX, Prefab, Animation Clip, Runtime Material, or roster replacement is authorized by this preflight.
