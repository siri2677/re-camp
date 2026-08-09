# Re:Camp 디자인 정렬 계약

> 작성일: 2026-08-09
> 상태: Design contract refreshed; runtime roster unchanged
> 범위: 게임 디자인·시스템 문서 정합화

## 1. Context / Goals / Non-goals

현재 제품 기준은 Android-first 가로형 싱글플레이, 3~5분 탐험 세션, 자연에 잠식된 폐허와 따뜻한 캠프, 성인 여성 5인 CH101~CH105다. 현재 Unity는 기존 레거시 Gray Box 로스터와 기능 검증 자산으로 회귀 테스트를 수행한다.

**Goals**

- 최신 Baseline과 게임 콘셉트·핵심 루프·MVP·시스템 아키텍처 문서를 같은 용어로 정렬한다.
- 현재 구현된 `Domain → UnityAdapter → Runtime`, 정산, 스킬 Command/Event 경계를 문서에 반영한다.
- 전투·경제·UI·저장·아트 handoff의 구현 전 계약과 검증 기준을 남긴다.

**Non-goals**

- CH101~CH105를 Runtime CharacterId, HUD, 능력, 저장 데이터로 자동 마이그레이션하지 않는다.
- Save schema, PlayerPrefs key, Unity 코드, Prefab, Scene, 수치를 문서만으로 변경하지 않는다.
- 이미지 provider 연결, PNG 생성, Gate A 인간 승인, 3D 제작, Android APK·실기기 검증을 완료로 기록하지 않는다.

## 2. Canonical source hierarchy

충돌 시 다음 순서를 따른다.

1. `docs/00_project/CURRENT_PROJECT_BASELINE.md`
2. `planning/DESIGN_DIRECTION_2026-08-09.md`, `planning/ART_DIRECTION_RESET_BRIEF_2026-08-09.md`
3. `docs/05_art_concept/CHARACTER_BIBLE.md`, `CHARACTER_ANCHOR_SPEC.md`, `ART_DIRECTION.md`, `ART_REVIEW_CHECKLIST.md`
4. 이 문서와 `docs/01_game_design/`, `docs/02_system_design/`
5. `planning/sprint_backlog.md`의 실행 상태
6. 레거시 Gray Box 코드·자산은 기능 검증 근거로만 사용

신규 아트는 후보 PNG 0/5, 사람 Gate A 승인 0/5, 최종 3D 0/5이며 승인 전 상태는 `REVIEW`다.

## 3. Player-facing loop와 Runtime flow

```text
Bootstrap → Lobby → Battle → Result → Lobby
```

플레이어 관점에서는 다음 선택을 반복한다.

```text
탐험 준비
→ 위험 구역 탐색·전투
→ 자원 회수
→ 계속 탐험 또는 귀환
→ Outcome 정산
→ 캠프 시설 강화
→ 다음 탐험
```

| 상태 | 입력/책임 | 결과 데이터 |
|---|---|---|
| Lobby | 캐릭터·캠프 상태 확인, Run 시작 | 선택 캐릭터, 초기 Run ledger |
| Battle | 이동, 자동 공격, 능력 Command, 귀환 | 적 처치·자원·시간·생존 상태 |
| Result | Outcome과 보상 확인 | 추출 보상, 실패 결과, 다음 Scene |
| Camp/Lobby | 자원 소비로 시설 강화 | 저장할 캠프 자원·시설 레벨 |

`Extracted`, `Defeated`, `Expired`는 서로 다른 Outcome이며, 추출 보상만 캠프에 입금한다. 정산은 Run ID 기준으로 한 번만 적용한다. 실패 보상·시간 만료 손실은 현재 Domain 계약과 실제 검증 결과를 기준으로 하며, 미검증 밸런스 수치는 `TBD / needs playtest`로 둔다.

## 4. Combat contract

### 입력과 출력

- 입력: 이동, 귀환, 능력 Command. PC 키보드와 향후 Touch/Gamepad 입력은 공통 입력 계약으로 연결한다.
- 규칙 출력: 생존 상태, 피해·회복·보호막·표식 등 결정 가능한 전투 결과, `SkillActivatedEvent`.
- 표현 출력: Animator/VFX/HUD 업데이트는 Runtime Presentation이 담당하며 Domain 규칙을 중복 구현하지 않는다.

### 현재 규칙 경계

- `SkillCommandProcessor`가 시그니처/유틸리티 능력의 수락과 쿨다운을 소유한다.
- `CharacterAbilityController`는 Command 결과와 이벤트를 Unity 캐릭터 표현에 연결한다.
- `BattleHudController`는 활성화 이벤트와 쿨다운 상태를 표시한다.
- 랜덤 스킬 선택은 현재 구현 사실이 아니라 후속 시스템 후보이며, 선택 풀·확률·재선택·저장 영향은 `TBD / needs playtest`다.

### 타이밍·수식 계약

공격 주기, 피해량, 쿨다운, 적 스폰 간격, 보스 수치는 현재 Gray Box와 테이블의 소유 범위를 따른다. 문서 정렬 단계에서 임의의 확정 수식을 만들지 않는다. 신규 수치가 필요하면 입력, 상태, 출력, 시간 단위, 반올림, 상한·하한, 재현 테스트를 함께 정의하고 Domain/테이블 소유권을 먼저 결정한다.

## 5. Economy contract

| 자원 | 현재 faucet | 현재 sink | 검토 항목 |
|---|---|---|---|
| Scrap | Battle resource drop | Generator/Workbench 비용 | 초반 시설 비용, 비축 상한 TBD |
| Food/Rations | Battle resource drop | RationStorage 비용·캠프 효과 | 실패 시 보존·손실 정책, pacing TBD |
| DataFragment | Battle resource drop | 시설·향후 진행 확장 | 해금 속도, 반복 비축, 막힘 TBD |

