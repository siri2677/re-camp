# Re:Camp Art Production Roadmap

## 1. 목표

```text
5인 라인업 방향 통일
→ 제작 파이프라인 검증
→ 루나 2D Approved 제작 시트
→ 루나 3D 5~6등신 Blockout
→ Coplay Unity Import·Prefab 검증
→ Editor Script·Preset·수동 Unity QA
→ 루나 Character Proof
→ Portfolio Vertical Slice
→ 나머지 4명과 출시 콘텐츠 확장
```

핵심은 루나에서 품질·비용·기술을 먼저 검증한 뒤 다섯 캐릭터에 확장하는 것이다.

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
- 캐릭터별 대표 색상·무기·큰 실루엣 설정
- 2D 일반 등신 + 3D 5~6등신 방향 확정
- 툰 셰이딩과 고정 쿼터뷰 확정
- 통합 캐릭터 라인업 생성

현재 라인업은 최종 제작 시트가 아니다. 개별 얼굴·헤어·의상·Turnaround는 캐릭터별 `APPROVED` 시트에서 확정한다.

## A1. 제작 파이프라인

### 작업

- `ART-PIPE-0101` ComfyUI 반복 생성 Workflow
- `ART-PIPE-0102` 캐릭터 변수·Seed·Metadata
- `ART-PIPE-0103` Figma 제작 시트 Template
- `ART-PIPE-0104` Blender MCP 소품 Export
- `ART-PIPE-0105` Coplay FBX Import·Prefab 테스트
- `ART-PIPE-0106` Unity Import Preset·Validation Editor Tool
- `ART-PIPE-0107` Inspector·Console·Prefab Diff·PlayMode QA
- `ART-PIPE-0108` Git LFS·`art_source/` 구조

### 비용 원칙

- 별도 월 구독이 필요한 도구는 필수 파이프라인에서 제외한다.
- Aura AI는 체험 이후 유료 구조이므로 사용하지 않는다.
- Coplay가 처리하지 못하는 작업은 Editor Script·Preset·수동 Unity 작업으로 보완한다.

### 완료 기준

```text
루나 기준 이미지 반복 생성
+ Figma 시트 Export
+ Blender FBX Export
+ Coplay Import·Prefab 성공
+ Validation Tool 통과
+ 수동 Inspector·Console·PlayMode 검증
```

## A2. 루나 2D 제작 시트

- `ART-2D-1001` 전신 후보 3안
- `ART-2D-1002` 얼굴·헤어 기준
- `ART-2D-1003` 의상·실루엣 기준
- `ART-2D-1004` Front·Side·Back·Turnaround
- `ART-2D-1005` 표정 8종
- `ART-2D-1006` 에너지 단검·탐지 장치
- `ART-2D-1007` 컬러·재질표·3D Notes
- `ART-2D-1008` Approved 제작 시트

### 완료 기준

- 모든 시점에서 얼굴·헤어·후드·재킷·단검 구조 일치
- 정찰형 근접 딜러 역할이 외형에서 읽힘
- 3D 구현이 어려운 장식 정리
- 쿼터뷰에서 강조할 실루엣 요소 명시

## A3. 루나 3D Blockout과 쿼터뷰 Proof

- `ART-3D-2001` 3D Spec 리뷰
- `ART-3D-2002` 공용 5~6등신 Base Mesh
- `ART-3D-2003` 공용 Humanoid Rig 초안
- `ART-3D-2004` 루나 Blockout
- `ART-3D-2005` Coplay Import·Prefab
- `ART-3D-2006` Import Validation Tool·수동 QA
- `ART-3D-2007` Unity 실루엣 승인

### 검증

- 후드·단검·머리·상체가 기본 거리에서 보임
- 무기가 몸에 완전히 가려지지 않음
- 5~6등신이 SD·치비로 보이지 않음
- Humanoid Animation Retargeting 가능
- Material·Animator·Collider·Socket 구조 재사용 가능
- Console Error와 Missing Reference 없음

## A4. 루나 Character Proof

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
- Windows 목표 성능 유지
- 나머지 캐릭터에 재사용할 공용 기반 승인

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

## A7. 나머지 캐릭터 제작

### 시작 조건

루나 Character Proof와 Portfolio Vertical Slice Approved

### 순서

```text
미유 → 코코 → 이리스 → 노아
```

각 캐릭터는 개별 2D Approved 제작 시트, 얼굴·헤어·의상·무기, 공용 Base Mesh·Rig·Shader, 고유 공격·스킬·VFX, 선택·로비·전투 Prefab을 제작한다.

## A8. 출시 아트 확장

- 폐쇄된 연구소
- 추가 몬스터 3종과 보스 1종
- 캠프 시설 4종 이상
- 캐릭터 친밀도·대화·로비 상호작용
- Android 품질 단계
- Store Key Art와 Trailer
- 라이선스·AI Metadata 검토

## 승인 Gate

```text
Direction Approved
→ 2D Production Sheet Approved
→ 3D Blockout Approved
→ Coplay Import + Unity Validation Approved
→ Character Proof Approved
→ Vertical Slice Approved
→ Full Production
```
