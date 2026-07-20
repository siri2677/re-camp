# Re:Camp Agent Development Guide

이 문서는 Re:Camp 저장소에서 사람과 AI Agent가 동일한 기준으로 개발·아트 작업을 수행하기 위한 운영 규칙이다.

## 1. 최우선 기준

```text
1. docs/00_project/CURRENT_PROJECT_BASELINE.md
2. planning/sprint_backlog.md
3. planning/roadmap.md
4. 관련 분야별 Spec
5. tables/와 APPROVED art_refs/
```

문서가 충돌하면 `CURRENT_PROJECT_BASELINE.md`를 우선한다.

## 2. 프로젝트 기준

| 항목 | 기준 |
|---|---|
| 1차 플랫폼 | Windows PC |
| 2차 플랫폼 | Android |
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| Input | Unity Input System |
| Camera | 고정 쿼터뷰 |
| 캐릭터 | 2D 일반 등신 + 3D 5~6등신 스타일라이즈드 |
| Rendering | 툰 셰이딩 |
| Save | 로컬 저장 |

## 3. Portfolio Vertical Slice

```text
루나 1명
+ 버려진 거리 1개
+ 일반 몬스터 3종
+ 보스 1종
+ 캠프 시설 3종
+ 3~5분 탐험·귀환·성장 루프
```

나머지 캐릭터와 두 번째 스테이지는 Vertical Slice 승인 후 진행한다.

## 4. 저장소 구조

```text
re-camp/
├── Assets/_ReCamp/
│   ├── Art/
│   ├── Audio/
│   ├── Prefabs/
│   ├── Scenes/
│   ├── Scripts/
│   ├── ScriptableObjects/
│   └── Tests/
├── Packages/
├── ProjectSettings/
├── planning/
├── docs/
├── tables/
├── art_refs/
├── art_source/
├── README.md
├── AGENT.md
└── CHANGELOG.md
```

`art_source/`는 Blender·Figma Export 원본·ComfyUI Workflow·고해상도 Texture를 관리하며 Unity `Assets/`와 분리한다.

## 5. Unity 구조 원칙

- 프로젝트 전용 자산은 `Assets/_ReCamp/`에 둔다.
- 외부 Asset과 직접 제작 자산을 섞지 않는다.
- 게임 규칙은 `ReCamp.Core` 또는 Unity 비종속 계층에 유지한다.
- MonoBehaviour는 입력·Scene·Animation·VFX·UI·Adapter 역할을 담당한다.
- ScriptableObject는 설정 데이터와 Presentation 참조에 사용한다.
- 게임 규칙을 Prefab·Animation Event·UI에 중복 구현하지 않는다.

## 6. Scene 기준

```text
00_Bootstrap
01_Title
02_Lobby
03_Battle
04_Result
```

## 7. 기술 설정

필수:

- Unity 6.3 LTS
- URP
- Linear Color Space
- Visible Meta Files
- Force Text
- Input System
- TextMesh Pro
- Unity Test Framework

검토 후 도입:

- Cinemachine
- AI Navigation
- Addressables

## 8. 입력

### Windows

- Keyboard/Mouse
- Gamepad
- Input Action Asset

### Android

- PC Vertical Slice 이후 가상 조이스틱·터치 버튼 연결
- Core와 Gameplay 코드는 공유하고 Input Adapter만 분리

## 9. 제작 도구 역할

### ComfyUI Cloud MCP

- 2D 캐릭터·환경·몬스터·VFX 후보
- Workflow·Seed·Model·Metadata 기록

### Figma Remote MCP

- 캐릭터 Approved 제작 시트
- UI Design System·Wireframe
- 리뷰 상태와 Export

### Blender MCP

- 3D Blockout·소품·Rig·Animation·FBX Export 보조
- 얼굴·Retopology·UV·Weight·관통은 사람 검수

### Coplay MCP

- Unity Scene·Prefab·Component·Material·Animator Batch 편집
- Import 설정·Reference 연결·Scene 배치
- 반복적인 Unity Editor 작업 자동화

### GitHub MCP

