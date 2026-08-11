# CH101 아마사와 린 — Gate A Candidate Manifest v001

> Backlog: `ART-1001`
> Status: APPROVED / Gate A + 2D production sheet; Gate B pending
> Generation: Current Generation only
> Canonical: `docs/00_project/CURRENT_PROJECT_BASELINE.md`
> Character: `docs/05_art_concept/CHARACTER_BIBLE.md`
> Anchor: `docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md`
> Review: `docs/05_art_concept/ART_REVIEW_CHECKLIST.md`

이 파일은 디자인 결정을 새로 정의하지 않는다. CH101의 동일 Anchor를 유지한 채 Gate A에서 비교할 3개의 통제 후보를 만들기 위한 제작 Manifest다.

## 1. 공통 고정 조건

세 후보 모두 다음을 동일하게 유지한다.

- 성인 여성, 2D 목표 비율은 Canonical Baseline의 CH101 값을 따른다.
- 밝고 자신감 있는 성인 여성 얼굴, 한쪽 입꼬리가 먼저 올라가는 표정 언어.
- 펄 블랙 단발 + 청록 언더라이트 + 한쪽 긴 묶음 포인트.
- 펄 화이트 비대칭 크롭 레이싱 재킷 + 딥 차콜 기능 이너 + 허리 하네스.
- 손목 접이식 **단일** 와이어 세이버.
- 어깨에서 시작해 하나의 큰 흐름으로 읽히는 **단일 신호 리본**.
- 낮은 전진 자세와 기동형 실루엣.
- 펄 화이트·딥 차콜·청록 기반, 버밀리온은 작은 경고 포인트에만 사용.
- 자연에 잠식된 폐허는 낮은 밀도의 중립 배경으로만 사용하며 캐릭터보다 시각적으로 앞서지 않는다.
- 고양이 귀·센서 후드·쌍단검·닌자/암살자·총기 중심 디자인을 사용하지 않는다.
- 리본을 여러 케이블이나 Cloth Physics 전제로 설계하지 않는다.

## 2. 후보 A — Route Sprint

목적: CH101의 **속도와 대표 얼굴**을 가장 직접적으로 읽히게 하는 안.

CONTROLLED 변화:

- 재킷: 세 후보 중 가장 짧고 스포티한 비대칭 크롭.
- 신호 리본: 어깨 뒤에서 넓은 한 번의 C-curve로 크게 휘어 속도를 강조.
- 헤어 묶음: 비교적 높은 뒤쪽 위치.
- 세이버: 가장 단순하고 날렵한 직선형 Handle.
- 표정: 자신감 있는 작은 미소.
- 포즈: 왼발이 먼저 나간 낮은 전진 준비 자세.

Gate A에서 확인할 질문:

- 3초 안에 `빠른 길잡이/정찰`이 읽히는가?
- 리본이 캐릭터보다 먼저 보이지 않는가?
- 스포티함이 유아형 또는 닌자형으로 흐르지 않는가?

## 3. 후보 B — Signal Courier

목적: **도시형 패션과 귀환 경로를 만드는 캐릭터성**을 가장 강하게 보여주는 안.

CONTROLLED 변화:

- 재킷: 허리선 가까이 오는 비대칭 레이싱 재킷, 앞뒤 길이 차이를 조금 더 줌.
- 신호 리본: 몸에서 너무 멀어지지 않는 S-curve로 배치해 얼굴·상체와 함께 읽히게 함.
- 헤어 묶음: 귀 아래쪽의 낮은 위치.
- 세이버: 얇은 브러시드 메탈 프레임과 작은 청록 활성 표시.
- 표정: 침착하지만 장난기가 남은 미소.
- 포즈: 한 손으로 경로를 가리키고 다른 손은 세이버 Handle 근처.

Gate A에서 확인할 질문:

- 전투 캐릭터이면서도 `길을 만드는 사람`이라는 정체성이 읽히는가?
- 도시형 패션이 일반 레이싱걸/스트리트웨어로만 보이지 않는가?
- 작은 화면에서 얼굴과 헤어 비대칭이 충분히 남는가?

## 4. 후보 C — Ruin Marker

목적: **위험 구역에서 길을 표시하는 기능 장비와 실루엣**을 가장 선명하게 보여주는 안.

CONTROLLED 변화:

- 재킷: 어깨와 한쪽 허리 패널에 조금 더 구조적인 절개를 사용.
- 신호 리본: 뒤에서 세로로 한 번 올라갔다가 옆으로 흐르는 큰 역-S 경로.
- 헤어 묶음: 중간 높이, 길이는 A/B의 중간.
- 세이버: 손목 수납 구조가 가장 명확하게 보이는 Handle.
- 표정: 임무 집중 상태, 눈매가 조금 더 날카로움.
- 포즈: 상체는 전진, 한 손은 경로 비콘을 놓는 동작.

Gate A에서 확인할 질문:

- 장비 구조가 복잡해지지 않으면서도 `Signal Runner` 훅이 강화되는가?
- 임무형 표정에서도 성인 여성 캐릭터의 매력이 유지되는가?
- 쿼터뷰 3D로 단순화할 때 리본·헤어·세이버의 세 가지 신호가 남는가?

## 5. 생성 공통 출력 계약

후보별 1차 출력:

```text
3/4 full body
neutral low-density ruin background
same camera height
same character scale
same lighting direction
same crop and canvas ratio
full feet visible
weapon and single ribbon visible
no text / no logo / no watermark
```

후보 간 허용 차이:

```text
jacket cut
ribbon path/width
hair tie height
saber handle detail
expression
pose/hand gesture
```

후보 간 금지 차이:

```text
face identity replacement
hair color replacement
multiple ribbons
weapon category replacement
body age change
large proportion change
completely different fashion genre
```

## 6. 파일 계획

```text
art_refs/characters/rin/concept/CH101_Rin_FullBody_WIP_A_v002.png
art_refs/characters/rin/concept/CH101_Rin_FullBody_WIP_A_v002.metadata.md
art_refs/characters/rin/concept/CH101_Rin_FullBody_WIP_B_v001.png
art_refs/characters/rin/concept/CH101_Rin_FullBody_WIP_B_v001.metadata.md
art_refs/characters/rin/concept/CH101_Rin_FullBody_WIP_C_v001.png
art_refs/characters/rin/concept/CH101_Rin_FullBody_WIP_C_v001.metadata.md
```

현재 생성된 통합 비교 보드:

```text
art_refs/characters/rin/concept/CH101_Rin_GateA_Candidates_WIP_v001.png
art_refs/characters/rin/concept/CH101_Rin_GateA_Candidates_WIP_v001.metadata.md
art_refs/characters/rin/concept/CH101_Rin_GateA_Candidates_WIP_v001.review.md
```

현재 생성된 A안 개별 기준 자산:

```text
art_refs/characters/rin/concept/CH101_Rin_FullBody_WIP_A_v002.png
art_refs/characters/rin/concept/CH101_Rin_FullBody_WIP_A_v002.metadata.md
art_refs/characters/rin/concept/CH101_Rin_FullBody_WIP_A_v002.review.md
```

The v001 A full-body WIP was generated without the original contact sheet as an image reference and is superseded by source-faithful v002. Keep v001 only as provenance.

Gate A validation exports for source-faithful v002:

