# DEV-0113 Core 통합 결과

> 최종 갱신: 2026-08-17
> 상태: In Progress
> 기준 브랜치: `main`

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

Runtime이 Domain 규칙을 복제하지 않도록 하는 것이 최종 목표지만, 현재 탐험·스킬·정산 일부는 아직 Runtime에 남아 있다.

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

### 탐험 Outcome·정산 계약 (2026-08-17)

- `ReCamp.Domain.ResolveRunCommand`가 양의 `RunId`, `Extracted / Defeated / Expired`, 임시 보상 Snapshot을 소유한다.
- `RunSettlementPolicy`가 정산 규칙을 단일 소유한다. `Extracted`와 `Expired`는 보상을 보존하고,
  `Defeated`는 임시 보상을 0으로 만든다. 기존 Runtime 동작과 동일한 정책이다.
- `RunResolvedEvent`를 통해 Domain 결과를 반환하며, `GameManager`는 결과를 Runtime Ledger와
  `CampManager`에 적용하고 `RunResolved` 이벤트를 Presentation에 발행한다.
- `GameManager`는 탐험 시작마다 `CurrentRunId`를 증가시키고, 활성 런이 아닌 두 번째 정산 요청을
  무시해 Result 재진입·중복 버튼에 의한 중복 입금을 막는다.
- `BattleSceneController`는 종료 사유를 Domain Outcome으로 전달하며 `TimeExpired`가 수동 귀환으로
  잘못 정산되지 않도록 `CompleteRun(reason)`을 사용한다.

### 스킬 Command·Event 경계 (2026-08-17)

- `ReCamp.Domain.UseAbilityCommand`가 캐릭터 ID·능력 슬롯·능력 키·쿨타임을 Unity API 없이 표현한다.
- `AbilityResolvedEvent`가 Runtime 실행 결과를 성공/실패와 원본 Command로 전달한다.
- `CharacterAbilityController`는 키보드·Touch가 같은 `TryActivate`/`TryActivateUtility` 경로를 통과할 때
  Command를 발행하고, 실제 Gray Box 효과 실행 뒤 Event를 발행한다. Iris 차지 해제도 같은 계약을 사용한다.
- 전투 효과·상태 수치는 아직 Runtime에 남겨 두고, 다음 단계에서 Domain 이전 후보를 선별한다.

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

## 4. 아직 남은 통합 범위

DEV-0113을 `Done`으로 변경하려면 다음이 필요하다.

1. Domain 상태를 HUD와 Scene Presentation에 전달하는 Adapter 계약 정리
2. Runtime과 Domain에 중복된 캠프 비용·효과 수치 제거
3. 전체 Scene 전환·보상 정산 통합 테스트 추가
4. 별도 디렉터리 Fresh Clone 후 Unity Open·Compile·EditMode·PlayMode 재검증
5. Core·Unity CI에서 실제 Unity 라이선스 테스트 실행

## 5. 금지 사항

- 원격 `.NET 8` Core 프로젝트를 Unity Assembly에 그대로 넣지 않는다.
- Domain에서 `UnityEngine`, `PlayerPrefs`, `JsonUtility`, Scene API를 참조하지 않는다.
- Runtime에 새 게임 규칙을 추가하면서 Domain에 같은 규칙을 중복 작성하지 않는다.
- 현재 동작하는 Gray Box 수치를 검증 없이 원격 Core 수치로 일괄 교체하지 않는다.
- 자동 테스트 없이 저장 버전 또는 Migration 코드를 변경하지 않는다.

## 6. 다음 구현 순서

```text
탐험 Outcome·정산 계약
→ 스킬 Command/Event 경계
→ Runtime 중복 규칙 제거
→ 통합 Scene·정산 테스트
→ Fresh Clone 검증
→ CI 연결
```

실행 순서와 상태 변경은 `planning/sprint_backlog.md`에서 관리한다.
