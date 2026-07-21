# Re:Camp Integrated Roadmap

## 1. 최종 목표

Re:Camp의 최종 목표는 **Steam Windows 프리미엄 게임 정식 출시**다.

```text
Gray Box MVP
→ 루나 Character Proof
→ Portfolio Vertical Slice
→ itch.io 외부 테스트
→ Steam Store Page·무료 Demo
→ Full Release 콘텐츠 제작
→ Steam Windows 정식 출시
→ Epic·Android 후속 확장 판단
```

Portfolio Vertical Slice는 최종 제품이 아니라 출시 가능성을 검증하는 중간 Gate다.

## 2. 현재 기준

| 항목 | 기준 |
|---|---|
| 1차 개발 플랫폼 | Windows PC |
| 1차 상용 출시 | Steam Windows |
| 테스트 배포 | itch.io 제한 공개·무료 Demo |
| 2차 PC Store | Epic Games Store |
| 2차 플랫폼 | Google Play Android |
| 판매 방식 | 프리미엄 1회 구매 |
| 기준 정가 | 11,000원 |
| Unity | Unity 6.3 LTS / URP / Input System |
| 대표 일러스트 | 2D 일반 등신 |
| 인게임 캐릭터 | 3D 5~6등신 스타일라이즈드 |
| 카메라 | 고정 쿼터뷰 |
| 캐릭터 상태 | 5인 라인업 Direction Approved |
| Unity 자동화 | Coplay MCP |
| 검증 보완 | Editor Script·Preset·Inspector·Console·PlayMode·Profiler |

세부 사업 기준은 `docs/00_project/BUSINESS_AND_PLATFORM_STRATEGY.md`를 따른다.

## 3. 핵심 우선순위

1. 한 판의 탐험·전투·귀환·성장이 끝까지 작동하는가
2. 루나가 2D와 3D에서 같은 매력적인 캐릭터로 보이는가
3. 고정 쿼터뷰에서 캐릭터·적·위험·자원이 읽히는가
4. 탐험 여러 회를 연결해 PC에서 20~40분 세션이 형성되는가
5. 별도 유료 제작 도구 없이 반복 가능한가
6. Steam Demo와 본편으로 확장 가능한가
7. 예상 판매량이 제작비 손익분기보다 높은가

---

## M0. 기준·플랫폼·사업 전략 통합

### 상태

Review — Draft PR 병합 전

### 작업

- Windows 개발과 Steam 상용 출시를 구분해 명시
- itch.io Test, Epic 후속 Store, Android Port 역할 정의
- 프리미엄 1회 구매와 무료 Demo 확정
- 기준 정가 11,000원과 손익분기 모델 작성
- Unity 6.3 LTS·URP·Input System 통일
- 2D 일반 등신 + 3D 5~6등신 + 고정 쿼터뷰 통일
- 유료 Aura 의존 제거
- Coplay + Editor Tool + 수동 QA 통일
- 중복 작업 ID 정리

### 완료 기준

- Baseline·Business Strategy·Roadmap·Backlog 충돌 없음
- Draft PR 리뷰·병합
- 신규 작업이 Steam 출시 기준을 사용

---

## M1. Unity 기반과 제작 파이프라인

### Unity

- `DEV-0101` Unity 6.3 LTS URP 프로젝트
- `DEV-0102` Visible Meta Files·Force Text
- `DEV-0103` `Assets/_ReCamp` 구조와 기본 Scene
- `DEV-0104` Windows Build Target·해상도·Quality
- `DEV-0105` Input System PC Control Scheme
- `DEV-0106` 고정 쿼터뷰 Camera Preset 3종
- `DEV-0107` ReCamp.Core 호환성 검토
- `DEV-0108` Adapter·Assembly 구조
- `DEV-0109` EditMode·PlayMode 테스트
- `DEV-0110` Core·Unity CI
- `DEV-0111` Build Version·Channel 구조
- `DEV-0112` Save Path·Migration 기반

### 아트 파이프라인

