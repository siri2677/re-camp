# Re:Camp Integrated Sprint Backlog

이 문서는 현재부터 실제로 처리할 작업과 상태를 관리한다.

## 1. 현재 실행 순서

```text
1. 통합 문서 PR 리뷰·병합
2. Unity 6.3 LTS URP 프로젝트 생성
3. ReCamp.Core Unity Adapter 확정
4. Camera Preset과 Scene Gray Box
5. 완주 가능한 전투·자원·결과·캠프 루프
6. ComfyUI·Figma·Blender·Coplay 파이프라인
7. 루나 2D Approved 제작 시트
8. 루나 3D Blockout과 Character Proof
9. Portfolio Vertical Slice
10. itch.io 외부 테스트
11. Steam Store Page·무료 Demo
12. Full Release 콘텐츠
13. Steam Windows 정식 출시
14. Epic·Android 후속 판단
```

## 2. 상태 규칙

`Todo`, `Ready`, `In Progress`, `Review`, `Blocked`, `Done`을 사용한다. 완료 기준과 결과 링크가 없으면 `Done`으로 변경하지 않는다.

---

## Sprint 0. 기준·사업·저장소

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
| PROJ-0012 | 플랫폼·수익 모델·손익분기 전략 | High | Review | Steam 1차 출시·가격·BEP 문서화 |
| PROJ-0013 | Draft PR #7 리뷰·병합 | High | Review | 통합 내용 main 반영 |
| PROJ-0014 | 실제 비용 기록 방식 생성 | Medium | Review | `planning/business_cost_log.md` 존재 |

### Sprint 0 종료 조건

- 최종 목표가 Steam Windows 정식 출시로 명확함
- Vertical Slice가 중간 Gate로 정의됨
- Android가 자동 2차 개발이 아니라 Port Gate 대상임
- 플랫폼 비용과 손익분기 가정이 기록됨

---

## Sprint 1. Unity 프로젝트와 제작 파이프라인

### Unity 기반

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| DEV-0101 | Unity 6.3 LTS URP 프로젝트 생성 | High | Ready | PROJ-0013 | 프로젝트 실행 |
| DEV-0102 | Visible Meta Files·Force Text | High | Blocked | DEV-0101 | 설정·Meta 반영 |
| DEV-0103 | `Assets/_ReCamp` 구조 | High | Blocked | DEV-0101 | Art·Scripts·Scenes·Prefabs |
| DEV-0104 | Windows Build Target·해상도·Quality | High | Blocked | DEV-0101 | Windows Build 실행 |
| DEV-0105 | Input System PC Control Scheme | High | Blocked | DEV-0101 | Keyboard/Mouse·Gamepad |
| DEV-0106 | Camera Preset 3종 Gray Box | High | Blocked | DEV-0103 | Near·Default·Far 비교 |
| DEV-0107 | ReCamp.Core PR #6 리뷰 | High | Review | 없음 | Core 코드·테스트 확인 |
| DEV-0108 | Core Assembly·Adapter 방식 | High | Blocked | DEV-0101, DEV-0107 | Unity 비종속 구조 |
| DEV-0109 | 기본 Scene 5종 | High | Blocked | DEV-0103 | Bootstrap·Title·Lobby·Battle·Result |
| DEV-0110 | SceneLoader·GameManager | High | Blocked | DEV-0108, DEV-0109 | Scene 전환 |
| DEV-0111 | EditMode·PlayMode Test | High | Blocked | DEV-0103 | 테스트 실행 |
| DEV-0112 | Core·Unity CI | Medium | Blocked | DEV-0111 | PR 자동 테스트 |
| DEV-0113 | Build Version·Channel 구조 | Medium | Blocked | DEV-0104 | Dev·Demo·Release 구분 |
| DEV-0114 | Save Path·Migration 기반 | High | Blocked | DEV-0108 | 버전 포함 Save |

