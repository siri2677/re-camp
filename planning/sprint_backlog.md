# Re:Camp Integrated Sprint Backlog

이 문서는 현재부터 실제로 처리할 작업과 상태를 관리한다.

## 1. 현재 실행 순서

```text
1. 문서 통합 PR 리뷰·병합
2. Unity 6.3 LTS URP 프로젝트 생성
3. ReCamp.Core PR 리뷰와 Unity Adapter 방식 확정
4. Camera Preset과 Scene Gray Box
5. 완주 가능한 전투·자원·결과·캠프 루프
6. ComfyUI·Figma·Blender 제작 파이프라인
7. Coplay FBX Import·Prefab 테스트
8. Unity Import Preset·Validation Tool과 수동 QA
9. 루나 2D Approved 제작 시트
10. 루나 3D Blockout과 쿼터뷰 검증
11. 루나 Character Proof와 Vertical Slice
```

## 2. 상태 규칙

`Todo`, `Ready`, `In Progress`, `Review`, `Blocked`, `Done`을 사용한다. 완료 기준과 결과 링크가 없으면 `Done`으로 변경하지 않는다.

---

## Sprint 0. 기준 문서와 저장소

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| PROJ-0001 | GitHub 저장소 초기화 | High | Done | 저장소 사용 가능 |
| PROJ-0002 | 게임 콘셉트·MVP·Core Loop 문서 | High | Done | 핵심 루프와 제외 범위 확인 가능 |
| PROJ-0003 | 캐릭터·스킬·몬스터·아이템·스테이지 표 | High | Done | 구현 데이터 초안 존재 |
| PROJ-0004 | 5인 캐릭터 설정 통일 | High | Done | 이름·역할·장비 충돌 없음 |
| PROJ-0005 | 5인 라인업 방향 승인 | High | Done | Direction Approved, 최종 시트와 구분됨 |
| PROJ-0006 | Git LFS 기본 규칙 | High | Done | `.gitattributes` 존재 |
| PROJ-0007 | Git LFS 아트 확장자 검증 | High | Ready | blend·fbx·psd·tga·exr 규칙 확인 |
| PROJ-0008 | AI 생성 자산 Metadata Template | Medium | Ready | 도구·모델·Seed·수정·라이선스 양식 |
| PROJ-0009 | 현재 기준 단일화 | High | Review | `CURRENT_PROJECT_BASELINE.md`와 문서 충돌 제거 |
| PROJ-0010 | 중복 Backlog ID 제거 | High | Review | 모든 신규 계획이 Prefix 규칙 사용 |
| PROJ-0011 | 유료 Aura 의존 제거 | High | Review | 모든 필수 계획이 Coplay·Editor Tool·수동 검수로 작동 |
| PROJ-0012 | Draft PR #7 리뷰·병합 | High | Review | 문서 통합이 main 반영 |

### Sprint 0 종료 조건

- 플랫폼·Unity·아트·MCP·범위가 한 기준으로 설명됨
- Aura가 필수 도구·선행 조건·완료 조건에 남아 있지 않음
- `planning/` 작업 ID가 중복되지 않음

---

## Sprint 1. Unity 프로젝트와 아트 파이프라인

### Unity 기반

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| DEV-0101 | Unity 6.3 LTS URP 프로젝트 생성 | High | Ready | PROJ-0012 | 프로젝트 실행 |
| DEV-0102 | Visible Meta Files·Force Text | High | Blocked | DEV-0101 | 설정과 Meta Git 반영 |
| DEV-0103 | `Assets/_ReCamp` 구조 생성 | High | Blocked | DEV-0101 | Art·Scripts·Scenes·Prefabs 구조 |
| DEV-0104 | Windows Build Target·해상도·Quality | High | Blocked | DEV-0101 | Windows 빌드 실행 |
| DEV-0105 | Input System PC Control Scheme | High | Blocked | DEV-0101 | Keyboard/Mouse·Gamepad 입력 |
| DEV-0106 | Camera Preset 3종 Gray Box | High | Blocked | DEV-0103 | Near·Default·Far 비교 가능 |
| DEV-0107 | ReCamp.Core PR #6 리뷰 | High | Review | 없음 | Core 코드·테스트 범위 확인 |
| DEV-0108 | Core Assembly·Adapter 방식 확정 | High | Blocked | DEV-0101, DEV-0107 | MonoBehaviour 중복 없이 연결 방식 문서화 |
| DEV-0109 | Bootstrap·Title·Lobby·Battle·Result Scene | High | Blocked | DEV-0103 | 5개 Scene 존재 |
| DEV-0110 | SceneLoader·GameManager 기반 | High | Blocked | DEV-0108, DEV-0109 | Scene 전환과 초기화 |
| DEV-0111 | EditMode·PlayMode Test Assembly | High | Blocked | DEV-0103 | 테스트 실행 |
| DEV-0112 | Core·Unity CI | Medium | Blocked | DEV-0111 | PR에서 자동 테스트 |
| DEV-0113 | Android Build Target 전환 검증 | Low | Blocked | DEV-0104 | PC Vertical Slice 후 진행 가능 기록 |

