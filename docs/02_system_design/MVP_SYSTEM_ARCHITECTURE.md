# Re:Camp MVP System Architecture

> 최종 갱신: 2026-07-27
> 상태: Active
> 기준 브랜치: `codex/recamp-unity-mvp`
> Unity: `6000.5.3f1`

## 1. 문서 역할

현재 구현된 MVP의 Scene, Assembly, Domain·Adapter·Runtime 경계와 데이터 흐름을 정의한다.
제품 방향은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`, 실제 작업 상태는
`planning/sprint_backlog.md`, 구현 검증 증거는 `planning/IMPLEMENTATION_STATUS.md`를 따른다.

## 2. 현재 MVP 흐름

```text
Bootstrap
→ Lobby
→ Battle
→ Result
→ Lobby
```

- Lobby에서 캐릭터를 선택하고 탐험을 시작한다.
- Battle에서 적·보스와 전투하고 자원을 획득한다.
- 귀환·사망·시간 만료·승리로 Run이 종료된다.
- Result에서 보상을 확인하고 Camp에 반영한다.
- Lobby에서 캠프 시설을 강화한 뒤 다음 Run을 시작한다.

Title Scene은 존재하지만 빠른 개발 회귀에서는 Bootstrap에서 Lobby로 바로 진입할 수 있다.

## 3. Assembly 경계

```text
┌─────────────────────────────────────────────┐
│ ReCamp.Domain                               │
│ 순수 C# 규칙·자료, UnityEngine 참조 없음   │
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
- 현재 자원, 캠프 시설, 시설 비용·효과, 기본 능력치, Domain 저장 자료를 소유한다.
- 장기적으로 탐험 Outcome과 정산 정책, 테스트 가능한 스킬 규칙을 소유한다.

### `ReCamp.UnityAdapter`

경로: `Assets/_ReCamp/Scripts/UnityAdapter/`

- `ReCamp.Domain`을 참조한다.
- Domain과 Unity Runtime 사이의 이름·자료 구조 차이를 변환한다.
- 현재 `Food ↔ Rations`, `FoodStorage ↔ RationStorage`, 캠프 저장 DTO 왕복 변환을 담당한다.
- Scene·HUD·입력 같은 Presentation 책임은 갖지 않는다.

### `ReCamp.Runtime`

경로: `Assets/_ReCamp/Scripts/`

- `Unity.InputSystem`, `UnityEngine.UI`, `ReCamp.Domain`, `ReCamp.UnityAdapter`를 참조한다.
- `MonoBehaviour`, Scene 전환, 입력, HUD, 전투 표현, 적 AI, 자원 드랍과 Prefab 연결을 담당한다.
- 현재 Gray Box의 일부 게임 규칙이 남아 있으므로 DEV-0113에서 Domain과의 중복을 계속 제거한다.

## 4. Scene 계약

| 순서 | Scene | 책임 |
|---:|---|---|
| 0 | `00_Bootstrap` | `GameManager`와 공용 서비스를 보장하고 초기 Scene으로 이동 |
| 1 | `01_Title` | 타이틀 진입과 Lobby 이동. 개발 회귀에서는 우회 가능 |
| 2 | `02_Lobby` | 캐릭터 선택, 캠프 자원·시설 표시, Run 시작 |
| 3 | `03_Battle` | 플레이어·적·웨이브·자원·타이머·귀환·HUD와 Run 종료 판정 |
| 4 | `04_Result` | 마지막 Run 보상과 종료 결과 표시, Lobby 복귀 |

Scene 이름은 `GameScene`과 `SceneLoader`를 통해서만 사용한다. 게임 코드에 문자열 Scene 이름을 새로 직접 작성하지 않는다.

## 5. 주요 Runtime 책임

### `GameManager`

- Scene 사이에서 유지되는 단일 인스턴스
- 현재 Run 상태와 선택 캐릭터 유지
- Run 시작과 보상 Ledger 초기화
- Run 완료 시 마지막 보상 Snapshot 생성
- Camp에 보상 입금
- Result·Lobby·Title 전환 요청

`GameManager`는 Presentation 조정자다. 앞으로 정산 정책 자체는 Domain으로 이동하고 결과만 받아 적용해야 한다.

### `CampManager`

