# Luna 2D to 3D Translation WIP v002 — ART-0112 Review

- Asset: `Luna_2DTo3DTranslation_WIP_v002.png`
- Status: `WIP`
- Human Reviewer: `Pending`
- Approval: `NOT GRANTED`
- Review scope: 사용자 레퍼런스 기반 서브컬처 감도·여성적 매력과 `ART-0112` 변환 필드의 자동 사전 점검

## Revision Intent

v001은 서양권 전술 콘셉트 아트에 가까운 얼굴·장비 비중과 직선적인 체형으로 인해 목표한 남성향 서브컬처 감도와 여성적인 매력이 부족했다. v002는 섬세한 애니메이션 얼굴, 큰 눈의 가독성, 잘록한 허리와 곡선적인 골반·긴 다리 흐름, 크림·차콜 의상의 정돈된 광택을 강화했다. 오른쪽 3D형은 치비가 아니라 성인형 5~6등신 SD-lite로 읽히도록 별도 비율 보정을 적용했다.

## Style and Field Validation

| 항목 | 자동 판정 | 근거와 남은 확인 |
|---|---|---|
| 프리미엄 서브컬처 감도 | PASS FOR WIP | 섬세한 얼굴·발광 포인트·정돈된 의상 재질이 사용자 레퍼런스 방향에 가까워짐 |
| 매력적인 성인 여성 인상 | PASS FOR WIP | 성숙한 얼굴, 허리·골반 곡선, 긴 다리 흐름을 2D와 3D형 모두 유지 |
| 루나 정체성 일치 | PASS FOR WIP | 은민트 헤어, 기계식 고양이 센서 후드, 크림·차콜 복장, 청록 쌍단검 유지 |
| 2D 6.9~7.1 목표 기록 | CONDITIONAL | 목표값은 기록됐으나 head-count overlay 측정 전 |
| 3D 5.3~5.4 목표 기록 | CONDITIONAL | 오른쪽을 성인형 5~6등신으로 재보정했으나 정밀 비율·Orthographic 검증 전 |
| 확대·삭제·결합 필드 | PASS FOR WIP | 얼굴·센서 귀·쌍단검 확대와 미세 디테일 삭제, 큰 색면 결합을 명시 |
| 헤어·천 단순화 | CONDITIONAL | 방향은 명시됐으나 Hair Card·물리 본 예산 없음 |
| 관절·관통 위험 | NOT TESTED | 3D Blockout과 `CHARACTER_3D_SPEC.md`가 아직 없음 |
| 외부 IP 유사성 | NOT TESTED | 5인 비교와 별도 유사성 검토 필요 |

## Gate B Pre-check

| Gate | 판정 | 이유 |
|---|---|---|
| CHA-B03 | CONDITIONAL | 확대·삭제·결합 필드는 작성했지만 사람 검토와 Figma Frame 05 전사가 남음 |
| CHA-B04 | NOT TESTED | 정확한 5.3~5.4등신과 Humanoid 관절 가동을 측정하지 않음 |
| CHA-B07 | CONDITIONAL | 대표 특징 확대와 여성적 실루엣 방향은 보이나 카메라·리그·애니메이션 검증 전 |
| CHA-B08 | NOT TESTED | 헤어·패널·케이블 물리 본 및 관통 예산이 없음 |

## Next Actions

1. 이미지 위에 2D·3D head-count 기준선을 적용해 목표 비율을 측정한다.
2. 사용자 검토로 얼굴 매력, 여성적인 체형, 서브컬처 감도, 3D형 성숙도를 확인한다.
3. v002 제작 시트 `FRAME_05_Palette_Materials_3DTranslation`에 변환표를 전사한다.
4. 3D 번역본의 허리 파우치와 무릎 보호대 정보를 한 단계 더 단순화한다.
5. Approved 2D 제작 시트 전에는 `ART-1008`, Gate B 또는 모델링 기준으로 승격하지 않는다.