### 아트 파이프라인

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| ART-PIPE-0101 | ComfyUI 캐릭터 반복 생성 Workflow | High | Ready | PROJ-0005 | 루나 일관성 출력 3회 |
| ART-PIPE-0102 | 캐릭터 변수·Seed·Metadata | High | Blocked | ART-PIPE-0101, PROJ-0008 | YAML·Prompt·Workflow 기록 |
| ART-PIPE-0103 | Figma 캐릭터 제작 시트 Template | High | Ready | 없음 | 전신·표정·Turnaround·장비 Frame |
| ART-PIPE-0104 | Blender MCP 소품 Export | High | Ready | 없음 | 단검 또는 테스트 소품 FBX |
| ART-PIPE-0105 | Coplay FBX Import·Prefab 테스트 | High | Blocked | DEV-0101, ART-PIPE-0104 | Import·Material·Prefab·Scene 배치 |
| ART-PIPE-0106 | Unity Import Preset·Validation Editor Tool | High | Blocked | DEV-0101, ART-PIPE-0104 | Scale·Rig·Material·Socket·Reference 검사 |
| ART-PIPE-0107 | 수동 Unity Import·Prefab QA Report | High | Blocked | ART-PIPE-0105, ART-PIPE-0106 | Inspector·Console·Prefab Diff·PlayMode 기록 |
| ART-PIPE-0108 | `art_source/`와 Git LFS 구조 | Medium | Blocked | DEV-0101, PROJ-0007 | 원본·Export 분리 |

### Sprint 1 종료 조건

```text
Unity Clone 후 실행
+ Camera Gray Box
+ Core Adapter 방식
+ ComfyUI 반복 생성
+ Figma Template
+ Blender FBX
+ Coplay Import·Prefab
+ Editor Validation Tool과 수동 QA
```

---

## Sprint 2. 완주 가능한 Gray Box

| ID | 작업 | 우선순위 | 상태 | 선행 작업 |
|---|---|---:|---|---|
| GAME-0201 | Lobby → Battle 진입 | High | Blocked | DEV-0110 |
| GAME-0202 | Player 이동·Camera 추적 | High | Blocked | DEV-0105, DEV-0106 |
| GAME-0203 | 기본 공격·Hitbox·Damageable | High | Blocked | GAME-0202 |
| GAME-0204 | Enemy 추적 AI | High | Blocked | DEV-0109 |
| GAME-0205 | EnemySpawner·Wave | High | Blocked | GAME-0204 |
| GAME-0206 | 적 사망·보상 1회 지급 | High | Blocked | GAME-0203, GAME-0205 |
| GAME-0207 | 자원 드롭·획득 | High | Blocked | GAME-0206 |
| GAME-0208 | 귀환·사망·시간 만료 | High | Blocked | GAME-0202, DEV-0108 |
| GAME-0209 | Result 정산 | High | Blocked | GAME-0207, GAME-0208 |
| GAME-0210 | Camp 시설 강화 | High | Blocked | GAME-0209 |
| GAME-0211 | 로컬 Save·Load | High | Blocked | DEV-0108, GAME-0210 |
| GAME-0212 | Result → Lobby → 재탐험 | High | Blocked | GAME-0211 |
| GAME-0213 | Scene 흐름 PlayMode Test | High | Blocked | GAME-0212, DEV-0111 |
| GAME-0214 | 전투·보상·저장 Test | High | Blocked | GAME-0211, DEV-0111 |

