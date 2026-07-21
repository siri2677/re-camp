# Re:Camp Technical Targets

> 상태: Review  
> 적용 시점: Unity 프로젝트 생성부터  
> 승인 조건: Gray Box·Android Touch Prototype·Character Proof·Closed Test의 실제 측정 반영

## 1. 기술·출시 기준

| 항목 | 기준 |
|---|---|
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| 입력 | Unity Input System |
| 1차 제품 플랫폼 | Google Play Android |
| 개발·디버그 | Windows PC |
| 화면 | Landscape |
| 외부 테스트 | APK 제한 배포·Google Play Closed Test |
| PC 공개 빌드 | itch.io·포트폴리오 Demo |
| 카메라 | 고정 쿼터뷰 |
| 저장 | 로컬 저장 |
| 테스트 | EditMode + PlayMode + Android 실기기 QA |

## 2. 플랫폼 전략

### Android

- 제품 UX와 성능의 최종 기준
- 가상 조이스틱·Touch Button·Auto Aim 보조
- Landscape·Safe Area·Android Back·Background/Resume 대응
- Low·Medium·High 품질 단계
- 기기 파편화·발열·메모리·배터리 테스트
- 네트워크 없이 핵심 게임 실행 가능

### Windows

- Unity Editor 개발·디버깅
- 자동 테스트·CI·Profiler·Frame Debugger
- Keyboard/Mouse·Gamepad Adapter
- 아트 Import·Prefab·Material 검수
- 포트폴리오 영상·Screenshot

Windows 성능만 통과해 Android 최적화를 완료한 것으로 판단하지 않는다.

## 3. Android 초기 성능 목표

| 항목 | 기본 목표 | 선택 목표 |
|---|---:|---:|
| Target FPS | 30 | 지원 기기 60 |
| 허용 최소 FPS | 25 | 50 |
| 1회 탐험 | 3~5분 | 동일 |
| 권장 세션 | 5~15분 | 동일 |
| 동시 일반 적 | 10~20 | 15~25 |
| 동시 보스 | 1 | 1 |
| Scene 전환 | 가능하면 8초 이내 | 가능하면 5초 이내 |
| Gameplay GC Alloc | 지속 할당 최소화 | 0 B/frame 지향 |

실제 최소·권장 기기 범위는 Vertical Slice 실기기 테스트 후 확정한다.

## 4. 기준 기기 등급

### Low

- 출시 최소 지원 후보
- 30 FPS
- LOD1·LOD2 중심
- 낮은 Shadow·VFX·Physics

### Mid

- 기본 품질 기준
- 30 FPS 안정 또는 60 FPS 선택
- LOD1 중심
- 제한적 후처리·물리

### High

- 60 FPS 선택
- LOD0·LOD1
- 높은 Shadow·VFX·Physics 품질

정확한 SoC·RAM 목록은 실제 테스트 기기 확보 후 기록한다.

## 5. 렌더링 품질 단계

```text
High
- LOD0/LOD1
- 주요 캐릭터 그림자
- 제한적 후처리
- 캐릭터 물리 Bone 활성

Medium
- LOD1 중심
- 그림자 거리·해상도 감소
- 물리 Bone 일부 비활성

Low
- LOD1/LOD2
- 추가 광원·후처리·물리 최소화
- Particle·Trail·투명 Overdraw 감소
```

품질 변경 후 공격·위험·자원·캐릭터 실루엣은 계속 읽혀야 한다.

## 6. 아트 예산

### 캐릭터

- LOD0: 35k~60k triangles
- LOD1: 18k~35k triangles
- LOD2: 8k~15k triangles
- Material: 캐릭터당 4~6 slots 이하
- 전체 Bone: 120 이하

Vertical Slice의 Android 전투는 LOD1을 기본 검수 기준으로 한다.

### Texture

- 얼굴·헤어·주요 의상: 원본 2048, Android 1024 중심
- 영웅 캐릭터 선택 화면은 필요 시 2048
- 무기·장비: 1024
- 소형 장식: 512
- Mask 채널 통합
- Android ASTC 품질 단계 검토

