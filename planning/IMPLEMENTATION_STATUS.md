# Re:Camp Current Generation Implementation Status

> 최종 갱신: 2026-08-12
> 상태: Active Evidence Snapshot
> 기준 브랜치: `current/recamp-unified`
> Unity: `6000.5.3f1`

이 문서는 **실제 구현·테스트·환경·제약 증거만** 기록한다. 제품·플랫폼·Current 로스터·전역 비율·Production Budget·현재 Gate는 `docs/00_project/CURRENT_PROJECT_BASELINE.md`, 실행 순서와 상태는 `planning/sprint_backlog.md`가 소유한다.

## 1. 최근 검증 기준선

2026-08-09까지 기록된 최신 직접/자동 Unity 검증 기준:

- Unity `6000.5.3f1`, URP.
- `_ReCamp` Console 오류 0.
- EditMode `35/35`.
- PlayMode `21/21`.
- `Bootstrap → Lobby → Battle → Result → Lobby` 흐름.
- Extracted 보상·Camp 저장 통합 회귀.
- Domain 정산·스킬 Command/Event와 Unity Presentation 연결.
- Keyboard·Touch 공통 입력 Command 계층.

2026-08-10 세대·문서 단일화 작업에서는 Unity Editor 테스트를 다시 실행하지 않았다. 위 수치는 마지막 실제 Unity 검증 기록을 보존한 것이다.

## 2. Current Generation 문서·브랜치 검증

2026-08-10 확인:

- `legacy/recamp-pre-generation`: 2026-07-27 이전 통합 상태를 보존하는 동결 브랜치로 분리.
- `current/recamp-unified`: 2026-08-09 최신 구현·디자인 HEAD에서 시작한 활성 통합 브랜치.
- AGENTS·Skill·README·Planning Index가 Canonical Baseline으로 라우팅되도록 정리.
- Character Bible·Anchor·Art Direction·Roadmap·Backlog·Implementation Status의 소유 범위를 분리.
- 날짜형 디자인 리셋·정렬 문서를 `HISTORICAL / SUPERSEDED` 변경 이력으로 전환.
- PR #9 `Current docs consistency`에서 전체 활성 Markdown 정합성 검사 성공.

동일 PR에서 `Unity Tests` Workflow는 코드 테스트 실패가 아니라 GitHub Actions의 `UNITY_LICENSE`, `UNITY_EMAIL`, `UNITY_PASSWORD`가 비어 있어 Unity Test Runner가 시작되지 못했다. 2026-08-12 최신 run에서도 같은 원인과 빈 아티팩트 경로 후속 오류가 확인됐다. CI는 다음 변경에서 자격 증명 사전 점검과 고정 아티팩트 경로로 분리한다. Hosted Unity CI 성공 증거는 아직 없으며 DEV-0112는 `Review`를 유지한다.

## 3. Unity 프로젝트·Scene

| ID | 항목 | 상태 | 증거 / 남은 것 |
|---|---|---|---|
| DEV-0101 | Unity 프로젝트 | Done | `ProjectVersion.txt` 기준 `6000.5.3f1` |
| DEV-0102 | Meta·Text Serialization | Done | `.meta`와 Text Serialization 설정 |
| DEV-0103 | `Assets/_ReCamp` 구조 | Done | Scenes·Scripts·Art·Audio·Prefabs·Tests 존재 |
| DEV-0104 | Fresh Clone 재현 | Review | 원격 반영은 됐으나 별도 Clone·Unity Open·전체 재현 증거 보완 필요 |
| DEV-0105 | Scene 5개 | Done | Bootstrap·Title·Lobby·Battle·Result |
| DEV-0106 | SceneLoader | Done | `GameScene` 기반 중앙 매핑 |
| DEV-0107 | GameManager | Done | 선택·Run·보상·Scene 흐름 |

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
| Skill Command/Event | Done | cooldown/event와 Runtime/HUD 연결 |
| DEV-0113 | Done | 관련 EditMode/PlayMode 회귀 통과 |

Fresh Clone과 Hosted CI는 별도 항목이며 DEV-0113 완료와 동일하지 않다.

## 5. Android·Input

| ID | 항목 | 상태 | 증거 / 남은 것 |
|---|---|---|---|
| DEV-0114 | Android Build Support | Blocked | 설치 Unity에 AndroidPlayer·SDK·NDK·OpenJDK 확인 필요 |
| DEV-0115 | Landscape·Safe Area | Review | Portrait autorotation 비활성화·`Screen.safeArea` 기반 HUD. 화면비·Cutout·실기기 필요 |
| DEV-0116 | Touch Input·HUD | Review | `BattleInputRouter`, VirtualJoystick, TouchHoldButton, Touch HUD와 PC 입력 병행. 실기기 Smoke 필요 |
| DEV-0117 | App ID·첫 APK | Blocked | 배포 Identifier·Build Profile·APK 설치·Lifecycle 증거 필요 |

