# Re:Camp Integrated Sprint Backlog

이 문서는 현재부터 실제로 처리할 작업과 상태를 관리한다.

## 1. 현재 실행 순서

```text
1. 통합 문서 PR 리뷰·병합
2. Unity 6.3 LTS URP 프로젝트 생성
3. Android Build Support·Landscape·Safe Area
4. ReCamp.Core Unity Adapter
5. Camera Preset·Scene Gray Box
6. Android Touch Prototype과 완주 가능한 핵심 루프
7. ComfyUI·Figma·Blender·Coplay 파이프라인
8. 루나 2D Approved 제작 시트
9. 루나 3D Blockout·Character Proof
10. Android Portfolio Vertical Slice
11. APK 외부 테스트
12. Google Play Closed Test
13. Android Full Release
14. Windows·Steam·iOS 후속 판단
```

## 2. 상태 규칙

`Todo`, `Ready`, `In Progress`, `Review`, `Blocked`, `Done`을 사용한다. 완료 기준과 결과 링크가 없으면 `Done`으로 변경하지 않는다.

---

## Sprint 0. 기준·플랫폼·저장소

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| PROJ-0001 | GitHub 저장소 초기화 | High | Done | 저장소 사용 가능 |
| PROJ-0002 | 게임 콘셉트·MVP·Core Loop | High | Done | 핵심 루프와 제외 범위 |
| PROJ-0003 | 캐릭터·스킬·몬스터·아이템·스테이지 표 | High | Done | 구현 데이터 초안 |
| PROJ-0004 | 5인 캐릭터 설정 통일 | High | Done | 이름·역할·장비 충돌 없음 |
| PROJ-0005 | 5인 라인업 방향 승인 | High | Done | Direction Approved |
| PROJ-0006 | Git LFS 기본 규칙 | High | Done | `.gitattributes` 존재 |
| PROJ-0007 | Git LFS 아트 확장자 검증 | High | Ready | blend·fbx·psd·tga·exr 확인 |
| PROJ-0008 | AI 생성 자산 Metadata Template | Medium | Ready | 도구·모델·Seed·수정·라이선스 |
| PROJ-0009 | 프로젝트 기준 단일화 | High | Review | Baseline과 문서 충돌 제거 |
| PROJ-0010 | 중복 Backlog ID 제거 | High | Review | Prefix 규칙 통일 |
| PROJ-0011 | 유료 Aura 의존 제거 | High | Review | Coplay·Editor Tool·수동 QA로 작동 |
| PROJ-0012 | Android 우선 플랫폼 전략 | High | Review | 수익보다 제품 적합성·완성도 우선 |
| PROJ-0013 | Draft PR #7 리뷰·병합 | High | Review | 통합 내용 main 반영 |
| PROJ-0014 | 실제 비용 기록 방식 | Low | Review | 비용은 Scope 통제 참고값으로만 사용 |

### Sprint 0 종료 조건

- 최종 1차 제품 목표가 Google Play Android로 명확함
- Windows가 개발·QA 플랫폼으로 구분됨
- Vertical Slice가 Android 출시 검증 Gate로 정의됨
- 수익·손익분기가 필수 성공 조건에서 제외됨

---

## Sprint 1. Unity·Android 기반과 제작 파이프라인

