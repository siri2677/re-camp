# Re:Camp Integrated Roadmap

## 1. 최종 목표

Re:Camp의 1차 제품 목표는 **Google Play Android 정식 출시**다.

```text
Windows Editor Gray Box
→ Android Touch Prototype
→ 루나 Character Proof
→ Android Portfolio Vertical Slice
→ APK 외부 테스트
→ Google Play Closed Test
→ Android Full Release
→ Windows·Steam·iOS 후속 판단
```

수익은 핵심 성공 기준이 아니다. 완성·배포, 모바일 적합성, 캐릭터 매력, 포트폴리오 가치와 유지 가능한 Scope를 우선한다.

## 2. 현재 기준

| 항목 | 기준 |
|---|---|
| 1차 제품 플랫폼 | Google Play Android |
| 화면 | Landscape |
| 개발·디버그 | Windows PC |
| 외부 테스트 | APK 제한 배포·Google Play Closed Test |
| PC 공개 빌드 | itch.io·포트폴리오 Demo |
| 후속 플랫폼 | Steam Windows·iOS |
| Unity | Unity 6.3 LTS / URP / Input System |
| 캐릭터 | 2D 일반 등신 + 3D 5~6등신 |
| 카메라 | 고정 쿼터뷰 |
| 자동화 | Coplay MCP + Editor Validation Tool |

## 3. 핵심 우선순위

1. Android Touch UI로 한 판을 끝까지 완주할 수 있는가
2. 3~5분 탐험·귀환 구조가 모바일에서 자연스러운가
3. 루나가 작은 화면에서도 매력적으로 보이는가
4. 기준 기기에서 성능·발열·메모리가 안정적인가
5. 혼자 제작·업데이트 가능한 Scope인가
6. 실제 APK·Google Play로 배포 가능한가
7. 포트폴리오에서 전체 제작 과정을 설명할 수 있는가

---

## M0. 기준·플랫폼 통합

### 상태

Review — Draft PR 병합 전

### 작업

- Android Landscape를 1차 제품 목표로 통일
- Windows를 개발·QA·포트폴리오 기준으로 분리
- 수익을 플랫폼 결정 기준에서 비용 참고값으로 하향
- Steam을 Android 이후 선택적 PC 제품화로 변경
- Unity 6.3 LTS·URP·Input System 통일
- 2D 일반 등신 + 3D 5~6등신 + 고정 쿼터뷰 통일
- Coplay + Editor Tool + 수동 실기기 QA 통일

### 완료 기준

- Baseline·Strategy·Roadmap·Backlog 충돌 없음
- 신규 작업이 Android 출시 기준을 사용
- Draft PR 리뷰·병합

---

## M1. Windows 개발 기반과 Android Build 기반

### 작업

- `DEV-0101` Unity 6.3 LTS URP 프로젝트
- `DEV-0102` Visible Meta Files·Force Text
- `DEV-0103` `Assets/_ReCamp` 구조와 기본 Scene
- `DEV-0104` Android Build Support·SDK·Target
- `DEV-0105` Landscape·Orientation·Safe Area
- `DEV-0106` Touch Input Action과 PC Debug Adapter
- `DEV-0107` Camera Preset 3종
- `DEV-0108` ReCamp.Core 호환성과 Adapter 구조
- `DEV-0109` EditMode·PlayMode Test
- `DEV-0110` Core·Unity CI
- `DEV-0111` Low·Medium·High URP Profile
- `DEV-0112` 첫 Android APK Build

### 아트 파이프라인

- `ART-PIPE-0101` ComfyUI 반복 생성 Workflow
- `ART-PIPE-0102` 캐릭터 변수·Seed·Metadata
- `ART-PIPE-0103` Figma 제작 시트·모바일 UI Template
- `ART-PIPE-0104` Blender 소품 FBX Export
- `ART-PIPE-0105` Coplay Import·Prefab Proof
- `ART-PIPE-0106` Import Preset·Validation Editor Tool
- `ART-PIPE-0107` Android 실기기 QA Report
- `ART-PIPE-0108` Git LFS·`art_source/` 구조

### 완료 기준

```text
Unity Clone 후 실행
+ Android Build 성공
+ Landscape·Safe Area
+ Touch Input
+ Camera Gray Box
+ Core Adapter
+ Blender FBX·Coplay Import
+ Validation Tool·실기기 QA
```

---

## M2. 완주 가능한 Gray Box와 Touch Prototype

### 게임 루프

- `GAME-0201` Bootstrap·Title·Lobby·Battle·Result
- `GAME-0202` SceneLoader·Game State
- `GAME-0203` Player 이동·Camera 추적
- `GAME-0204` 기본 공격·Hitbox·Damageable
- `GAME-0205` Enemy 추적·Spawner·Wave
- `GAME-0206` 사망·보상 1회 지급
- `GAME-0207` 자원 드롭·획득
- `GAME-0208` 귀환·사망·시간 만료
- `GAME-0209` 결과 정산
- `GAME-0210` 캠프 시설 강화
- `GAME-0211` 로컬 저장·불러오기
- `GAME-0212` Scene 흐름·정산 테스트

### 모바일 입력

- `MOB-0251` 가상 조이스틱
- `MOB-0252` 공격·대시·스킬 Touch Button
- `MOB-0253` Auto Aim·대상 보정
- `MOB-0254` Android Back·Pause
- `MOB-0255` Background·Resume
- `MOB-0256` Safe Area·화면비
- `MOB-0257` 첫 실기기 성능·발열 측정

