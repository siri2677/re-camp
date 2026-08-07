# Luna 2D to 3D Translation WIP v002 Metadata

```yaml
Asset Name: Luna_2DTo3DTranslation_WIP_v002.png
Character/Environment: CH001 Luna
Purpose: ART-0112 서브컬처 여성 캐릭터 감도와 2D 약 7등신에서 3D 5.3~5.4등신으로의 시각 번역 검증
Status: WIP
Generated Date: 2026-07-25
Tool/Model: OpenAI built-in image generation tool / model identifier not exposed
Workflow Version: ART-0112 WIP v002
Seed: Not available
Input References:
  - docs/05_art_concept/CHARACTER_BIBLE.md v2.0, CH001 Luna
  - docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md v2.0, CH001 Luna
  - docs/05_art_concept/CHARACTER_SHEET_TEMPLATE_SPEC.md v002
  - art_refs/characters/luna/concept/Luna_2DTo3DTranslation_WIP_v001.png
  - User-provided reference: ChatGPT Image 2026년 7월 25일 오후 12_27_13.png
Human Edits: 사용자 스타일 피드백을 반영한 이미지 변환 후 오른쪽 3D형 비율 보정; 두 번째 생성 결과 선택
Usage Restriction: Review and field validation only; not an Approved character sheet, modeling source, or Unity runtime asset
Reviewer: Pending
2D Proportion Target: 6.9~7.1 heads
3D Proportion Target: 5.3~5.4 heads
One-line Visual Hook: 고양이형 방향 센서 후드와 청록 발광 쌍단검을 쓰는 도시형 폐허 정찰병
Style Direction: 매력적인 성인 여성 중심의 프리미엄 남성향 모바일 RPG 서브컬처; 섬세한 애니메이션 얼굴, 여성적인 실루엣, 정돈된 광택 재질
Trend / Function Rationale: 얼굴·눈·허리선·다리 실루엣의 매력을 우선하면서 쿼터뷰에서 센서 귀·쌍단검·크림 후드를 식별
External-IP Similarity: NOT TESTED
```

## Scope Assessment

| Scope | Status | Allowed Use | Notes |
|---|---|---|---|
| Character design | WIP | 비교·피드백 | 사용자 레퍼런스의 서브컬처 감도와 여성미를 반영했으나 얼굴·의상 최종 확정 전 |
| 2D proportion reference | CONDITIONAL | ART-0112 필드 검토 | 정확한 6.9~7.1 head-count overlay 측정 전 |
| 3D translation reference | CONDITIONAL | Blockout 방향 토론 | 정확한 5.3~5.4 head-count와 관절 가동 검증 전 |
| Final modeling source | NOT ALLOWED | 사용 금지 | Approved Turnaround·Equipment Sheet가 아님 |
| Unity runtime | NOT ALLOWED | 사용 금지 | 최종 Texture·Model·Prefab 자산이 아님 |

## 2D to 3D Simplification

| 처리 | 2D 요소 | 3D 번역 판단 |
|---|---|---|
| 유지 | 성인 여성형 얼굴·허리선·골반·다리 흐름 | 짧아진 비율에서도 유아형·치비형으로 보이지 않도록 여성적인 S-curve와 성숙한 인상을 보존 |
| 확대 | 얼굴·눈매 | 전투 카메라에서 섬세한 눈매와 캐릭터 매력이 읽히도록 상대 크기 확대 |
| 확대 | 접힘·회전식 센서 귀 | 생물 귀가 아닌 장비 구조를 유지하고 외곽선 식별성을 높임 |
| 확대 | 손·발·쌍단검 | 공격 방향과 장비 종류가 작은 화면에서도 읽히도록 확대 |
| 삭제 | 미세 버클·스티치·소형 파우치 | 실루엣에 기여하지 않는 반복 디테일을 제거 |
| 결합 | 상의 절개·보호대 Layer | 크림·차콜의 큰 색면과 제한된 보호대 덩어리로 통합 |
| 결합 | 허리 장식 | 비대칭 허리 패널 하나를 대표 실루엣으로 남김 |
| 단순화 | 울프 보브·비대칭 헤어 | 얼굴을 가리지 않는 큰 덩어리로 정리하고 끝단 수를 축소 |
| 단순화 | 긴 천·케이블 | 길이를 줄이고 물리 본·관통 위험이 높은 자유단을 제한 |
| 유지 | 손목 스캐너·소형 백팩 | 정찰 역할을 설명하는 보조 특징으로 유지하되 단일 큰 형태로 정리 |

## Generation Prompt Set

1. v001의 루나 정체성·장비를 유지하면서 사용자 레퍼런스의 프리미엄 서브컬처 모바일 RPG 감도, 섬세하고 매력적인 성인 여성 얼굴, 여성적인 체형, 정돈된 광택과 애니메이션 렌더링으로 변환한다.
2. 첫 결과의 스타일·정체성은 고정하고 오른쪽 3D형만 머리 크기를 줄이며 몸통과 다리를 늘려 5.3~5.4등신 성인형 SD-lite 비율로 보정한다.

## Known Risks

- 생성 이미지의 등신 수치는 시각 목표이며 정밀 측정값이 아니다.
- 후드와 센서 귀가 머리 부피를 크게 보여 실제 head-count를 더 짧게 인식시킬 수 있다.
- 오른쪽 3D형의 관절 가동 범위와 허리 패널·파우치·무릎 보호대의 관통 여부를 검증하지 않았다.
- 사용자 레퍼런스와의 방향성 비교는 반영했지만 최종 사람 승인 전이다.
- 외부 IP 유사성, 128px 얼굴 가독성, 흑백 실루엣 비교는 아직 수행하지 않았다.

## Review History

| Date | Reviewer | Decision | Notes |
|---|---|---|---|
| 2026-07-25 | User feedback | REVISION REQUESTED | v001은 서브컬처 감도와 여성적인 매력이 부족하므로 제공 레퍼런스 방향으로 수정 요청 |
| 2026-07-25 | Codex automatic review | WIP | 스타일 변환 후 오른쪽 비율을 재보정한 v002 선택; 사람 검토 대기 |