- 캠프 자원과 시설 레벨의 Unity Runtime 표현
- Run 보상 입금
- 시설 강화와 능력치 반영
- `SaveManager`를 통한 로컬 저장

### `BattleSceneController`

- Battle Run의 시간과 종료 이유 관리
- 적 웨이브·보스·획득 자원·귀환 상태 조정
- 승리·사망·시간 만료·조기 귀환을 Result 흐름으로 연결

### `CharacterAbilityController`

- 루나·미유·코코·이리스·노아의 역할 Gray Box 능력 실행
- 입력과 전투 Component를 연결
- 현재는 기능 검증용 Runtime 구현이며, 공통 규칙과 결정적 수치는 Domain 이전 후보로 검토한다.

### `BattleHudController`

- Screen Space UGUI 전투 HUD
- HP, Run 타이머, 캐릭터·능력 상태, 귀환 입력 표시
- `Screen.safeArea` 기반 Root 보정
- 최종 UI Design System이나 Android Touch HUD 완성을 의미하지 않는다.

## 6. Run 데이터 흐름

```text
LobbySceneController
→ GameManager.StartRun()
→ CurrentRunRewards 초기화
→ SceneLoader(Battle)

Battle의 ResourcePickup
→ GameManager.AddRunReward(type, amount)

Battle 종료
→ GameManager.CompleteRun()
→ LastRunRewards Snapshot
→ CampManager.Deposit()
→ SceneLoader(Result)

ResultSceneController
→ RunSettlementViewAdapter
→ 보상·Outcome 표시
→ GameManager.ReturnToLobby()
```

현재 Runtime Ledger가 Run 보상을 직접 소유하지만, terminal 결과는 Domain `RunResolvedEvent`에서
생성되고 `RunSettlementViewAdapter`가 Result Presentation용 snapshot으로 변환한다. `Extracted /
Defeated / Expired`별 정산 정책은 Domain이 소유한다.

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

### 저장 Adapter

```text
CampSaveData / UnityCampSaveData
↔ DomainCampSaveAdapter
↔ GameSaveData
```

현재 저장은 캠프 자원과 시설 레벨만 소유한다. 캐릭터 해금, 설정, 친밀도, 튜토리얼과 콘텐츠 진행을 추가하기 전에 별도 `SAVE_DATA_SPEC.md`에서 Schema와 Migration 규칙을 확정해야 한다.

## 8. 입력 경계

현재 PC 개발 입력과 Input System 기반 이동은 구현돼 있다. 다만 일부 능력·귀환 입력이 Runtime에서
`Keyboard.current`를 직접 읽고 있으며 Android On-screen Stick·Button은 아직 없다.

목표 구조는 다음과 같다.

```text
Keyboard / Gamepad / Touch UI
→ Input Action 또는 공통 Input Command
→ Player·Ability Runtime
```

Gameplay가 특정 장치 API를 직접 읽지 않도록 DEV-0116에서 공통 입력 계약으로 정리한다.

## 9. 테스트 Assembly

| Assembly | 역할 |
|---|---|
| `ReCamp.Tests.EditMode` | Domain·Adapter·자료 변환·Damageable·Roster·Arena 등 빠른 검증 |
| `ReCamp.Tests.PlayMode` | 실제 Runtime Component·전투·캠프·캐릭터 능력 검증 |

마지막 직접 검증 기준은 EditMode `25/25`, PlayMode `18/18`이다. Scene 전체 전환과 사망 드랍부터
Result 정산까지의 단일 통합 테스트, Fresh Clone, CI, Android Player 검증은 아직 남아 있다.

## 10. 현재 남은 구조 작업

1. 탐험 Outcome과 정산 정책을 Domain 계약으로 이동
2. 스킬 Command/Event와 Presentation 경계 확정
3. Runtime·Domain의 캠프 비용과 효과 중복 제거
4. PC·Touch를 통합하는 입력 Command 계층 추가
5. 저장 Schema·Migration 전용 문서 작성
6. Scene 전체 흐름·보상 정산 통합 테스트 추가
7. Fresh Clone과 CI 재현
8. Android Build·Lifecycle·실기기 검증

상세 DEV-0113 결과는 `planning/DEV-0113_CORE_INTEGRATION_RESULT.md`에서 관리한다.
