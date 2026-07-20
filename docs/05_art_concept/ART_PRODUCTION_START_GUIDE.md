# Re:Camp Art Production Start Guide

이 문서는 Re:Camp 아트 작업을 실제로 시작할 때 사용하는 실행 순서와 완료 기준을 정의한다.

## 1. 이미 확정된 방향

```text
2D 일반 등신 캐릭터 대표 일러스트
+ 3D 5~6등신 스타일라이즈드 인게임 모델
+ 고정 쿼터뷰 전투
+ URP 툰 셰이딩
+ 자연에 잠식된 부드러운 포스트 아포칼립스
+ Windows PC 우선 검증
+ Android 후속 확장
```

5인 통합 라인업은 `Direction Approved` 상태다. 역할·색상·무기·큰 실루엣은 유지하되 개별 얼굴·헤어·의상·Turnaround는 별도 Approved 제작 시트에서 확정한다.

## 2. 현재 제작 목표

```text
루나 반복 생성 Workflow
→ 루나 2D Approved 제작 시트
→ 5~6등신 Blockout
→ Coplay Import·Prefab
→ Import Preset·Validation Tool
→ 수동 Unity QA
→ 고정 쿼터뷰 실루엣 승인
→ Character Proof
```

## 3. 시작 전 기준

| 항목 | 문서 | 상태 | 승인 조건 |
|---|---|---|---|
| 프로젝트 기준 | `CURRENT_PROJECT_BASELINE.md` | Active | 최신 결정 반영 |
| 캐릭터 방향 | `ART_DIRECTION.md`, `CHARACTER_BIBLE.md` | Direction Approved | 역할·색상·실루엣 유지 |
| 생성 일관성 | `COMFYUI_CHARACTER_CONSISTENCY_SPEC.md` | Ready | 루나 반복 생성 3회 |
| 카메라·UI | `CAMERA_AND_UI_BASELINE.md` | Review | Camera Preset 비교 |
| 3D 캐릭터 | `CHARACTER_3D_SPEC.md` | Review | Blockout과 성능 검증 |
| Animation | `ANIMATION_GUIDE.md` | Review | 공용 Rig·Clip 테스트 |
| Unity Import | `UNITY_ART_IMPORT_GUIDE.md` | Review | Coplay·Validation Tool·수동 QA 통과 |
| 파일·승인 | `ART_ASSET_STRUCTURE.md`, `ASSET_NAMING_GUIDE.md` | Ready | 신규 산출물에 적용 |

## 4. Step 1 — Metadata와 Workflow

- `PROJ-0008` AI 생성 자산 Metadata Template
- `ART-PIPE-0101` ComfyUI Workflow
- `ART-PIPE-0102` 루나 고정 변수·Seed·Prompt
- `ART-PIPE-0103` Figma Sheet Template

같은 얼굴·헤어·후드·재킷·단검을 유지한 루나 전신 결과를 3회 이상 생성하고 설정을 재현한다.

## 5. Step 2 — 루나 후보 3안

```text
A안: 현재 라인업 방향 유지
B안: 정찰 장비와 에너지 단검 기능성 강화
C안: 고양이 후드와 캐릭터 매력 강화
```

공통 고정:

- 얼굴과 눈 인상
- 헤어 길이와 색상
- 5~6등신 전환을 고려한 신체 비율
- 고양이 후드
- 민트·크림·핑크 팔레트
- 정찰형 근접 딜러 역할

## 6. Step 3 — 루나 기준 승인

- 얼굴·눈·눈썹
- 헤어·앞머리·후드
- 재킷·하의·신발
- 단검 형태·Grip·크기
- 탐지 장치·백팩 위치
- 색상·재질
- 3D에서 확대하거나 제거할 요소

승인 전에는 Turnaround와 최종 3D 제작을 시작하지 않는다.

## 7. Step 4 — 루나 제작 시트

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

AI 측면·후면 결과는 참고만 하고 의상 절개·장비 위치·단검 크기를 Figma 또는 수작업으로 구조화한다.

## 8. Step 5 — Blender Export Proof

완성 캐릭터 전에 단검이나 소품으로 검증한다.

- Scale·Axis·Pivot
- Transform `(1,1,1)`
- Material Slot
- UV·Texture 경로
- FBX Export Option
- 파일명과 원본·Export 분리

결과 ID: `ART-PIPE-0104`

## 9. Step 6 — Coplay Import·Prefab Proof

- Import Preset 적용
- Material 연결
- Prefab Hierarchy
- Animator·Collider·Socket
- Scene 배치
- Missing Reference·Console Error 확인

결과 ID: `ART-PIPE-0105`

## 10. Step 7 — Import Validation Tool

자동 검사:

```text
Scale Factor
Rig Type·Avatar
Material·Texture Missing
Prefab 표준 Hierarchy
필수 Component
Collider·Hitbox·Socket
Animator Controller
LODGroup
Missing Script·Reference
파일명·경로
```

검사 결과를 Text 또는 JSON Report로 저장한다.

결과 ID: `ART-PIPE-0106`

## 11. Step 8 — 수동 Unity QA

- Inspector Import 값
- Console Error·Warning
- Prefab Diff
- Humanoid Avatar
- PlayMode Animation·Collider·Reference
- Default Camera 실루엣
- Profiler 기본 측정

결과 ID: `ART-PIPE-0107`

Aura AI는 체험 이후 유료 사용이 필요한 구조이므로 제작 선행 조건에서 제외한다.

## 12. Step 9 — Camera Gray Box

Capsule과 임시 무기로 Near·Default·Far Preset을 비교한다.

- 캐릭터 화면 점유율
- 적·자원·이동 경로
- 장애물 가림
- Perspective / Orthographic
- 5~6등신이 SD처럼 보이지 않는 거리

결과 ID: `DEV-0106`

## 13. Step 10 — 루나 3D Blockout

- 5~6등신 비율
- 후드·머리·단검 식별성
- 공격 포즈 무기 궤적
- 장비가 이동·회전에 방해되지 않는지
- Humanoid Avatar 생성
- Coplay Import
- Validation Tool·수동 QA
- Windows 1920×1080 가독성
- Android 축소 화면 참고 가독성

실루엣 승인 후에만 최종 모델링으로 이동한다.

## 14. 실행 묶음

### A

```text
Metadata Template
+ ComfyUI Workflow
+ Figma Template
+ Blender Export Proof
```

### B

```text
Unity Project
+ Camera Preset
+ Coplay Proof
+ Validation Tool
+ 수동 QA
```

### C

```text
루나 후보 3안
+ 기준 이미지 승인
+ 제작 시트
```

### D

```text
Base Mesh
+ 루나 Blockout
+ Unity 쿼터뷰 승인
```

## 15. 작업 완료 정의

```text
기준 문서 일치
+ Metadata 기록
+ 파일명·디렉터리 규칙
+ 사람 구조 검수
+ Coplay·Validation Tool·수동 Unity 검증
+ 결과 Commit·PR·스크린샷
+ Review/Approved 상태
```

## 16. 중단 조건

- 캐릭터 일관성을 재현할 수 없음
- 정면·측면·후면 구조 불일치
- 3D 비용이 과도한 장식 미해결
- 5~6등신이 Camera에서 SD처럼 보임
- 후드·단검·공격 방향이 읽히지 않음
- Coplay 자동화 또는 Validation 결과가 재현되지 않음
- 라이선스·Metadata 누락

중단 시 기준 이미지·Spec·Camera·Importer를 수정한 뒤 다시 검증한다.
