# Re:Camp Camera and UI Baseline

> 상태: Review  
> 목적: Android Landscape 기준의 고정 쿼터뷰 전투 가독성과 Touch UI를 정의하고 Windows 입력을 개발·QA Adapter로 분리한다.

## 1. 카메라 원칙

- 플레이 중 카메라는 고정 쿼터뷰를 기본으로 한다.
- 캐릭터 얼굴·상체·무기, 적 공격 방향, 자원 드롭이 작은 모바일 화면에서도 읽혀야 한다.
- 카메라 연출보다 전투 정보와 이동 경로 가독성을 우선한다.
- 로비·캐릭터 선택 화면은 전투보다 가까운 별도 카메라를 사용할 수 있다.

## 2. 초기 검증값

| 항목 | 초기 후보 |
|---|---|
| 투영 | Perspective 우선, Orthographic 비교 |
| Yaw | 약 45도 |
| Pitch | 약 45~55도 |
| 플레이 중 회전 | 고정 |
| 캐릭터 화면 높이 | 기본 전투 거리에서 약 16~24% |
| 카메라 추적 | 부드러운 위치 추적 |
| Look Ahead | 이동 방향으로 제한 적용 가능 |

```text
Near: 캐릭터 매력·타격감 우선
Default: 모바일 전투·탐험 균형
Far: 적·자원·경로 가독성 우선
```

Default Preset은 실제 Android 6~7인치 화면에서 결정한다.

## 3. 쿼터뷰 가독성

### 캐릭터

- 머리·상체·무기가 배경과 분리됨
- 루나의 고양이 후드와 단검이 기본 거리에서 식별됨
- 무기와 장비가 몸에 완전히 가려지지 않음
- Outline·Rim Light·Ground Shadow를 제한적으로 조합

### 적

- 일반 적 3종의 크기·실루엣·이동 방식 구분
- 공격 준비·활성·회복 구간이 포즈와 VFX로 구분
- 보스가 화면과 Touch UI를 과도하게 가리지 않음

### 환경

- 이동 가능 영역과 장애물이 명확함
- 큰 소품이 캐릭터를 가리면 Fade 또는 Dither
- 자원·상자·귀환 지점은 높은 명도·윤곽·제한적 발광 사용
- 식생·잔해가 Hitbox와 Navigation을 혼동시키지 않음

## 4. 화면별 카메라

| 화면 | 기준 |
|---|---|
| Lobby | 캠프와 캐릭터를 함께 보여주는 고정 View |
| Character Select | 얼굴·의상을 확인하는 근접 3D View |
| Battle | 고정 쿼터뷰 Default Preset |
| Boss Intro | 짧은 연출 후 즉시 Battle Preset 복귀 |
| Result | Victory Pose와 획득 자원 표시 |
| Camp Upgrade | 시설 중심 고정 View 또는 UI 전용 화면 |

## 5. Android Touch 입력

### 기본 배치

```text
왼쪽 하단: 이동 조이스틱
오른쪽 하단: 기본 공격
공격 주변: 대시·스킬 버튼
오른쪽 상단: Pause
화면 상단: HP·시간·목표·자원
```

### 조작 원칙

- 가로형 양손 조작을 기준으로 한다.
- 기본 공격은 자동 연속 공격 또는 Hold 입력을 비교한다.
- Auto Aim 또는 대상 보정을 제공한다.
- 대시와 주요 스킬은 엄지 이동 범위 안에 둔다.
- 사용 빈도가 낮은 기능은 전투 중심부에서 제거한다.
- 이동 중 스킬 사용과 조이스틱 이탈을 실기기에서 검증한다.

### Touch Target

- 주요 전투 버튼은 최소 48dp 상당의 실제 터치 영역 확보
- 시각적 Icon보다 터치 판정 영역을 넓게 설정 가능
- 버튼 사이 오입력 방지 간격 확보
- Safe Area와 손가락 가림을 고려

## 6. Auto Aim과 대상 보정

우선순위 후보:

```text
1. 공격 방향과 가까운 적
2. 캐릭터와 가까운 적
3. 화면 중앙과 가까운 적
4. 보스·위협도 가중치
```

검증 항목:

- 의도하지 않은 먼 적을 공격하지 않음
- 근접 캐릭터가 뒤쪽 적을 향해 급회전하지 않음
- 보스와 일반 적이 섞였을 때 선택 정책이 일관됨
- 대상이 사망·화면 밖 이동 시 자연스럽게 해제