### 아트 파이프라인

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| ART-PIPE-0101 | ComfyUI 반복 생성 Workflow | High | Ready | PROJ-0005 | 루나 일관성 출력 3회 |
| ART-PIPE-0102 | 캐릭터 변수·Seed·Metadata | High | Blocked | ART-PIPE-0101, PROJ-0008 | YAML·Prompt·Workflow |
| ART-PIPE-0103 | Figma 제작 시트 Template | High | Ready | 없음 | 필수 Frame |
| ART-PIPE-0104 | Blender 소품 Export | High | Ready | 없음 | 단검 또는 소품 FBX |
| ART-PIPE-0105 | Coplay Import·Prefab Proof | High | Blocked | DEV-0101, ART-PIPE-0104 | Material·Prefab·Scene |
| ART-PIPE-0106 | Import Preset·Validation Editor Tool | High | Blocked | DEV-0101, ART-PIPE-0104 | Scale·Rig·Socket·Reference 검사 |
| ART-PIPE-0107 | 수동 Unity QA Report | High | Blocked | ART-PIPE-0105, ART-PIPE-0106 | Inspector·Console·PlayMode |
| ART-PIPE-0108 | `art_source/`·Git LFS 구조 | Medium | Blocked | DEV-0101, PROJ-0007 | 원본·Export 분리 |

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
| GAME-0211 | Save·Load | High | Blocked | DEV-0114, GAME-0210 |
| GAME-0212 | Result → Lobby → 재탐험 | High | Blocked | GAME-0211 |
| GAME-0213 | Scene 흐름 PlayMode Test | High | Blocked | GAME-0212, DEV-0111 |
| GAME-0214 | 전투·보상·저장 Test | High | Blocked | GAME-0211, DEV-0111 |

### 캐릭터 역할 프로토타입

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| CHR-PROT-0301 | 공용 CharacterController·Stats | High | Blocked |
| CHR-PROT-0310 | 루나 공격·대시·스캔 | High | Blocked |
| CHR-PROT-0320 | 미유 드론 최소 테스트 | Low | Blocked |
| CHR-PROT-0330 | 코코 회복·보호막 최소 테스트 | Low | Blocked |
| CHR-PROT-0340 | 이리스 차지 사격 최소 테스트 | Low | Blocked |
| CHR-PROT-0350 | 노아 가드·반격 최소 테스트 | Low | Blocked |
| CHR-PROT-0360 | 역할 중복·조작 비용 검토 | Medium | Blocked |

나머지 네 캐릭터 테스트는 Gray Box 완주 후 진행하며 일정이 밀리면 연기한다.

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
| ART-3D-2006 | Validation Tool·수동 QA | High | Blocked |
| ART-3D-2007 | 쿼터뷰 실루엣 승인 | High | Blocked |

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
| TEST-4001 | 관통·가독성·성능 | High | Blocked |
| TEST-4002 | 루나 매력 사용자 테스트 | High | Blocked |

---

## Sprint 5. Portfolio Vertical Slice

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| ART-ENV-3001 | 버려진 거리 Color Key | High | Ready |
| ART-ENV-3002 | Modular Kit·최종 환경 | High | Blocked |
| ART-ENV-3003 | 캠프 Color Key | High | Ready |
| ART-ENV-3004 | 캠프 시설 3종 | High | Blocked |
| ART-ENV-3005 | 일반 몬스터 3종 | High | Blocked |
| ART-ENV-3006 | 보스 1종 | High | Blocked |
| ART-ENV-3007 | 자원·상자·소품 | Medium | Blocked |
| ART-UI-4001 | UI Design System | High | Ready |
| ART-UI-4002 | Lobby | High | Blocked |
| ART-UI-4003 | Battle HUD | High | Blocked |
| ART-UI-4004 | Skill Select | High | Blocked |
| ART-UI-4005 | Result | High | Blocked |
| ART-UI-4006 | Camp Upgrade | High | Blocked |
| ART-UI-4007 | Pause·Settings | Medium | Blocked |
| ART-VFX-5003 | 적 위험·피격·사망 | High | Blocked |
| ART-VFX-5004 | 자원·귀환·성장 | Medium | Blocked |
| ART-VFX-5005 | VFX 품질·성능 | High | Blocked |
| VS-6001 | 전체 Scene·Prefab 통합 | High | Blocked |
| VS-6002 | 저장·튜토리얼·설정 | High | Blocked |
| VS-6003 | 사운드·음악 | Medium | Blocked |
| VS-6004 | 성능·메모리·로딩 | High | Blocked |
| VS-6005 | 외부 플레이 테스트 | High | Blocked |
| VS-6006 | Screenshot·Video | Medium | Blocked |

---

