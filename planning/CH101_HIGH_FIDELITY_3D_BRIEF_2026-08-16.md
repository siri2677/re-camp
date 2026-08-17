# CH101 고품질 3D 시각 제작 브리프 — 2026-08-16

상태: `READY / NOT APPROVED`

이 문서는 v010 프리미티브 스캐폴드를 대체할 CH101 시각 제작의 시작 기준이다.
v010의 리그·소켓·LOD·예산 메타데이터는 기술 참고로만 사용하며, 외형이나 품질의
승인 근거로 사용하지 않는다.

## 목표

Re:Camp의 5~6등신 스타일라이즈드 3D 캐릭터로서, 원신·승리의 여신: 니케·젠레스
존 제로 계열의 프리미엄 일본 서브컬처 인상을 주되 특정 외부 IP의 얼굴·의상·무기를
복제하지 않는다. 캐릭터는 성인 여성으로 읽혀야 하며 쿼터뷰에서도 매력과 역할이
동시에 읽혀야 한다.

## 고정 기준

- 기준 소스: `art/current-roster-gate-a` / `183b0f0983969937d779f70b2ac51e53fc976203`
- 기준 등신: 5.2~5.5등신 중심, CH101 허용 범위 5.2~5.4등신
- 얼굴: 큰 애니메이션 홍채, 짧은 중안부, 작은 코·입, 선명한 턱선, 성인 여성 비례
- 헤어: 앞머리·옆머리·후두부·포니테일/센서 모듈이 곡면 덩어리로 연결되고, 실루엣에서 읽힘
- 체형: 슬림 애슬레틱, 허리선과 허벅지 노출이 보이며 과도한 아동형/남성형 금지
- 의상: 크롭 기능성 재킷, 짧은 하이웨이스트 쇼츠, 허벅지 스트랩, 대표 장비와 기능색
- 재질: 피부·헤어·천·가죽/고무·금속·발광을 별도 셰이딩 언어로 구분
- 렌더: 얇고 선명한 애니 선화에 해당하는 형태 분리, 차가운 셀 그림자, 따뜻한 얼굴광, 림 라이트

## 첫 제작 패키지

1. CH101 얼굴/흉상 스타일 앵커 3안
2. 전신 3/4 KeyArt 3안 — 장비 ON/OFF, 하체 노출과 실루엣 확인
3. 동일 조건 128px 얼굴·흑백 실루엣·저채도 비교
4. 사용자 선택안 1개의 정면·3/4·측면·후면 Turnaround
5. 표정 8종, 장비 상세, 팔레트·재질표
6. 2D→3D 변환표 — 확대·삭제·결합·물리 위험 기록
7. 선택안 기반 5.2~5.4등신 3D 고품질 블록아웃
8. A-Pose·Idle·Attack·Skill 포즈 및 관통/실루엣 검토

현재 1차 WIP 후보 보드:

- `art_refs/characters/rin/concept/CH101_HighFidelity_Candidates_WIP_v001.png`
- `art_refs/characters/rin/concept/CH101_HighFidelity_Candidates_WIP_v001.metadata.md`

이 보드는 A/B/C 방향 비교용이며 사용자 선택 전까지 `WIP / NOT APPROVED`다.

현재 A+B 통합 WIP 보드:

- `art_refs/characters/rin/concept/CH101_HighFidelity_AB_Variant_WIP_v002.png`
- `art_refs/characters/rin/concept/CH101_HighFidelity_AB_Variant_WIP_v002.metadata.md`

v002는 C안을 제거하고 A/B를 동일 캐릭터의 canonical/alternate 변형으로 정리한
비교본이다. 두 변형 모두 사용자 승인 전에는 제작 앵커가 아니다.

현재 A+B Turnaround WIP:

- `art_refs/characters/rin/concept/CH101_HighFidelity_AB_Turnaround_WIP_v003.png`
- `art_refs/characters/rin/concept/CH101_HighFidelity_AB_Turnaround_WIP_v003.metadata.md`

