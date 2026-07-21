# Re:Camp Camera and UI Baseline

> 상태: Review  
> 목적: Steam Windows 기준의 고정 쿼터뷰 전투 가독성과 PC UI를 먼저 완성하고 후속 Android Port 규칙을 분리한다.

## 1. 카메라 원칙

- 플레이 중 카메라는 고정 쿼터뷰를 기본으로 한다.
- 캐릭터 얼굴·상체·무기, 적 공격 방향, 자원 드롭이 동시에 읽혀야 한다.
- 카메라 연출보다 전투 정보와 이동 경로 가독성을 우선한다.
- 로비·캐릭터 선택 화면은 전투보다 가까운 별도 카메라를 사용할 수 있다.

## 2. 초기 검증값

Gray Box와 루나 3D Blockout으로 비교한다.

| 항목 | 초기 후보 |
|---|---|
| 투영 | Perspective 우선, Orthographic 비교 |
| Yaw | 약 45도 |
| Pitch | 약 45~55도 |
| 플레이 중 회전 | 고정 |
| 캐릭터 화면 높이 | 기본 전투 거리에서 약 15~22% |
| 카메라 추적 | 부드러운 위치 추적, 회전 추적 없음 |
| Look Ahead | 이동 방향으로 제한 적용 가능 |

```text
Near: 캐릭터 매력·타격감 우선
Default: 전투·탐험 균형
Far: 적·자원·경로 가독성 우선
```

## 3. 쿼터뷰 가독성

### 캐릭터

- 머리·상체·무기가 배경과 분리됨
- 루나의 고양이 후드와 단검이 기본 거리에서 식별됨
- 무기와 장비가 몸에 완전히 가려지지 않음
- Outline·Rim Light·Ground Shadow를 제한적으로 조합

### 적

- 일반 적 3종은 크기·실루엣·이동 방식이 구분됨
- 공격 준비·활성·회복 구간이 포즈와 VFX로 구분됨
- 보스는 화면을 가리지 않으면서 위협적 크기를 유지함

### 환경

- 이동 가능 영역과 장애물이 명확함
- 큰 소품이 캐릭터를 가리면 Fade 또는 Dither 처리
- 자원·상자·귀환 지점은 환경보다 높은 명도 또는 발광 사용
- 식생과 잔해가 Hitbox·Navigation을 혼동시키지 않음

## 4. 화면별 카메라

| 화면 | 카메라 기준 |
|---|---|
| Lobby | 캠프와 캐릭터를 함께 보여주는 고정 또는 제한적 이동 |
| Character Select | 얼굴과 의상을 확인하는 근접 3D View |
| Battle | 고정 쿼터뷰 Default Preset |
| Boss Intro | 짧은 연출 후 Battle Preset 복귀 |
| Result | Victory Pose와 보상을 함께 표시 |
| Camp Upgrade | 시설 중심 고정 View 또는 UI 전용 화면 |

## 5. Steam Windows 입력

### Keyboard / Mouse

```text
WASD: 이동
Space: 대시 또는 회피
Mouse / 방향 입력: 조준 또는 대상 보정
1~4 또는 Q/E/R/F: 스킬
Tab: 탐험 정보
Esc: 일시정지
```

실제 키는 Input Action Asset과 설정 화면에서 변경 가능하게 구성한다.

### Gamepad

```text
Left Stick: 이동
Right Stick: 조준 또는 대상 선택
South Button: 기본 상호작용
East Button: 대시
Shoulder / Trigger: 스킬
Menu: 일시정지
```

필수 처리:

- Controller 연결·해제·재연결
- Xbox·PlayStation·Generic Prompt 전략
- Keyboard/Mouse와 Gamepad 자동 전환
- Focus 이동과 Back 동작
- Steam Deck과 휴대형 PC는 별도 최적화 약속 없이 참고 검증

## 6. Android Port 기준

Android UI는 Steam Full Release 안정화 후 Port Gate를 통과한 경우에만 구현한다.

```text
Steam 출시 지표 확인
→ Touch UI·Auto Aim 정책
→ Android 기기 성능·발열 검증
→ Input Action에 Touch Adapter 연결
```

