# Re:Camp Current Generation Implementation Status

> 최종 갱신: 2026-08-10
> 상태: Active Evidence Snapshot
> 기준 브랜치: `current/recamp-unified`
> Unity: `6000.5.3f1`

이 문서는 **실제 구현·테스트·환경·제약 증거만** 기록한다. 제품·플랫폼·Current 로스터·전역 비율·Production Budget·현재 Gate는 `docs/00_project/CURRENT_PROJECT_BASELINE.md`, 실행 순서와 상태는 `planning/sprint_backlog.md`가 소유한다.

## 1. 최근 Unity 검증 기준선

2026-08-09까지 기록된 마지막 직접 Unity 검증:

- Unity `6000.5.3f1`, URP.
- `_ReCamp` Console 오류 0.
- EditMode `35/35`.
- PlayMode `21/21`.
- `Bootstrap → Lobby → Battle → Result → Lobby` 흐름.
- Extracted 보상·Camp 저장 통합 회귀.
- Domain 정산·Skill Command/Event와 Unity Presentation 연결.
- Keyboard·Touch 공통 입력 Command 계층.

2026-08-10 이후의 세대 단일화와 PR #10 변경에서는 Unity Editor 테스트를 다시 실행하지 않았다. 위 수치는 새 변경의 테스트 결과가 아니라 마지막 실제 기준선이다.

## 2. Current Generation 문서·브랜치 검증

2026-08-10 확인:

- `legacy/recamp-pre-generation`: 이전 세대 동결 브랜치.
- `current/recamp-unified`: 현재 세대 활성 통합 브랜치.
- AGENTS·Skill·README·Planning·Design 문서가 Canonical Baseline의 소유권 규칙을 따름.
- 날짜형 디자인 리셋·정렬 문서는 `HISTORICAL / SUPERSEDED` 이력으로 분리.
- PR #9 `Current docs consistency` 전체 활성 Markdown 정합성 검사 성공.

## 3. Unity 프로젝트·Fresh Checkout

| ID | 항목 | 상태 | 증거 / 남은 것 |
|---|---|---|---|
| DEV-0101 | Unity 프로젝트 | Done | `ProjectVersion.txt` 기준 `6000.5.3f1` |
| DEV-0102 | Meta·Text Serialization | Done | `.meta`와 Text Serialization 설정 |
| DEV-0103 | `Assets/_ReCamp` 구조 | Done | Scenes·Scripts·Art·Audio·Prefabs·Tests 존재 |
| DEV-0104 | Fresh Clone 재현 | Review | PR #10 GitHub Hosted Ubuntu의 빈 Runner에서 checkout + 프로젝트 파일 Preflight PASS. Unity Open·Compile·Test는 라이선스 설정 후 필요 |
| DEV-0105 | Scene 5개 | Done | Bootstrap·Title·Lobby·Battle·Result |
| DEV-0106 | SceneLoader | Done | `GameScene` 기반 중앙 매핑 |
| DEV-0107 | GameManager | Done | 선택·Run·보상·Scene 흐름 |

PR #10 `Fresh checkout preflight`가 확인한 항목:

```text
Checkout: PASS
ProjectSettings/ProjectVersion.txt: present
Unity version 6000.5.3f1: PASS
ProjectSettings/ProjectSettings.asset: present
Packages/manifest.json: present
ReCamp.Runtime.asmdef: present
Landscape autorotation serialized settings: PASS
```

이 결과는 **Fresh checkout과 저장소 구조 재현 증거**이며 Unity Editor Open/Compile/Test 완료 증거는 아니다.

## 4. Domain·Adapter·Runtime

```text
ReCamp.Domain
→ ReCamp.UnityAdapter
→ ReCamp.Runtime
```

| 항목 | 상태 | 증거 |
|---|---|---|
| Domain Assembly | Done | UnityEngine 비종속 규칙 영역 |
| UnityAdapter | Done | Domain↔Unity 저장/캠프 변환 |
| Runtime | Done | Input·UI·Scene·Combat Presentation |
| 캠프 자원·시설 규칙 | Done | Domain 단일 규칙 + Runtime Adapter |
| PlayerPrefs v1→v2 | Done | Legacy Key 변환·v2 저장 |
| Run Outcome 정산 | Done | Domain 정책·idempotence·Result/Camp 통합 |
| Skill Command/Event | Done | Cooldown/Event와 Runtime/HUD 연결 |
| DEV-0113 | Done | 마지막 직접 Unity 회귀 기준선에서 검증 |

DEV-0110의 잔여 정적 Character Data·Presentation 중복은 별도 정리 대상이다.

## 5. Android·Input

| ID | 항목 | 상태 | 증거 / 남은 것 |
|---|---|---|---|
| DEV-0114 | Android Build Support | Blocked | 설치 Unity에 AndroidPlayer·SDK·NDK·OpenJDK 확인 필요 |
| DEV-0115 | Landscape·Safe Area | Review | Portrait 비활성·양쪽 Landscape 활성. `Screen.safeArea` HUD 구조 구현. PR #10에서 설정 및 SafeArea 자동 회귀 보강. Cutout·실기기 필요 |
| DEV-0116 | Touch Input·HUD | Review | 공통 Input Router·Joystick·Touch Hold 존재. PR #10에서 Pointer ID 소유권으로 멀티터치 Release 충돌 수정 및 회귀 테스트 추가. 실기기 Smoke 필요 |
| DEV-0117 | App ID·첫 APK | Blocked | 배포 Identifier·Build Profile·APK 설치·Lifecycle 증거 필요 |