### Unity 기반

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| DEV-0101 | Unity 6.3 LTS URP 프로젝트 생성 | High | Ready | PROJ-0013 | 프로젝트 실행 |
| DEV-0102 | Visible Meta Files·Force Text | High | Blocked | DEV-0101 | 설정·Meta 반영 |
| DEV-0103 | `Assets/_ReCamp` 구조 | High | Blocked | DEV-0101 | Art·Scripts·Scenes·Prefabs |
| DEV-0104 | Android Build Support·SDK·Target | High | Blocked | DEV-0101 | Android Build 가능 |
| DEV-0105 | Landscape·Orientation·Safe Area | High | Blocked | DEV-0104 | 화면 회전·Cutout 대응 |
| DEV-0106 | Input System Touch Control Scheme | High | Blocked | DEV-0101 | Touch Action 동작 |
| DEV-0107 | Windows Debug Control Scheme | Medium | Blocked | DEV-0101 | Keyboard/Mouse·Gamepad |
| DEV-0108 | Camera Preset 3종 Gray Box | High | Blocked | DEV-0103 | Near·Default·Far 비교 |
| DEV-0109 | ReCamp.Core PR #6 리뷰 | High | Review | 없음 | Core 코드·테스트 확인 |
| DEV-0110 | Core Assembly·Adapter 방식 | High | Blocked | DEV-0101, DEV-0109 | Unity 비종속 구조 |
| DEV-0111 | 기본 Scene 5종 | High | Blocked | DEV-0103 | Bootstrap·Title·Lobby·Battle·Result |
| DEV-0112 | SceneLoader·GameManager | High | Blocked | DEV-0110, DEV-0111 | Scene 전환 |
| DEV-0113 | EditMode·PlayMode Test | High | Blocked | DEV-0103 | 테스트 실행 |
| DEV-0114 | Core·Unity CI | Medium | Blocked | DEV-0113 | PR 자동 테스트 |
| DEV-0115 | URP Low·Medium·High Profile | High | Blocked | DEV-0104 | 품질 단계 전환 |
| DEV-0116 | Save Path·Migration 기반 | High | Blocked | DEV-0110 | 버전 포함 Save |
| DEV-0117 | 첫 Android APK Build | High | Blocked | DEV-0104~0106, DEV-0111 | 기준 기기에서 실행 |

### 아트 파이프라인

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| ART-PIPE-0101 | ComfyUI 반복 생성 Workflow | High | Ready | PROJ-0005 | 루나 일관성 출력 3회 |
| ART-PIPE-0102 | 캐릭터 변수·Seed·Metadata | High | Blocked | ART-PIPE-0101, PROJ-0008 | YAML·Prompt·Workflow |
| ART-PIPE-0103 | Figma 제작 시트·모바일 UI Template | High | Ready | 없음 | 캐릭터 Frame·Touch UI Frame |
| ART-PIPE-0104 | Blender 소품 Export | High | Ready | 없음 | 단검 또는 소품 FBX |
| ART-PIPE-0105 | Coplay Import·Prefab Proof | High | Blocked | DEV-0101, ART-PIPE-0104 | Material·Prefab·Scene |
| ART-PIPE-0106 | Import Preset·Validation Editor Tool | High | Blocked | DEV-0101, ART-PIPE-0104 | Scale·Rig·Socket·Reference 검사 |
| ART-PIPE-0107 | Android 실기기 Art QA Report | High | Blocked | ART-PIPE-0105, ART-PIPE-0106, DEV-0117 | Inspector·Console·APK 결과 |
| ART-PIPE-0108 | `art_source/`·Git LFS 구조 | Medium | Blocked | DEV-0101, PROJ-0007 | 원본·Export 분리 |

---

## Sprint 2. 완주 가능한 Gray Box와 Touch Prototype

### 핵심 루프

| ID | 작업 | 우선순위 | 상태 | 선행 작업 |
|---|---|---:|---|---|
| GAME-0201 | Lobby → Battle 진입 | High | Blocked | DEV-0112 |
| GAME-0202 | Player 이동·Camera 추적 | High | Blocked | DEV-0106~0108 |
| GAME-0203 | 기본 공격·Hitbox·Damageable | High | Blocked | GAME-0202 |
| GAME-0204 | Enemy 추적 AI | High | Blocked | DEV-0111 |
| GAME-0205 | EnemySpawner·Wave | High | Blocked | GAME-0204 |
| GAME-0206 | 적 사망·보상 1회 지급 | High | Blocked | GAME-0203, GAME-0205 |
| GAME-0207 | 자원 드롭·획득 | High | Blocked | GAME-0206 |
| GAME-0208 | 귀환·사망·시간 만료 | High | Blocked | GAME-0202, DEV-0110 |
| GAME-0209 | Result 정산 | High | Blocked | GAME-0207, GAME-0208 |
| GAME-0210 | Camp 시설 강화 | High | Blocked | GAME-0209 |
| GAME-0211 | Save·Load | High | Blocked | DEV-0116, GAME-0210 |
| GAME-0212 | Result → Lobby → 재탐험 | High | Blocked | GAME-0211 |
| GAME-0213 | Scene 흐름 PlayMode Test | High | Blocked | GAME-0212, DEV-0113 |
| GAME-0214 | 전투·보상·저장 Test | High | Blocked | GAME-0211, DEV-0113 |

