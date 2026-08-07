# Luna 2D to 3D Translation WIP v001 Metadata

```yaml
Asset Name: Luna_2DTo3DTranslation_WIP_v001.png
Character/Environment: CH001 Luna
Purpose: ART-0112 2D 약 7등신에서 3D 5.3~5.4등신으로의 시각 번역 필드 검증
Status: WIP
Generated Date: 2026-07-25
Tool/Model: OpenAI built-in image generation tool / model identifier not exposed
Workflow Version: ART-0112 WIP v001
Seed: Not available
Input References:
  - docs/05_art_concept/CHARACTER_BIBLE.md v2.0, CH001 Luna
  - docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md v2.0, CH001 Luna
  - docs/05_art_concept/CHARACTER_SHEET_TEMPLATE_SPEC.md v002
  - art_refs/moodboard/battle_vertical_slice_concept.png
Human Edits: Prompt-directed proportion correction; second generated iteration selected
Usage Restriction: Review and field validation only; not an Approved character sheet, modeling source, or Unity runtime asset
Reviewer: Pending
2D Proportion Target: 6.9~7.1 heads
3D Proportion Target: 5.3~5.4 heads
One-line Visual Hook: 고양이형 방향 센서 후드와 쌍단검을 쓰는 도시형 폐허 정찰병
Trend / Function Rationale: 성인 서브컬처 패션 실루엣을 유지하면서 쿼터뷰에서 센서 귀·얼굴·쌍단검을 우선 식별
External-IP Similarity: NOT TESTED
```

## Scope Assessment

| Scope | Status | Allowed Use | Notes |
|---|---|---|---|
| Character design | WIP | 비교·피드백 | 얼굴·헤어·후드·의상 구조는 아직 변경 가능 |
| 2D proportion reference | CONDITIONAL | ART-0112 필드 검토 | 정확한 6.9~7.1 head-count overlay 측정 전 |
| 3D translation reference | CONDITIONAL | Blockout 방향 토론 | 정확한 5.3~5.4 head-count와 관절 가동 검증 전 |
| Final modeling source | NOT ALLOWED | 사용 금지 | Approved Turnaround·Equipment Sheet가 아님 |
| Unity runtime | NOT ALLOWED | 사용 금지 | 최종 Texture·Model·Prefab 자산이 아님 |

## 2D to 3D Simplification

| 처리 | 2D 요소 | 3D 번역 판단 |
|---|---|---|
| 확대 | 얼굴·눈매 | 전투 카메라에서 성인 인상과 장난기 있는 눈매가 읽히도록 상대 크기 확대 |
| 확대 | 접힘·회전식 센서 귀 | 생물 귀가 아닌 장비 구조를 유지하고 외곽선 식별성을 높임 |
| 확대 | 손·발·쌍단검 | 공격 방향과 장비 종류가 작은 화면에서도 읽히도록 확대 |
| 삭제 | 미세 버클·스티치·소형 파우치 | 실루엣에 기여하지 않는 반복 디테일을 제거 |
| 결합 | 상의 절개·보호대 Layer | 크림·차콜의 큰 색면과 제한된 보호대 덩어리로 통합 |
| 결합 | 허리 장식 | 비대칭 허리 패널 하나를 대표 실루엣으로 남김 |
| 단순화 | 울프 보브·비대칭 헤어 | 얼굴을 가리지 않는 큰 덩어리로 정리하고 끝단 수를 축소 |
| 단순화 | 긴 천·케이블 | 길이를 줄이고 물리 본·관통 위험이 높은 자유단을 제한 |
| 유지 | 손목 스캐너·소형 백팩 | 정찰 역할을 설명하는 보조 특징으로 유지하되 단일 큰 형태로 정리 |

## Known Risks

- 생성 이미지의 등신 수치는 시각 목표이며 정밀 측정값이 아니다.
- 오른쪽 후드와 센서 귀가 머리 부피를 크게 보여 실제 head-count를 더 짧게 인식시킬 수 있다.
- 허리 패널·파우치·무릎 보호대의 정보량이 3D 번역본에서 아직 많다.
- 스캐너 케이블의 고정점·최대 길이·물리 본 수가 정의되지 않았다.
- 외부 IP 유사성, 128px 얼굴 가독성, 흑백 실루엣 비교는 아직 수행하지 않았다.

## Review History

| Date | Reviewer | Decision | Notes |
|---|---|---|---|
| 2026-07-25 | Codex automatic review | WIP | 1차 초안의 치비 비율을 교정한 2차 생성본 선택; 사람 검토 대기 |
