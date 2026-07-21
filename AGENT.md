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

문서가 충돌하면 위 순서를 우선한다. 플랫폼·가격·Scope 변경 시 관련 문서를 같은 PR에서 갱신한다.

## 2. 프로젝트·출시 기준

| 항목 | 기준 |
|---|---|
| 최종 목표 | Steam Windows 프리미엄 게임 정식 출시 |
| 현재 Gate | Unity 기반 → Character Proof → Vertical Slice |
| 테스트 배포 | itch.io 제한 공개·Steam 무료 Demo |
| 2차 PC Store | Epic Games Store |
| 후속 플랫폼 | Google Play Android |
| 판매 방식 | 프리미엄 1회 구매 |
| 기준 정가 | 11,000원 |
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| Input | Unity Input System |
| Camera | 고정 쿼터뷰 |
| 캐릭터 | 2D 일반 등신 + 3D 5~6등신 스타일라이즈드 |
| Save | 로컬 저장 |

Steam을 우선하는 이유는 현재 게임이 서버·F2P·광고·가챠 없이 완결 가능한 패키지 구조이기 때문이다.

## 3. 출시 단계

```text
Gray Box MVP
→ 루나 Character Proof
→ Portfolio Vertical Slice
→ itch.io 외부 테스트
→ Steam Store Page·무료 Demo
→ Full Release 콘텐츠
→ Steam Release Candidate
→ Steam Windows 정식 출시
→ Epic·Android Port 판단
```

Vertical Slice는 최종 제품이 아니라 Steam 출시 가능성을 검증하는 중간 Gate다.

## 4. 범위

### Portfolio Vertical Slice

```text
루나 1명
+ 버려진 거리 1개
+ 일반 몬스터 3종
+ 보스 1종
+ 캠프 시설 3종
+ 3~5분 탐험·귀환·성장 루프
```

### Steam Full Release

```text
캐릭터 5명
+ 스테이지 2개 이상 또는 동등한 반복 플레이 분량
+ 일반 몬스터 6종 이상
+ 보스 2종 이상
+ 캠프 시설 4종 이상
+ 캐릭터 해금·친밀도·대화
+ 난이도·도전·업적
+ 20~40분 권장 플레이 세션
+ Controller·Settings·Save·Crash 대응
```

## 5. 사업 기준

```text
기준 정가: 11,000원
출시 실판매가 가정: 9,900원
보수적 순수익: 6,000원 / 카피
현금비용 1,000만원 BEP: 약 1,667카피
Full Cost 4,600만원 예시 BEP: 약 7,667카피
```

목표:

- 최소 상업 검증: 2,000카피
- Full Cost 손익분기: 8,000카피
- 안전한 성공: 10,000카피 이상

실제 비용과 투입 시간은 `planning/business_cost_log.md`에 기록한다.

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

`art_source/`는 Blender·Figma Export 원본·ComfyUI Workflow·고해상도 Texture를 관리하며 Unity `Assets/`와 분리한다.

## 7. Unity 구조 원칙

- 프로젝트 전용 자산은 `Assets/_ReCamp/`에 둔다.
- 외부 Asset과 직접 제작 자산을 섞지 않는다.
- 게임 규칙은 `ReCamp.Core` 또는 Unity 비종속 계층에 유지한다.
- MonoBehaviour는 Input·Scene·Animation·VFX·UI·Adapter 역할을 담당한다.
- Store 기능은 Steam·Epic·None Adapter로 분리 가능하게 설계한다.
- Demo와 Full Version 차이를 게임 규칙에 하드코딩하지 않는다.
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

Camp Upgrade는 초기에는 Lobby 내부 UI로 유지한다. 추가 Scene은 필요성이 확인된 뒤 만든다.

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

검토 후 도입:

- Cinemachine
- AI Navigation
- Addressables
- Steamworks Integration Library

필요성이 확인되지 않은 Package를 미리 추가하지 않는다.

## 10. 입력·플랫폼

### Steam Windows

- Keyboard/Mouse와 Gamepad 완전 지원
- Input Action Asset 사용
- Controller 연결·해제·재연결 대응
- 1280×720~2560×1440과 창·전체 화면 검증

### itch.io

- Alpha·제한 공개 Build
- Store SDK 없이 실행 가능한 Windows Build 유지

### Epic Games Store

- Steam 출시 안정화 후 Store Adapter와 추가 QA 비용을 평가한다.

### Android

- Steam Full Release 이후 Port Gate를 통과해야 시작한다.
- Touch UI·Auto Aim·기기 성능·발열·Safe Area를 별도 검증한다.
- 모바일 출시를 위해 가챠·광고·F2P 운영을 추가하지 않는다.

