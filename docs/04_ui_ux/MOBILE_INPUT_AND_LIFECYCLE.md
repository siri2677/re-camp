# Re:Camp Mobile Input and Lifecycle

> 최종 갱신: 2026-08-09
> 상태: Touch Command Slice Implemented; Device Smoke Pending
> 대상: Android Landscape Vertical Slice

## 1. 목적

Android 가로 화면에서 전투 입력, Safe Area, 일시정지, Android Back, 앱 Background·Resume 동작을
하나의 계약으로 정의한다.

- `BattleHudController`의 Safe Area 대응과 PC 개발 입력, 가상 조이스틱·능력·귀환 Touch UI가 구현됐다.
- `BattleInputRouter`가 Keyboard와 Touch를 공통 Command로 변환하며, Runtime Gameplay는 장치 API를 직접 읽지 않는다.

## 2. 화면 방향과 Safe Area

- 게임 화면은 Landscape만 지원하며 `ProjectSettings`에서 Portrait 자동 회전을 비활성화하고 좌우 Landscape 회전을 허용한다.
- 양쪽 Cutout은 HUD에서 처리하며 실기기 확인이 남아 있다.
- 모든 필수 조작은 `Screen.safeArea` 내부에 배치한다.
- 배경 장식은 Safe Area 밖까지 확장할 수 있지만 버튼·텍스트·HP·타이머는 잘리면 안 된다.
- 기준 설계 화면은 16:9이며 18:9, 19.5:9, 20:9와 Tablet 비율을 검증한다.

## 3. 전투 조작 배치

### 왼쪽 영역

- 이동용 가상 조이스틱 1개
- 기본 위치는 왼쪽 아래
- 손가락 Down 위치를 중심으로 생성하는 Floating 방식과 고정 방식 중 실기기 비교 후 결정
- 최대 입력 반경 밖의 이동은 정규화한다.
- Dead Zone을 적용해 미세 떨림을 막는다.

### 오른쪽 영역

- 기본 공격
- Dash
- Active Skill 1
- Active Skill 2
- 귀환 Hold 버튼
- 필요 시 캐릭터 고유 Ability 표시

공격과 Dash는 가장 큰 버튼으로 배치한다. 스킬 버튼은 Cooldown, 사용 가능 여부, 상태 이상을
아이콘·숫자·명도 변화로 표시한다.

## 4. 입력 Command 계약

- Gameplay 코드는 `Keyboard.current`와 Touch 좌표를 직접 읽지 않는다.
- 장치 입력은 다음 공통 Command로 변환한다.

```text
Move(Vector2)
AttackPressed
AttackReleased
DashPressed
Skill1Pressed
Skill1Released
Skill2Pressed
Skill2Released
ExtractStarted
ExtractCancelled
PausePressed
```

- PC Keyboard·Touch UI는 같은 Command를 생성한다.
- 캐릭터 능력이 Hold·Release를 사용하는 경우 Press와 Release를 모두 전달한다.
- 귀환은 Hold 진행률을 Runtime이 소유하고, UI는 시작·취소 입력과 진행 상태만 표시한다.
- UI Button 이벤트가 전투 Component를 직접 호출하지 않고 Input Command 계층을 거친다.

## 5. PC 개발 입력 병행

Android 제품 개발 중에도 Windows Editor 회귀를 위해 PC 입력을 유지한다.

| 행동 | PC 개발 입력 | Android 입력 |
|---|---|---|
| 이동 | WASD / 방향키 | 가상 조이스틱 |
| 기본 공격 | 자동 또는 지정 Key | 공격 버튼 |
| Dash | 지정 Key | Dash 버튼 |
| Skill 1·2 | 지정 Key | Skill 버튼 |
| 귀환 | `R` Hold | 귀환 Hold 버튼 |
| 일시정지 | `Escape` | Pause / Android Back |

정확한 Key Binding은 Input Action Asset에서 관리하고 Gameplay 코드에 하드코딩하지 않는다.

## 6. 자동 조준과 대상 선택

Vertical Slice 기본 정책은 모바일 조작 부담을 줄이기 위해 다음을 사용한다.

- 기본 공격은 유효 사거리 안의 가장 가까운 적 또는 현재 우선 대상을 자동 조준한다.
- 정밀 방향이 필요한 스킬은 이동 방향·최근 조준 방향·가까운 대상 중 스킬별 규칙을 사용한다.
- 화면 밖 대상은 조준 우선순위를 낮춘다.
- 사망·비활성 대상은 즉시 Target Registry에서 제외한다.
- 수동 Target Lock은 Vertical Slice 필수 범위가 아니다.

## 7. HUD 피드백

모든 버튼은 다음 상태를 구분해야 한다.