v003은 정면·3/4·측면·후면, 얼굴 클로즈업, 장비 ON/OFF, 세이버·부츠 상세를
포함한 제작 전 검토 시트다. 사용자 승인 전에는 3D 모델링 입력으로 고정하지 않는다.

현재 3D LookDev WIP 타깃:

- `art_refs/characters/rin/concept/CH101_3D_LookDev_AB_WIP_v004.png`
- `art_refs/characters/rin/concept/CH101_3D_LookDev_AB_WIP_v004.metadata.md`

v004는 실제 메시가 아니라, Blender 모델이 도달해야 할 얼굴·체형·재질·조명·A/B
실루엣의 시각 목표다. v010 프리미티브 스캐폴드와 혼동하지 않는다.

현재 Blender 공통 베이스 메시 WIP 리뷰:

- 소스 스크립트: `re-camp-blender/scripts/blender/build_ch101_base_mesh_wip.py`
- 렌더 리뷰: `re-camp-blender/artifacts/CH101_common_base_run3/renders/CH101_CommonBase_AB_WIP_front.png`
- 리뷰 문서: `re-camp-blender/docs/plans/ch101-common-base-mesh-wip-review-2026-08-16.md`

run3/4, 연결 Skin Modifier run2, voxel body run1은 각각 연속 링·패널 메시·연결 몸통·
voxel remesh를 검증한 기술 WIP지만, 결과가 여전히 레고/토이형 파츠 조합으로 읽혀
시각 품질 기준에서 반려됐다.
게임 자산·Gate B·Unity 임포트로 승격하지 않으며, 실제 고해상도 베이스 메시 확보 후
다시 시작한다.

현재 CH101-A canonical 모델링 입력 시트:

- `art_refs/characters/rin/concept/CH101_A_Canonical_Turnaround_WIP_v005.png`
- `art_refs/characters/rin/concept/CH101_A_Canonical_Turnaround_WIP_v005.metadata.md`
- `art_refs/characters/rin/3d_reference/CH101_A_2D3D_Translation_WIP_v001.md`

Blender 모델링 착수 씬:

- `re-camp-blender/artifacts/CH101_modeling_guide_run3/CH101_A_ModelingGuide_WIP_v001.blend`
- `re-camp-blender/docs/plans/ch101-modeling-guide-wip-2026-08-16.md`
- `re-camp-blender/artifacts/CH101_rig_template_run5/CH101_A_RigTemplate_WIP_v001.blend`
- `re-camp-blender/docs/plans/ch101-rig-template-wip-2026-08-16.md`
- `re-camp-blender/scripts/blender/validate_ch101_mesh_intake.py`
- `re-camp-blender/docs/plans/ch101-mesh-intake-validator-wip-2026-08-16.md`
- `art_source/manifests/CH101_A_PRODUCTION_MANIFEST_WIP_v001.json`
- `planning/CH101_A_MODELING_HANDOFF_WIP_2026-08-16.md`
- `re-camp-blender/vendor_lock.json`
- `re-camp-blender/docs/plans/ch101-mpfb-source-review-2026-08-17.md`
- `re-camp-blender/artifacts/CH101_v011_modeling_guide_run1/CH101_A_V011_ModelingGuide_WIP_v001.blend`
- `re-camp-blender/artifacts/CH101_v011_modeling_guide_run1/reports/CH101_A_V011_ModelingGuide_WIP_v001.json`
- `re-camp-blender/artifacts/CH101_v012_modeling_guide_run1/CH101_A_V012_ModelingGuide_WIP_v001.blend`
- `re-camp-blender/artifacts/CH101_v012_modeling_guide_run1/reports/CH101_A_V012_ModelingGuide_WIP_v001.json`
- `re-camp-blender/artifacts/CH101_mpfb_bound_run1/CH101_A_MPFBody_RigBound_WIP_v001.blend`
- `re-camp-blender/artifacts/CH101_mpfb_bound_run2/CH101_A_MPFBody_RigBound_WIP_v001.blend`
- `re-camp-blender/artifacts/CH101_targeted_bound_run1/CH101_A_TargetedBody_RigBound_WIP_v001.blend`
- `re-camp-blender/artifacts/CH101_targeted_bound_run1/reports/CH101_targeted_bound_validation.json`
- `re-camp-blender/scripts/blender/validate_ch101_bound_body.py`
- `re-camp-blender/docs/plans/ch101-mpfb-source-review-2026-08-17.md`

