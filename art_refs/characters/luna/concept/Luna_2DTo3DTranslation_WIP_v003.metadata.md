# Luna 2D to 3D Translation WIP v003 Metadata

> `VISUAL CONTRACT SUPERSEDED`: 비대칭 허리 천 패널은 최신 전신 WIP v007에서 폐기됐다. 현재 계약은
> 패널 없는 차콜 하이웨이스트 유틸리티 쇼츠와 허리 스캐너·벨트 비대칭이다.

```yaml
Asset Name: Luna_2DTo3DTranslation_WIP_v003.png
Character/Environment: CH001 Luna
Purpose: ART-0112 대표 히로인급 서브컬처 매력과 2D 약 7등신에서 3D 5.3~5.4등신으로의 시각 번역 검증
Status: WIP
Generated Date: 2026-07-25
Tool/Model: OpenAI built-in image generation tool / model identifier not exposed
Workflow Version: ART-0112 WIP v003
Seed: Not available
Input References:
  - docs/05_art_concept/CHARACTER_BIBLE.md v2.0, CH001 Luna
  - docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md v2.0, CH001 Luna
  - docs/05_art_concept/CHARACTER_SHEET_TEMPLATE_SPEC.md v002
  - art_refs/characters/luna/concept/Luna_2DTo3DTranslation_WIP_v002.png
  - User-provided reference: ChatGPT Image 2026년 7월 25일 오후 12_27_13.png
Human Edits: v002 스타일 변환 후 얼굴 가독성과 3D 비율을 반복 검토; 첫 v003 비율을 유지한 얼굴 앞머리 전용 보정본 선택
Usage Restriction: Review and field validation only; not an Approved character sheet, modeling source, or Unity runtime asset
Reviewer: Pending
2D Proportion Target: 6.9~7.1 heads
3D Proportion Target: 5.3~5.4 heads
Measured 2D Proportion: 6.97 heads using visible hood-dome crown convention; independent anatomical-crown estimate 7.65 heads
Measured 3D Proportion: 4.14 heads using visible hood-dome crown convention; independent anatomical-crown estimate 4.59 heads
Proportion Decision: RIGHT / 3D OUTSIDE TARGET; revision required
One-line Visual Hook: 감정에 반응하는 고양이형 방향 센서 후드와 쌍단검을 쓰는 장난기 많은 도시형 폐허 정찰병
Style Direction: 매력적인 성인 여성 대표 히로인; 섬세한 애니메이션 얼굴, 여성적 기능성 패션, 장난스러움과 전투 집중의 대비
Trend / Function Rationale: 예쁨과 여성성을 공통 진입점으로 확보하고 센서 귀·꼬리형 스캐너 케이블·쌍단검·표정 대비로 루나만의 역할과 팬심 훅을 분리
External-IP Similarity: NOT TESTED
```

## Anchor Decisions

| 범주 | v003 적용 |
|---|---|
| 얼굴 | 두 청록 눈을 모두 노출하고 밝고 영리한 성인 인상과 작은 장난스러운 미소를 우선 |
| 헤어 | 민트 실버 비대칭 울프 보브, 한쪽이 긴 얼굴 프레이밍 Lock은 눈 옆으로 배치 |
| 체형 | 2D는 여성적인 S-curve와 긴 다리를 가진 슬림 애슬레틱, 3D는 성인 허리·골반·허벅지 흐름을 유지한 SD-lite |
| 패션 | 크림 크롭 정찰 재킷과 몸선을 정리하는 차콜 이너, 하이웨이스트 쇼츠, 단일 비대칭 허리 패널 |
| 대표 특징 | 회전 Hinge와 청록 Scan Aperture가 보이는 기계식 센서 귀 |
| 보조 특징 | Fang형 쌍 에너지 단검, 꼬리 제스처를 만드는 단일 스캐너 케이블 |
| 디테일 원칙 | 군용 Harness·파우치·무릎 장갑을 줄이고 큰 색면과 여성적 곡선 재단을 우선 |

## 2D to 3D Simplification