- Branch·Commit·PR·Issue
- 문서·Backlog·승인 자산 이력

### Unity Editor Script·Preset

- Import Property 고정
- Material·Texture 연결 자동화
- Prefab 구조·Socket·Collider 검사
- Missing Reference와 설정 검증

### Unity 수동 검수

- Inspector
- Console
- Prefab Diff
- PlayMode
- Profiler
- Camera·실루엣·Material 미감 검수

Aura AI는 체험 이후 유료 사용이 필요한 구조이므로 필수 도구에서 제외한다.

## 10. Coplay 운영 규칙

- 변경 전 대상 Scene·Prefab·파일을 명확히 지정한다.
- 가능한 작업은 Batch Operation으로 묶는다.
- 변경 후 전체 Scene이 아니라 Diff·Summary·Console을 확인한다.
- 반복되는 Import·검증 절차는 Editor Script 또는 Preset으로 승격한다.
- 자동화 성공 여부는 Unity Console·Prefab Diff·PlayMode로 판단한다.
- Coplay가 지원하지 않는 작업은 수동 Editor 작업으로 진행하고 결과를 기록한다.

## 11. 작업 ID

| Prefix | 분야 |
|---|---|
| `PROJ-` | 문서·저장소 |
| `DEV-` | Unity 기술 기반 |
| `GAME-` | 게임 루프 |
| `CHR-PROT-` | 캐릭터 플레이 프로토타입 |
| `ART-PIPE-` | 아트 파이프라인 |
| `ART-2D-` | 캐릭터 2D |
| `ART-3D-` | 캐릭터 3D |
| `ART-ENV-` | 환경·몬스터·소품 |
| `ART-UI-` | UI |
| `ART-VFX-` | VFX |
| `TEST-` | 검증 |
| `VS-` | Vertical Slice |
| `PROD-` | 출시 확장 |
| `REL-` | QA·Release |

## 12. Branch 전략

```text
main       안정된 데모·승인 문서·자산
agent/*    ChatGPT·Codex 작업
feature/*  기능 개발
art/*      아트 작업
fix/*      버그 수정
release/*  배포 준비
```

## 13. 코드 작업 순서

```text
Backlog ID 확인
→ 관련 Core·Spec 확인
→ 최소 구현
→ EditMode·PlayMode Test
→ Console Error 확인
→ Scene 또는 Prefab 검증
→ Backlog 상태·결과 링크 갱신
→ Commit·PR
```

## 14. 아트 작업 순서

```text
Direction Approved
→ ComfyUI 후보·Metadata
→ Figma Approved 제작 시트
→ Blender Blockout·FBX
→ Coplay Import·Prefab
→ Editor Script·Preset·수동 Unity 검증
→ Camera·실루엣 Review
→ 최종 모델·Rig·Animation
→ Unity Character Proof
```

루나 Proof 전 나머지 캐릭터의 최종 모델을 대량 제작하지 않는다.

## 15. Git·Asset 규칙

- `.meta` 파일을 반드시 Commit
- `Library`, `Temp`, `Logs`, `obj`, `Build` 제외
- 대형 원본은 Git LFS 규칙 확인
- WIP와 APPROVED 파일을 같은 이름으로 덮어쓰지 않음
- 원본과 Export 분리
- AI 생성 자산에 Tool·Model·Seed·Input·Human Edit·License 기록

## 16. 완료 조건

코드:

```text
Compile 성공
+ 관련 Test 통과
+ Console Error 없음
+ 실제 Scene 검증
+ 결과 Commit·PR
```

아트:

```text
Spec 일치
+ Metadata
+ 파일 규칙
+ 사람 검수
+ Unity Camera 검증
+ Review/Approved 상태
+ 결과 Commit·PR
```

## 17. 범위 통제

다음은 Vertical Slice 승인 전 시작하지 않는다.

- 나머지 네 캐릭터 최종 모델
- 두 번째 스테이지 최종 환경
- 친밀도·개인 에피소드
- 복잡한 장비·스킨
- 결제·가챠·온라인 기능
- 유료 Aura AI 의존 작업
