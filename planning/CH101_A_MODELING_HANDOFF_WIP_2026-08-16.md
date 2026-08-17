# CH101-A 모델링 핸드오프 — WIP

상태: `READY FOR HIGH-RES MODELING / GATE A PENDING / NOT APPROVED`

## 모델러가 먼저 열 파일

1. `art_refs/characters/rin/concept/CH101_A_Canonical_Turnaround_WIP_v005.png`
2. `art_refs/characters/rin/3d_reference/CH101_A_NeutralBodySculpt_WIP_v009.png`
3. `art_refs/characters/rin/expressions/CH101_A_ExpressionSheet_WIP_v006.png`
4. `art_refs/characters/rin/equipment/CH101_A_EquipmentSheet_WIP_v007.png`
5. `art_refs/characters/rin/poses/CH101_A_PoseBoard_WIP_v008.png`
6. `art_refs/characters/rin/concept/CH101_A_ReadabilitySheet_WIP_v010.png`

Blender 시작 씬은 `re-camp-blender/artifacts/CH101_modeling_guide_run3/`이며, 리그와
소켓 템플릿은 `re-camp-blender/artifacts/CH101_rig_template_run5/`에 있다.

## 제작 순서

1. 중립 바디 기준으로 얼굴·손·발·흉부·골반이 연결된 5.3~5.4등신 베이스를 만든다.
2. A-Pose에서 UV와 재질 슬롯을 분리한다: skin / hair / cloth / rubber / metal / emissive.
3. 크롭 재킷·크롭 탑·쇼츠·허벅지 스트랩·부츠를 별도 의상 메시로 제작한다.
4. 세이버·리본·파우치·포니테일을 소켓과 함께 얹는다.
5. 표정 8종과 A-Pose·Idle·Attack·Skill·Victory에서 관통/변형을 검토한다.
6. `validate_ch101_mesh_intake.py`를 실행한 뒤 사람 Gate A/B 증거를 제출한다.

## 금지 사항

- 기존 run3/run4/connected Skin 렌더를 최종 외형으로 재사용하지 않는다.
- 큐브·구체 조합을 최종 메시로 제출하지 않는다.
- 이미지 생성 raster를 메시·FBX·Unity 자산으로 오인하지 않는다.
- Gate A 사람 승인 전 `APPROVED` 또는 Unity Import를 표시하지 않는다.