2026-08-17 스타일링 검증 결과:

- `re-camp-blender/artifacts/CH101_mpfb_styled_run6/` — 로프트 의상·부츠·얼굴/헤어 비례 보정 WIP
- `re-camp-blender/artifacts/CH101_mpfb_styled_run7/` — 연속 재킷 쉘·알몬드 눈·세분화 헤어 WIP
- `re-camp-blender/artifacts/CH101_mpfb_helpers_run1/` — MPFB helper 표면 좌표 정렬 검사
- 위 세 결과는 모두 자동 생성 검증용이며 재킷·헤어가 실제 인체 표면에 붙은
  프리미엄 CH101 모델로 읽히지 않아 `WIP / NOT APPROVED`로 유지한다.
- 다음 구현은 자동 패널/튜브 누적이 아니라, MPFB 인체 바디를 기준으로 한 수동/
  고해상도 의상·헤어 production mesh 제작이다. 해당 메시와 4방향·포즈 렌더가
  나오기 전에는 Gate A를 승인 상태로 바꾸지 않는다.

이 씬은 기준 이미지·신체 기준점·소켓·생산 컬렉션을 묶은 작업 시작점이다. 생산
컬렉션은 실제 고해상도 연결 메시가 들어오기 전까지 비워 두며, 프리미티브 스캐폴드를
재사용하지 않는다.

추가 제작 입력:

- `art_refs/characters/rin/expressions/CH101_A_ExpressionSheet_WIP_v006.png`
- `art_refs/characters/rin/expressions/CH101_A_ExpressionSheet_WIP_v006.metadata.md`
- `art_refs/characters/rin/equipment/CH101_A_EquipmentSheet_WIP_v007.png`
- `art_refs/characters/rin/equipment/CH101_A_EquipmentSheet_WIP_v007.metadata.md`
- `art_refs/characters/rin/poses/CH101_A_PoseBoard_WIP_v008.png`
- `art_refs/characters/rin/poses/CH101_A_PoseBoard_WIP_v008.metadata.md`
- `art_refs/characters/rin/3d_reference/CH101_A_NeutralBodySculpt_WIP_v009.png`
- `art_refs/characters/rin/3d_reference/CH101_A_NeutralBodySculpt_WIP_v009.metadata.md`
- `art_refs/characters/rin/concept/CH101_A_ReadabilitySheet_WIP_v010.png`
- `art_refs/characters/rin/concept/CH101_A_ReadabilitySheet_WIP_v010.metadata.md`

2026-08-17 얼굴·상체 스타일 재정렬 WIP:

- `art_refs/characters/rin/concept/CH101_A_FaceBustStyleAnchor_WIP_v011.png`
- `art_refs/characters/rin/concept/CH101_A_FaceBustStyleAnchor_WIP_v011.metadata.md`
- `art_refs/characters/rin/concept/CH101_A_FaceBustRotation_WIP_v012.png`
- `art_refs/characters/rin/concept/CH101_A_FaceBustRotation_WIP_v012.metadata.md`

v011은 기존 v005/v010의 얼굴·헤어·재킷·체형 언어를 한 장의 3/4 상체 앵커로
재정렬한 신규 2D WIP다. 기존 Blender run6/7보다 목표 화풍과의 매칭이 높지만,
사람 Gate A 승인 전에는 3D 입력 또는 `APPROVED`로 취급하지 않는다.

v012는 v011과 v005를 기준으로 정면·3/4·측면·후면 상체 회전을 고정한 시트다.
얼굴·포니테일·칼라·재킷 어깨/등판을 수동 3D 메시에서 일치시키는 입력으로 사용한다.

