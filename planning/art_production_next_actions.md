# Re:Camp Art Production Next Actions

이 문서는 지금 바로 실행할 아트 작업을 순서대로 정리한다. 장기 상태는 `art_production_backlog.md`에서 관리한다.

## 1. 현재 상태

```text
5인 라인업: Direction Approved
개별 캐릭터 제작 시트: 미승인
Unity 프로젝트: 생성 전
ComfyUI 반복 생성 Workflow: 미구축
Blender FBX Proof: 미실행
Coplay/Aura Import·Prefab Proof: Unity 프로젝트 대기
```

따라서 현재는 라인업을 다시 처음부터 검토하는 단계가 아니라 **루나 제작 기준과 도구 파이프라인을 실제 결과물로 전환하는 단계**다.

## 2. 즉시 실행 순서

| 순서 | ID | 작업 | 상태 | 결과물 |
|---:|---|---|---|---|
| 1 | PROJ-0007 | Git LFS 아트 규칙 검증 | Ready | 갱신된 `.gitattributes` 또는 검증 기록 |
| 2 | PROJ-0008 | AI 생성 자산 Metadata Template | Ready | Markdown 또는 YAML Template |
| 3 | ART-PIPE-0101 | ComfyUI 루나 반복 생성 Workflow | Ready | Workflow JSON·출력 3회 |
| 4 | ART-PIPE-0102 | 루나 변수·Seed·Prompt·Metadata | Blocked | 설정 YAML·기준 Prompt |
| 5 | ART-PIPE-0103 | Figma 캐릭터 Sheet Template | Ready | Export 가능한 제작 시트 Frame |
| 6 | ART-PIPE-0104 | Blender 단검 또는 소품 FBX Proof | Ready | `.blend`와 `.fbx` |
| 7 | DEV-0101 | Unity 6.3 LTS URP 프로젝트 생성 | Ready | Unity 프로젝트 |
| 8 | DEV-0106 | Camera Preset 3종 Gray Box | Blocked | Near·Default·Far Screenshot |
| 9 | ART-PIPE-0105 | Coplay Import·Prefab Proof | Blocked | 테스트 Prefab·기록 |
| 10 | ART-PIPE-0106 | Aura Import·Prefab Validation | Blocked | 동일 FBX 검증 기록 |
| 11 | ART-PIPE-0107 | Coplay/Aura 역할·차이 정리 | Blocked | Primary·Validator 운영 기준 |
| 12 | ART-2D-1001 | 루나 전신 후보 3안 | Blocked | REVIEW 후보 이미지 |
| 13 | ART-2D-1002~1008 | 루나 2D 제작 시트 | Blocked | APPROVED 제작 시트 |
| 14 | ART-3D-2004 | 루나 3D Blockout | Blocked | 저해상도 FBX |
| 15 | ART-3D-2005~2007 | Unity Import·쿼터뷰 검증 | Blocked | Prefab·Screenshot·Review 기록 |

## 3. 병렬로 가능한 방향 작업

다음은 Unity 프로젝트 생성과 별개로 시작할 수 있다.

- `ART-ENV-3001` 버려진 거리 Color Key
- `ART-ENV-3003` 캠프 Color Key
- `ART-UI-4001` UI Design System
- `ART-VFX-5001` 공통 VFX 언어
- `ART-2D-1101~1401` 미유·코코·이리스·노아 단독 전신 방향

단, 나머지 네 캐릭터의 최종 Turnaround·표정·3D 모델은 루나 Character Proof 이후로 보류한다.

## 4. ComfyUI 루나 Workflow

### 입력

- `docs/05_art_concept/CHARACTER_BIBLE.md`
- `docs/05_art_concept/ART_DIRECTION.md`
- `docs/05_art_concept/COMFYUI_CHARACTER_CONSISTENCY_SPEC.md`
- `art_refs/art_direction/ReCamp_Character_Lineup.png`

### 고정 요소

```text
얼굴 인상
헤어 길이·색상·앞머리
고양이 후드
재킷과 하의 구조
에너지 단검
탐지 장치
민트·크림·핑크 팔레트
정찰형 근접 딜러 인상
```

### 기록

```text
Checkpoint
VAE
LoRA와 Weight
Reference Adapter
ControlNet
Seed
Sampler·Scheduler
Steps·CFG
해상도
후처리
Input Reference
Human Edit
License
```

### 완료 기준

같은 얼굴·헤어·후드·의상·단검을 유지한 루나 전신 이미지를 3회 이상 반복 생성한다.

## 5. 루나 후보 3안

한 후보에서 너무 많은 요소를 동시에 바꾸지 않는다.

```text
A안: 현재 라인업 방향 유지
B안: 정찰 장비와 단검 기능성 강화
C안: 고양이 후드와 캐릭터 매력 강화
```

평가 항목:

- 첫인상과 얼굴 기억성
- 5~6등신 3D 전환 가능성
- 후드·단검 실루엣
- 민트·크림·핑크 색상 균형
- 정찰형 근접 역할 전달
- 쿼터뷰에서 읽힐 큰 형태

## 6. 루나 Approved 제작 시트

필수 산출물:

```text
Key Art
Front / Side / Back
Turnaround
Face Close-up
Expression 8종
Hair Structure
Outfit Breakdown
Energy Dagger / Scanner Sheet
Material Palette
Representative Poses
3D Production Notes
```

AI가 생성한 측면·후면을 그대로 승인하지 않고 Figma 또는 수작업으로 구조를 정리한다.

## 7. Blender Proof

첫 테스트는 완성 캐릭터가 아니라 에너지 단검 또는 단순 소품을 사용한다.

확인 항목:

- Unity 기준 Scale·Axis
- Pivot과 Transform
- Material Slot
- UV·Texture 경로
- FBX Export 설정
- 파일명 규칙

## 8. Coplay / Aura 공동 Proof

같은 FBX와 Texture를 각각의 경로로 테스트한다.

### Coplay

- Import 설정
- Material 연결
- Prefab Hierarchy 생성
- Component·Collider·Socket 배치
- Scene 배치

### Aura

- Import 결과 검증
- Material·Animator·Prefab 구성 검증 또는 보완
- Missing Reference와 Console Error 확인
- 동일 작업의 대체 가능 범위 확인

### 비교 기록

```text
Primary Tool
실행한 작업
성공·실패 항목
생성·수정된 파일
Unity Console 결과
Prefab Diff
수동 수정 필요 항목
다음 작업에서의 역할
```

한 Prefab을 두 도구가 동시에 수정하지 않는다.

## 9. Camera Gray Box

루나 Blockout 전에 Capsule과 임시 무기를 이용해 다음 Preset을 만든다.

```text
Near
Default
Far
```

확인 항목:

- 캐릭터가 화면에서 차지하는 비율
- 적·자원·이동 경로 가독성
- 장애물 가림과 Fade 처리
- Perspective와 Orthographic 비교
- 5~6등신 캐릭터가 SD처럼 보이지 않는 거리

## 10. 루나 Blockout 완료 기준

- 전체 비율이 5~6등신으로 보임
- 후드·단검·상체가 Default Camera에서 식별됨
- Humanoid Avatar 생성 가능
- 공용 Idle·Run을 적용할 수 있음
- Coplay와 Aura Import 결과가 기록됨
- 최종 모델링 전 수정 목록이 승인됨

## 11. 작업 종료 기록

각 작업 후 다음을 Backlog 또는 PR에 남긴다.

```text
작업 ID
상태
결과 파일 경로
사용 도구·버전
Primary / Validator Tool
검증 방법
Commit·PR
남은 문제
다음 작업
```
