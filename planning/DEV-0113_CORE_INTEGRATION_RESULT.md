# DEV-0113 Core 통합 결과

> 최종 갱신: 2026-08-09
> 상태: Done
> 기준 브랜치: `codex/recamp-unity-mvp`

## 1. 목적

`agent/unity-independent-core`에서 검토한 Unity 비종속 규칙을 현재 Unity 프로젝트에 그대로 복사하지 않고,
Unity에서 유지 가능한 `Domain → UnityAdapter → Runtime` 경계로 통합한 결과를 기록한다.

이 문서는 `DEV-0108_CORE_COMPATIBILITY_AUDIT.md`의 사전 검토 이후 실제로 반영된 내용을 소유한다.
제품 방향과 실행 우선순위는 각각 `CURRENT_PROJECT_BASELINE.md`, `planning/sprint_backlog.md`를 따른다.

## 2. 최종 구조 결정

```text
ReCamp.Domain
  순수 C# 게임 규칙·저장 DTO
  UnityEngine 참조 없음
          ↓
ReCamp.UnityAdapter
  Domain 자료와 Unity 저장·표현 자료의 변환
          ↓
ReCamp.Runtime
  MonoBehaviour·Scene·입력·HUD·Prefab·전투 표현
```

### `ReCamp.Domain`

- Assembly: `Assets/_ReCamp/Scripts/Domain/ReCamp.Domain.asmdef`
- `noEngineReferences: true`
- 현재 소유 범위
  - 자원 종류와 `ResourceWallet`
  - 캠프 시설 종류·비용·레벨
  - 기본 플레이어 능력치와 시설 효과
  - `GameSession`
  - Domain 저장 DTO `GameSaveData`
- Unity API, `MonoBehaviour`, `PlayerPrefs`, `JsonUtility`, Scene 이름을 참조하지 않는다.

### `ReCamp.UnityAdapter`

- Assembly: `Assets/_ReCamp/Scripts/UnityAdapter/ReCamp.UnityAdapter.asmdef`
- `ReCamp.Domain`만 직접 참조한다.
- 현재 소유 범위
  - Unity 캠프 저장 자료와 Domain 저장 자료 변환
  - `Food ↔ Rations`
  - `FoodStorage ↔ RationStorage`
  - Unity 저장 버전 자료의 정규화

### `ReCamp.Runtime`

- Assembly: `Assets/_ReCamp/Scripts/ReCamp.Runtime.asmdef`
- `Unity.InputSystem`, `UnityEngine.UI`, `ReCamp.Domain`, `ReCamp.UnityAdapter`를 참조한다.
- 현재 소유 범위
  - `GameManager`, `CampManager`
  - Scene Controller와 Scene 전환
  - 플레이어·적·전투·자원 드랍
  - 입력과 HUD
  - `PlayerPrefs` 저장 입출력
  - 캐릭터 선택·능력 Gray Box

Runtime은 Domain 규칙을 소비하고 Unity Scene·입력·HUD·전투 표현을 소유한다. 탐험·스킬·정산 계약은 Domain과 Adapter 경계를 통해 연결됐다.

## 3. 완료된 구현

### Assembly와 Namespace

- `ReCamp.Domain` 추가
- `ReCamp.UnityAdapter` 추가
- 기존 Unity Runtime 타입을 `ReCamp.Runtime` 영역으로 정리
- Test Assembly에서 Domain·Adapter·Runtime을 분리 참조

### 캠프·자원·저장 경계

- Unity `Scrap / Food / DataFragment`를 Domain `Scrap / Rations / DataFragment`로 변환
- Unity `Generator / Workbench / FoodStorage`를 Domain `Generator / Workshop / RationStorage`로 변환
- 시설 레벨과 자원 값을 Domain 저장 DTO로 왕복 변환
- `PlayerPrefs` 저장 키를 `ReCamp.CampSave.v1`에서 `ReCamp.CampSave.v2`로 마이그레이션
- 잘못된 JSON은 신규 기본 저장 자료로 복구
- v1 자료를 읽으면 v2로 변환해 다시 저장

### 검증

마지막 직접 검증은 2026년 7월 19일 Unity `6000.5.3f1`에서 수행됐다.

- `ReCamp.Domain`, `ReCamp.UnityAdapter`, `ReCamp.Runtime` 컴파일 성공
- `_ReCamp` Console 오류 0건
- EditMode `25/25` 통과
- PlayMode `18/18` 통과
- Food↔Rations 변환 확인
- Domain 시설 저장 복원 확인
- PlayerPrefs v1→v2 마이그레이션 확인

이 기록은 당시 로컬 Editor 검증 결과다. Fresh Clone, CI Runner, Android Player에서의 재현은 아직 완료되지 않았다.

### 2026-08-09 working-tree integration

The portable contracts and their Unity presentation wiring are implemented and verified in the
working tree.

- `RunSettlementCommand`, `RunSettlementResult` and `RunSettlementService` own the
  `Extracted / Defeated / Expired` reward policy and one-run idempotence in `ReCamp.Domain`.
- `DomainCampSaveAdapter` converts the runtime ledger to a domain settlement command and
  converts the result back to Unity reward data.
- `GameManager` creates a stable run id, submits the outcome, deposits only extracted rewards,
  and exposes `LastRunOutcome`.
- `BattleSceneController` maps defeat and time expiry to distinct domain outcomes while
  preserving the existing time-expiry presentation state.
- `SkillCommandProcessor` owns signature/utility cooldown acceptance and emits a
  `SkillActivatedEvent`; `CharacterAbilityController` uses it for cooldown state and
  `BattleHudController` presents the event and cooldown state.
- `SceneSettlementRuntimeTests` covers `Bootstrap → Lobby → Battle → Result → Lobby`,
  extracted reward transfer, Result presentation, and camp persistence.
- Domain costs and facility effects are the single source of truth; `CampManager` now adapts
  them instead of reimplementing the rules.

Verification on Unity `6000.5.3f1`:

- Batch script compilation: exit code `0`; `ReCamp.Domain`, `ReCamp.UnityAdapter`,
  `ReCamp.Runtime`, and test assemblies compiled.
- Current working tree EditMode: `35/35` passed
  (`TestResults/editmode-current.xml`, 2026-08-09).
- Current working tree PlayMode: `21/21` passed
  (`TestResults/playmode-current.xml`, 2026-08-09).

Fresh Clone verification is complete. CI is configured but a hosted run remains pending until
the workflow is pushed with the required Unity license secrets.

## 4. 아직 남은 통합 범위

1. Hosted GitHub Actions run of the same EditMode and PlayMode suites.

## 5. 금지 사항

- 원격 `.NET 8` Core 프로젝트를 Unity Assembly에 그대로 넣지 않는다.
- Domain에서 `UnityEngine`, `PlayerPrefs`, `JsonUtility`, Scene API를 참조하지 않는다.
- Runtime에 새 게임 규칙을 추가하면서 Domain에 같은 규칙을 중복 작성하지 않는다.
- 현재 동작하는 Gray Box 수치를 검증 없이 원격 Core 수치로 일괄 교체하지 않는다.
- 자동 테스트 없이 저장 버전 또는 Migration 코드를 변경하지 않는다.

## 6. 다음 구현 순서

```text
Hosted CI 실행
```

실행 순서와 상태 변경은 `planning/sprint_backlog.md`에서 관리한다.