- `ART-PIPE-0101` ComfyUI 반복 생성 Workflow
- `ART-PIPE-0102` 캐릭터 변수·Seed·Metadata
- `ART-PIPE-0103` Figma 제작 시트 Template
- `ART-PIPE-0104` Blender 소품 FBX Export
- `ART-PIPE-0105` Coplay Import·Prefab Proof
- `ART-PIPE-0106` Import Preset·Validation Editor Tool
- `ART-PIPE-0107` 수동 Unity QA Report
- `ART-PIPE-0108` Git LFS·`art_source/` 구조

### 완료 기준

```text
Unity Clone 후 실행
+ Camera Gray Box
+ Core Adapter
+ ComfyUI 반복 생성
+ Figma Template
+ Blender FBX
+ Coplay Import·Prefab
+ Editor Validation과 수동 QA
```

---

## M2. 완주 가능한 전투 Gray Box

### 작업

- `GAME-0201` Bootstrap·Title·Lobby·Battle·Result Scene
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

### 역할 프로토타입

- `CHR-PROT-0301` 공용 CharacterController·Stats
- `CHR-PROT-0310` 루나 근접 공격·대시·스캔
- `CHR-PROT-0320` 미유 드론 최소 테스트
- `CHR-PROT-0330` 코코 회복·보호막 최소 테스트
- `CHR-PROT-0340` 이리스 차지 사격 최소 테스트
- `CHR-PROT-0350` 노아 가드·반격 최소 테스트
- `CHR-PROT-0360` 역할 중복 검토

### 완료 기준

- Capsule 캐릭터로 탐험·귀환·캠프 강화 완주
- Save 후 재탐험 가능
- 루나 조작이 재미 검증 가능한 수준

### Scope Gate

Gray Box가 완주되지 않으면 루나 외 캐릭터와 보스·확장 기능을 중단한다.

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
- `ART-3D-2006` Validation Tool·수동 QA
- `ART-3D-2007` 쿼터뷰 실루엣 승인

### 완료 기준

- 후드·단검·상체가 기본 Camera에서 식별
- Humanoid Avatar 생성
- Import·Prefab 규칙 재현 가능
- Console Error·Missing Reference 없음

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
- `ART-UI-4002` Lobby Character View
- `TEST-4001` 관통·가독성·성능
- `TEST-4002` 캐릭터 매력 사용자 테스트

### 완료 기준

- 2D와 3D가 같은 캐릭터로 인식
- 기본 거리에서 후드·단검·공격 식별
- Windows 60 FPS 목표 검증
- 공용 구조를 다른 캐릭터에 재사용 가능

---

## M5. Portfolio Vertical Slice

### 콘텐츠

- `ART-ENV-3001` 버려진 거리 Color Key
- `ART-ENV-3002` Modular Kit·최종 환경
- `ART-ENV-3003` 캠프 Color Key
- `ART-ENV-3004` 캠프 시설 3종
- `ART-ENV-3005` 일반 몬스터 3종
- `ART-ENV-3006` 보스 1종
- `ART-ENV-3007` 자원·상자·소품

### UI·VFX·통합

- `ART-UI-4001` UI Design System
- `ART-UI-4003` Battle HUD
- `ART-UI-4004` Skill Select
- `ART-UI-4005` Result
- `ART-UI-4006` Camp Upgrade
- `ART-UI-4007` Pause·Settings
- `ART-VFX-5003` 적 위험·피격·사망
- `ART-VFX-5004` 자원·귀환·성장
- `VS-6001` Scene·Prefab 통합
- `VS-6002` 저장·튜토리얼·설정
- `VS-6003` 사운드·음악
- `VS-6004` 성능·메모리·로딩
- `VS-6005` 외부 플레이 테스트
- `VS-6006` Portfolio Screenshot·Video

### 완료 기준

- 3~5분 핵심 루프 완주
- 재탐험 의향 확인
- Windows 성능 유지
- Store Page에 사용할 수 있는 비주얼 품질

---

## M6. itch.io 외부 테스트와 Steam Demo

### 외부 테스트

