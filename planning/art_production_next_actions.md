# Re:Camp Art Production Next Actions

이 문서는 지금 바로 실행할 아트 작업을 순서대로 정리한다. 장기 상태는 `art_production_backlog.md`에서 관리한다.

## 1. 현재 상태

```text
5인 라인업: Direction Approved
개별 캐릭터 제작 시트: 미승인
Unity 프로젝트: 생성 전
ComfyUI 반복 생성 Workflow: 미구축
Blender FBX Proof: 미실행
Coplay Import·Prefab Proof: Unity 프로젝트 대기
Import Validation Tool: 미구축
```

현재는 라인업을 다시 처음부터 검토하는 단계가 아니라 **루나 제작 기준과 도구 파이프라인을 실제 결과물로 전환하는 단계**다.

## 2. 즉시 실행 순서

| 순서 | ID | 작업 | 상태 | 결과물 |
|---:|---|---|---|---|
| 1 | PROJ-0007 | Git LFS 아트 규칙 검증 | Ready | `.gitattributes` 검증 기록 |
| 2 | PROJ-0008 | AI 생성 자산 Metadata Template | Ready | Markdown 또는 YAML Template |
| 3 | ART-PIPE-0101 | ComfyUI 루나 반복 생성 Workflow | Ready | Workflow JSON·출력 3회 |
| 4 | ART-PIPE-0102 | 루나 변수·Seed·Prompt·Metadata | Blocked | 설정 YAML·기준 Prompt |
| 5 | ART-PIPE-0103 | Figma 캐릭터 Sheet Template | Ready | 제작 시트 Frame |
| 6 | ART-PIPE-0104 | Blender 단검 또는 소품 FBX Proof | Ready | `.blend`와 `.fbx` |
| 7 | DEV-0101 | Unity 6.3 LTS URP 프로젝트 생성 | Ready | Unity 프로젝트 |
| 8 | DEV-0106 | Camera Preset 3종 Gray Box | Blocked | Near·Default·Far Screenshot |
| 9 | ART-PIPE-0105 | Coplay Import·Prefab Proof | Blocked | 테스트 Prefab·기록 |
| 10 | ART-PIPE-0106 | Import Preset·Validation Editor Tool | Blocked | 검사 Menu·Report |
| 11 | ART-PIPE-0107 | 수동 Unity Import·Prefab QA | Blocked | Inspector·Console·Diff·PlayMode Report |
| 12 | ART-2D-1001 | 루나 전신 후보 3안 | Blocked | REVIEW 후보 이미지 |
| 13 | ART-2D-1002~1008 | 루나 2D 제작 시트 | Blocked | APPROVED 제작 시트 |
| 14 | ART-3D-2004 | 루나 3D Blockout | Blocked | 저해상도 FBX |
| 15 | ART-3D-2005~2007 | Unity Import·검증·쿼터뷰 승인 | Blocked | Prefab·Screenshot·Review 기록 |

## 3. 병렬로 가능한 방향 작업

- `ART-ENV-3001` 버려진 거리 Color Key
- `ART-ENV-3003` 캠프 Color Key
- `ART-UI-4001` UI Design System
- `ART-VFX-5001` 공통 VFX 언어
- `ART-2D-1101~1401` 미유·코코·이리스·노아 단독 전신 방향

나머지 네 캐릭터의 최종 Turnaround·표정·3D 모델은 루나 Character Proof 이후로 보류한다.

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

```text
A안: 현재 라인업 방향 유지
B안: 정찰 장비와 단검 기능성 강화
C안: 고양이 후드와 캐릭터 매력 강화
```

평가:

- 첫인상과 얼굴 기억성
- 5~6등신 3D 전환 가능성
- 후드·단검 실루엣
- 민트·크림·핑크 색상 균형
- 정찰형 근접 역할 전달
- 쿼터뷰에서 읽힐 큰 형태

## 6. 루나 Approved 제작 시트

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

## 7. Blender Export Proof

첫 테스트는 완성 캐릭터가 아니라 에너지 단검 또는 단순 소품을 사용한다.

- Unity 기준 Scale·Axis
- Pivot과 Transform
- Material Slot
- UV·Texture 경로
- FBX Export 설정
- 파일명 규칙

## 8. Coplay Import·Prefab Proof

같은 FBX와 Texture를 사용해 다음을 실행한다.

- Import 설정
- Material 연결
- Prefab Hierarchy 생성
- Animator·Collider·Socket 배치
- Scene 배치
- Missing Reference·Console Error 확인

Coplay가 지원하지 않는 Import Property는 Preset 또는 Editor Script로 처리한다.

## 9. Import Validation Tool

최소 자동 검사:

```text
Scale Factor
Rig Type와 Avatar
Material·Texture Missing
Prefab 표준 Hierarchy
필수 Component
Collider·Hitbox·Socket
Missing Script·Reference
Animator Controller
LODGroup
파일명·경로
```

Editor Menu에서 선택 Asset 또는 폴더 단위로 실행하고 Text·JSON Report를 저장할 수 있게 한다.

## 10. 수동 Unity QA

- Inspector Import 값 확인
- Console Error·Warning 확인
- Prefab Diff 확인
- PlayMode에서 Animation·Collider·Reference 확인
- Default Camera에서 실루엣 확인
- Profiler 기본 측정

Aura AI는 체험 이후 유료 사용이 필요하므로 이 검증 과정에 포함하지 않는다.

## 11. Camera Gray Box

```text
Near
Default
Far
```

확인:

- 캐릭터 화면 점유율
- 적·자원·이동 경로 가독성
- 장애물 가림과 Fade
- Perspective와 Orthographic 비교
- 5~6등신이 SD처럼 보이지 않는 거리

## 12. 루나 Blockout 완료 기준

- 전체 비율이 5~6등신으로 보임
- 후드·단검·상체가 Default Camera에서 식별됨
- Humanoid Avatar 생성 가능
- 공용 Idle·Run 적용 가능
- Coplay Import와 Validation Tool·수동 QA 통과
- 최종 모델링 전 수정 목록 승인

## 13. 작업 종료 기록

```text
작업 ID
상태
결과 파일 경로
사용 도구·버전
자동화 작업
수동 보완 작업
검증 방법
Commit·PR
남은 문제
다음 작업
```