## Sprint 6. itch.io 테스트와 Steam Demo

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| TEST-6101 | itch.io 제한 공개 Build | High | Blocked |
| TEST-6102 | 설치·첫 실행·입력·해상도 QA | High | Blocked |
| TEST-6103 | Session Length·재플레이 조사 | High | Blocked |
| TEST-6104 | Crash·Save·진행 불가 수집 | High | Blocked |
| REL-6101 | Steam Direct 등록 | Medium | Blocked |
| REL-6102 | Steam Store Page 초안 | High | Blocked |
| REL-6103 | Capsule·Screenshot·Description | High | Blocked |
| REL-6104 | Trailer 1차 | High | Blocked |
| REL-6105 | Steam 무료 Demo | High | Blocked |
| REL-6106 | Demo 종료·Wishlist Flow | Medium | Blocked |
| REL-6107 | Controller·Settings·Save QA | High | Blocked |
| REL-6108 | 가격·비용·BEP 갱신 | High | Blocked |

---

## Sprint 7. Steam Full Release 콘텐츠

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| PROD-7001 | 미유 최종 2D·3D | High | Blocked |
| PROD-7002 | 코코 최종 2D·3D | High | Blocked |
| PROD-7003 | 이리스 최종 2D·3D | High | Blocked |
| PROD-7004 | 노아 최종 2D·3D | High | Blocked |
| PROD-7005 | 두 번째 스테이지 또는 동등 콘텐츠 | High | Blocked |
| PROD-7006 | 추가 일반 적 3종·보스 1종 | High | Blocked |
| PROD-7007 | 캠프 시설 4종 이상 | Medium | Blocked |
| PROD-7008 | 캐릭터 해금·친밀도 | Medium | Blocked |
| PROD-7009 | 대화·로비 상호작용 | Medium | Blocked |
| PROD-7010 | 난이도·도전·업적 | High | Blocked |
| PROD-7011 | 20~40분 세션 구조 검증 | High | Blocked |
| PROD-7012 | Tutorial·Accessibility·Localization | High | Blocked |

---

## Sprint 8. Steam Release Candidate

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| REL-8001 | 전체 회귀 테스트 | High | Blocked |
| REL-8002 | Save Migration·손상 복구 | High | Blocked |
| REL-8003 | Windows 성능·장시간 테스트 | High | Blocked |
| REL-8004 | CPU·GPU·Memory·GC 최적화 | High | Blocked |
| REL-8005 | Controller·해상도·접근성 | High | Blocked |
| REL-8006 | Rig·관통·Animation 폴리시 | Medium | Blocked |
| REL-8007 | WIP Asset 제거 | High | Blocked |
| REL-8008 | License·AI Metadata | High | Blocked |
| REL-8009 | Store Page·Trailer·Localization | High | Blocked |
| REL-8010 | 정가·출시 할인 확정 | High | Blocked |
| REL-8011 | Release Candidate 승인 | High | Blocked |
| REL-8012 | Steam Windows 정식 출시 | High | Blocked |
| REL-8013 | 출시 30일 판매·환불·리뷰 분석 | High | Blocked |

---

## Sprint 9. 후속 플랫폼

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| PORT-9001 | Epic Store 추가 비용·QA 평가 | Low | Blocked |
| PORT-9002 | Epic Windows Build·Store Page | Low | Blocked |
| PORT-9010 | Android 사업·과금 모델 재검토 | Low | Blocked |
| PORT-9011 | Touch UI·Auto Aim | Low | Blocked |
| PORT-9012 | Android 성능·기기 QA | Low | Blocked |
| PORT-9013 | Google Play 12명·14일 Closed Test | Low | Blocked |
| PORT-9014 | Android 출시 여부 최종 판단 | Low | Blocked |
| PORT-9020 | iOS 투자 여부 평가 | Low | Blocked |

## Backlog 운영 규칙

- 새 작업은 구현 전에 ID와 완료 기준 등록
- 결과 Commit·PR·파일·스크린샷 연결
- 실제 현금비용과 투입 시간을 월별 기록
- Steam Demo 전 Store 수수료·정책·환율 재확인
- 가격보다 콘텐츠와 Scope를 먼저 조정
- Android는 Steam 출시 후 Port Gate를 통과해야 시작
- Scope 축소는 `planning/SCOPE_AND_RISK_RULES.md`를 따른다.