## 7. 앱 상태 처리

- Android Back 동작은 Pause 또는 이전 화면으로 처리
- 앱이 Background로 이동하면 전투 일시정지
- 복귀 시 Audio·Input·TimeScale 정상 복원
- 화면 회전을 Landscape로 고정
- 강제 종료 후 마지막 안전 저장 지점에서 복구

## 8. Windows 개발·QA 입력

### Keyboard / Mouse

```text
WASD: 이동
Space: 대시
Mouse 또는 방향 입력: 조준 보정 테스트
1~4 또는 Q/E/R/F: 스킬
Esc: Pause
```

### Gamepad

```text
Left Stick: 이동
Right Stick: 조준 또는 대상 선택 테스트
Face Button: 공격·대시
Shoulder / Trigger: 스킬
Menu: Pause
```

Windows 입력은 Android 게임 규칙을 대체하지 않으며 개발·테스트와 포트폴리오 Demo용 Adapter다.

## 9. UI Design System

```text
크림색·저채도 Panel
+ 라벤더·민트 Accent
+ 짙은 남색 Text
+ 둥근 모서리
+ 제한적 Glass 표현
```

필수 Token:

- Primary·Secondary·Accent·Danger·Success
- Text Primary·Secondary·Disabled
- Spacing 4·8·12·16·24·32
- Radius Small·Medium·Large
- Touch Button Small·Default·Primary
- Panel·Modal·Tooltip·Card·Tab
- Pressed·Cooldown·Unavailable·Selected

## 10. Vertical Slice 필수 화면

| ID | 화면 | 필수 정보 |
|---|---|---|
| ART-UI-4001 | Mobile UI Design System | Token·Touch Button·Panel·Typography |
| ART-UI-4002 | Lobby / Exploration Ready | 캐릭터·캠프·탐험 시작 |
| ART-UI-4003 | Battle HUD | HP·시간·목표·Touch Skill·귀환 |
| ART-UI-4004 | Skill Select | 3개 선택지·효과·현재 빌드 |
| ART-UI-4005 | Result | 자원·생존 시간·종료 원인 |
| ART-UI-4006 | Camp Upgrade | 시설 레벨·비용·효과 |
| ART-UI-4007 | Pause / Settings | 음량·진동·그래픽·Camera Shake·종료 |
| ART-UI-4008 | Touch Tutorial | 이동·공격·대시·스킬·귀환 안내 |

가챠·상점 결제·복잡한 장비 UI는 포함하지 않는다.

## 11. 전투 HUD 원칙

- 전투 중심부를 가리는 대형 Panel 금지
- 손가락이 캐릭터와 위험 표시를 가리지 않도록 배치
- HP와 위험 상태는 시선 이동이 적은 위치
- Skill Icon은 Cooldown·사용 가능·강화 상태 구분
- Skill Select 동안 전투를 안전하게 정지
- 귀환은 실수 입력을 막되 빠르게 찾을 수 있어야 함
- HUD 크기는 화면비와 DPI에 따라 Scale

## 12. 검증 매트릭스

### Android 필수

```text
16:9
18:9
19.5:9
20:9
Display Cutout·Safe Area
Low·Mid·High 기준 기기
30 FPS Profile
60 FPS Profile 지원 기기
Touch 조이스틱 동시 입력
Background·Resume
Android Back
```

### Windows 개발 참고

```text
1280×720
1920×1080
Keyboard/Mouse
Gamepad
```

확인:

- Text 잘림·Button 겹침 없음
- 캐릭터·보스·자원 가림 없음
- 조이스틱과 스킬 동시 입력
- 손가락 가림·오입력 없음
- Background 복귀 후 입력 정상
- 품질 변경 후 Layout·가독성 유지

## 13. 승인 조건

- Capsule Gray Box에서 Android Default Camera 승인
- 루나 Blockout에서 후드·단검 식별
- 일반 적 3종과 보스 동시 식별
- Landscape Touch HUD Wireframe 승인
- Android 실기기에서 전체 흐름 완주
- Auto Aim과 대시·스킬 동시 입력 검증
- Safe Area·Background·Back 동작 검증
- Windows Adapter로 동일 게임 규칙 테스트 가능