후속 구성:

- 좌측 가상 조이스틱
- 우측 공격·대시·스킬 버튼
- 터치 대상 선택 또는 Auto Aim
- Safe Area
- 화면 크기별 HUD Scale
- Touch Target 44~48px 상당 이상

Android UI를 별도 게임 규칙으로 구현하지 않으며 모바일 Port를 위해 가챠·광고 UI를 추가하지 않는다.

## 7. UI Design System

```text
크림색·저채도 배경 Panel
+ 라벤더·민트 Accent
+ 짙은 남색 Text·Header
+ 둥근 모서리
+ 제한적 Glass 표현
```

필수 Token:

- Primary·Secondary·Accent·Danger·Success
- Text Primary·Secondary·Disabled
- Spacing 4·8·12·16·24·32
- Radius Small·Medium·Large
- Button Height Small·Default·Large
- Panel·Modal·Tooltip·Card·Tab
- Keyboard·Gamepad Focus·Hover·Pressed·Disabled

## 8. Vertical Slice 필수 화면

| ID | 화면 | 필수 정보 |
|---|---|---|
| ART-UI-4001 | UI Design System | Token·Button·Panel·Modal·Typography |
| ART-UI-4002 | Lobby / Exploration Ready | 캐릭터·캠프 상태·탐험 시작 |
| ART-UI-4003 | Battle HUD | HP·시간·목표·스킬·귀환 |
| ART-UI-4004 | Skill Select | 3개 선택지·효과·현재 빌드 |
| ART-UI-4005 | Result | 자원·생존 시간·종료 원인 |
| ART-UI-4006 | Camp Upgrade | 시설 레벨·비용·효과·강화 피드백 |
| ART-UI-4007 | Pause / Settings | 입력·음량·화면·종료 |

캐릭터 수집, 복잡한 장비, 상점 결제, 가챠 UI는 Vertical Slice에 포함하지 않는다.

## 9. Steam Demo·Full Release 추가 UI

### Steam Demo

- 첫 실행 입력 안내
- Tutorial
- Controller Prompt
- 해상도·창 모드·전체 화면·음량·Camera Shake
- Demo 종료와 본편 Wishlist 안내
- Demo와 본편 Save 호환 안내

### Steam Full Release

- Character Select·Unlock
- Challenge·Achievement
- 친밀도·대화
- Save Slot 또는 진행도 관리 정책
- Credits·License
- Patch 이후 신규 정보 표시

Store 이동은 게임 플레이를 방해하지 않고 Demo 종료 또는 명확한 메뉴에서만 제공한다.

## 10. 전투 HUD 원칙

- 전투 중심부를 가리는 대형 Panel 금지
- HP와 위험 상태는 시선 이동이 적은 위치
- 스킬 Icon은 Cooldown·사용 가능·강화 상태 구분
- Skill Select 동안 전투를 정지하거나 안전 처리
- 귀환은 실수 입력을 막되 빠르게 찾을 수 있어야 함
- PC 화면에서 Touch UI처럼 과도하게 큰 버튼을 강제하지 않음

## 11. 검증 매트릭스

### Steam Windows 필수

```text
1280×720
1920×1080
2560×1440
16:10
창 모드
Borderless 또는 전체 화면
Keyboard/Mouse
Gamepad
Controller 재연결
```

### 참고 검증

```text
울트라와이드
Steam Deck·휴대형 PC
Android Safe Area Mockup
```

확인:

- Text 잘림·Button 겹침 없음
- 캐릭터·보스·자원 가림 없음
- Keyboard·Mouse·Gamepad Focus 이동
- 입력 장치 전환 시 Prompt 정상
- 해상도 변경 후 Layout 유지

## 12. 승인 조건

- Capsule Gray Box에서 Default Camera Preset 승인
- 루나 Blockout에서 후드·단검 식별
- 일반 적 3종과 보스 동시 식별
- 1920×1080 Vertical Slice Wireframe 승인
- Keyboard/Mouse·Gamepad로 전체 흐름 완주
- Steam Demo Settings·Controller Flow 승인
- Android 규칙은 Port 시작 전까지 문서 상태로 유지 가능