### Android UX

| ID | 작업 | 우선순위 | 상태 | 선행 작업 |
|---|---|---:|---|---|
| MOB-0251 | 가상 조이스틱 | High | Blocked | DEV-0106, GAME-0202 |
| MOB-0252 | 공격·대시·스킬 Touch Button | High | Blocked | GAME-0203 |
| MOB-0253 | Auto Aim·대상 보정 | High | Blocked | GAME-0203, GAME-0204 |
| MOB-0254 | Android Back·Pause | High | Blocked | DEV-0112 |
| MOB-0255 | Background·Resume | High | Blocked | DEV-0112 |
| MOB-0256 | Safe Area·화면비 | High | Blocked | DEV-0105 |
| MOB-0257 | APK 성능·발열·Memory 측정 | High | Blocked | DEV-0117, GAME-0212 |

### 캐릭터 역할 프로토타입

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| CHR-PROT-0301 | 공용 CharacterController·Stats | High | Blocked |
| CHR-PROT-0310 | 루나 공격·대시·스캔 | High | Blocked |
| CHR-PROT-0320 | 미유 드론 최소 테스트 | Low | Blocked |
| CHR-PROT-0330 | 코코 회복·보호막 최소 테스트 | Low | Blocked |
| CHR-PROT-0340 | 이리스 차지 사격 최소 테스트 | Low | Blocked |
| CHR-PROT-0350 | 노아 가드·반격 최소 테스트 | Low | Blocked |
| CHR-PROT-0360 | 모바일 조작 비용·역할 중복 검토 | Medium | Blocked |

나머지 4명은 Android 핵심 루프 완주 후에만 진행하며 일정이 밀리면 연기한다.

---

## Sprint 3. 루나 제작 시트와 3D Blockout

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| ART-2D-1001 | 루나 전신 후보 3안 | High | Blocked |
| ART-2D-1002 | 얼굴·헤어 승인 | High | Blocked |
| ART-2D-1003 | 의상·실루엣 승인 | High | Blocked |
| ART-2D-1004 | Front·Side·Back·Turnaround | High | Blocked |
| ART-2D-1005 | 표정 8종 | Medium | Blocked |
| ART-2D-1006 | 단검·탐지 장치 | High | Blocked |
| ART-2D-1007 | 컬러·재질표·3D Notes | High | Blocked |
| ART-2D-1008 | 루나 제작 시트 Approved | High | Blocked |
| ART-3D-2001 | Character 3D Spec 리뷰 | High | Review |
| ART-3D-2002 | 공용 5~6등신 Base Mesh | High | Blocked |
| ART-3D-2003 | 공용 Humanoid Rig | High | Blocked |
| ART-3D-2004 | 루나 3D Blockout | High | Blocked |
| ART-3D-2005 | Coplay Import·Prefab | High | Blocked |
| ART-3D-2006 | Validation Tool·Android QA | High | Blocked |
| ART-3D-2007 | 모바일 쿼터뷰 실루엣 승인 | High | Blocked |

---

## Sprint 4. 루나 Character Proof

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| ART-3D-2010 | 최종 모델·Retopology·UV | High | Blocked |
| ART-3D-2011 | Texture·Material·Toon Shader | High | Blocked |
| ART-3D-2012 | Rig·Weight·표정 | High | Blocked |
| ART-3D-2013 | 공용 Animation | High | Blocked |
| ART-3D-2014 | 루나 고유 Animation | High | Blocked |
| ART-VFX-5001 | 공통 VFX 언어 | High | Ready |
| ART-VFX-5002 | 루나 공격·스킬 VFX | High | Blocked |
| TEST-4001 | 관통·모바일 가독성·성능 | High | Blocked |
| TEST-4002 | 루나 매력 사용자 테스트 | High | Blocked |

