# Re:Camp Art Production Roadmap

## 1. 목표

Re:Camp 아트 제작은 Android Landscape 실기기에서 캐릭터 매력과 전투 가독성을 검증하는 순서로 진행한다.

```text
5인 라인업 방향 통일
→ 제작 파이프라인 검증
→ 루나 2D Approved 제작 시트
→ 루나 3D 5~6등신 Blockout
→ Coplay Unity Import·Prefab
→ Editor Validation Tool
→ Android 실기기 쿼터뷰 검증
→ 루나 Character Proof
→ Android Portfolio Vertical Slice
→ 나머지 4명과 Full Release 콘텐츠
```

핵심은 루나에서 품질·비용·기술을 먼저 검증한 뒤 안전하게 확장하는 것이다.

## 2. 현재 비주얼 기준

- 대표 일러스트: 2D 일반 등신 서브컬쳐
- 인게임 캐릭터: 3D 5~6등신 스타일라이즈드
- Rendering: URP 툰 셰이딩
- Camera: Android Landscape 고정 쿼터뷰
- 환경: 자연에 잠식된 부드러운 포스트 아포칼립스
- UI: 모바일 Touch 가독성 우선
- 개발·검수: Windows Editor + Android 실기기

## A0. 방향 승인

### 상태

Done — Direction Approved

### 완료 내용

- 루나·미유·코코·이리스·노아 이름·역할 통일
- 대표 색상·무기·큰 실루엣 방향 설정
- 2D 일반 등신 + 3D 5~6등신 방향 확정
- 툰 셰이딩과 고정 쿼터뷰 확정
- 통합 캐릭터 라인업 생성

현재 라인업은 최종 제작 시트가 아니다. 개별 얼굴·헤어·의상·Turnaround는 캐릭터별 `APPROVED` 시트에서 확정한다.

## A1. 제작 파이프라인

- `ART-PIPE-0101` ComfyUI 반복 생성 Workflow
- `ART-PIPE-0102` 캐릭터 변수·Seed·Metadata
- `ART-PIPE-0103` Figma 제작 시트·Mobile UI Template
- `ART-PIPE-0104` Blender 소품 Export Proof
- `ART-PIPE-0105` Coplay FBX Import·Prefab Proof
- `ART-PIPE-0106` Import Preset·Validation Editor Tool
- `ART-PIPE-0107` Android 실기기 Art QA
- `ART-PIPE-0108` Git LFS·`art_source/` 구조

완료 기준:

```text
루나 기준 이미지 반복 생성
+ Figma 제작 시트 Export
+ Blender FBX Export
+ Coplay Import·Prefab
+ Validation Report
+ Android APK에서 Material·LOD·실루엣 확인
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

완료 기준:

- 모든 시점에서 얼굴·헤어·후드·재킷·단검 구조 일치
- 정찰형 근접 딜러 역할이 외형에서 읽힘
- Android 쿼터뷰에서 강조할 요소 명시
- 모바일 성능에 불필요한 장식 정리

## A3. 루나 3D Blockout과 Android Proof

- `ART-3D-2001` 3D Spec 리뷰
- `ART-3D-2002` 공용 5~6등신 Base Mesh
- `ART-3D-2003` 공용 Humanoid Rig
- `ART-3D-2004` 루나 Blockout
- `ART-3D-2005` Coplay Import·Prefab
- `ART-3D-2006` Validation Tool·Android QA
- `ART-3D-2007` 모바일 실루엣 승인

검증:

- 후드·단검·머리·상체가 Android 기본 거리에서 보임
- 5~6등신이 SD처럼 보이지 않음
- 공용 Animation Retargeting 가능
- Material·Animator·Collider·Socket 재사용 가능
- LOD1에서 목표 성능과 Memory 범위 확인

## A4. 루나 Character Proof

- 최종 모델·Retopology·UV
- Texture·Toon Material
- Rig·Weight·표정
- 공용 Idle·Run·Hit·Down
- 루나 Attack·Dash·Skill·Victory
- 루나 VFX·사운드·진동 피드백
- Lobby·Battle Prefab
- Android 사용자 매력 테스트

완료 기준:

- 2D와 3D가 같은 캐릭터로 인식
- 모바일 쿼터뷰에서 매력과 역할 전달
- 공격·대시·스킬에서 치명적 관통 없음
- 기준 기기 30 FPS와 품질 단계 검증
- 공용 기반을 다른 캐릭터에 재사용 가능

## A5. Android Vertical Slice 환경·몬스터·소품

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

Android Low Profile에서도 이동 경로·위험·자원이 명확해야 한다.

## A6. 모바일 UI·VFX·연출

### UI

- Mobile UI Design System
- Lobby·Exploration Ready
- Touch Battle HUD
- Skill Select
- Result
- Camp Upgrade
- Pause·Settings
- Touch Tutorial

### VFX

- 루나 민트·청록 베기와 Scan Pulse
- 적 위험·피격·사망
- 자원 획득·귀환·캠프 성장
- High·Medium·Low 품질 단계

## A7. 나머지 캐릭터 제작

### 시작 조건

루나 Character Proof와 Android Portfolio Vertical Slice Approved

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
- 대표 Idle·기본 공격·스킬·승리
- 캐릭터별 VFX·사운드
- Lobby·Battle Prefab
- Android 실기기 QA

## A8. Android Full Release 아트 확장

- 폐쇄된 연구소 또는 동등한 두 번째 플레이 공간
- 추가 몬스터 3종·보스 1종
- 캠프 시설 4종 이상
- 캐릭터 친밀도·대화·로비 상호작용
- Android Store Icon·Screenshot·Trailer
- 전체 라이선스·AI Metadata 검토

## 3. 승인 Gate

```text
Direction Approved
→ 2D Production Sheet Approved
→ 3D Blockout Approved
→ Android Character Proof Approved
→ Android Vertical Slice Approved
→ Full Production
```

Gate를 건너뛰어 고비용 최종 제작으로 이동하지 않는다.