현재 코드가 Touch 입력을 포함한다는 사실은 Android 제품 검증 완료를 의미하지 않는다.

## 6. 핵심 Gameplay

| 범위 | 상태 | 현재 증거 | 남은 범위 |
|---|---|---|---|
| 이동·카메라·아레나 | Done | 카메라 상대 XZ 이동·Orthographic·Clamp | 최종 캐릭터 크기에서 framing 재검토 |
| 기본 공격·피격·사망 | Done | 자동 공격·Damageable·사망 | final hitbox·피드백 |
| 적 추적 | Done | 추적·접촉 피해·생명주기 | 적 종류별 고유 행동 |
| Wave·Boss | Done | 일반 Wave→Boss | 정식 난이도·패턴 |
| 자원 드랍·흡수 | Done | ResourcePickup·Ledger | final VFX·balance |
| Run 종료 | Done | 귀환·사망·시간 만료 | 모바일 연출·밸런스 |
| Result·Camp 정산 | Done | 단일 정산·저장 | 출시 Save QA |

## 7. 기능 역할 Prototype

현재 Unity의 기존 5개 캐릭터 역할은 **Current Generation의 최종 캐릭터 디자인이 아니라 Gameplay 재사용 Proof**다.

| 역할 Proof | 상태 | 검증된 기능 |
|---|---|---|
| 기동·탐지 | Review | Dash·Combo·Scan·Pickup Range |
| 원거리·수집 제어 | Review | Ranged/Drone prototype·Burst·Attraction |
| 회복·보호 | Review | Heal·Shield |
| 정밀·표식 | Review | Charge·Mark |
| 가드·공간 방어 | Review | Guard·Barrier·Knockback |

Current Generation Runtime handoff에서는 이 Gameplay 축을 재사용하되 Legacy 이름·외형·장비를 최종 자산으로 승격하지 않는다.

## 8. Current 디자인 산출물 증거

현재 저장소에 확인되는 디자인 제작 증거:

- Current Character Bible·Anchor·Art Direction 계약 존재.
- CH101~CH105의 2D 제작 시트와 Gate A 승인 기록이 존재한다.
- 현재 5인 교차 2D 판정은 `PASS`이며, Face128·비교 보드는 REVIEW 증거로 유지한다.
- CH101~CH105 통합 Gate B 프리플라이트와 캐릭터별 handoff 문서가 준비됐다.
- Gate B, 3D Blockout, Unity Import, Android·Runtime 증거는 아직 없다.

정확한 디자인 내용은 이 문서에서 반복하지 않고 Canonical Baseline과 직접 소유 문서를 읽는다.

## 9. 자동 테스트·CI 증거

마지막 로컬/Editor 기록:

```text
EditMode 35 / 35 PASS
PlayMode 21 / 21 PASS
_ReCamp Console Error 0
```

2026-08-08~2026-08-12 GitHub Actions:

```text
Current docs consistency: PASS on the prior successful run.
Unity Tests: NOT EXECUTED — Unity license credentials missing; latest run also attempted artifact upload with an empty output path.
```

Unity Workflow 실패를 테스트 assertion 실패로 기록하지 않는다. 라이선스 설정 후 Hosted CI를 다시 실행해야 한다.

## 10. 아직 증명되지 않은 것

- Current branch의 완전한 Fresh Clone·Unity Open·Build·Test parity.
- Hosted Unity CI의 성공 결과.
- Android Build Support 전체 설치와 재현 가능한 APK.
- 실제 Android 기기의 Touch·Safe Area·Lifecycle.
- 저·중·고사양 기기 성능·발열·메모리.
- Current Generation 캐릭터 Gate B/C.
- final 3D·환경·UI·VFX·Audio.
- Current Generation Runtime roster migration과 Save compatibility.

## 11. 기록 규칙

- 계획 상태를 이 문서가 독자적으로 변경하지 않는다.
- 제품·디자인 결정을 이 문서에 복제하지 않는다.
- 검증하지 않은 결과를 `Done`으로 쓰지 않는다.
- 실제 테스트 날짜·환경·수치·실패 원인을 가능한 범위에서 기록한다.
- Legacy와 Current의 결과를 섞어 하나의 최신 검증처럼 표현하지 않는다.