## 7. Profiler 측정 항목

```text
CPU Main Thread
Render Thread
GPU Frame Time
Batches / SetPass Calls
Triangles / Vertices
Skinned Mesh Renderer
Particle·Trail·Overdraw
Texture Memory
Managed Memory
GC Alloc per Frame
Scene Load Time
Save·Load Time
Battery·Thermal 상태
```

측정 결과에는 기기 모델·OS·해상도·품질 설정·플레이 시간을 함께 기록한다.

## 8. 프로젝트 설정 작업

```text
DEV-0101 Unity 6.3 LTS URP 프로젝트 생성
DEV-0102 Visible Meta Files / Force Text
DEV-0103 Android Build Support·SDK·Target 설정
DEV-0104 Landscape·Orientation·Safe Area
DEV-0105 Input System Touch Control Scheme
DEV-0106 Windows Debug Control Scheme
DEV-0107 URP Low·Medium·High Profile
DEV-0108 Package 버전 기록·잠금
DEV-0109 Build Version·Development/ClosedTest/Release Channel
DEV-0110 Save Path·Migration 기반
DEV-0111 Android Back·Pause·Background/Resume
DEV-0112 첫 APK 실기기 Build
```

필수 Package:

- Universal RP
- Input System
- TextMesh Pro
- Unity Test Framework

검토 후 도입:

- Cinemachine
- AI Navigation
- Addressables

Store SDK는 핵심 게임 완성 전에 추가하지 않는다.

## 9. 코드 구조 원칙

- 게임 규칙은 `ReCamp.Core` 또는 Unity 비종속 계층에 유지
- MonoBehaviour는 Input·Scene·Animation·VFX·UI·Adapter 역할
- Touch·Keyboard·Gamepad Input Adapter 분리
- Android Lifecycle을 게임 규칙과 분리
- ScriptableObject는 설정 데이터와 Presentation 참조
- Damage·Reward·Camp Upgrade 규칙을 Animation Event나 Prefab에 중복 구현하지 않음
- Update 기반 할당과 반복 검색을 피하고 Pooling 적용

## 10. 자동 테스트

- Core 규칙 EditMode Test
- Scene 흐름 PlayMode Test
- 자원 획득·결과 정산
- Save·Load·Migration
- Character Skill 상태
- Touch Input Adapter의 상태 전환
- Pause·Resume과 중복 보상 방지
- 품질 Profile 선택과 설정 저장

## 11. 수동 테스트

### Windows Editor

- 핵심 루프 빠른 반복
- Keyboard/Mouse·Gamepad Adapter
- 1920×1080 아트·Camera 검수
- Profiler·Memory Profiler

### Android Touch Prototype

- APK 설치·첫 실행
- Landscape·Safe Area
- 조이스틱·공격·대시·스킬 동시 입력
- Auto Aim
- Android Back·Background·Resume
- 15분 반복 플레이 발열·Memory

### Android Vertical Slice

- Low·Mid·High 기준 기기
- 30 FPS·60 FPS Profile
- 16:9·18:9·19.5:9·20:9
- Save 생성·종료·재실행
- 30분 연속 실행
- 앱 업데이트 후 기존 Save

### Closed Test

- 설치·업데이트·삭제·재설치
- 첫 실행 Tutorial
- 진행 불가·Crash·저장 손상 수집
- 조작 이해·재플레이 의향

## 12. 승인 조건

- Unity 프로젝트가 다른 PC에서 Clone 후 열림
- 첫 Android APK가 기준 기기에서 실행
- Touch UI로 핵심 루프 완주
- 루나 LOD1·몬스터 3종·VFX 전투 측정
- Android 기본 30 FPS 목표 달성 또는 병목 수정 계획
- Safe Area·Back·Background/Resume 검증
- Closed Test 후보 Build의 설치·입력·Save 검증
