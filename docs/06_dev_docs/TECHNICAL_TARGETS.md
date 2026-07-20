# Re:Camp Technical Targets

> 상태: Review  
> 적용 시점: Unity 프로젝트 생성부터  
> 승인 조건: Gray Box와 루나 Character Proof의 실제 프로파일링 결과 반영

## 1. 기술 기준

| 항목 | 기준 |
|---|---|
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| 입력 | Unity Input System |
| 1차 플랫폼 | Windows PC |
| 2차 플랫폼 | Android |
| 카메라 | 고정 쿼터뷰 |
| 저장 | 로컬 저장 |
| 테스트 | EditMode + PlayMode + 수동 플레이 검증 |

## 2. 플랫폼 전략

### Windows

- 개발과 포트폴리오 Vertical Slice의 기준 플랫폼
- Keyboard/Mouse와 Gamepad를 우선 지원
- 1920×1080을 기본 검수 해상도로 사용
- 창 모드와 전체 화면을 모두 확인

### Android

- PC Vertical Slice 이후 확장
- 가상 조이스틱과 터치 스킬 버튼 추가
- 동일한 게임 규칙을 유지하고 Presentation과 입력만 분리
- Texture, Shadow, Post Processing, VFX 품질 단계를 별도 구성

## 3. 초기 성능 목표

다음 값은 개발 초기 목표이며 실제 프로파일링 결과로 수정한다.

| 항목 | Windows 목표 | Android 검토 목표 |
|---|---:|---:|
| Target FPS | 60 | 30 또는 60 품질 단계 |
| 허용 최소 FPS | 45 | 25 또는 45 |
| 기본 해상도 | 1920×1080 | 기기 해상도 기반 Dynamic Resolution 검토 |
| 전투 세션 | 3~5분 | 3~5분 |
| 동시 일반 적 | 15~30 | 10~20 |
| 동시 보스 | 1 | 1 |
| Scene 전환 | 가능하면 5초 이내 | 가능하면 8초 이내 |

## 4. 렌더링 품질 단계

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

## 5. 초기 예산

### 캐릭터

- LOD0: 35k~60k triangles
- LOD1: 18k~35k triangles
- LOD2: 8k~15k triangles
- Material: 캐릭터당 4~6 slots 이하 목표
- 전체 Bone: 120 이하 목표

상세 기준은 `docs/05_art_concept/CHARACTER_3D_SPEC.md`를 따른다.

### Texture

- 얼굴·헤어·주요 의상: 원본 2048, Unity 1024~2048
- 무기·장비: 1024 중심
- 소형 장식: 512 중심
- Mask 채널 통합을 우선하고 불필요한 독립 맵을 줄임

### 전투 Scene

초기 측정 항목:

```text
CPU Main Thread
GPU Frame Time
Batches / SetPass Calls
Triangles / Vertices
Skinned Mesh Renderer 수
Particle 수와 Overdraw
Texture Memory
GC Alloc per Frame
Scene Load Time
```

절대 수치는 Gray Box와 실제 에셋 도입 후 기록한다.

## 6. 프로젝트 설정 작업

```text
DEV-0101 Unity 6.3 LTS URP 프로젝트 생성
DEV-0102 Visible Meta Files / Force Text 설정
DEV-0103 Windows Build Target과 기본 해상도 설정
DEV-0104 Input System과 PC Control Scheme 구성
DEV-0105 URP Renderer와 Quality Profile 구성
DEV-0106 기본 Package 버전 기록·잠금
DEV-0107 Android Build Target 전환 검증
```

필수 검토 Package:

- Universal RP
- Input System
- TextMesh Pro
- Unity Test Framework
- Cinemachine 사용 여부
- AI Navigation 사용 여부
- Addressables 사용 여부

사용하지 않는 Package는 초기 단계에서 추가하지 않는다.

## 7. 코드 구조 원칙

- 게임 규칙은 `ReCamp.Core` 또는 Unity 비종속 계층에 유지
- MonoBehaviour는 입력, Scene, Animation, VFX, UI와 Adapter 역할 담당
- ScriptableObject는 설정 데이터와 Presentation 참조에 사용
- Damage, Reward, Camp Upgrade 등 핵심 규칙을 Animation Event나 Prefab에 중복 구현하지 않음
- Update 기반 할당과 반복 검색을 피하고 Pooling을 적용

## 8. 테스트 기준

### 자동 테스트

- Core 규칙 EditMode 테스트
- Scene 흐름 PlayMode 테스트
- 자원 획득과 결과 정산 테스트
- Save/Load와 데이터 마이그레이션 테스트
- Character Skill의 핵심 상태 테스트

### 수동 테스트

- Windows 1920×1080에서 전체 루프 완주
- Keyboard/Mouse와 Gamepad 조작 확인
- 쿼터뷰 가독성과 UI 겹침 확인
- 30분 반복 플레이 시 Memory 증가 확인
- Android 전환 후 입력·발열·성능 별도 확인

## 9. 승인 조건

이 문서는 다음 결과가 기록되면 Approved로 전환한다.

- Unity 프로젝트가 다른 PC에서 Clone 후 열림
- Gray Box 전투의 Profiler 기록 보유
- 루나 LOD1, 몬스터 3종, VFX가 함께 등장하는 전투 측정
- Windows 목표 FPS 달성 또는 병목과 수정 계획 기록
- Android 테스트 빌드가 실행되거나 후속 단계로 명시적으로 연기됨
