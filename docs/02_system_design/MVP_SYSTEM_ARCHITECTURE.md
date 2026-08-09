# Re:Camp MVP System Architecture

> 최종 갱신: 2026-08-09
> 상태: Active — DEV-0113 integrated; Hosted CI and Android pending
> 기준 브랜치: `codex/recamp-unity-mvp`
> Unity: `6000.5.3f1`

## 1. 문서 역할

현재 구현된 MVP의 Scene, Assembly, Domain·Adapter·Runtime 경계와 데이터 흐름을 정의한다. 제품 방향은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`, 실제 작업 상태는 `planning/sprint_backlog.md`, 구현 검증 증거는 `planning/IMPLEMENTATION_STATUS.md`, Core 통합 결과는 `planning/DEV-0113_CORE_INTEGRATION_RESULT.md`를 따른다.

## 2. 현재 MVP 흐름

```text
Bootstrap
→ Lobby
→ Battle
→ Result
→ Lobby
```

- Lobby에서 현재 기능 검증용 레거시 캐릭터를 선택하고 탐험을 시작한다.
- Battle에서 적·보스와 전투하고 자원을 획득한다.
- 추출·패배·시간 만료·승리로 Run이 종료된다.
- Result에서 Domain 정산 결과를 확인하고 추출 보상만 Camp에 반영한다.
- Lobby에서 캠프 시설을 강화한 뒤 다음 Run을 시작한다.

Title Scene은 존재하지만 빠른 개발 회귀에서는 Bootstrap에서 Lobby로 바로 진입할 수 있다.

## 3. Assembly 경계

```text
┌─────────────────────────────────────────────┐
│ ReCamp.Domain                               │
│ 순수 C# 규칙·저장 DTO, UnityEngine 없음     │
└───────────────────┬─────────────────────────┘
                    │ DTO·규칙
┌───────────────────▼─────────────────────────┐
│ ReCamp.UnityAdapter                         │
│ Domain ↔ Unity 저장·표현 자료 변환          │
└───────────────────┬─────────────────────────┘
                    │ 변환 결과
┌───────────────────▼─────────────────────────┐
│ ReCamp.Runtime                              │
│ MonoBehaviour·Scene·입력·HUD·전투·Prefab   │
└─────────────────────────────────────────────┘
```

### `ReCamp.Domain`

경로: `Assets/_ReCamp/Scripts/Domain/`

- `noEngineReferences: true`
- Unity API와 플랫폼 저장소를 참조하지 않는다.
- 자원, 캠프 시설, 비용·효과, 기본 능력치, Domain 저장 자료를 소유한다.
- `RunSettlementCommand`, `RunSettlementResult`, `RunSettlementService`가 Extracted/Defeated/Expired 정책과 Run idempotence를 소유한다.
- `SkillCommandProcessor`가 시그니처/유틸리티 능력 수락·쿨다운과 `SkillActivatedEvent`를 소유한다.

### `ReCamp.UnityAdapter`

경로: `Assets/_ReCamp/Scripts/UnityAdapter/`

- `ReCamp.Domain`만 직접 참조한다.
- Domain과 Unity Runtime 사이의 이름·자료 구조 차이를 변환한다.
- `Food ↔ Rations`, `FoodStorage ↔ RationStorage`, 캠프 저장 DTO 왕복 변환을 담당한다.
- `DomainCampSaveAdapter`가 Runtime ledger를 정산 Command로 변환하고 Domain 결과를 Unity 보상 자료로 되돌린다.
- Scene·HUD·입력 같은 Presentation 책임은 갖지 않는다.

### `ReCamp.Runtime`

경로: `Assets/_ReCamp/Scripts/`

- `Unity.InputSystem`, `UnityEngine.UI`, `ReCamp.Domain`, `ReCamp.UnityAdapter`를 참조한다.
- `MonoBehaviour`, Scene 전환, 입력, HUD, 전투 표현, 적 AI, 자원 드랍과 Prefab 연결을 담당한다.
- Domain 정책을 재구현하지 않고 Domain 결과를 표현한다.
- 현재 레거시 Gray Box 로스터는 기능 검증 자산이며 신규 CH101~CH105로 자동 교체하지 않는다.

## 4. Scene 계약

| 순서 | Scene | 책임 |
|---:|---|---|
| 0 | `00_Bootstrap` | `GameManager`와 공용 서비스를 보장하고 초기 Scene으로 이동 |
| 1 | `01_Title` | 타이틀 진입과 Lobby 이동. 개발 회귀에서는 우회 가능 |
| 2 | `02_Lobby` | 기능 검증용 캐릭터 선택, 캠프 자원·시설 표시, Run 시작 |
| 3 | `03_Battle` | 플레이어·적·웨이브·자원·타이머·귀환·HUD와 Run 종료 판정 |
| 4 | `04_Result` | 마지막 Run 보상과 종료 결과 표시, Lobby 복귀 |

Scene 이름은 `GameScene`과 `SceneLoader`를 통해서만 사용한다. 게임 코드에 문자열 Scene 이름을 새로 직접 작성하지 않는다.

## 5. 주요 Runtime 책임

### `GameManager`

- Scene 사이에서 유지되는 단일 인스턴스
- 현재 Run 상태와 선택 캐릭터 유지
- 안정적인 Run ID 생성과 보상 ledger 초기화
- Run 완료 시 Domain settlement 제출
- `LastRunOutcome`과 결과 Snapshot 노출
- Extracted 보상만 Camp에 입금
- Result·Lobby·Title 전환 요청

### `CampManager`

- 캠프 자원과 시설 레벨의 Unity Runtime 표현
- Domain 비용·효과를 사용한 시설 강화
- 정산된 Run 보상 입금
- `SaveManager`를 통한 로컬 저장

### `BattleSceneController`

- Battle Run의 시간과 종료 이유 관리
- 적 웨이브·보스·획득 자원·귀환 상태 조정
- 패배와 시간 만료를 서로 다른 Domain Outcome으로 매핑
- 기존 시간 만료 Presentation 상태를 보존하면서 Result 흐름으로 연결

### `CharacterAbilityController`

- 기존 레거시 Gray Box 로스터의 역할 능력 실행
- `SkillCommandProcessor` 결과와 `SkillActivatedEvent`를 Unity 표현에 연결
- 신규 CH101~CH105는 Gate A/B 이후 별도 Presentation·Runtime 데이터로 연결한다.

### `BattleHudController`

- Screen Space UGUI 전투 HUD
- HP, Run 타이머, 캐릭터·능력 상태, 귀환 입력 표시
- `Screen.safeArea` 기반 Root 보정
- 최종 UI Design System이나 Android Touch HUD 완료를 의미하지 않는다.

## 6. Run 데이터 흐름

```text
LobbySceneController
→ GameManager.StartRun()
→ stable Run ID + CurrentRunRewards 초기화
→ SceneLoader(Battle)

