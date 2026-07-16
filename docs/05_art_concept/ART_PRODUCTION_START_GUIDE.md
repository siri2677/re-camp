# Re:Camp Art Production Start Guide

이 문서는 Re:Camp 아트 작업을 실제로 시작할 때 사용하는 실행 순서와 완료 기준을 정의한다.

## 1. 이미 확정된 방향

다음 항목은 재검토 없이 제작 기준으로 사용한다.

```text
2D 일반 등신 캐릭터 대표 일러스트
+ 3D 5~6등신 스타일라이즈드 인게임 모델
+ 고정 쿼터뷰 전투
+ 툰 셰이딩
+ 자연에 잠식된 부드러운 포스트 아포칼립스
+ 모바일 우선 가독성
```

세부 캐릭터 설정은 `CHARACTER_BIBLE.md`, 공통 비주얼 기준은 `ART_DIRECTION.md`를 우선한다.

## 2. 제작 시작 전 반드시 확정할 항목

| 항목 | 기준 문서 | 상태 | 완료 조건 |
|---|---|---|---|
| 통합 캐릭터 라인업 | `art_refs/art_direction/` | Review | 5명의 역할·실루엣·색상 충돌 여부 확인 |
| 캐릭터 생성 변수 | `COMFYUI_CHARACTER_CONSISTENCY_SPEC.md` | Ready | 루나 기준 반복 생성 테스트 통과 |
| 3D 캐릭터 예산 | `CHARACTER_3D_SPEC.md` | Review | 테스트 모델을 Unity에서 성능·가독성 검증 |
| 애니메이션 목록 | `ANIMATION_GUIDE.md` | Review | 공용/고유 애니메이션 범위 승인 |
| Unity Import 규칙 | `UNITY_ART_IMPORT_GUIDE.md` | Review | 테스트 FBX·Texture·Prefab Import 성공 |
| 파일명 규칙 | `ASSET_NAMING_GUIDE.md` | Ready | 신규 산출물에 규칙 적용 |

## 3. 첫 번째 실행 순서

### Step 1. 통합 라인업 리뷰

확인 항목:

- 루나, 미유, 코코, 이리스, 노아의 얼굴·헤어·의상 인상이 구분되는가
- 쿼터뷰 축소 상태에서 머리, 상체, 무기 실루엣이 구분되는가
- 캐릭터별 대표 색상이 겹치지 않는가
- 전투 역할이 장비와 형태로 전달되는가
- 3D로 구현하기 어려운 장식이나 구조가 과도하지 않은가

결과는 다음 중 하나로 기록한다.

```text
APPROVED: 개별 캐릭터 단독 시안 제작 시작
REVISE: 수정 항목을 캐릭터별로 작성한 뒤 라인업 재생성
```

### Step 2. 루나 단독 후보 3안 제작

루나를 첫 번째 품질 기준 캐릭터로 사용한다.

필수 후보:

1. 현재 라인업과 가장 유사한 기준안
2. 정찰병 기능성과 에너지 단검을 강화한 안
3. 고양이 후드와 캐릭터 매력을 강화한 안

모든 후보는 동일한 얼굴·헤어·신체 비율·대표 색상 변수를 사용한다.

### Step 3. 루나 기준 이미지 승인

다음 요소를 각각 승인한다.

- 얼굴과 눈 형태
- 헤어 길이와 앞머리
- 고양이 귀 후드 구조
- 재킷과 하체 실루엣
- 에너지 단검 구조
- 탐지 장치와 백팩 위치
- 민트·크림·핑크 팔레트

승인 전에는 Turnaround와 3D Blockout을 시작하지 않는다.

### Step 4. 루나 제작 시트 구성

필수 산출물:

```text
Luna_KeyArt_APPROVED_v###.png
Luna_Front_APPROVED_v###.png
Luna_Side_APPROVED_v###.png
Luna_Back_APPROVED_v###.png
Luna_Turnaround_APPROVED_v###.png
Luna_ExpressionSheet_APPROVED_v###.png
Luna_EquipmentSheet_APPROVED_v###.png
Luna_MaterialPalette_APPROVED_v###.png
Luna_3DNotes_APPROVED_v###.png
```

Turnaround는 AI 생성 결과를 그대로 승인하지 않는다. 정면·측면·후면의 의상 절개, 장비 위치, 단검 크기를 사람이 정리한다.

### Step 5. 3D Blockout과 Unity 가독성 테스트

최종 모델링 전에 저해상도 Blockout으로 다음을 확인한다.

- 5~6등신 비율이 실제 카메라에서 적절한가
- 후드, 머리, 단검이 캐릭터 크기에서 식별되는가
- 공격 모션에서 무기 궤적이 보이는가
- 의상과 장비가 이동·회전에 방해되지 않는가
- 모바일 화면에서 캐릭터와 배경이 분리되는가

실루엣 테스트가 통과한 뒤에만 최종 모델링으로 이동한다.

## 4. 권장 2주 작업 계획

### 1주차

| 순서 | 작업 | 결과물 |
|---:|---|---|
| 1 | 통합 라인업 리뷰 | 캐릭터별 유지/수정 항목 |
| 2 | ComfyUI 워크플로 구성 | Workflow JSON과 모델·시드 기록 |
| 3 | 루나 단독 후보 3안 | REVIEW 전신 후보 |
| 4 | 루나 얼굴·헤어 선택 | 얼굴 기준 이미지 |
| 5 | 루나 의상·장비 선택 | 실루엣 기준 이미지 |

### 2주차

| 순서 | 작업 | 결과물 |
|---:|---|---|
| 1 | 루나 정면·측면·후면 정리 | Turnaround 초안 |
| 2 | 표정 8종과 장비 상세 | Expression/Equipment Sheet |
| 3 | 컬러·재질표 작성 | Material Palette |
| 4 | 3D Blockout 제작 | 저해상도 FBX |
| 5 | Unity 쿼터뷰 테스트 | 스크린샷과 수정 목록 |

## 5. 작업 완료 정의

아트 작업은 이미지가 생성되었다는 이유만으로 완료하지 않는다.

```text
기준 문서와 일치
+ 메타데이터 기록
+ 파일명·디렉터리 규칙 준수
+ 사람이 구조 검수
+ Unity 또는 대상 화면에서 확인
+ Review/Approved 상태 기록
```

## 6. 작업 중단 조건

다음 상황에서는 다음 단계로 이동하지 않는다.

- 얼굴과 의상이 출력마다 크게 달라짐
- 정면·측면·후면의 장비 구조가 일치하지 않음
- 3D 구현이 어려운 장식이 해결되지 않음
- 쿼터뷰에서 캐릭터와 무기가 식별되지 않음
- 라이선스 또는 생성 모델의 상업적 사용 조건을 확인하지 못함
- 기준 이미지와 메타데이터가 Git에 저장되지 않음

## 7. 관련 문서 우선순위

```text
planning/의 현재 작업 상태
→ CHARACTER_BIBLE.md
→ ART_DIRECTION.md
→ 개별 APPROVED 캐릭터 시트
→ CHARACTER_3D_SPEC.md / ANIMATION_GUIDE.md
→ UNITY_ART_IMPORT_GUIDE.md
→ REVIEW/WIP 레퍼런스
```
