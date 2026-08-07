# Luna 2D to 3D Translation WIP v003 — ART-0112 Review

- Asset: `Luna_2DTo3DTranslation_WIP_v003.png`
- Status: `WIP`
- Human Reviewer: `Pending`
- Approval: `NOT GRANTED`
- Review scope: 대표 히로인급 서브컬처 매력·여성적 기능성 패션·루나 고유 훅과 `ART-0112` 변환 필드의 자동 사전 점검

## Revision Intent

v002는 렌더 품질과 기본 여성미는 확보했지만 범용적인 은발 전술 요원으로 읽힐 여지가 있었다.
v003는 두 눈이 보이는 밝고 영리한 얼굴, 장난스러운 미소, 여성적인 허리·골반·다리 흐름,
크림 크롭 정찰 패션, 감정과 탐지 상태를 표현하는 기계식 센서 귀, 꼬리 제스처의 스캐너 케이블을
루나의 판매 포인트로 강화했다.

## Style and Field Validation

| 항목 | 자동 판정 | 근거와 남은 확인 |
|---|---|---|
| 프리미엄 서브컬처 감도 | PASS FOR WIP | 얼굴·헤어·피부·의상 재질과 청록 발광을 캐릭터 중심으로 정리 |
| 매력적인 성인 여성 인상 | PASS FOR WIP | 성인 얼굴, 분명한 허리선, 골반·허벅지 곡선과 긴 다리 흐름을 유지 |
| 얼굴·두 눈 가독성 | PASS FOR WIP | 앞머리를 눈 옆으로 이동해 두 눈과 눈동자를 모두 노출 |
| 루나 정체성 | PASS FOR WIP | 민트 실버 비대칭 보브, 기계식 센서 후드, 크림 재킷, 쌍단검, 스캐너 유지 |
| 장난↔집중 감정 대비 | CONDITIONAL | 좌우 표정 온도 차이는 있으나 표정 8종 제작 전 |
| 여성적 기능성 패션 | PASS FOR WIP | 군용 부피를 줄이고 크롭 재킷·하이웨이스트 쇼츠·비대칭 패널로 몸선과 역할을 결합 |
| 2D 6.9~7.1 목표 | PASS FOR WIP | 공식 보이는 후드 Dome 규칙에서 6.97로 목표 안; 독립 해부학적 Crown 추정 7.65는 민감도 참고값 |
| 3D 5.3~5.4 목표 | FAIL — REVISION REQUIRED | 보이는 후드 Dome 기준 4.14, 독립 해부학적 Crown 추정 4.59로 두 방법 모두 목표 밖 |
| 128px 얼굴 가독성 | PASS FOR WIP | 두 눈·얼굴 윤곽·민트 헤어가 읽힘; 최종 Portrait Crop은 별도 확정 필요 |
| 흑백 실루엣 | CONDITIONAL | 센서 귀·케이블·쌍단검은 식별되나 오른쪽 Head mass가 과대하고 장비 포함 외곽이 넓음 |
| 3D 장식 단순화 | CONDITIONAL | 큰 색면은 분리되지만 Seam·패널 마킹을 추가 축소해야 함 |
| 관절·관통 위험 | NOT TESTED | 실제 3D Blockout, 케이블 물리 본, 허리 패널 가동 검증 전 |
| 외부 IP 유사성 | NOT TESTED | 5인 교차 비교와 별도 유사성 검토 필요 |

## Gate B Pre-check

| Gate | 판정 | 이유 |
|---|---|---|
| CHA-B03 | CONDITIONAL | 확대·삭제·결합 필드는 작성했지만 사람 검토와 Figma Frame 05 전사가 남음 |
| CHA-B04 | FAIL | 공식 측정 오른쪽 4.14등신, 독립 교차검증 4.59등신 모두 목표보다 짧음; Humanoid 가동 검증 전에도 비율 재작업 필요 |
| CHA-B07 | CONDITIONAL | 얼굴·센서 귀·쌍단검과 여성적 실루엣은 읽히나 실제 전투 카메라 검증 전 |
| CHA-B08 | NOT TESTED | 헤어·패널·케이블 물리 본 및 관통 예산이 없음 |

## Human Review Questions

1. 루나가 첫 화면에서 충분히 예쁘고 매력적인 대표 히로인으로 보이는가?
2. 성인 여성의 슬림 애슬레틱 체형과 여성성이 과하거나 부족하지 않은가?
3. 얼굴이 다른 서브컬처 캐릭터와 구분되는가, 아니면 여전히 범용 미형에 가까운가?
4. 기계식 센서 귀와 꼬리형 케이블이 역할 장비로 읽히며 생물형 Catgirl로 오독되지 않는가?
5. 오른쪽의 공식 측정 4.14등신 결과를 폐기하고 다음 번역본을 5.3~5.4등신으로 다시 만드는 방향에 동의하는가? 독립 4.59등신도 같은 실패를 확인했다.

## Next Actions

1. 선택용 `Luna_FullBodyCandidates_REVIEW_v002.png`의 A v001 / B v004 / C v005에서 사람 기준안을 선택한다.
2. 선택된 약 7등신 2D 후보를 기준으로 오른쪽 3D 번역본을 5.3~5.4등신으로 재생성한다.
3. 같은 `Build-CharacterReviewEvidence.ps1` 측정법으로 새 번역본을 다시 검증한다.
4. 비율 통과 후 v002 제작 시트 `FRAME_05_Palette_Materials_3DTranslation`에 변환표를 전사한다.
5. 사람 승인 전에는 `ART-1008`, Gate B 또는 모델링 기준으로 승격하지 않는다.

## Evidence

- `Luna_ProportionGateEvidence_REVIEW_v001.png`
- `Luna_Face128_REVIEW_v001.png`
- `Luna_SilhouetteTest_REVIEW_v001.png`
- `tools/art/Build-CharacterReviewEvidence.ps1`
