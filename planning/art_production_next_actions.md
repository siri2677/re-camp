# Re:Camp Art Production Next Actions

이 문서는 지금 바로 실행할 아트 작업을 순서대로 정리한다. 장기 상태는 `art_production_backlog.md`에서 관리한다.

## 1. 현재 상태

```text
5인 라인업: Direction Approved
개별 캐릭터 제작 시트: 미승인
Unity 프로젝트: 생성 전
Android Build 기반: 미구축
ComfyUI 반복 생성 Workflow: 미구축
Blender FBX Proof: 미실행
Coplay Import·Prefab Proof: Unity 프로젝트 대기
Import Validation Tool: 미구축
Android 실기기 Art QA: 미실행
```

현재는 라인업을 다시 처음부터 검토하는 단계가 아니라 **루나 제작 기준과 도구 파이프라인을 Android 실기기 결과물로 전환하는 단계**다.

## 2. 즉시 실행 순서

| 순서 | ID | 작업 | 상태 | 결과물 |
|---:|---|---|---|---|
| 1 | PROJ-0007 | Git LFS 아트 규칙 검증 | Ready | `.gitattributes` 검증 기록 |
| 2 | PROJ-0008 | AI 생성 자산 Metadata Template | Ready | Markdown 또는 YAML Template |
| 3 | ART-PIPE-0101 | ComfyUI 루나 반복 생성 Workflow | Ready | Workflow JSON·출력 3회 |
| 4 | ART-PIPE-0102 | 루나 변수·Seed·Prompt·Metadata | Blocked | 설정 YAML·기준 Prompt |
| 5 | ART-PIPE-0103 | Figma 캐릭터 Sheet·Mobile UI Template | Ready | 제작 시트·Landscape Frame |
| 6 | ART-PIPE-0104 | Blender 단검 또는 소품 FBX Proof | Ready | `.blend`·`.fbx` |
| 7 | DEV-0101 | Unity 6.3 LTS URP 프로젝트 | Ready | Unity 프로젝트 |
| 8 | DEV-0104~0105 | Android Build·Landscape·Safe Area | Blocked | Android 설정·Test Scene |
| 9 | DEV-0108 | Camera Preset 3종 Gray Box | Blocked | Near·Default·Far Screenshot |
| 10 | ART-PIPE-0105 | Coplay Import·Prefab Proof | Blocked | 테스트 Prefab·기록 |
| 11 | ART-PIPE-0106 | Import Preset·Validation Tool | Blocked | 검사 Menu·Report |
| 12 | DEV-0117 | 첫 Android APK | Blocked | 기준 기기 실행 APK |
| 13 | ART-PIPE-0107 | Android 실기기 Art QA | Blocked | Material·LOD·실루엣·Profiler Report |
| 14 | ART-2D-1001 | 루나 전신 후보 3안 | Blocked | REVIEW 후보 이미지 |
| 15 | ART-2D-1002~1008 | 루나 2D 제작 시트 | Blocked | APPROVED 제작 시트 |
| 16 | ART-3D-2004 | 루나 3D Blockout | Blocked | 저해상도 FBX |
| 17 | ART-3D-2005~2007 | Import·Android 쿼터뷰 승인 | Blocked | Prefab·APK Screenshot·Review |

## 3. 병렬로 가능한 방향 작업

- `ART-ENV-3001` 버려진 거리 Color Key
- `ART-ENV-3003` 캠프 Color Key
- `ART-UI-4001` Mobile UI Design System
- `ART-VFX-5001` 공통 VFX 언어
- `ART-2D-1101~1401` 미유·코코·이리스·노아 단독 전신 방향

나머지 4명의 최종 Turnaround·표정·3D 모델은 루나 Character Proof 이후로 보류한다.

## 4. ComfyUI 루나 Workflow

입력:

- `CHARACTER_BIBLE.md`
- `ART_DIRECTION.md`
- `COMFYUI_CHARACTER_CONSISTENCY_SPEC.md`
- `ReCamp_Character_Lineup.png`

고정 요소:

```text
얼굴 인상
헤어 길이·색상·앞머리
고양이 후드
재킷과 하의 구조
에너지 단검
탐지 장치
민트·크림·핑크
정찰형 근접 딜러 인상
```

기록:

```text
Checkpoint·VAE·LoRA
Reference Adapter·ControlNet
Seed·Sampler·Scheduler·Steps·CFG
해상도·후처리
Input Reference·Human Edit·License
```

완료 기준은 같은 얼굴·헤어·후드·의상·단검을 유지한 루나 전신 이미지를 3회 이상 반복 생성하는 것이다.

## 5. 루나 후보 3안

```text
A안: 현재 라인업 방향 유지
B안: 정찰 장비와 단검 기능성 강화
C안: 고양이 후드와 캐릭터 매력 강화
```

평가:

- 얼굴 기억성
- 5~6등신 3D 전환 가능성
- 후드·단검 실루엣
- 민트·크림·핑크 균형
- 정찰형 근접 역할 전달
- Android 기본 거리에서 읽힐 큰 형태

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
Android Readability Notes
```

AI 측면·후면을 그대로 승인하지 않고 Figma 또는 수작업으로 구조를 정리한다.

## 7. Blender Export Proof

첫 테스트는 단검 또는 단순 소품을 사용한다.

- Scale·Axis·Pivot
- Transform
- Material Slot
- UV·Texture 경로
- FBX Export
- 파일명

## 8. Coplay Import·Prefab Proof

- Import 설정
- Material 연결
- Prefab Hierarchy
- Animator·Collider·Socket
- Android Test Scene 배치
- Missing Reference·Console Error

Coplay 미지원 Import Property는 Preset 또는 Editor Script로 처리한다.

## 9. Import Validation Tool

최소 자동 검사:

```text
Scale Factor
Rig Type·Avatar
Material·Texture Missing
Prefab 표준 Hierarchy
필수 Component
Collider·Hitbox·Socket
Missing Script·Reference
Animator Controller
LODGroup
Android Texture Override
파일명·경로
```

## 10. Android 실기기 Art QA

- APK에서 Material·Texture 확인
- Android Default Camera 실루엣
- LOD0·LOD1·LOD2 전환
- Low·Medium·High 품질
- Particle·Outline·Rim·Emission
- Texture Memory·Frame Time
- 15분 반복 실행 발열
- Landscape 화면비·Safe Area

Windows PlayMode 결과만으로 승인하지 않는다.

## 11. Camera Gray Box

```text
Near
Default
Far
```

확인:

- 모바일 화면 캐릭터 점유율
- 적·자원·이동 경로
- Touch HUD와 전투 영역 간섭
- 장애물 가림·Fade
- Perspective·Orthographic
- 5~6등신이 SD처럼 보이지 않는 거리

## 12. 루나 Blockout 완료 기준

- 전체 비율이 5~6등신
- Android Default Camera에서 후드·단검·상체 식별
- Humanoid Avatar 생성
- 공용 Idle·Run 적용
- Coplay Import·Validation Tool 통과
- APK에서 Material·LOD·실루엣 확인
- 최종 모델링 전 수정 목록 승인

## 13. 작업 종료 기록

```text
작업 ID
상태
결과 파일 경로
사용 도구·버전
자동화·수동 보완 작업
Windows 검증
Android APK·기기·품질 설정
Profiler 결과
Commit·PR
남은 문제
다음 작업
```
