# Re:Camp Technical Targets

> 상태: Review  
> 적용 시점: Unity 프로젝트 생성부터  
> 승인 조건: Gray Box·Character Proof·Steam Demo의 실제 프로파일링 결과 반영

## 1. 기술·출시 기준

| 항목 | 기준 |
|---|---|
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| 입력 | Unity Input System |
| 1차 개발 플랫폼 | Windows PC |
| 1차 상용 출시 | Steam Windows |
| 테스트 배포 | itch.io 제한 공개·Steam 무료 Demo |
| 2차 PC Store | Epic Games Store |
| Android | Steam 출시 안정화 후 Port 판단 |
| 카메라 | 고정 쿼터뷰 |
| 저장 | 로컬 저장 |
| 테스트 | EditMode + PlayMode + 수동 플레이 검증 |

## 2. 플랫폼 전략

### Steam Windows

- 개발·Vertical Slice·정식 출시의 기준 플랫폼
- Keyboard/Mouse와 Gamepad 완전 지원
- 1920×1080을 기본 검수 해상도로 사용
- 창 모드·전체 화면·Borderless 지원 범위 결정
- Steam Demo와 본편 Build를 분리 가능하게 구성
- Controller 연결 해제·재연결 대응
- Save 위치·Migration·Crash Log 정책 마련
- Steam Achievement·Cloud Save 사용 여부는 Demo 이후 확정

### itch.io

- 내부·외부 Alpha와 제한 공개 Test Build
- 설치·압축 해제·실행 과정과 Controller·성능 피드백 확인
- 상용 빌드의 단일 기준 플랫폼으로 사용하지 않음

### Epic Games Store

- Steam Windows Build 안정화 후 추가 Store로 검토
- 게임 코드는 공유하되 Store SDK·Achievement·Build Pipeline을 Adapter로 분리
- 추가 QA·Store 운영비가 예상 수익보다 낮을 때 진행

### Android

- Steam Full Release 안정화 후 Port Gate를 통과해야 진행
- 가상 조이스틱·Touch Button·Auto Aim 보조 추가
- Texture·Shadow·Post Processing·VFX 품질 단계 별도 구성
- 기기 파편화·발열·메모리·Safe Area 테스트
- PC Core와 Save 규칙을 공유하고 Input·Presentation만 분리
- 모바일 출시를 위해 F2P·광고·가챠를 추가하지 않음

## 3. Windows 초기 성능 목표

| 항목 | 목표 |
|---|---:|
| Target FPS | 60 |
| 허용 최소 FPS | 45 |
| 기본 검수 해상도 | 1920×1080 |
| 추가 해상도 | 1280×720, 2560×1440, 16:10 |
| 1회 탐험 | 3~5분 |
| 권장 전체 세션 | 20~40분 |
| 동시 일반 적 | 15~30 |
| 동시 보스 | 1 |
| Scene 전환 | 가능하면 5초 이내 |
| Gameplay GC Alloc | 지속 할당 최소화, 실제 측정 기록 |

최소·권장 PC 사양은 실제 Vertical Slice Profiler 결과와 저사양 PC 테스트 후 결정한다.

## 4. Android 참고 목표

Android 수치는 Port 착수 전 확정하지 않는다. 초기 참고값:

| 항목 | 참고 목표 |
|---|---:|
| Target FPS | 30 또는 60 품질 단계 |
| 허용 최소 FPS | 25 또는 45 |
| 동시 일반 적 | 10~20 |
| Scene 전환 | 가능하면 8초 이내 |

## 5. 렌더링 품질 단계

```text
High
- LOD0/LOD1 적극 사용
- 주요 캐릭터 그림자와 제한적 후처리
- 캐릭터 물리 Bone 활성

Medium
- 전투 캐릭터 LOD1 중심
- 그림자 거리와 해상도 감소
- 물리 Bone 일부 비활성

Low
- LOD1/LOD2 중심
- 추가 광원·후처리·물리 최소화
- VFX Particle과 투명 Overdraw 감소
```

