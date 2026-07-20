# Re:Camp Camera and UI Baseline

> 상태: Review  
> 목적: 고정 쿼터뷰 전투 가독성과 PC 우선 UI 기준을 통일한다.

## 1. 카메라 원칙

- 플레이 중 카메라는 고정 쿼터뷰를 기본으로 한다.
- 캐릭터의 얼굴·상체·무기, 적의 공격 방향, 자원 드롭이 동시에 읽혀야 한다.
- 카메라 연출보다 전투 정보와 이동 경로의 가독성을 우선한다.
- 로비·캐릭터 선택 화면은 전투보다 가까운 별도 카메라를 사용할 수 있다.

## 2. 초기 검증값

다음 값은 Gray Box와 루나 3D Blockout으로 비교 검증한다.

| 항목 | 초기 후보 |
|---|---|
| 투영 | Perspective 우선, Orthographic 비교 테스트 |
| Yaw | 약 45도 |
| Pitch | 약 45~55도 |
| 플레이 중 회전 | 고정 |
| 캐릭터 화면 높이 | 기본 전투 거리에서 약 15~22% |
| 카메라 추적 | 부드러운 위치 추적, 회전 추적 없음 |
| Look Ahead | 이동 방향으로 제한적으로 적용 가능 |

숫자는 확정값이 아니며 다음 3개 Preset을 만들어 비교한다.

```text
Near: 캐릭터 매력과 타격감 우선
Default: 전투·탐험 균형
Far: 적·자원·경로 가독성 우선
```

## 3. 쿼터뷰 가독성 기준

### 캐릭터

- 머리·상체·무기가 배경과 분리됨
- 루나의 고양이 후드와 단검이 기본 거리에서 식별됨
- 캐릭터 뒤쪽의 무기와 장비가 몸에 완전히 가려지지 않음
- Outline, Rim Light, Ground Shadow를 조합하되 과도한 테두리를 피함

### 적

- 일반 적 3종은 크기·실루엣·이동 방식이 구분됨
- 공격 준비, 공격 활성, 회복 구간이 포즈와 VFX에서 구분됨
- 보스는 화면을 지나치게 가리지 않으면서 위협적인 크기를 유지함

### 환경

- 이동 가능 영역과 장애물이 명확함
- 건물이나 큰 소품이 캐릭터를 가리면 Fade 또는 Dither 처리
- 자원·상자·귀환 지점은 환경보다 높은 명도 또는 발광으로 표시
- 배경 식생과 잔해가 Hitbox·Navigation을 혼동시키지 않음

## 4. 화면별 카메라

| 화면 | 카메라 기준 |
|---|---|
| Lobby | 캠프와 캐릭터를 함께 보여주는 고정 또는 제한적 이동 |
| Character Select | 얼굴과 의상 확인이 가능한 근접 3D 뷰 |
| Battle | 고정 쿼터뷰 Default Preset |
| Boss Intro | 짧은 연출 후 즉시 Battle Preset 복귀 |
| Result | 캐릭터 Victory와 보상을 함께 표시 |
| Camp Upgrade | 시설 중심 고정 뷰 또는 UI 전용 화면 |

## 5. PC 입력 기준

### Keyboard / Mouse

```text
WASD: 이동
Space: 대시 또는 회피
Mouse / 방향 입력: 조준 또는 대상 보정
1~4 또는 Q/E/R/F: 스킬
Tab: 탐험 정보
Esc: 일시정지
```

실제 키는 Input Action Asset에서 변경 가능하게 구성한다.

### Gamepad

```text
Left Stick: 이동
Right Stick: 조준 또는 대상 선택
South Button: 기본 상호작용
East Button: 대시
Shoulder / Trigger: 스킬
Menu: 일시정지
```

## 6. Android 확장 기준

PC Vertical Slice 이후 같은 Input Action을 다음 UI에 연결한다.

- 좌측 가상 조이스틱
- 우측 공격·대시·스킬 버튼
- 터치 대상 선택 또는 자동 조준 보조
- Safe Area 대응
- 화면 크기에 따른 HUD Scale 조정

Android UI를 PC UI와 별도 게임 규칙으로 구현하지 않는다.

## 7. UI Design System

### 기본 방향

```text
크림색·저채도 배경 패널
+ 라벤더·민트 포인트
+ 짙은 남색 텍스트와 헤더
+ 둥근 모서리
+ 제한적인 글래스 효과
```

### 필수 Token

- Primary / Secondary / Accent / Danger / Success 색상
- Text Primary / Secondary / Disabled
- Spacing 4 / 8 / 12 / 16 / 24 / 32
- Corner Radius Small / Medium / Large
- Button Height Small / Default / Large
- Panel, Modal, Tooltip, Card, Tab 공통 규격

## 8. Vertical Slice 필수 화면

| ID | 화면 | 필수 정보 |
|---|---|---|
| ART-UI-4001 | UI Design System | Token, Button, Panel, Modal, Typography |
| ART-UI-4002 | Lobby / Exploration Ready | 캐릭터, 캠프 상태, 탐험 시작 |
| ART-UI-4003 | Battle HUD | HP, 시간, 목표, 스킬, 귀환 |
| ART-UI-4004 | Skill Select | 3개 선택지, 효과, 현재 빌드 |
| ART-UI-4005 | Result | 획득 자원, 생존 시간, 귀환·사망 결과 |
| ART-UI-4006 | Camp Upgrade | 시설 레벨, 비용, 효과, 강화 피드백 |
| ART-UI-4007 | Pause / Settings | 입력, 음량, 화면, 종료 |

캐릭터 수집, 복잡한 장비, 상점 결제, 가챠 UI는 Vertical Slice 범위에 포함하지 않는다.

## 9. 전투 HUD 원칙

- 전투 중심부를 가리는 대형 패널 금지
- HP와 위험 상태는 시선 이동이 적은 위치에 배치
- 스킬 아이콘은 쿨다운·사용 가능·강화 상태를 구분
- 스킬 선택 화면은 전투를 일시 정지하거나 안전하게 처리
- 귀환 버튼은 실수 입력을 막되 긴 탐색 없이 찾을 수 있어야 함
- PC 화면에서도 터치 UI처럼 지나치게 큰 버튼을 강제하지 않음

## 10. 검증 매트릭스

```text
1280×720
1920×1080
2560×1440
16:10 화면
울트라와이드 참고 검증
Android Safe Area 참고 검증
```

각 화면에서 확인한다.

- 텍스트 잘림 없음
- 버튼 겹침 없음
- 캐릭터·보스·자원 가림 없음
- Keyboard, Mouse, Gamepad Focus 이동 가능
- Android 변환 시 터치 영역 44~48px 상당 이상 확보

## 11. 승인 조건

- Capsule Gray Box에서 Default 카메라 Preset 승인
- 루나 Blockout에서 후드·단검 식별 가능
- 일반 적 3종과 보스가 동시에 읽힘
- 1920×1080에서 Vertical Slice 필수 화면 Wireframe 승인
- Windows 입력 흐름이 완주 가능
- Android용 변환 규칙이 문서와 Input Action에 연결됨