- Normal
- Pressed
- Cooldown
- Disabled
- Not Enough Resource
- Interrupted

터치 입력 시 시각 반응은 즉시 발생해야 한다. Gameplay 실행 실패 시에도 버튼이 눌린 것처럼 계속
남아 있지 않도록 Command 결과와 UI 상태를 동기화한다.

## 8. 일시정지

### 전투 중

일시정지 시 다음을 멈춘다.

- 플레이어·적 이동
- 공격·스킬·피격
- 웨이브와 Run 타이머
- 귀환 Hold 진행
- 물리 기반 Gameplay

UI Animation과 설정 메뉴는 동작할 수 있다. 일시정지 해제 전 입력 상태를 초기화해 Dash·Skill·귀환이
자동으로 실행되지 않게 한다.

### Lobby·Result

Lobby와 Result에서는 시간 정지가 필요하지 않으며 메뉴 Layer만 표시한다.

## 9. Android Back 정책

| 현재 화면 | 동작 |
|---|---|
| Battle | Pause 메뉴 열기. 이미 열려 있으면 닫기 |
| Lobby | 종료 확인 Dialog 열기 |
| Result | Lobby 복귀 확인 또는 Lobby 이동 |
| Title | 앱 종료 확인 |
| 설정·팝업 | 가장 위의 팝업부터 닫기 |

Android Back을 즉시 앱 종료나 Run 포기로 연결하지 않는다.

## 10. Background·Resume 정책

### Background 진입

- `OnApplicationPause(true)` 또는 Focus 상실 시 Battle을 즉시 일시정지한다.
- 현재 Touch·Hold 입력을 취소한다.
- Camp의 영구 상태는 즉시 저장한다.
- 일시정지 Overlay를 표시할 준비를 한다.

### 같은 Process에서 Resume

- 자동으로 전투를 재개하지 않는다.
- Pause 화면에서 사용자가 `계속`을 눌러야 재개한다.
- 입력 장치 상태를 다시 초기화한다.
- Audio와 Time Scale을 정상화한다.

### Process 종료 또는 OS Kill

Vertical Slice에서는 Battle 중간 저장·복원을 지원하지 않는다.

- 획득 중이던 Run 보상은 Camp에 입금하지 않는다.
- 다음 실행은 Lobby 또는 Title의 정상 시작 상태로 진입한다.
- 마지막으로 저장된 Camp 자원·시설만 복구한다.

중간 Run 복구는 Full Release 필요성이 검증될 때 별도 Save Schema로 추가한다.

## 11. 터치 충돌 방지

- UI 위 Touch는 이동·월드 입력으로 전달하지 않는다.
- 멀티터치에서 이동 손가락과 스킬 손가락을 개별 Pointer ID로 추적한다.
- 조이스틱 손가락이 화면 밖으로 나가거나 Cancel되면 이동을 0으로 초기화한다.
- 앱 Pause, Scene 전환, 캐릭터 사망 시 모든 Pointer 상태를 초기화한다.
- Safe Area 재계산 중 버튼 위치가 순간 이동해 입력이 유지되지 않도록 Layout 갱신 후 Pointer를 정리한다.

## 12. 접근성과 설정

Vertical Slice에서 최소한 다음 설정을 제공한다.

- 조이스틱 크기
- 오른쪽 버튼 크기
- HUD 투명도
- 진동 On/Off
- 자동 공격 On/Off 또는 기본 정책 표시
- 품질 30 FPS / 선택형 60 FPS

버튼 위치 완전 자유 배치는 초기 출시 필수 범위가 아니다.

## 13. 완료 검증

### 자동 테스트

- `BattleInputRouterTests`: Dead Zone·입력 정규화·취소·transient reset
- `BattleInputRouter_SignatureCommandActivatesCurrentAbility`: 공통 Signature Command가 현재 캐릭터 능력으로 전달됨
- `BattleHud_CreatesSafeTouchControlsThatEmitExtractionCommand`: Safe Area HUD 생성과 귀환 Hold Command
- Unity EditMode `35/35`, PlayMode `21/21` 통과

### 남은 실기기 Smoke

1. 이동하면서 공격·Dash·Skill 동시 사용
2. Cutout 좌우 회전에서 버튼 잘림 없음
3. 알림창·홈 이동 후 Resume
4. Android Back으로 Pause 열기·닫기
5. 3~5분 Run 완주
6. Background 중 시간이 흐르지 않음
7. Process Kill 후 Camp 저장만 정상 복구

## 14. 제외 범위

- 세로 화면
- 화면 터치 직접 이동
- 복잡한 수동 Target Lock
- Battle 중간 저장·복원
- 버튼 완전 자유 배치 편집기
- 제스처 기반 다중 스킬 입력
