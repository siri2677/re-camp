# Re:Camp Integrated Roadmap

## 1. 프로젝트 목표

Re:Camp는 **매력적인 3D 스타일라이즈드 캐릭터로 폐허를 탐험하고, 자원을 회수해 캠프를 성장시키는 고정 쿼터뷰 로그라이트 RPG**다.

개발은 두 단계로 구분한다.

```text
Portfolio Vertical Slice
→ 루나 1명과 한 개 스테이지의 완결된 플레이

Full Release
→ 캐릭터 5명과 두 개 스테이지로 확장
```

## 2. 현재 기준

| 항목 | 기준 |
|---|---|
| 1차 플랫폼 | Windows PC |
| 2차 플랫폼 | Android |
| Unity | Unity 6.3 LTS / URP / Input System |
| 대표 일러스트 | 2D 일반 등신 |
| 인게임 캐릭터 | 3D 5~6등신 스타일라이즈드 |
| 렌더링 | 툰 셰이딩 |
| 카메라 | 고정 쿼터뷰 |
| 현재 캐릭터 상태 | 5인 라인업 Direction Approved, 개별 제작 시트 미승인 |

상세 단일 기준은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`를 따른다.

## 3. 핵심 우선순위

1. 한 판의 탐험·전투·귀환·성장이 끝까지 작동하는가
2. 루나가 2D와 3D에서 같은 매력적인 캐릭터로 보이는가
3. 고정 쿼터뷰에서 캐릭터·적·위험·자원이 읽히는가
4. 공용 Rig·Shader·Prefab 파이프라인이 반복 가능한가
5. 작은 범위라도 외부 사용자가 플레이할 수 있는가
6. Vertical Slice 승인 후 캐릭터와 콘텐츠를 확장할 수 있는가

---

## M0. 프로젝트 기준 통합

### 상태

Review — Draft PR 병합 전

### 포함 작업

- 플랫폼을 Windows 우선, Android 후속으로 통일
- Unity 6.3 LTS·URP·Input System 기준 명시
- 2D 일반 등신 + 3D 5~6등신 + 고정 쿼터뷰 방향 통일
- Coplay와 Aura 병행 사용 확정
- Portfolio Vertical Slice와 Full Release 범위 분리
- 중복 작업 ID를 분야별 Prefix로 통합
- 카메라·UI·환경·VFX·기술·Scope 규격 추가

### 완료 기준

- `CURRENT_PROJECT_BASELINE.md`와 모든 계획 문서가 충돌하지 않음
- Draft PR이 리뷰되고 병합됨
- 이후 신규 작업이 새 ID 규칙을 사용함

---

## M1. Unity 기반과 아트 파이프라인

### 목표

Unity 프로젝트와 아트 제작 도구를 동시에 준비해 Gray Box와 루나 제작을 시작할 수 있게 한다.

### Unity 기반

- `DEV-0101` Unity 6.3 LTS URP 프로젝트 생성
- `DEV-0102` Visible Meta Files·Force Text
- `DEV-0103` `Assets/_ReCamp` 구조와 기본 Scene
- `DEV-0104` Windows Build Target·해상도·Quality
- `DEV-0105` Input System PC Control Scheme
- `DEV-0106` 고정 쿼터뷰 Camera Preset 3종
- `DEV-0107` ReCamp.Core Unity 호환성 검토
- `DEV-0108` Adapter·Assembly 구조 확정
- `DEV-0109` EditMode·PlayMode 테스트 기반
- `DEV-0110` CI에서 Core와 Unity 테스트

### 아트 파이프라인

- `ART-PIPE-0101` ComfyUI 반복 생성 Workflow
- `ART-PIPE-0102` 캐릭터 변수·Seed·Metadata
- `ART-PIPE-0103` Figma 제작 시트 Template
- `ART-PIPE-0104` Blender MCP 소품 Export
- `ART-PIPE-0105` Coplay FBX Import·Prefab 테스트
- `ART-PIPE-0106` Aura FBX Import·Prefab 검증 테스트
- `ART-PIPE-0107` Git LFS와 `art_source/` 구조
- `ART-PIPE-0108` 승인·라이선스 Metadata Template

### 완료 기준

```text
Unity 프로젝트가 Clone 후 실행됨
+ Camera Gray Box가 존재함
+ ReCamp.Core 통합 방식이 결정됨
+ 루나 이미지를 반복 생성할 수 있음
+ Blender 테스트 FBX를 Coplay와 Aura 경로로 Import·Prefab 구성함
```

---

## M2. 완주 가능한 전투 Gray Box

### 목표

최종 아트 없이 핵심 게임 루프를 처음부터 끝까지 완성한다.

### 작업

- `GAME-0201` Bootstrap·Title·Lobby·Battle·Result Scene
- `GAME-0202` SceneLoader와 Game State
- `GAME-0203` Player 이동과 Camera 추적
- `GAME-0204` 기본 공격·Hitbox·Damageable
- `GAME-0205` Enemy 추적·스폰·웨이브
- `GAME-0206` 사망·보상 1회 지급
- `GAME-0207` 자원 드롭·획득
- `GAME-0208` 귀환·사망·시간 만료
- `GAME-0209` 결과 정산
- `GAME-0210` 캠프 시설 강화
- `GAME-0211` 로컬 저장·불러오기
- `GAME-0212` Scene 흐름과 정산 자동 테스트

### 캐릭터 역할 검증

루나를 우선 완성하고 나머지 네 명은 저비용 임시 프로토타입으로 역할만 확인한다.

- `CHR-PROT-0301` 공용 CharacterController·Stats
- `CHR-PROT-0310` 루나 근접 공격·대시·스캔
- `CHR-PROT-0320` 미유 드론 사격 최소 프로토타입
- `CHR-PROT-0330` 코코 회복·보호막 최소 프로토타입
- `CHR-PROT-0340` 이리스 차지 사격 최소 프로토타입
- `CHR-PROT-0350` 노아 가드·반격 최소 프로토타입
- `CHR-PROT-0360` 역할 중복 검토

### 완료 기준

- Capsule 캐릭터로 한 판을 완주함
- 전투·자원·결과·캠프·저장이 연결됨
- 루나의 기본 조작이 재미 검증 가능한 수준임
- 나머지 네 캐릭터의 역할 중복 여부를 기록함

### Scope Gate

Gray Box가 완주되지 않으면 나머지 네 캐릭터 프로토타입과 보스·스킬 확장을 중단하고 루나 핵심 루프에 집중한다.

---

## M3. 루나 2D 제작 시트와 3D Blockout

### 목표

루나를 최종 모델링할 수 있는 2D 기준과 Unity에서 검증 가능한 3D Blockout을 확보한다.

### 2D

- `ART-2D-1001` 루나 전신 후보 3안
- `ART-2D-1002` 얼굴·헤어 승인
- `ART-2D-1003` 의상·실루엣 승인
- `ART-2D-1004` Front·Side·Back·Turnaround
- `ART-2D-1005` 표정 8종
- `ART-2D-1006` 에너지 단검·탐지 장치
- `ART-2D-1007` 컬러·재질표와 3D Notes
- `ART-2D-1008` 루나 제작 시트 Approved

### 3D Proof

- `ART-3D-2001` 3D Spec 리뷰
- `ART-3D-2002` 공용 5~6등신 Base Mesh
- `ART-3D-2003` 공용 Humanoid Rig 초안
- `ART-3D-2004` 루나 저해상도 Blockout
- `ART-3D-2005` Coplay Import·Prefab 구성
- `ART-3D-2006` Aura Import·Prefab 검증
- `ART-3D-2007` 고정 쿼터뷰 실루엣 테스트

### 완료 기준

- 루나의 얼굴·후드·단검이 쿼터뷰에서 식별됨
- Coplay와 Aura 경로의 Import 결과 차이가 기록됨
- Unity Humanoid Avatar가 생성됨
- 최종 모델링 전에 수정할 비율·장식·무기 크기가 확정됨

---

## M4. 루나 Character Proof

### 목표

루나 1명을 출시 방향에 가까운 품질로 완성해 캐릭터 제작 비용과 품질 기준을 확정한다.

### 작업

- `ART-3D-2010` 루나 최종 모델·Retopology·UV
- `ART-3D-2011` Texture·Material·툰 셰이더
- `ART-3D-2012` Rig·Weight·표정 BlendShape
- `ART-3D-2013` 공용 Idle·Run·Hit·Down
- `ART-3D-2014` 루나 Attack·Dash·Skill·Victory
- `ART-VFX-5001` 공통 VFX 언어
- `ART-VFX-5002` 루나 공격·스킬 VFX
- `ART-UI-4002` 로비·캐릭터 표시
- `TEST-4001` 관통·가독성·성능 테스트
- `TEST-4002` 사용자 캐릭터 매력 테스트

### 완료 기준

- 2D와 3D가 같은 캐릭터로 인식됨
- 전투 기본 거리에서 후드·단검·공격이 읽힘
- 애니메이션과 VFX가 Gameplay Frame과 일치함
- 공용 구조를 다른 캐릭터 Blockout에 재사용 가능함

### Scope Gate

루나가 승인되기 전 나머지 네 캐릭터의 최종 제작 시트와 최종 모델을 대량 제작하지 않는다.

---

## M5. Portfolio Vertical Slice

### 목표

루나와 버려진 거리 한 구간을 외부 사용자가 플레이할 수 있는 완결된 포트폴리오 데모로 만든다.

### 콘텐츠

- `ART-ENV-3001` 버려진 거리 Color Key
- `ART-ENV-3002` Modular Kit과 최종 환경
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
- `ART-VFX-5003` 적 위험·피격·사망 VFX
- `ART-VFX-5004` 자원·귀환·성장 VFX
- `VS-6001` 전체 Scene과 Prefab 통합
- `VS-6002` 저장·튜토리얼·설정
- `VS-6003` 사운드·음악 1차
- `VS-6004` 성능·메모리·로딩 최적화
- `VS-6005` 외부 플레이 테스트

### 완료 기준

- 3~5분 핵심 루프 완주
- 루나의 매력·전투·귀환·캠프 성장 목적 전달
- Windows 목표 성능 유지
- 승인되지 않은 WIP 자산 미포함
- 영상·스크린샷·README로 결과 설명 가능

---

## M6. 나머지 캐릭터와 Full Release 콘텐츠

### 시작 조건

M5 Vertical Slice Approved

### 작업

- 미유·코코·이리스·노아 개별 2D Approved 제작 시트
- 공용 Base Mesh·Rig·Shader를 이용한 3D 제작
- 각 캐릭터 고유 공격·스킬·VFX
- 폐쇄된 연구소
- 추가 일반 몬스터 3종과 보스 1종
- 캠프 시설 4종 이상
- 캐릭터 해금·친밀도·대화·로비 상호작용
- Android 입력·UI·성능 품질 단계

### 완료 기준

캐릭터 5명, 스테이지 2개, 일반 몬스터 6종, 보스 2종의 전체 성장 루프를 처음부터 끝까지 플레이할 수 있다.

---

## M7. Release Candidate

### 작업

- 전체 회귀 테스트
- 저장 데이터 마이그레이션과 손상 방지
- Windows·Android 성능 테스트
- CPU·GPU·Memory·GC·Draw Call 최적화
- 해상도·입력·키 설정
- Rig·관통·Animation 폴리시
- 라이선스·AI 생성 Metadata 검토
- 스토어 페이지·스크린샷·트레일러
- 체험판 또는 외부 베타

### 완료 기준

```text
치명적 진행 불가 버그 없음
저장 데이터 안정성 확보
목표 성능 유지
WIP 자산 빌드 미포함
캐릭터 5명의 역할과 매력 구분
```

## 상세 문서

- 현재 작업: `planning/sprint_backlog.md`
- 범위 통제: `planning/SCOPE_AND_RISK_RULES.md`
- 아트 단계: `planning/art_production_roadmap.md`
- 아트 세부 작업: `planning/art_production_backlog.md`