| 처리 | 2D 요소 | 3D 번역 판단 |
|---|---|---|
| 유지 | 두 눈이 보이는 매력적인 성인 얼굴 | 눈·입꼬리·앞머리 방향을 확대해 작은 화면에서 표정 우선 |
| 유지 | 허리·골반·허벅지의 여성적인 흐름 | 머리가 커져도 유아형이 되지 않도록 성인형 허리와 하체 곡선을 유지 |
| 확대 | 센서 귀·손·발·쌍단검 | 쿼터뷰에서 역할과 공격 방향을 식별하도록 확대 |
| 확대 | 손목 스캐너 | 단일 반투명 청록 덩어리로 정리해 탐지 역할을 보조 |
| 삭제 | 반복 버클·스티치·소형 파우치·무릎 장갑 | 실루엣과 역할에 기여하지 않는 전술 장비 정보를 제거 |
| 결합 | 상의 절개·허리 장식 | 크림 재킷, 차콜 이너, 비대칭 패널의 큰 색면으로 통합 |
| 단순화 | 울프 보브·재킷 주름·패널 프린트 | 끝단·주름·마킹 수를 줄이고 얼굴과 외곽선 주변만 유지 |
| 단순화 | 꼬리형 스캐너 케이블 | 단일 Cable과 끝단 Probe만 남기고 물리 본·관통 예산을 제한 |

## Generation Prompt Set

1. v002의 정체성과 좌우 비교 구도를 유지하고, 사용자 레퍼런스의 프리미엄 서브컬처 감도만 참고해 대표 히로인급 얼굴·여성적 기능성 패션·장난기·기계식 센서 귀를 강화한다.
2. 두 눈 가독성과 오른쪽 비율을 함께 보정한 분기는 오른쪽이 축소된 약 7등신으로 회귀해 제외한다.
3. 오른쪽 비율만 재보정한 분기도 2D와 3D의 구조 차이가 약해 제외한다.
4. 첫 v003 후보의 좌우 비율과 의상·장비를 고정하고, 앞머리만 눈 옆으로 이동해 두 눈을 완전히 노출한 결과를 최종 WIP로 선택한다.

## Known Risks

- 공식 후드 돔 규칙에서 왼쪽 2D는 6.97등신으로 통과하고 오른쪽 3D는 4.14등신으로 실패했다. 독립 해부학적 Crown 추정 7.65/4.59는 측정 민감도 참고값이며 공식 범위로 합치지 않는다.
- 오른쪽은 3D 제작 방향을 설명하는 일러스트이며 Orthographic Turnaround, 실제 Mesh, Humanoid 관절 가동 결과가 아니다.
- 오른쪽 의상 Seam과 허리 패널 마킹은 실제 3D 번역 시 한 단계 더 단순화해야 한다.
- 꼬리형 스캐너 케이블 끝단이 생물 꼬리로 오독되지 않도록 회전 Joint와 Probe 구조를 제작 시트에서 명확히 해야 한다.
- 가슴선과 허리 노출도가 대표 히로인의 여성적 패션으로 적절한지는 사람 검토가 필요하다.
- 128px 얼굴은 두 눈·얼굴 윤곽·민트 헤어가 읽히지만 센서 귀 끝 일부가 Crop 밖으로 나간다.
- 흑백 실루엣은 센서 귀·케이블·쌍단검이 읽히지만 오른쪽의 과대 Head mass가 명확하다.
- 외부 IP 유사성과 5인 교차 디자인 비교는 아직 수행하지 않았다.

## Review History

| Date | Reviewer | Decision | Notes |
|---|---|---|---|
| 2026-07-25 | User feedback | REVISION REQUESTED | v002보다 예쁨·귀여움·여성성과 루나 고유의 매력을 더 발전시킬 필요가 있음 |
| 2026-07-25 | Codex automatic review | WIP | 얼굴·패션·센서 기능·표정 훅을 강화하고 실패한 비율 보정 분기를 제외한 두 눈 노출본 선택 |
| 2026-07-25 | Codex image-space validation | REVISION REQUIRED | 128px 얼굴은 통과했으나 공식 측정 오른쪽 3D 4.14등신이 5.3~5.4 목표 실패; 독립 4.59도 실패를 교차 확인 |