---

## Sprint 5. Android Portfolio Vertical Slice

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| ART-ENV-3001 | 버려진 거리 Color Key | High | Ready |
| ART-ENV-3002 | Modular Kit·최종 환경 | High | Blocked |
| ART-ENV-3003 | 캠프 Color Key | High | Ready |
| ART-ENV-3004 | 캠프 시설 3종 | High | Blocked |
| ART-ENV-3005 | 일반 몬스터 3종 | High | Blocked |
| ART-ENV-3006 | 보스 1종 | High | Blocked |
| ART-ENV-3007 | 자원·상자·소품 | Medium | Blocked |
| ART-UI-4001 | Mobile UI Design System | High | Ready |
| ART-UI-4002 | Lobby·Exploration Ready | High | Blocked |
| ART-UI-4003 | Touch Battle HUD | High | Blocked |
| ART-UI-4004 | Skill Select | High | Blocked |
| ART-UI-4005 | Result | High | Blocked |
| ART-UI-4006 | Camp Upgrade | High | Blocked |
| ART-UI-4007 | Pause·Settings | Medium | Blocked |
| ART-UI-4008 | Touch Tutorial | High | Blocked |
| ART-VFX-5003 | 적 위험·피격·사망 VFX | High | Blocked |
| ART-VFX-5004 | 자원·귀환·성장 VFX | Medium | Blocked |
| ART-VFX-5005 | Android VFX 품질 단계 | High | Blocked |
| VS-6001 | 전체 Scene·Prefab 통합 | High | Blocked |
| VS-6002 | 저장·튜토리얼·설정 | High | Blocked |
| VS-6003 | 사운드·진동·음악 | Medium | Blocked |
| VS-6004 | Android 성능·Memory·발열 | High | Blocked |
| VS-6005 | APK 외부 플레이 테스트 | High | Blocked |
| VS-6006 | 포트폴리오 영상·Screenshot | Medium | Blocked |

---

## Sprint 6. Google Play Closed Test

- `REL-7001` App ID·Version·Signing
- `REL-7002` Closed Test 후보 Build
- `REL-7003` 설치·업데이트·삭제·재설치
- `REL-7004` Store Listing·아이콘·Screenshot
- `REL-7005` 개인정보·권한·콘텐츠 등급
- `REL-7006` 기기 호환성·화면비 Matrix
- `REL-7007` Crash·Save·Background·Back 회귀 테스트
- `REL-7008` 테스트 피드백·재플레이 의향 분석
- `REL-7009` Full Release Scope Lock

## Sprint 7. Android Full Release

- `PROD-8001~8004` 미유·코코·이리스·노아 최종 제작
- `PROD-8005` 두 번째 스테이지 또는 동등한 반복 분량
- `PROD-8006` 추가 몬스터 3종·보스 1종
- `PROD-8007` 캠프 시설 4종 이상
- `PROD-8008` 캐릭터 해금·친밀도·대화
- `PROD-8009` 난이도·도전·반복 목표
- `REL-8101` Release Candidate
- `REL-8102` Google Play 정식 공개
- `REL-8103` 출시 후 Patch·지원

## Sprint 8. 후속 플랫폼

- `PORT-9001` Windows itch.io Demo
- `PORT-9002` Steam PC 제품화 검토
- `PORT-9003` iOS Build·TestFlight 검토

## 운영 원칙

- 수익 목표보다 완성·배포와 모바일 품질을 우선한다.
- 실제 Android Build가 없으면 모바일 작업을 Done으로 처리하지 않는다.
- PC에서만 좋은 UI·성능은 승인 기준이 아니다.
- Vertical Slice 승인 전 Full Release 최종 자산을 대량 제작하지 않는다.
- 결과 Commit·PR·APK·Profiler·실기기 기록을 작업과 연결한다.