### 캐릭터 역할 프로토타입

| ID | 작업 | 우선순위 | 상태 | 선행 작업 |
|---|---|---:|---|---|
| CHR-PROT-0301 | 공용 CharacterController·Stats | High | Blocked | GAME-0202, DEV-0108 |
| CHR-PROT-0310 | 루나 공격·대시·스캔 | High | Blocked | CHR-PROT-0301 |
| CHR-PROT-0320 | 미유 드론 최소 역할 테스트 | Low | Blocked | CHR-PROT-0301, GAME-0212 |
| CHR-PROT-0330 | 코코 회복·보호막 최소 테스트 | Low | Blocked | CHR-PROT-0301, GAME-0212 |
| CHR-PROT-0340 | 이리스 차지 사격 최소 테스트 | Low | Blocked | CHR-PROT-0301, GAME-0212 |
| CHR-PROT-0350 | 노아 가드·반격 최소 테스트 | Low | Blocked | CHR-PROT-0301, GAME-0212 |
| CHR-PROT-0360 | 역할 중복·조작 비용 검토 | Medium | Blocked | CHR-PROT-0310~0350 |

나머지 네 캐릭터 프로토타입은 Gray Box 완주 후 진행하며 일정이 밀리면 루나를 제외하고 연기한다.

---

## Sprint 3. 루나 2D 제작 시트와 Blockout

| ID | 작업 | 우선순위 | 상태 | 선행 작업 |
|---|---|---:|---|---|
| ART-2D-1001 | 루나 전신 후보 3안 | High | Blocked | ART-PIPE-0101, ART-PIPE-0102 |
| ART-2D-1002 | 루나 얼굴·헤어 승인 | High | Blocked | ART-2D-1001 |
| ART-2D-1003 | 루나 의상·실루엣 승인 | High | Blocked | ART-2D-1001 |
| ART-2D-1004 | Front·Side·Back·Turnaround | High | Blocked | ART-2D-1002, ART-2D-1003 |
| ART-2D-1005 | 표정 8종 | Medium | Blocked | ART-2D-1002 |
| ART-2D-1006 | 단검·탐지 장치 Sheet | High | Blocked | ART-2D-1003 |
| ART-2D-1007 | 컬러·재질표·3D Notes | High | Blocked | ART-2D-1004, ART-2D-1006 |
| ART-2D-1008 | 루나 제작 시트 Approved | High | Blocked | ART-2D-1004~1007 |
| ART-3D-2001 | Character 3D Spec 리뷰 | High | Review | DEV-0106 |
| ART-3D-2002 | 공용 5~6등신 Base Mesh | High | Blocked | ART-2D-1008, ART-3D-2001 |
| ART-3D-2003 | 공용 Humanoid Rig 초안 | High | Blocked | ART-3D-2002 |
| ART-3D-2004 | 루나 3D Blockout | High | Blocked | ART-2D-1008, ART-3D-2002 |
| ART-3D-2005 | Coplay Import·Prefab | High | Blocked | ART-3D-2004, ART-PIPE-0107 |
| ART-3D-2006 | Import·Prefab Validation Tool·수동 QA | High | Blocked | ART-3D-2005, ART-PIPE-0106 |
| ART-3D-2007 | Unity 쿼터뷰 실루엣 승인 | High | Blocked | ART-3D-2006, DEV-0106 |

---

## Sprint 4. 루나 Character Proof