```text
art_refs/characters/rin/concept/CH101_Rin_Face128_WIP_A_v001.png
art_refs/characters/rin/concept/CH101_Rin_Face128_WIP_A_v001.metadata.md
art_refs/characters/rin/concept/CH101_Rin_Face128_WIP_A_v001.review.md
art_refs/characters/rin/concept/CH101_Rin_Silhouette_ON_WIP_A_v001.png
art_refs/characters/rin/concept/CH101_Rin_Silhouette_ON_WIP_A_v001.metadata.md
art_refs/characters/rin/concept/CH101_Rin_Silhouette_ON_WIP_A_v001.review.md
art_refs/characters/rin/concept/CH101_Rin_Silhouette_OFF_WIP_A_v001.png
art_refs/characters/rin/concept/CH101_Rin_Silhouette_OFF_WIP_A_v001.metadata.md
art_refs/characters/rin/concept/CH101_Rin_Silhouette_OFF_WIP_A_v001.review.md
art_refs/characters/rin/concept/CH101_Rin_Desaturated_WIP_A_v001.png
art_refs/characters/rin/concept/CH101_Rin_Desaturated_WIP_A_v001.metadata.md
art_refs/characters/rin/concept/CH101_Rin_Desaturated_WIP_A_v001.review.md
```

These are Gate A evidence proxies. They support the recorded CH101 approval but are not the final production sheet and do not permit Unity import.

Consolidated review board:

```text
art_refs/characters/rin/concept/CH101_Rin_GateA_Validation_Board_WIP_v001.png
art_refs/characters/rin/concept/CH101_Rin_GateA_Validation_Board_WIP_v001.metadata.md
art_refs/characters/rin/concept/CH101_Rin_GateA_Validation_Board_WIP_v001.review.md
```

통합 보드는 A/B/C 방향을 한 화면에서 비교하기 위한 WIP다. 개별 A/B/C PNG, Face128, 장비 ON/OFF 실루엣,
개별 후보 3안과 관련 작업이 모두 정리되기 전에는 `ART-1001`을 완료로 기록하지 않는다. 2D 제작 시트
승인은 별도 `CH101_Rin_Production_Sheet_Approval_20260811.md`에 기록한다.

CH101 A안은 2026-08-11 사람 Gate A 승인을 받았다. `ART-1001`은 개별 후보와 제작 패키지 정리가 남아 있어
In Progress로 유지한다. `CH101_Rin_Production_Handoff_REVIEW_v001.md`와 현재 REVIEW PNG/PDF는 제작 준비
자료이며, 최종 시트는 승인되었지만 Gate B 전에는 Unity에 적용하지 않는다.

## 7. Gate A 다음 단계

A안 선택 및 Gate A 승인 후 다음 순서로 진행한다.

1. 동일 크기 전신 비교.
2. 128px 얼굴 Crop 비교.
3. 장비 포함/제거 흑색 실루엣.
4. 저채도 비교.
5. `CHA-A01~A19` 판정.
6. 사람 선택 또는 전부 재작업.
7. 사람 Gate A 승인 후 제작 시트 REVIEW 패키지와 2D→3D handoff를 검토.

사람이 2D 제작 시트를 승인했더라도 Gate B 증거와 별도 승인이 완료되기 전에는 Runtime CH101 치환과 3D Blockout을 시작하지 않는다.

## 8. Current production package

```text
art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_REVIEW_v001.png
art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_REVIEW_v001.pdf
art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_APPROVED_v001.png
art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_APPROVED_v001.pdf
art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_APPROVED_v001.metadata.md
art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_APPROVED_v001.review.md
art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_REVIEW_v001.metadata.md
art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_REVIEW_v001.review.md
art_refs/characters/rin/concept/CH101_Rin_Turnaround_REVIEW_v001.png
art_refs/characters/rin/concept/CH101_Rin_ExpressionSheet_REVIEW_v001.png
art_refs/characters/rin/concept/CH101_Rin_EquipmentSheet_REVIEW_v001.png
art_refs/characters/rin/concept/CH101_Rin_MaterialPalette_REVIEW_v001.png
art_source/manifests/CH101_Rin_Production_Handoff_REVIEW_v001.md
```

이 패키지는 Gate A 승인 방향을 제작용으로 묶은 패키지다. `CH101_Rin_CharacterSheet_APPROVED_v001`은
2026-08-11 사용자 승인을 받았으며, Gate B와 3D Blockout은 별도 승인 전까지 보류한다.