### 완료 기준

- Android Touch로 탐험·귀환·캠프 강화 완주
- 저장 후 재탐험 가능
- UI가 전투 중심부를 과도하게 가리지 않음
- 15분 반복 플레이 성능·발열 기록

### Scope Gate

Touch Prototype이 완주되지 않으면 나머지 캐릭터·보스·추가 UI를 중단하고 루나 핵심 루프에 집중한다.

---

## M3. 루나 2D 제작 시트와 3D Blockout

### 2D

- `ART-2D-1001` 전신 후보 3안
- `ART-2D-1002` 얼굴·헤어 승인
- `ART-2D-1003` 의상·실루엣 승인
- `ART-2D-1004` Front·Side·Back·Turnaround
- `ART-2D-1005` 표정 8종
- `ART-2D-1006` 단검·탐지 장치
- `ART-2D-1007` 컬러·재질표·3D Notes
- `ART-2D-1008` 제작 시트 Approved

### 3D Proof

- `ART-3D-2001` 3D Spec 리뷰
- `ART-3D-2002` 공용 5~6등신 Base Mesh
- `ART-3D-2003` 공용 Humanoid Rig
- `ART-3D-2004` 루나 Blockout
- `ART-3D-2005` Coplay Import·Prefab
- `ART-3D-2006` Validation Tool·Android QA
- `ART-3D-2007` 모바일 쿼터뷰 실루엣 승인

### 완료 기준

- Android 기본 화면에서 후드·단검·상체 식별
- Humanoid Avatar·Prefab 규칙 재현 가능
- LOD1 전투와 Material이 기준 기기에서 동작

---

## M4. 루나 Character Proof

### 작업

- `ART-3D-2010` 최종 모델·Retopology·UV
- `ART-3D-2011` Texture·Material·Toon Shader
- `ART-3D-2012` Rig·Weight·표정
- `ART-3D-2013` 공용 Animation
- `ART-3D-2014` 루나 고유 Animation
- `ART-VFX-5001` 공통 VFX 언어
- `ART-VFX-5002` 루나 공격·스킬 VFX
- `TEST-4001` 관통·모바일 가독성·성능
- `TEST-4002` 캐릭터 매력 사용자 테스트

### 완료 기준

- 2D와 3D가 같은 캐릭터로 인식
- 모바일 화면에서 후드·단검·공격 식별
- 기준 기기 30 FPS 목표 검증
- 다른 캐릭터에 재사용 가능한 공용 구조 승인

---

## M5. Android Portfolio Vertical Slice

### 콘텐츠

- 버려진 거리 1개
- 캠프 시설 3종
- 일반 몬스터 3종
- 보스 1종
- 자원·상자·소품

### UI·VFX·통합

- Mobile UI Design System
- Lobby·Battle HUD·Skill Select·Result·Camp Upgrade
- Touch Tutorial·Settings
- 적 위험·피격·사망 VFX
- 자원·귀환·성장 VFX
- Scene·Prefab·Save 통합
- 성능·Memory·발열 최적화
- 외부 플레이 테스트
- Portfolio Screenshot·Video

### 완료 기준

- APK에서 3~5분 핵심 루프 완주
- Touch 조작 이해와 재탐험 의향 확인
- Low·Mid·High 기기 테스트 기록
- Safe Area·Back·Background/Resume 검증
- 포트폴리오 영상과 설명 자료 제작 가능

---

## M6. APK 외부 테스트와 Google Play Closed Test

### 작업

- 제한 공개 APK 배포
- 설치·업데이트·삭제·재설치
- 첫 실행·Tutorial·권한·개인정보 확인
- 화면비·기기 호환성
- Save Migration·Crash 수집
- Closed Test 참여자·피드백 관리
- Store Listing 초안

### 완료 기준

- 치명적 진행 불가·저장 손상 문제 없음
- 목표 기기 범위와 최소 품질 Profile 정의
- 외부 사용자가 별도 설명 없이 핵심 루프 완주
- Full Release Scope와 유지보수 계획 승인

---

## M7. Android Full Release

### 목표 범위

- 캐릭터 5명
- 스테이지 2개 이상 또는 동등한 반복 분량
- 일반 몬스터 6종 이상
- 보스 2종 이상
- 캠프 시설 4종 이상
- 캐릭터 해금·친밀도·대화
- 난이도·도전·반복 목표
- Android 설정·저장·업데이트 안정성

### 배포

- 배포 형태 결정: 무료·저가 유료·1회 해금
- Store Listing·아이콘·Screenshot·Trailer
- 콘텐츠 등급·개인정보·지원 연락처
- Release Candidate 회귀 테스트
- Google Play 정식 공개

### 완료 기준

- 목표 기기에서 안정적 실행
- Closed Test 치명적 문제 해결
- 장기 성장과 캐릭터 콘텐츠 완결
- 출시 후 Patch·지원 범위가 감당 가능

---

## M8. 후속 플랫폼 판단

Android 출시·안정화 후 다음을 개별 평가한다.

- Windows itch.io Demo
- Steam PC 제품화
- iOS Build·TestFlight

후속 플랫폼 때문에 Android 업데이트와 프로젝트 완성도를 훼손하지 않는다.