Windows에서도 Low Profile을 유지해 저사양 PC와 향후 Android Port 기반으로 사용한다.

## 6. 아트 예산

### 캐릭터

- LOD0: 35k~60k triangles
- LOD1: 18k~35k triangles
- LOD2: 8k~15k triangles
- Material: 캐릭터당 4~6 slots 이하 목표
- 전체 Bone: 120 이하 목표

### Texture

- 얼굴·헤어·주요 의상: 원본 2048, Unity 1024~2048
- 무기·장비: 1024 중심
- 소형 장식: 512 중심
- Mask 채널 통합 우선

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
```

절대 수치는 Gray Box와 실제 에셋 도입 후 기록한다.

## 8. 프로젝트 설정 작업

```text
DEV-0101 Unity 6.3 LTS URP 프로젝트 생성
DEV-0102 Visible Meta Files / Force Text
DEV-0103 Windows Build Target·기본 해상도
DEV-0104 Input System PC Control Scheme
DEV-0105 URP Renderer·Quality Profile
DEV-0106 Package 버전 기록·잠금
DEV-0107 Build Version·Channel 분리
DEV-0108 Demo / Full Build Define 검토
DEV-0109 Save Path·Migration 기반
DEV-0110 Crash·Log 수집 정책
DEV-0111 Android Build Target 전환은 Port Gate 이후
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
- Steamworks Integration Library

필요성이 확인되지 않은 Package를 미리 추가하지 않는다.

## 9. 코드 구조 원칙

- 게임 규칙은 `ReCamp.Core` 또는 Unity 비종속 계층에 유지
- MonoBehaviour는 Input·Scene·Animation·VFX·UI·Adapter 역할
- Store 기능은 Steam·Epic·None Adapter로 분리 가능하게 설계
- Demo와 Full Version의 콘텐츠 차이를 하드코딩하지 않음
- ScriptableObject는 설정 데이터와 Presentation 참조에 사용
- Damage·Reward·Camp Upgrade 규칙을 Animation Event나 Prefab에 중복 구현하지 않음
- Update 기반 할당과 반복 검색을 피하고 Pooling 적용

## 10. 자동 테스트

- Core 규칙 EditMode Test
- Scene 흐름 PlayMode Test
- 자원 획득·결과 정산
- Save·Load·Migration
- Character Skill 상태
- Demo 콘텐츠 제한과 본편 콘텐츠 분리
- Store Adapter 없이도 게임 실행 가능

## 11. 수동 테스트

### Vertical Slice

- Windows 1920×1080에서 핵심 루프 완주
- Keyboard/Mouse와 Gamepad
- 쿼터뷰 가독성·UI 겹침
- 30분 반복 플레이 Memory 증가

### Steam Demo

- 깨끗한 PC에서 설치·첫 실행
- Controller 연결·해제·재연결
- 1280×720~2560×1440
- 창 모드·전체 화면 전환
- Save 생성·종료·재실행
- Demo 종료와 Store 이동 Flow
- Crash Log와 오류 메시지

### Steam Full Release

- 20~40분 반복 세션
- Save Migration과 손상 복구
- Achievement·Cloud 사용 시 Offline 동작
- 장시간 실행과 Memory
- 패치 후 기존 Save

### Android Port

- Port Gate 통과 후 기기별 입력·발열·성능·Safe Area 확인

## 12. 승인 조건

- Unity 프로젝트가 다른 PC에서 Clone 후 열림
- Gray Box 전투 Profiler 기록
- 루나 LOD1·몬스터 3종·VFX 전투 측정
- Windows 목표 FPS 달성 또는 병목 수정 계획
- itch.io 외부 Test Build 실행
- Steam Demo 후보 Build의 설치·입력·Settings·Save 검증
- Android는 실제 Port Build 또는 후속 단계로 명시적으로 연기됨