### PR #10 Android 사전 검증 변경

- `TouchHoldButton`이 활성 Pointer ID를 소유하도록 변경.
- 다른 Pointer의 Up/Exit가 기존 Signature/Utility/Extract Hold를 해제하지 않도록 차단.
- 멀티터치 Pointer 소유권 EditMode 테스트 추가.
- `ProjectSettings.asset` Landscape-only 직렬화 값 회귀 테스트 추가.
- Battle HUD PlayMode 테스트에서 모든 Touch Control이 `SafeArea` 하위인지 확인.
- `Screen.safeArea` 정규화 값과 SafeArea `RectTransform.anchorMin/anchorMax` 매핑 검증 추가.

위 테스트 코드는 추가됐지만 **Unity Test Runner가 아직 실행되지 않았으므로 PASS로 기록하지 않는다.**

## 6. 핵심 Gameplay

| 범위 | 상태 | 현재 증거 | 남은 범위 |
|---|---|---|---|
| 이동·카메라·아레나 | Done | 카메라 상대 XZ 이동·Orthographic·Clamp | 최종 캐릭터 크기 framing |
| 기본 공격·피격·사망 | Done | 자동 공격·Damageable·사망 | Final hitbox·피드백 |
| 적 추적 | Done | 추적·접촉 피해·생명주기 | 적 종류별 고유 행동 |
| Wave·Boss | Done | 일반 Wave→Boss | 정식 난이도·패턴 |
| 자원 드랍·흡수 | Done | ResourcePickup·Ledger | Final VFX·Balance |
| Run 종료 | Done | 귀환·사망·시간 만료 | 모바일 연출·Balance |
| Result·Camp 정산 | Done | 단일 정산·저장 | 출시 Save QA |

## 7. 기능 역할 Prototype

현재 Unity의 기존 5개 캐릭터 역할은 **Current Generation 최종 캐릭터 디자인이 아니라 Gameplay 재사용 Proof**다.

| 역할 Proof | 상태 | 검증된 기능 |
|---|---|---|
| 기동·탐지 | Review | Dash·Combo·Scan·Pickup Range |
| 원거리·수집 제어 | Review | Ranged/Drone·Burst·Attraction |
| 회복·보호 | Review | Heal·Shield |
| 정밀·표식 | Review | Charge·Mark |
| 가드·공간 방어 | Review | Guard·Barrier·Knockback |

Current Runtime handoff에서는 Gameplay 축을 재사용하되 Legacy 이름·외형·장비를 최종 자산으로 승격하지 않는다.

## 8. Current 디자인 산출물 증거

- Current Character Bible·Anchor·Art Direction 계약 존재.
- 공통 5인 라인업 WIP + metadata + review 존재.
- 해당 라인업은 `WIP / GATE A PENDING`이며 Approved가 아니다.
- 캐릭터별 통제 후보·128px 얼굴·장비 on/off·저채도 비교는 아직 완료되지 않았다.
- 사람 Gate A, Approved 2D 제작 시트, 최종 3D는 아직 없다.

정확한 디자인 내용은 Canonical Baseline과 직접 소유 문서에서 관리한다.

## 9. 자동 테스트·CI 증거

마지막 직접 Unity Editor 기록:

```text
EditMode 35 / 35 PASS
PlayMode 21 / 21 PASS
_ReCamp Console Error 0
```

2026-08-10 PR #9:

```text
Current docs consistency: PASS
Unity Tests: NOT EXECUTED — Unity license credentials missing
```

2026-08-10 PR #10:

```text
Fresh checkout preflight: PASS
Unity Test Runner: NOT EXECUTED
Reason: UNITY_LICENSE / UNITY_EMAIL / UNITY_PASSWORD not configured
Artifact upload: PASS with no artifact, no secondary CI failure
```

Unity Workflow의 실패를 Test Assertion 또는 Compile 실패로 기록하지 않는다. Hosted Unity CI 성공 증거는 라이선스 설정 후 새 실행이 필요하다.

## 10. 아직 증명되지 않은 것

- Current branch Fresh Checkout 후 Unity Editor Open·Compile·전체 Test parity.
- Hosted Unity CI의 실제 Test Runner 성공 결과.
- PR #10 신규 Android/Touch 테스트의 실제 PASS 결과.
- Android Build Support 전체 설치와 재현 가능한 APK.
- 실제 Android 기기의 Touch·Safe Area·Lifecycle.
- 저·중·고사양 기기 성능·발열·메모리.
- Current Generation 캐릭터 사람 Gate A/B/C.
- Final 2D·3D·환경·UI·VFX·Audio.
- Current Runtime roster migration과 Save compatibility.

## 11. 기록 규칙

- 계획 상태를 이 문서가 독자적으로 변경하지 않는다.
- 제품·디자인 결정을 이 문서에 복제하지 않는다.
- 검증하지 않은 결과를 `Done`으로 쓰지 않는다.
- 실제 테스트 날짜·환경·수치·실패 원인을 가능한 범위에서 기록한다.
- Legacy와 Current 결과를 섞어 하나의 최신 검증처럼 표현하지 않는다.
