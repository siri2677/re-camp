# Re:Camp MVP Scope

## MVP 목표

Re:Camp의 MVP는 전체 게임 완성이 아니라 **3~5분 탐험·전투·자원 회수·귀환·캠프 정산 루프가 실제로 작동하는지 검증하는 것**이다. Windows Unity는 개발·자동 테스트 기준이고, 제품 목표 플랫폼은 Android Landscape다.

## MVP 핵심 루프

```text
Bootstrap
→ Lobby
→ 탐험 준비
→ Battle 진입
→ 이동·전투·자원 획득
→ 귀환 / 패배 / 시간 만료
→ Result 정산
→ Camp 시설 강화·저장
→ Lobby 복귀
```

## 포함 범위: 현재 Gray Box 검증

| 구분 | MVP 범위 | 상태 경계 |
|---|---|---|
| 캐릭터 | 기능 검증용 레거시 Runtime 로스터 | 신규 CH101~CH105로 자동 교체하지 않음 |
| 조작 | 모바일 가상 조이스틱 계획 / 키보드 테스트 입력 | Android Touch·Lifecycle은 별도 Gate |
| 공격 | 기본 자동 공격 또는 반자동 공격 | 현재 구현 수치와 테스트 기준 유지 |
| 능력 | 현재 Runtime의 캐릭터 능력 Command/Event | 랜덤 스킬 선택은 후속 시스템 후보 |
| 몬스터 | 일반 적·보스·웨이브 Gray Box | 최종 콘텐츠 수치는 별도 범위 |
| 스테이지 | 폐허 거리 1개와 쿼터뷰 Battle Scene | Android 실기기 가독성 미검증 |
| 자원 | 고철, 식량, 데이터 조각 | Domain/Adapter 변환 계약 사용 |
| 캠프 시설 | 발전기, 작업대, 식량 창고 | Domain 비용·효과가 단일 진실 |
| Scene | Bootstrap, Title, Lobby, Battle, Result | 빠른 회귀는 Bootstrap→Lobby 우회 가능 |
| UI | 로비, 전투, 결과, 캠프 HUD | 최종 Design System 아님 |
| 저장 | 로컬 `PlayerPrefs` 캠프 저장 v2 | 신규 roster/progression schema 미포함 |

## 제품 방향과 MVP Runtime의 분리

제품 디자인 로스터는 다음 신규 성인 여성 5인이다.

- CH101 아마사와 린
- CH102 키사라기 마오
- CH103 카나데 노조미
- CH104 시온 타테가미
- CH105 쿠로가네 아카리

이들은 현재 후보 PNG 0/5, 사람 Gate A 승인 0/5, 최종 3D 0/5 상태다. Gate A/B와 별도 Character handoff 전에는 MVP Runtime, HUD, 저장 해금, Prefab에 자동 연결하지 않는다. 기존 Unity 레거시 로스터는 기능 검증 자산이며 최종 제품 아트가 아니다.

## 제외 범위

```text
실시간 멀티플레이
PvP
길드
가챠
상점 결제
광고
시즌 이벤트
음성 더빙
대규모 스토리 컷신
CH101~CH105 Runtime Migration
복잡한 장비 파밍
Android APK·실기기 성능 승인
Hosted CI 완료
```

## 완료 기준: 현재 기술 MVP

다음은 현재 Windows Unity Gray Box와 자동 테스트로 확인할 범위다.

```text
1. Bootstrap에서 Lobby로 진입할 수 있다.
2. Lobby에서 Battle을 시작할 수 있다.
3. 플레이어가 이동할 수 있다.
4. 적이 스폰되고 플레이어를 추적한다.
5. 플레이어가 적을 공격하고 능력을 사용할 수 있다.
6. 적 처치와 자원 획득이 Run ledger에 기록된다.
7. 귀환·패배·시간 만료가 구분된 Result 흐름으로 연결된다.
8. Extracted 보상이 한 번 Camp에 정산된다.
9. 결과와 캠프 시설을 표시할 수 있다.
10. 캠프 강화 결과가 저장되고 다시 읽힌다.
11. Lobby로 복귀해 다음 Run을 시작할 수 있다.
```

현재 직접 검증 근거는 Unity 6000.5.3f1 EditMode `35/35`, PlayMode `21/21`이다. 이는 Android APK·실기기·Hosted CI·최종 아트 완료를 의미하지 않는다.

## 우선순위

```text
P0: Scene 흐름, 플레이어 이동, 적 스폰, 기본 전투, 종료 상태
P1: 자원 획득, Result 정산, 캠프 성장, 저장
P2: Android Touch/Lifecycle, 보스·콘텐츠 확장, 랜덤 스킬 선택 설계·검증
P3: 신규 CH101~CH105 Gate A/B/C handoff, 연출, 사운드, 튜토리얼, UI 고도화
```

수치·보상 곡선·랜덤 스킬 선택 규칙은 플레이테스트와 별도 설계 승인 전 `TBD / needs playtest`로 유지한다.