| ID | 작업 | 우선순위 | 상태 | 선행 작업 |
|---|---|---:|---|---|
| ART-3D-2010 | 루나 최종 모델·Retopology·UV | High | Blocked | ART-3D-2007 |
| ART-3D-2011 | Texture·Material·Toon Shader | High | Blocked | ART-3D-2010 |
| ART-3D-2012 | Rig·Weight·표정 | High | Blocked | ART-3D-2011 |
| ART-3D-2013 | 공용 Animation 적용 | High | Blocked | ART-3D-2012 |
| ART-3D-2014 | 루나 고유 Animation | High | Blocked | ART-3D-2013, CHR-PROT-0310 |
| ART-VFX-5001 | 공통 VFX 언어 | High | Todo | GAME-0203 |
| ART-VFX-5002 | 루나 공격·스킬 VFX | High | Blocked | ART-3D-2014, ART-VFX-5001 |
| TEST-4001 | 관통·가독성·성능 | High | Blocked | ART-3D-2014, ART-VFX-5002 |
| TEST-4002 | 루나 매력 사용자 테스트 | High | Blocked | TEST-4001 |

---

## Sprint 5. Portfolio Vertical Slice

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| ART-ENV-3001 | 버려진 거리 Color Key | High | Todo |
| ART-ENV-3002 | Modular Kit과 최종 환경 | High | Blocked |
| ART-ENV-3003 | 캠프 Color Key | High | Todo |
| ART-ENV-3004 | 캠프 시설 3종 | High | Blocked |
| ART-ENV-3005 | 일반 몬스터 3종 | High | Blocked |
| ART-ENV-3006 | 보스 1종 | High | Blocked |
| ART-ENV-3007 | 자원·상자·소품 | Medium | Blocked |
| ART-UI-4001 | UI Design System | High | Ready |
| ART-UI-4002 | Lobby·Exploration Ready | High | Blocked |
| ART-UI-4003 | Battle HUD | High | Blocked |
| ART-UI-4004 | Skill Select | High | Blocked |
| ART-UI-4005 | Result | High | Blocked |
| ART-UI-4006 | Camp Upgrade | High | Blocked |
| ART-UI-4007 | Pause·Settings | Medium | Blocked |
| ART-VFX-5003 | 적 위험·피격·사망 VFX | High | Blocked |
| ART-VFX-5004 | 자원·귀환·성장 VFX | Medium | Blocked |
| ART-VFX-5005 | VFX 품질 단계·성능 | High | Blocked |
| VS-6001 | 전체 Scene·Prefab 통합 | High | Blocked |
| VS-6002 | 저장·튜토리얼·설정 | High | Blocked |
| VS-6003 | 사운드·음악 1차 | Medium | Blocked |
| VS-6004 | 성능·메모리·로딩 최적화 | High | Blocked |
| VS-6005 | 외부 플레이 테스트 | High | Blocked |
| VS-6006 | 포트폴리오 영상·스크린샷 | Medium | Blocked |

---

## Sprint 6. Full Release 확장

M5가 Approved된 후 활성화한다.

- `PROD-7001~7004`: 미유·코코·이리스·노아 2D/3D 최종 제작
- `PROD-7005`: 폐쇄된 연구소
- `PROD-7006`: 추가 몬스터 3종·보스 1종
- `PROD-7007`: 캠프 시설 4종 이상
- `PROD-7008`: 캐릭터 해금·친밀도
- `PROD-7009`: 대화·로비 상호작용
- `PROD-7010`: Android 입력·UI·성능 확장

## Sprint 7. QA와 출시

- `REL-8001`: 전체 회귀 테스트
- `REL-8002`: Save Migration·손상 방지
- `REL-8003`: Windows·Android 성능 테스트
- `REL-8004`: CPU·GPU·Memory·GC·Draw Call 최적화
- `REL-8005`: 해상도·입력·접근성
- `REL-8006`: Rig·관통·Animation 폴리시
- `REL-8007`: WIP 자산 제거
- `REL-8008`: 라이선스·AI Metadata
- `REL-8009`: Store·Trailer
- `REL-8010`: Demo·Beta
- `REL-8011`: Release Candidate 승인

## Backlog 운영 규칙

- 새 작업은 구현 전에 ID와 완료 기준을 등록한다.
- 결과 Commit·PR·파일·스크린샷을 작업 항목과 연결한다.
- Coplay 작업은 자동화 범위와 수동 보완 범위를 기록한다.
- 별도 유료 도구를 필수 선행 조건으로 두지 않는다.
- 아트는 `APPROVED`가 아니면 최종 게임 자산으로 사용하지 않는다.
- Scope 축소는 `planning/SCOPE_AND_RISK_RULES.md`를 따른다.