## 11. 제작 도구 역할

### ComfyUI Cloud MCP

- 2D 캐릭터·환경·몬스터·VFX 후보
- Workflow·Seed·Model·Metadata 기록

### Figma Remote MCP

- 캐릭터 Approved 제작 시트
- UI Design System·Wireframe
- Store UI Reference와 Export

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
- Camera·실루엣·Material 미감

Aura AI는 체험 이후 유료 사용이 필요한 구조이므로 필수 도구에서 제외한다.

## 12. Coplay 운영 규칙

- 대상 Scene·Prefab·파일을 명확히 지정한다.
- 가능한 작업은 Batch Operation으로 묶는다.
- 변경 후 Diff·Summary·Console을 확인한다.
- 반복 Import·검증은 Editor Script 또는 Preset으로 승격한다.
- 성공 여부는 Unity Console·Prefab Diff·PlayMode로 판단한다.

## 13. 작업 ID

| Prefix | 분야 |
|---|---|
| `PROJ-` | 문서·저장소·사업 기준 |
| `DEV-` | Unity 기술 기반 |
| `GAME-` | 게임 루프 |
| `CHR-PROT-` | 캐릭터 플레이 프로토타입 |
| `ART-PIPE-` | 아트 파이프라인 |
| `ART-2D-` | 캐릭터 2D |
| `ART-3D-` | 캐릭터 3D |
| `ART-ENV-` | 환경·몬스터·소품 |
| `ART-UI-` | UI |
| `ART-VFX-` | VFX |
| `TEST-` | 내부·외부 검증 |
| `VS-` | Vertical Slice |
| `PROD-` | Steam Full Release 콘텐츠 |
| `REL-` | Store·Demo·QA·출시 |
| `PORT-` | Epic·Android·iOS Port |

## 14. Branch 전략

```text
main       안정된 Demo·Release와 승인 문서·자산
agent/*    ChatGPT·Codex 작업
feature/*  기능 개발
art/*      아트 작업
fix/*      버그 수정
release/*  Steam Demo·Full Release 준비
```

## 15. 코드 작업 순서

```text
Backlog ID 확인
→ 관련 Core·Spec 확인
→ 최소 구현
→ EditMode·PlayMode Test
→ Console Error 확인
→ Scene·Prefab·Build 검증
→ 비용·일정 영향 기록
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
→ Editor Script·Preset·수동 Unity 검증
→ Camera·실루엣 Review
→ 최종 모델·Rig·Animation
→ Character Proof
→ Store Screenshot 품질 검증
```

루나 Proof 전 나머지 캐릭터 최종 모델을 대량 제작하지 않는다.

## 17. 출시 작업 순서

```text
Vertical Slice 승인
→ itch.io 제한 테스트
→ 설치·입력·Save·Crash QA
→ Steam Direct·Store Page
→ 무료 Demo
→ Full Release 콘텐츠 Scope Lock
→ Release Candidate
→ 가격·출시 할인 확정
→ Steam 출시
→ 30일 지표 분석
```

## 18. Git·Asset 규칙

- `.meta` 파일 Commit
- `Library`, `Temp`, `Logs`, `obj`, `Build` 제외
- 대형 원본 Git LFS 확인
- WIP와 APPROVED 파일을 같은 이름으로 덮어쓰지 않음
- 원본과 Export 분리
- AI 생성 자산에 Tool·Model·Seed·Input·Human Edit·License 기록
- Store Asset의 원본·Export·사용 범위 기록

## 19. 완료 조건

코드:

```text
Compile 성공
+ 관련 Test 통과
+ Console Error 없음
+ 실제 Scene·Build 검증
+ 결과 Commit·PR
```

아트:

```text
Spec 일치
+ Metadata·파일 규칙
+ 사람 검수
+ Unity Camera 검증
+ Store Screenshot 품질 확인
+ Review/Approved 상태
+ 결과 Commit·PR
```

출시:

```text
Store 요구사항 충족
+ Controller·Settings·Save·Crash QA
+ 가격·BEP 갱신
+ Release Candidate 승인
+ Patch·지원 계획
```

## 20. 범위 통제

Vertical Slice 승인 전 시작하지 않는다.

- 나머지 4명 최종 모델
- 두 번째 스테이지 최종 환경
- 친밀도·개인 에피소드
- 복잡한 장비·스킨
- Steam Store 유료 마케팅 확대

Steam Demo 검증 전 시작하지 않는다.

- Epic Store 동시 출시
- Android Port
- iOS 투자

항상 `planning/SCOPE_AND_RISK_RULES.md`와 `planning/business_cost_log.md`를 함께 확인한다.