- `TEST-6101` itch.io 제한 공개 Build
- `TEST-6102` 설치·첫 실행·입력·해상도 Test
- `TEST-6103` Session Length·재플레이 의향 조사
- `TEST-6104` Crash·Save·진행 불가 버그 수집

### Steam 준비

- `REL-6101` Steam Direct 등록
- `REL-6102` Store Page 초안
- `REL-6103` Capsule·Screenshot·Description
- `REL-6104` Trailer 1차
- `REL-6105` 무료 Demo Build
- `REL-6106` Demo 종료·Wishlist Flow
- `REL-6107` Controller·Settings·Save 검증
- `REL-6108` 가격·손익분기 재검토

### 완료 기준

- 외부 사용자가 별도 설명 없이 설치·실행
- 무료 Demo 완주 가능
- Store Page Asset 품질 확보
- Full Release 범위와 가격 설명 가능
- 현금비용과 예상 판매량 갱신

---

## M7. Steam Full Release 콘텐츠

### 캐릭터

- 미유·코코·이리스·노아 Approved 제작 시트
- 공용 Base Mesh·Rig·Shader 기반 최종 3D
- 각 캐릭터 고유 공격·Skill·Animation·VFX

### 콘텐츠

- 스테이지 2개 이상 또는 동등한 반복 플레이 분량
- 일반 몬스터 6종 이상
- 보스 2종 이상
- 캠프 시설 4종 이상
- 캐릭터 해금·친밀도·대화
- 난이도·도전 목표·업적
- 20~40분 권장 세션 구성

### 제품 완성도

- Save Migration
- Settings·Controller·Resolution
- Tutorial·Accessibility
- Achievement·Cloud Save 사용 여부 확정
- Localization 범위
- Patch·Support 구조

### Scope Gate

가격 11,000원과 콘텐츠 분량이 맞지 않으면 가격 인상보다 콘텐츠·반복 플레이 구조를 먼저 보완한다.

---

## M8. Steam Release Candidate와 출시

### 작업

- `REL-8001` 전체 회귀 테스트
- `REL-8002` Save Migration·손상 복구
- `REL-8003` Windows 성능·장시간 테스트
- `REL-8004` CPU·GPU·Memory·GC 최적화
- `REL-8005` Controller·해상도·접근성
- `REL-8006` Rig·관통·Animation 폴리시
- `REL-8007` WIP Asset 제거
- `REL-8008` License·AI Metadata
- `REL-8009` Store Page·Trailer·Localization
- `REL-8010` Price·Launch Discount 확정
- `REL-8011` Release Candidate 승인
- `REL-8012` Steam Windows 정식 출시
- `REL-8013` 출시 30일 지표 분석

### 사업 기준

```text
보수적 1카피 순수익: 6,000원
현금비용 1,000만원 손익분기: 약 1,667카피
Full Cost 4,600만원 예시: 약 7,667카피
Full Cost 목표: 8,000카피
안전한 성공 목표: 10,000카피 이상
```

### 완료 기준

- 치명적 진행 불가 버그 없음
- Save 안정성 확보
- Windows 목표 성능 유지
- 본편 콘텐츠 완결
- 출시 후 Patch·Support 가능

---

## M9. 후속 Store와 플랫폼

### Epic Games Store

Steam Build 안정화 후 다음을 검토한다.

- Store Page·Build·Achievement 추가 운영비
- 게임당 제출비와 회수 조건
- 동일 Windows Build 재사용 가능성
- 예상 추가 매출 대비 QA 비용

### Google Play Android

다음 Gate를 통과해야 착수한다.

- Steam 출시 지표와 사용자 피드백 확보
- Touch UI·Auto Aim 정책
- 기기별 성능·발열·메모리
- 유료 앱 또는 무료 Demo + 1회 Unlock 모델
- 12명·14일 Closed Test 계획
- 출시 시점 Google Play 수수료·정책 재확인

모바일 출시를 위해 가챠·광고·라이브 운영을 추가하지 않는다.

### iOS

Steam과 Android 성과가 확인된 뒤 별도 투자 판단한다.