Battle ResourcePickup
→ GameManager.AddRunReward(type, amount)

Battle 종료
→ GameManager.CompleteRun(outcome)
→ DomainCampSaveAdapter → RunSettlementCommand
→ RunSettlementService
→ LastRunOutcome / LastRunRewards Snapshot
→ Extracted인 경우 CampManager.Deposit()
→ SceneLoader(Result)

ResultSceneController
→ 결과 표시
→ GameManager.ReturnToLobby()
```

정산은 Run ID 기준으로 한 번만 적용한다. Result와 UI는 Domain 결과를 재계산하지 않는다.

## 7. 저장 구조

```text
Camp Runtime State
→ CampSaveData v2
→ JsonUtility
→ PlayerPrefs: ReCamp.CampSave.v2
```

### 현재 계약

- 현재 Unity 저장 버전: `2`
- Legacy Key: `ReCamp.CampSave.v1`
- Current Key: `ReCamp.CampSave.v2`
- v1 자료는 `DomainCampSaveAdapter`를 거쳐 v2로 변환 후 다시 저장한다.
- JSON 파싱 실패 시 기본 저장 자료로 복구한다.
- Run 중 임시 ledger는 저장하지 않는다.
- 캐릭터 해금, 설정, 친밀도, 튜토리얼과 콘텐츠 진행은 현재 schema에 포함하지 않는다.

신규 CH101~CH105의 해금과 진행을 추가하기 전에 별도 `SAVE_DATA_SPEC.md`에서 RootSave 구조와 Migration 규칙을 확정한다.

## 8. 입력 경계

현재 PC 개발 입력과 Input System 기반 이동은 구현돼 있다. 일부 능력·귀환 입력과 Android On-screen Stick·Button의 완성은 별도 DEV-0116/Android 검증 범위다.

```text
Keyboard / Gamepad / Touch UI
→ Input Action 또는 공통 Input Command
→ Player·Ability Runtime
```

Gameplay가 특정 장치 API를 직접 읽지 않도록 공통 입력 계약으로 정리한다.

## 9. 테스트 Assembly와 현재 검증

| Assembly | 역할 |
|---|---|
| `ReCamp.Tests.EditMode` | Domain·Adapter·자료 변환·Damageable·Roster·Arena 등 빠른 검증 |
| `ReCamp.Tests.PlayMode` | 실제 Runtime Component·전투·캠프·캐릭터 능력·Scene 정산 검증 |

Unity `6000.5.3f1` 현재 working tree 기준:

- EditMode `35/35` passed
- PlayMode `21/21` passed
- Batch script compilation exit code `0`

Fresh Clone과 Hosted GitHub Actions는 workflow와 Unity license secrets가 준비된 hosted run을 기다린다. Android Build·Lifecycle·실기기·성능 검증도 아직 남아 있다.

## 10. 현재 남은 범위

1. Hosted GitHub Actions에서 동일 EditMode·PlayMode suite 실행
2. Android Build Profile·Lifecycle·APK·실기기 입력·Safe Area·성능 검증
3. 신규 CH101~CH105의 Gate A/B 승인 후 별도 Character handoff 설계
4. 승인된 아트의 Visual Prefab·Portrait·Icon·VFX·Animator 통합
5. 장기 roster/progression 저장 schema와 migration 설계

상세 Core 결과와 금지 사항은 `planning/DEV-0113_CORE_INTEGRATION_RESULT.md`에서 관리한다.
