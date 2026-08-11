# CH101 아마사와 린 — Production Handoff REVIEW v001

> Date: 2026-08-11
> Branch: `art/current-roster-gate-a`
> Status: `REVIEW / Gate B preparation`
> Upstream approval: `art_source/manifests/CH101_Rin_GateA_Approval_20260811.md`

이 문서는 Gate A 승인 방향을 제작 시트와 2D→3D 작업으로 넘기기 위한 REVIEW handoff다. 이 문서와 현재 REVIEW PNG/PDF는 사람의 최종 제작 시트 승인이나 Gate B 승인을 대체하지 않는다.

## 1. Package

- `art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_REVIEW_v001.png`
- `art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_REVIEW_v001.pdf`
- `art_refs/characters/rin/concept/CH101_Rin_Turnaround_REVIEW_v001.png`
- `art_refs/characters/rin/concept/CH101_Rin_ExpressionSheet_REVIEW_v001.png`
- `art_refs/characters/rin/concept/CH101_Rin_EquipmentSheet_REVIEW_v001.png`
- `art_refs/characters/rin/concept/CH101_Rin_MaterialPalette_REVIEW_v001.png`
- Existing Gate A face, silhouette ON/OFF, and desaturated validation exports.

## 2. LOCKED from Gate A

- Face identity and high dark ponytail with cyan accent strands.
- White/black/gold sporty cropped jacket, black cropped shorts, thigh straps, and high-top boots.
- Exactly one saber and exactly one cyan signal ribbon with gold lattice pattern.
- Route Sprint forward-motion read, adult feminine proportions, and signal-courier role hook.
- 128px face readability, equipment ON/OFF evidence, and low-saturation direction are approved as Gate A evidence.

## 3. CONTROLLED / OPEN for this package

- Side/back seam placement and exact proportion consistency.
- Expression target selection and facial deformation limits.
- Saber grip/socket, stored/active state, emission edge, collider, and prefab boundaries.
- Ribbon path, single-ribbon implementation, material values, and emission budget.
- 2D→3D simplification and common Humanoid compatibility.

## 4. 2D→3D simplification table

| 항목 | 유지 | 확대 | 단순화/삭제 | 제작 위험 |
|---|---|---|---|---|
| 얼굴 | 눈 모양, 앞머리, 성인 여성 비율, 표정 방향 | 128px 얼굴·눈 대비 | 미세 속눈썹·피부선 축약 | 쿼터뷰에서 얼굴 가독성 저하 |
| 헤어 | 높은 포니테일, 시안 포인트, 앞머리 실루엣 | 포니테일 루트와 끝단 색 | 잔가닥을 2~3개 큰 카드/덩어리로 통합 | 카메라 클리핑·관통 |
| 상체 | 흰/검정/금색 재킷 절개, 칼라·스트랩 | 칼라·어깨·허리선 | 스티치·소형 버클 일부 삭제/텍스처화 | 어깨·팔꿈치 변형 |
| 하체 | 크롭 쇼츠, 허벅지 스트랩, 부츠 | 부츠·다리 실루엣 | 버클·미세 끈 통합 | 관절 클리핑·실루엣 약화 |
| 대표 장비 | 단일 세이버의 그립·가드·시안 블레이드 | 그립·가드·발광 엣지 | 미세 블레이드 패턴은 텍스처 | 손 소켓·공격 모션 충돌 |
| 천·링·케이블 | 단일 신호 리본의 큰 경로와 금색 격자 | 리본 경로·활성 발광 | 격자는 텍스처, 물리는 단일 Trail/mesh로 제한 | 얼굴/카메라 가림, overdraw |
| 발광·VFX | 세이버 엣지와 리본 활성 상태 | 작은 시안 emission cue | 파티클 수·레이어·수명 최소화 | 모바일 overdraw 및 가독성 저하 |

## 5. Gate B exit criteria

1. 사용자가 `CH101_Rin_CharacterSheet_REVIEW_v001`을 검토하고 승인 또는 수정 범위를 기록한다.
2. `CHA-B01~B10` 필수 증거가 turnaround, equipment sheet, material table, simplification table, pose blockout, `CHARACTER_3D_SPEC.md`와 함께 채워진다.
3. 공용 Humanoid 관절, socket, material slot, LOD, texture, physics, VFX 예산이 기록된다.
4. 위 조건 전에는 3D Blockout, Unity import, Runtime roster replacement를 시작하지 않는다.
