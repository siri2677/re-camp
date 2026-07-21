# Re:Camp Agent Development Guide

이 문서는 Re:Camp 저장소에서 사람과 AI Agent가 동일한 기준으로 개발·아트·출시 작업을 수행하기 위한 운영 규칙이다.

## 1. 최우선 기준

```text
1. docs/00_project/CURRENT_PROJECT_BASELINE.md
2. docs/00_project/BUSINESS_AND_PLATFORM_STRATEGY.md
3. planning/sprint_backlog.md
4. planning/roadmap.md
5. 관련 분야별 Spec
6. tables/와 APPROVED art_refs/
```

문서가 충돌하면 위 순서를 우선한다. 플랫폼·Scope 변경 시 관련 문서를 같은 PR에서 갱신한다.

## 2. 프로젝트·출시 기준

| 항목 | 기준 |
|---|---|
| 최종 1차 목표 | Google Play Android 정식 출시 |
| 제품 형태 | 가로형 모바일 3D 쿼터뷰 로그라이트 RPG |
| 개발·디버그 | Windows PC |
| 현재 Gate | Android 기반 → Touch Prototype → Character Proof |
| 중간 Gate | Android Portfolio Vertical Slice·Closed Test |
| 후속 플랫폼 | Windows Demo·Steam·iOS |
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| Input | Unity Input System |
| Camera | 고정 쿼터뷰 |
| 캐릭터 | 2D 일반 등신 + 3D 5~6등신 스타일라이즈드 |
| Save | 로컬 저장 |

수익은 필수 성공 기준이 아니다. 완성·배포, 모바일 적합성, 캐릭터 매력, 포트폴리오 가치와 유지 가능한 Scope를 우선한다.

## 3. 출시 단계

```text
Windows Editor Gray Box
→ Android Touch Prototype
→ 루나 Character Proof
→ Android Portfolio Vertical Slice
→ APK 외부 테스트
→ Google Play Closed Test
→ Android Full Release
→ Windows·Steam·iOS 후속 판단
```

Vertical Slice는 최종 제품이 아니라 Android 출시 가능성을 검증하는 중간 Gate다.

## 4. 범위

### Android Portfolio Vertical Slice

```text
루나 1명
+ 버려진 거리 1개
+ 일반 몬스터 3종
+ 보스 1종
+ 캠프 시설 3종
+ Touch HUD·스킬 선택·결과·캠프 강화
+ 로컬 저장
+ 3~5분 탐험·귀환·성장 루프
+ Android APK 실기기 검증
```

### Android Full Release

```text
캐릭터 5명
+ 스테이지 2개 이상 또는 동등한 반복 분량
+ 일반 몬스터 6종 이상
+ 보스 2종 이상
+ 캠프 시설 4종 이상
+ 캐릭터 해금·친밀도·대화
+ 난이도·도전·반복 목표
+ Touch Tutorial·Settings·Save·Lifecycle
+ 기기 품질 단계·화면비·발열·Memory 대응
+ Google Play 정식 공개
```

## 5. 비용 기준

비용은 완주 가능성을 보호하기 위해 기록한다.

- 판매량 목표를 작업 완료 조건으로 두지 않는다.
- 무료 출시도 성공으로 인정한다.
- 손익분기는 외주·구독·마케팅 지출이 과도한지 판단하는 참고값이다.
- 실제 비용과 투입 시간은 `planning/business_cost_log.md`에 기록한다.

## 6. 저장소 구조

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

`art_source/`는 Blender·Figma Export 원본·ComfyUI Workflow·고해상도 Texture를 Unity `Assets/`와 분리해 관리한다.

## 7. Unity 구조 원칙

- 프로젝트 전용 자산은 `Assets/_ReCamp/`에 둔다.
- 외부 Asset과 직접 제작 자산을 섞지 않는다.
- 게임 규칙은 `ReCamp.Core` 또는 Unity 비종속 계층에 유지한다.
- MonoBehaviour는 Input·Scene·Animation·VFX·UI·Adapter 역할을 담당한다.
- Touch·Keyboard·Gamepad Input Adapter를 분리한다.
- Android Lifecycle을 게임 규칙과 분리한다.
- ScriptableObject는 설정 데이터와 Presentation 참조에 사용한다.
- 게임 규칙을 Prefab·Animation Event·UI에 중복 구현하지 않는다.

## 8. Scene 기준

```text
00_Bootstrap
01_Title
02_Lobby
03_Battle
04_Result
```

Camp Upgrade는 초기에는 Lobby 내부 UI로 유지한다.

## 9. 기술 설정

필수:

- Unity 6.3 LTS
- URP
- Linear Color Space
- Visible Meta Files
- Force Text
- Input System
- TextMesh Pro
- Unity Test Framework
- Android Build Support

검토 후 도입:

- Cinemachine
- AI Navigation
- Addressables

필요성이 확인되지 않은 Package와 Store SDK를 미리 추가하지 않는다.

## 10. 입력·플랫폼

### Android

- Landscape 고정
- 좌측 가상 조이스틱
- 우측 공격·대시·스킬 Button
- Auto Aim 또는 대상 보정
- Safe Area·Android Back·Background/Resume
- 30 FPS 기본·지원 기기 60 FPS 선택

### Windows

- Unity 개발·QA·Profiler·자동 테스트
- Keyboard/Mouse·Gamepad Debug Adapter
- 포트폴리오 Video·Screenshot
- 필요 시 itch.io Demo

