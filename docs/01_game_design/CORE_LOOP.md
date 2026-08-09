# Re:Camp Core Loop

## 핵심 루프 개요

Re:Camp의 핵심 루프는 **탐험 준비 → 전투·탐색 → 자원 회수 → 귀환 판단 → Outcome 정산 → 캠프 성장 → 재탐험**이다. 목표 세션은 약 3~5분이며, 현재 Unity 회귀 기준은 기존 Gray Box Runtime을 사용한다.

```text
탐험 준비
→ 위험 구역 진입
→ 이동·전투·탐색
→ 자원 회수
→ 계속 탐험 또는 귀환
→ Extracted / Defeated / Expired 정산
→ 캠프 시설 강화
→ 다음 탐험
```

## 런타임 Scene 흐름

```text
Bootstrap → Lobby → Battle → Result → Lobby
```

| 단계 | 플레이어 행동 | 현재 런타임 책임 | 결과 |
|---|---|---|---|
| Lobby | 캐릭터·캠프 확인, 탐험 시작 | `GameManager.StartRun()` | Run ID와 빈 보상 ledger |
| Battle | 이동, 자동 공격, 능력, 자원 회수, 귀환 | `BattleSceneController`, 전투·Pickup Runtime | 전투 상태·자원·종료 원인 |
| Result | 결과와 보상 확인 | `GameManager` 정산 결과, Result UI | 추출 보상 또는 실패 결과 |
| Camp/Lobby | 시설 강화, 다음 탐험 준비 | `CampManager`, 저장 Adapter | 캠프 자원·시설 레벨 저장 |

## 전투·능력 경계

- 현재 구현된 기본 공격·이동·능력 Command/Event와 Runtime Presentation을 구분한다.
- `SkillCommandProcessor`는 시그니처/유틸리티 능력의 수락과 쿨다운을 처리하고 `SkillActivatedEvent`를 발행한다.
- `CharacterAbilityController`는 이벤트를 캐릭터 표현과 쿨다운 상태에 연결한다.
- `BattleHudController`는 활성화 이벤트와 상태를 표시한다.
- **랜덤 스킬 선택은 현재 구현된 단계가 아니다.** 선택 풀, 확률, 재선택, 저장 영향은 후속 시스템에서 플레이테스트 후 정의한다.

## 자원과 Outcome

| Outcome | 의미 | 정산 원칙 |
|---|---|---|
| `Extracted` | 플레이어가 귀환해 런을 종료 | 추출한 보상을 한 번 캠프에 입금 |
| `Defeated` | 플레이어가 패배 | Domain 정책에 따른 결과를 표시; 미검증 수치는 TBD |
| `Expired` | 제한 시간이 만료 | 기존 시간 만료 표현을 유지하고 Domain 정책에 따른 결과 표시 |

Run ID는 정산 중복을 막는 멱등성 키다. Result 재진입, Scene 전환 반복, 종료 이벤트 중복 발생이 캠프에 보상을 두 번 입금하지 않아야 한다. 전투 중 임시 ledger는 저장하지 않는다.

## 리스크/보상 구조

탐험 시간이 길어질수록 자원 기대값과 위험도가 함께 상승한다. 초반·중반·후반의 정확한 시간·획득량·손실 곡선은 플레이테스트 전 `TBD / needs playtest`로 유지한다.

```text
초반: 생존·기본 자원 확보와 첫 시설 강화
중반: 시설 선택과 귀환 시점의 균형
후반: 큰 보상과 패배 위험, 반복 비축·해금 압력
```

## 귀환 시스템

귀환은 Re:Camp의 핵심 선택 요소다.

- 추출 성공: Domain 정산 결과의 추출 보상 보존
- 패배: `Defeated` 정책 적용
- 제한 시간 종료: `Expired` 정책 적용
- 결과 UI는 Domain 결과를 표시하며 보상 정책을 재계산하지 않는다.

## 반복 플레이 목표

```text
자원 수집
캠프 시설 강화
전투·귀환 판단 숙련
보스·고위험 구역 도전
신규 캐릭터 해금 방향 준비
```

신규 CH101~CH105의 캐릭터 성장·해금과 랜덤 스킬 조합은 제품 확장 범위이며 현재 저장 schema나 레거시 Runtime에 자동 반영하지 않는다.

## MVP 기준 핵심 루프

현재 Windows Unity Gray Box에서 검증하는 최소 흐름은 다음과 같다.

```text
Bootstrap
→ Lobby
→ Battle
→ 적 처치·자원 획득
→ 귀환/패배/시간 만료
→ Result 정산
→ Camp 시설 강화·저장
→ Lobby 복귀
```

현재 검증 근거는 EditMode `35/35`, PlayMode `21/21`이다. Hosted CI, Android APK·Lifecycle·실기기 성능과 신규 5인 최종 아트는 이 문서의 완료를 의미하지 않는다.
