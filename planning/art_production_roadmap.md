# Re:Camp Art Production Roadmap

## 1. 목표

Re:Camp의 아트 제작은 다음 순서로 진행한다.

```text
5인 라인업 방향 통일
→ 제작 파이프라인 검증
→ 루나 2D Approved 제작 시트
→ 루나 3D 5~6등신 Blockout
→ Coplay/Aura Unity Import·Prefab 공동 검증
→ 루나 Character Proof
→ Portfolio Vertical Slice
→ 나머지 4명과 출시 콘텐츠 확장
```

핵심은 캐릭터 수를 줄이는 것이 아니라 **루나에서 품질·비용·기술을 먼저 검증한 뒤 다섯 캐릭터에 안전하게 확장하는 것**이다.

## 2. 현재 비주얼 기준

- 대표 일러스트: 2D 일반 등신 서브컬쳐
- 인게임 캐릭터: 3D 5~6등신 스타일라이즈드
- Rendering: URP 툰 셰이딩
- Camera: 고정 쿼터뷰
- 환경: 자연에 잠식된 부드러운 포스트 아포칼립스
- UI: 크림·라벤더·민트 기반, PC 우선 가독성
- 플랫폼: Windows 우선, Android 후속

## A0. 방향 승인

### 상태

Done — Direction Approved

### 완료 내용

- 루나·미유·코코·이리스·노아 이름·역할 통일
- 캐릭터별 대표 색상·무기·큰 실루엣 방향 설정
- 2D 일반 등신 + 3D 5~6등신 방향 확정
- 툰 셰이딩과 고정 쿼터뷰 확정
- 통합 캐릭터 라인업 생성

### 주의

현재 라인업은 최종 제작 시트가 아니다. 개별 얼굴·헤어·의상·Turnaround는 캐릭터별 `APPROVED` 시트에서 확정한다.

## A1. 제작 파이프라인

### 작업

- `ART-PIPE-0101` ComfyUI 반복 생성 Workflow
- `ART-PIPE-0102` 캐릭터 변수·Seed·Metadata
- `ART-PIPE-0103` Figma 제작 시트 Template
- `ART-PIPE-0104` Blender MCP 소품 Export
- `ART-PIPE-0105` Coplay FBX Import·Prefab 테스트
- `ART-PIPE-0106` Aura FBX Import·Prefab 검증
- `ART-PIPE-0107` 두 경로 비교와 역할 확정
- `ART-PIPE-0108` Git LFS·`art_source/` 구조

### Coplay / Aura 원칙

- 둘 다 프로젝트에 유지한다.
- 동일한 FBX와 Texture를 사용해 Import 결과를 비교한다.
- 한 Prefab을 동시에 수정하지 않는다.
- 작업마다 Primary Tool을 정하고 다른 도구는 검증·보완으로 사용한다.
- 최종 성공은 Unity Console, Prefab 구조, PlayMode로 판단한다.

### 완료 기준

```text
루나 기준 이미지 반복 생성
+ Figma 시트 Export
+ Blender FBX Export
+ Coplay Import·Prefab 성공
+ Aura Import·Prefab 검증 성공
+ 결과 차이와 역할 문서화
```

## A2. 루나 2D 제작 시트

### 산출물

- `ART-2D-1001` 전신 후보 3안
- `ART-2D-1002` 얼굴·헤어 기준
- `ART-2D-1003` 의상·실루엣 기준
- `ART-2D-1004` Front·Side·Back·Turnaround
- `ART-2D-1005` 표정 8종
- `ART-2D-1006` 에너지 단검·탐지 장치
- `ART-2D-1007` 컬러·재질표·3D Notes
- `ART-2D-1008` Approved 제작 시트

### 완료 기준

- 모든 시점에서 얼굴·헤어·후드·재킷·단검 구조가 일치
- 정찰형 근접 딜러 역할이 외형에서 읽힘
- 3D로 구현하기 어려운 장식이 정리됨
- 고정 쿼터뷰에서 강조할 실루엣 요소가 명시됨

## A3. 루나 3D Blockout과 쿼터뷰 Proof

### 작업

- `ART-3D-2001` 3D Spec 리뷰
- `ART-3D-2002` 공용 5~6등신 Base Mesh
- `ART-3D-2003` 공용 Humanoid Rig 초안
- `ART-3D-2004` 루나 Blockout
- `ART-3D-2005` Coplay Import·Prefab
- `ART-3D-2006` Aura Import·Prefab 검증
- `ART-3D-2007` Unity 실루엣 승인

### 검증

- 후드·단검·머리·상체가 기본 전투 거리에서 보임
- 무기가 몸에 완전히 가려지지 않음
- 5~6등신이 SD·치비로 보이지 않음
- 공용 Animation Retargeting이 가능함
- Material·Animator·Collider·Socket 구조가 재사용 가능함

## A4. 루나 Character Proof

### 작업

- 최종 모델·Retopology·UV
- Texture·Toon Material
- Rig·Weight·표정
- 공용 Idle·Run·Hit·Down
- 루나 Attack·Dash·Skill·Victory
- 루나 VFX·사운드
- 로비·전투 Prefab
- 사용자 매력 테스트

### 완료 기준

- 2D와 3D가 같은 캐릭터로 인식됨
- 쿼터뷰에서 매력과 역할이 전달됨
- 공격·대시·스킬에서 관통이 치명적이지 않음
- Windows 목표 성능을 유지함
- 나머지 캐릭터에 재사용할 공용 기반이 승인됨

## A5. Vertical Slice 환경·몬스터·소품

### 버려진 거리

- Color Key
- Modular Kit
- 도로·건물·차량·잔해·식생
- 전투 구역·보스 구역·귀환 지점

### 캠프

- 따뜻한 안전 공간 Color Key
- 발전기·작업대·식량 창고
- 강화 전후 외형과 VFX

### 적

- 근접 추적형
- 원거리 공격형
- 중장갑형
- 보스 1종

상세 기준은 `ENVIRONMENT_AND_VFX_SPEC.md`를 따른다.

## A6. UI·VFX·연출

### UI

- Design System
- Lobby·Exploration Ready
- Battle HUD
- Skill Select
- Result
- Camp Upgrade
- Pause·Settings

### VFX

- 루나 민트·청록 베기와 Scan Pulse
- 적 위험·피격·사망
- 자원 획득·귀환·캠프 성장
- High·Medium·Low 품질 단계

상세 카메라와 UI 기준은 `CAMERA_AND_UI_BASELINE.md`를 따른다.

## A7. 나머지 캐릭터 제작

### 시작 조건

루나 Character Proof와 Portfolio Vertical Slice Approved

### 순서

```text
미유
→ 코코
→ 이리스
→ 노아
```

각 캐릭터는 다음을 제작한다.

- 개별 2D Approved 제작 시트
- 얼굴·헤어·의상·무기
- 공용 Base Mesh·Rig·Shader 적용
- 대표 Idle·기본 공격·스킬 3종·승리
- 캐릭터별 VFX와 사운드
- 선택·로비·전투 Prefab

## A8. 출시 아트 확장

- 폐쇄된 연구소
- 추가 몬스터 3종과 보스 1종
- 캠프 시설 4종 이상
- 캐릭터 친밀도·대화·로비 상호작용
- Android 품질 단계
- Store Key Art와 Trailer
- 전체 라이선스·AI Metadata 검토

## 3. 승인 Gate

```text
Direction Approved
→ 2D Production Sheet Approved
→ 3D Blockout Approved
→ Character Proof Approved
→ Vertical Slice Approved
→ Full Production
```

Gate를 건너뛰어 고비용 최종 제작으로 이동하지 않는다.