Windows 결과만으로 모바일 작업을 승인하지 않는다.

### Steam·iOS

- Android Full Release 안정화 후 별도 제품화 비용과 유지보수 영향을 평가한다.

## 11. 제작 도구 역할

### ComfyUI Cloud MCP

- 2D 캐릭터·환경·몬스터·VFX 후보
- Workflow·Seed·Model·Metadata 기록

### Figma Remote MCP

- 캐릭터 Approved 제작 시트
- Mobile UI Design System·Wireframe
- Android 화면비·Safe Area·Touch 영역

### Blender MCP

- 3D Blockout·소품·Rig·Animation·FBX Export 보조
- 얼굴·Retopology·UV·Weight·관통은 사람 검수

### Coplay MCP

- Unity Scene·Prefab·Component·Material·Animator Batch 편집
- Import 설정·Reference 연결·Scene 배치

### GitHub MCP

- Branch·Commit·PR·Issue
- 문서·Backlog·승인 자산·출시 이력

### Unity Editor Script·Preset

- Import Property 고정
- Material·Texture 연결 자동화
- Prefab·Socket·Collider·Missing Reference 검사

### Unity 수동 검수

- Inspector·Console·Prefab Diff
- PlayMode·Profiler
- Android APK·실기기 입력·가독성·발열·Memory

Aura AI는 체험 이후 유료 사용이 필요한 구조이므로 필수 도구에서 제외한다.

## 12. Coplay 운영 규칙

- 대상 Scene·Prefab·파일을 명확히 지정한다.
- 가능한 작업은 Batch Operation으로 묶는다.
- 변경 후 Diff·Summary·Console을 확인한다.
- 반복 Import·검증은 Editor Script 또는 Preset으로 승격한다.
- 성공 여부는 Android APK·Unity Console·Prefab Diff·PlayMode로 판단한다.

## 13. 작업 ID

| Prefix | 분야 |
|---|---|
| `PROJ-` | 문서·저장소·플랫폼 기준 |
| `DEV-` | Unity·Build·기술 기반 |
| `GAME-` | 게임 루프 |
| `MOB-` | Android Touch·Lifecycle·기기 검증 |
| `CHR-PROT-` | 캐릭터 플레이 프로토타입 |
| `ART-PIPE-` | 아트 파이프라인 |
| `ART-2D-` | 캐릭터 2D |
| `ART-3D-` | 캐릭터 3D |
| `ART-ENV-` | 환경·몬스터·소품 |
| `ART-UI-` | 모바일 UI |
| `ART-VFX-` | VFX |
| `TEST-` | 내부·외부 검증 |
| `VS-` | Android Vertical Slice |
| `REL-` | Closed Test·Store·QA·출시 |
| `PROD-` | Android Full Release 콘텐츠 |
| `PORT-` | Windows·Steam·iOS 후속 Port |

## 14. Branch 전략

```text
main       안정된 APK·Demo·Release와 승인 문서·자산
agent/*    ChatGPT·Codex 작업
feature/*  기능 개발
art/*      아트 작업
fix/*      버그 수정
release/*  Closed Test·Android Release 준비
```

## 15. 코드 작업 순서

```text
Backlog ID 확인
→ 관련 Core·Spec 확인
→ 최소 구현
→ EditMode·PlayMode Test
→ Windows Editor 검증
→ Android APK 실기기 검증
→ Console·Profiler 확인
→ Backlog 상태·결과 링크
→ Commit·PR
```

## 16. 아트 작업 순서

```text
Direction Approved
→ ComfyUI 후보·Metadata
→ Figma Approved 제작 시트
→ Blender Blockout·FBX
→ Coplay Import·Prefab
→ Editor Script·Preset 검증
→ Android Camera·실기기 Review
→ 최종 모델·Rig·Animation
→ Character Proof
```

루나 Proof 전 나머지 캐릭터 최종 모델을 대량 제작하지 않는다.

## 17. 출시 작업 순서

```text
Android Vertical Slice 승인
→ APK 제한 테스트
→ 설치·입력·Save·Lifecycle QA
→ Google Play Closed Test
→ Full Release 콘텐츠 Scope Lock
→ Release Candidate
→ Store Listing·아이콘·Screenshot·Trailer
→ Android 정식 공개
→ 30일 운영 결과 분석
```

## 18. Git·Asset 규칙

- `.meta` 파일 Commit
- `Library`, `Temp`, `Logs`, `obj`, `Build` 제외
- 대형 원본은 Git LFS 확인
- WIP와 APPROVED 파일을 같은 이름으로 덮어쓰지 않음
- 원본과 Export 분리
- AI 생성 자산에 Tool·Model·Seed·Input·Human Edit·License 기록

## 19. 테스트 원칙

- Core 규칙은 Unity 비종속 Test 우선
- Scene 흐름은 PlayMode Test
- Save·Reward·Camp Upgrade 자동 Test
- Touch Input·Pause·Resume·중복 보상 Test
- 실제 APK가 없으면 모바일 기능을 Done으로 처리하지 않음
- Profiler 측정 없이 성능 작업을 Done으로 처리하지 않음

## 20. 범위 통제

상세 기준은 `planning/SCOPE_AND_RISK_RULES.md`를 따른다.

Android Vertical Slice 승인 전 시작하지 않는다.

- 나머지 4명 최종 모델
- 두 번째 스테이지 최종 환경
- 친밀도·개인 에피소드
- 복잡한 장비·스킨
- Steam·iOS 동시 출시 작업