v006은 동일 얼굴의 표정 8종, v007은 세이버·리본·의상 하드웨어·스트랩·파우치·
부츠의 분리 제작 기준, v008은 A-Pose·Idle·Attack·Skill·Victory 변형 기준이다. 세
시트와 v009 중립 바디 기준 모두 실제 blendshape/메시/Unity 자산이 아니며
사람 Gate A/B 승인 전에는 `APPROVED`로 표시하지 않는다.

v005는 A Route Sprint를 첫 제작 대상으로 고정하기 위한 정면·측면·후면·3/4·얼굴
클로즈업 시트다. 이는 수동/고해상도 모델링의 시각 입력이며, 최종 직교도나 메시가
아니다. 사람 Gate A 승인 전에는 `APPROVED` 또는 Unity 입력으로 취급하지 않는다.

## A+B 변형 사용 정책

사용자 방향에 따라 CH101은 A와 B를 같은 캐릭터의 두 의상/임무 변형으로
발전시킬 수 있다.

- A `Route Sprint`: 기본 전투·탐험형. 역동적인 포즈, 짧은 크롭 재킷, 가장 강한
  허벅지 노출과 속도 실루엣을 담당한다.
- B `Signal Courier`: 대체 임무·로비형. A와 같은 얼굴·체형·리그를 사용하고,
  균형 잡힌 재킷 패널·후드·신호 장비로 차이를 만든다.
- A와 B는 별도 플레이어블 캐릭터가 아니며, 캐릭터 ID·스킬·골격·표정 세트를
  공유한다.
- MVP에서는 A를 canonical 3D 기준으로 먼저 제작하고, B는 같은 베이스 메시와
  리그에 의상·헤어 액세서리·장비 차이를 추가하는 순서로 제작한다.
- 다른 4인에게도 동일한 변형 수를 즉시 강제하지 않는다. 각 캐릭터의 대표 훅과
  제작 예산을 확인한 뒤 선택적으로 확장한다.

A와 B 모두 Gate A에서 방향 승인을 받아야 하며, Gate B에서는 공통 베이스와 두
  변형의 의상/장비 교체 구조·소켓·관통·LOD 예산을 함께 확인한다.

## Gate A와 Gate B의 경계

### Gate A — 사용자가 먼저 승인할 것

- 3안 중 CH101의 얼굴·헤어·체형·패션·대표 장비가 매력적으로 느껴지는가
- 128px 얼굴과 흑백 실루엣에서도 캐릭터가 즉시 구분되는가
- 일본 서브컬처 화풍이며 서양식/레고식/회색 박스 인상이 없는가
- 다른 4인과 같은 게임의 스타일이면서 CH101만의 훅이 있는가

### Gate B — 선택 후 승인할 것

- 선택된 2D와 3D Turnaround의 얼굴·헤어·의상 절개가 일치하는가
- 5.2~5.4등신에서 성인 여성 가독성과 Humanoid 관절이 유지되는가
- 대표 장비의 결합·소켓·접힘·발광 구조가 제작 가능한가
- A-Pose·Idle·Attack·Skill에서 의상/헤어/장비 관통이 통제되는가
- Material·Bone·Texture·LOD·Shader 예산과 2D→3D 단순화표가 존재하는가

Gate B는 최종 출시 모델 승인이 아니다. Gate B 승인 뒤에 Unity Import·Prefab·LODGroup
테스트를 시작할 수 있으며, 실제 게임 사용은 Gate C 승인 이후에만 가능하다.

## 즉시 실패 조건

- 큐브·구체 조합처럼 보이는 프리미티브 얼굴/헤어/의상
- 얼굴 특징이 눈 두 점과 입 선으로만 표현됨
- 5등신 미만 또는 6등신 초과, 아동형·남성형 실루엣
- 동일한 검정 전술복의 색상 교체처럼 보임
- 3/4 쿼터뷰에서 얼굴·허리선·대표 장비가 읽히지 않음
- 사용자가 “매력적이다”라고 판단하기 전 Gate B 또는 `APPROVED` 표기