- 캠프 시설 비용과 효과의 단일 진실은 Domain이다. `CampManager`는 이를 적응해 표현한다.
- 추출·패배·시간 만료의 보상 정책을 UI가 재계산하지 않는다.
- 초반은 생존과 첫 시설 강화, 중반은 시설 선택과 귀환 리스크, 후반은 반복 비축과 해금 속도를 검토한다. 목표 시간·획득량·비용은 플레이테스트 전 확정하지 않는다.
- 무한 파밍, 실패 반복으로 인한 손실 회피, 저장 재실행, 중복 정산을 밸런스 검토 압력점으로 기록한다.

## 6. Legacy Gray Box와 CH101~CH105 handoff

- 현재 Runtime의 레거시 CH001~CH005(기존 이름: 루나·미유·코코·이리스·노아)는 기능·Scene·저장 회귀용 Gray Box다.
- 제품 디자인의 신규 캐릭터는 CH101 아마사와 린, CH102 키사라기 마오, CH103 카나데 노조미, CH104 시온 타테가미, CH105 쿠로가네 아카리다.
- Gate A 인간 승인과 Gate B 제작 가능성 검토 전에는 신규 캐릭터를 Runtime roster나 최종 아트로 승격하지 않는다.
- handoff 시 Character ID, Visual Prefab, Portrait, Icon, VFX, Animator, 장비 Socket, 저장·해금 Migration을 별도 작업으로 설계하고 자동 치환하지 않는다.

## 7. UI / Android contract

- 목표 플랫폼은 Android Landscape이며 Windows는 개발·자동 테스트 기준이다.
- HUD는 캐릭터·적·전장을 가리지 않는 정보 우선순위를 유지하고 Safe Area를 고려한다.
- 현재 Touch HUD, Android Lifecycle, APK, 실제 기기 성능은 완료가 아니다.
- Android Gate에는 입력·Safe Area·일시정지/복귀·해상도·터치 영역·실기기 성능 증거가 필요하다.
- 키보드·Gamepad·Touch는 공통 Input Action/Command 경계로 연결하고 Gameplay가 장치 API를 직접 중복 호출하지 않도록 한다.

## 8. Save / migration impact

문서 리팩토링은 현재 `ReCamp.CampSave.v2`와 Domain `GameSaveData`를 변경하지 않는다.

- 저장 대상은 현재 캠프 자원과 시설 레벨이다.
- Run 중 임시 ledger는 저장하지 않고, 정산 후 추출 보상만 한 번 입금한다.
- v1 자료는 Adapter를 통해 v2로 정규화한다.
- CH101~CH105 해금·친밀도·스테이지 진행·설정은 향후 별도 RootSave 계약과 Migration 계획이 필요하다.

## 9. Edge cases / exploit / open decisions

- 동일 Run 결과가 재전송되거나 Result/Lobby 전환이 반복돼도 보상이 중복 입금되지 않아야 한다.
- `Defeated`와 `Expired`를 `Extracted`로 잘못 표시하거나 보존 보상을 지급하지 않아야 한다.
- 잘못된 JSON, 누락된 필드, 음수 자원, 알 수 없는 시설 레벨은 기존 정규화·기본값 계약을 벗어나지 않아야 한다.
- 능력 입력이 쿨다운 중이거나 전투가 종료된 뒤 들어와도 중복 이벤트를 만들지 않아야 한다.
- 연결 끊김/앱 백그라운드/강제 종료의 Android 저장 시점과 복귀 정책은 실기기 검증 전 `TBD`다.
- 랜덤 스킬 선택의 시점·풀·확률·실패 보상, 적 생성 압력, 귀환 보상 곡선은 플레이테스트 결정 사항이다.

## 10. Completion criteria / validation checklist

### 문서

- [ ] GAME_CONCEPT, CORE_LOOP, MVP_SCOPE가 Android-first·3~5분·신규 5인·레거시 Gray Box를 구분한다.
- [ ] MVP_SYSTEM_ARCHITECTURE가 DEV-0113 완료 경계와 Hosted CI/Android/아트 잔여 범위를 반영한다.
- [ ] 캐릭터 시트 템플릿의 v003 표기와 `REVIEW` 상태가 일치한다.
- [ ] 이 계약에 Combat/Economy/Save/UI/Edge case와 완료 기준이 있다.

### 구현·저장 보호

- [ ] `Assets/_ReCamp/Scripts/`와 Save schema를 문서 리팩토링으로 변경하지 않는다.
- [ ] 신규 CH101~CH105 Runtime mapping과 아트 승인 상태를 자동 변경하지 않는다.
- [ ] Unity 검증 수치는 실제 기록만 사용하고 Android/Hosted CI 미실행을 `Done`으로 올리지 않는다.

### 검증

- [ ] stale 레거시 이름이 신규 제품 로스터로 설명되는 위치가 없다.
- [ ] `random skill selection`이 현재 구현 사실로 서술되지 않는다.
- [ ] 문서 링크·버전·Markdown 구조를 확인한다.
- [ ] `git diff --check`를 실행한다.
- [ ] 이번 문서 변경 후에도 기존 Unity EditMode `35/35`, PlayMode `21/21` 근거와 Hosted CI pending 상태를 보존한다.

## 11. Deferred

OpenRouter/API key 연결, 실제 PNG 후보 생성, 사람 Gate A, Figma 실사용 검증, 2D→3D 변환표 확정, Blender/FBX/Unity 아트 통합, CH101~CH105 Runtime Migration, Android APK·실기기·성능 검증은 별도 backlog와 승인 게이트에서 진행한다.
