# Re:Camp Integrated Sprint Backlog

> 최종 갱신: 2026-07-27
> 역할: 실제 작업 ID·순서·상태·완료 조건의 단일 기준

제품·플랫폼·전역 비주얼·로스터·Gate 정의는 `docs/00_project/CURRENT_PROJECT_BASELINE.md`를 따른다. 이 문서는 그 내용을 복제하지 않는다.

## 상태

| 상태 | 의미 |
|---|---|
| `Todo` | 결과 없음 |
| `Ready` | 선행 조건 충족 |
| `In Progress` | 현재 작업 중 |
| `Review` | 핵심 결과는 있으나 통합 검증·재현·사람 승인 일부가 남음 |
| `Blocked` | 외부 설치·기기·사용자 결정·승인 필요 |
| `Deferred` | 현재 필수가 아니며 실제 병목 시 재평가 |
| `Done` | 완료 조건과 필요한 증거 충족 |

## 현재 P0 실행 큐

| 순서 | ID | 작업 | 상태 | 다음 완료 조건 |
|---:|---|---|---|---|
| 1 | DEV-0113 | Domain·Unity Presentation 잔여 통합 | In Progress | 탐험·스킬 Command/Event 연결과 중복 규칙 제거 |
| 2 | DEV-0115 | Android Landscape·Safe Area | Review | 방향 고정, 화면비·Cutout 테스트, 실기기 증거 |
| 3 | DEV-0116 | Android Touch 조작·HUD | Ready | 공통 입력 Command와 On-screen 조작 구현·검증 |
| 4 | DEV-0114 | Android Build Support·도구 체인 | Blocked | AndroidPlayer·SDK·NDK·OpenJDK 설치와 Target 전환 |
| 5 | DEV-0117 | App ID·첫 APK·실기기 Smoke | Blocked | DEV-0114~0116 완료와 배포 식별자 결정 |
| 6 | ART-0111 | Figma 제작 시트 실사용 검증 | Review | Import·Clone·한글·PNG/PDF Export·사용성 검토 |
| 7 | ART-0112 | 2D→3D 변환표 샘플 | Ready | 루나 샘플에서 확대·삭제·결합·단순화 필드 검증 |
| 8 | ART-1001·1101·1201·1301·1401 | 5인 전신 후보 | Ready | 캐릭터별 3안과 metadata |
| 9 | ART-1501~1503 | 교차 디자인·유사성 검토 | Todo | 실루엣·얼굴·저채도·외부 IP 비교 |
| 10 | ART-0104 | Blender 소품 Export Proof | Ready | 규격 이름의 `.blend`와 FBX Export 증거 |
| 11 | TEST-0202 | 전투·보상·정산 통합 회귀 | Review | 전체 Scene 전환과 정산 단일 자동화 |
| 12 | CHR-0360 | 5인 밸런스·역할 중복 검토 | Review | 수동 플레이 기록과 수치 조정 |

## Sprint 0. 저장소·문서 기반

| ID | 작업 | 상태 | 완료 조건 |
|---|---|---|---|
| RC-0001 | 저장소 초기화 | Done | 저장소 존재 |
| RC-0002 | 루트 README | Done | 프로젝트 탐색 경로 제공 |
| RC-0003 | AGENTS·프로젝트 Skill | Done | Baseline 우선 작업 규칙 존재 |
| RC-0004 | Unity `.gitignore` | Done | 생성 디렉터리 제외 |
| RC-0005 | Git LFS 규칙 | Done | 대상 확장자 속성 검증 |
| RC-0006~0010 | 기획·테이블·실행 문서 | Done | 분야별 소유 문서 존재 |
| RC-0011 | 과거 캐릭터 라인업 이력 | Review | 상태·실패 원인 보존, 제작 기준 사용 금지 |
| RC-0012 | LFS·아트 구조 검증 | Done | 속성과 경로 검증 |
| RC-0013 | 프로젝트 Baseline 단일화 | Done | 전역 결정 단일 소스 확정 |
| RC-0014 | LLM 문서 소유권 단일화 | Done | AGENTS·Skill·README·Planning·Art·Roadmap 중복 제거와 검증 스크립트 |

## Sprint 1. Unity·Core·Android 기반

| ID | 작업 | 상태 | 남은 완료 조건 |
|---|---|---|---|
| DEV-0101 | Unity 프로젝트·버전 | Done | 없음 |
| DEV-0102 | Meta·Text Serialization | Done | 없음 |
| DEV-0103 | `Assets/_ReCamp` 구조 | Done | 없음 |
| DEV-0104 | 원격 Git·Fresh Clone 재현 | Review | 별도 Clone·Unity Open·Compile·Test |
| DEV-0105 | Scene 5개 | Done | 없음 |
| DEV-0106 | SceneLoader | Done | 없음 |
| DEV-0107 | GameManager·서비스 초기화 | Done | 없음 |
| DEV-0108 | 독립 Core 호환성 감사 | Done | 없음 |
| DEV-0109 | Domain·Adapter 경계 결정 | Done | 없음 |
| DEV-0110 | Domain 상태와 Presentation 연결 | Review | 중복 규칙 정리 |
| DEV-0111 | EditMode·PlayMode Assembly | Done | 없음 |
| DEV-0112 | Core·Unity CI | Todo | 자동 Workflow와 결과 Artifact |
| DEV-0113 | 독립 Core 통합 | In Progress | 탐험·스킬 포트와 Command/Event 연결 |
| DEV-0114 | Android Build Support | Blocked | Module·SDK·NDK·JDK 설치 |
| DEV-0115 | Landscape·Safe Area | Review | 설정·자동 테스트·실기기 |
| DEV-0116 | Touch Control Scheme | Ready | 입력 계층·HUD·멀티터치 검증 |
| DEV-0117 | App ID·Build Profile·첫 APK | Blocked | 선행 작업·식별자·기기 필요 |

## Sprint 2. Scene 흐름·Gray Box 전투

| ID | 작업 | 상태 | 남은 완료 조건 |
|---|---|---|---|
| DEV-0201~0204 | Bootstrap·Lobby·Battle·Result Gray Box | Done | 없음 |
| DEV-0205~0207 | 전체 Scene 흐름 | Done | 자동 통합 회귀는 TEST-0201에서 관리 |
| DEV-0208 | Input System·PlayerController | Review | 실제 입력 수동 회귀 |
| DEV-0209 | 쿼터뷰 카메라·이동 경계 | Done | 최종 자산 시 framing 재검토 |
| DEV-0210 | 기본 공격·Damageable | Done | 없음 |
| DEV-0211 | Enemy 추적·생명주기 | Done | 적 종류별 고유 행동은 콘텐츠 단계 |
| DEV-0212 | Wave·Boss | Done | 정식 난이도는 밸런스 단계 |
| DEV-0213 | 사망·보상 1회 지급 | Done | 통합 자동화는 TEST-0202 |
| DEV-0214 | 귀환·사망·시간 만료 | Done | 모바일 입력·연출 후속 |
| DEV-0215 | 결과 정산·로컬 저장 | Done | 앱 종료·손상·migration 확대 |
| TEST-0201 | Scene 흐름 PlayMode 통합 테스트 | Review | 실제 Scene 전환·상태 전달 자동화 |
| TEST-0202 | 전투·보상·정산 통합 테스트 | Review | 드랍부터 Lobby 반영까지 단일 자동화 |

## Sprint 3. 캐릭터 역할 프로토타입

| ID | 작업 | 상태 | 남은 완료 조건 |
|---|---|---|---|
| CHR-0301 | 공용 Controller·Stats·Ability | Done | 없음 |
| CHR-0302 | 선택·데이터 적용 | Done | 없음 |
| CHR-0310~0311 | 루나 역할 능력 | Review | VFX·수치 튜닝 |
| CHR-0320~0321 | 미유 역할 능력 | Review | 수동 대상 지정 |
| CHR-0330~0331 | 코코 역할 능력 | Review | 상태 이상·해제 |
| CHR-0340~0341 | 이리스 역할 능력 | Review | 약점 연출·튜닝 |
| CHR-0350~0351 | 노아 역할 능력 | Review | 충돌·VFX·튜닝 |
| CHR-0360 | 역할 중복·밸런스 | Review | 수동 플레이 기록 |
| TEST-0301 | 캐릭터 핵심 능력 테스트 | Done | 없음 |

## Sprint 4. 캐릭터 2D 제작 시트

세부 ID와 완료 조건은 `planning/art_production_backlog.md`가 소유한다.

Exit 기준:

- 후보·교차 비교·Turnaround·표정·장비·재질·2D→3D 변환표.
- Gate A/B와 사람 승인.
- 캐릭터별 metadata·review·Approved 경로.

## Sprint 5. 루나 Character Proof

| ID 범위 | 작업 | 상태 |
|---|---|---|
| ART-2001~2004 | 3D·Unity Presentation 공용 계약 | Todo |
| ART-2005~2006 | 루나 Blockout·쿼터뷰·Android Gate | Todo |
| ART-2007~2010 | 모델·Rig·표정·Animation·VFX·Prefab | Todo |
| ART-2011 | 캐릭터 매력·훅 사용자 검증 | Todo |

Exit 기준은 Baseline의 Gate와 `art_production_roadmap.md`를 따른다.

## Sprint 6. Vertical Slice

| ID | 작업 | 상태 |
|---|---|---|
| VS-6001 | 첫 환경 | Todo |
| VS-6002 | 일반 몬스터 3종 | Todo |
| VS-6003 | 첫 보스 | Todo |
| VS-6004 | 캠프 시설 3종 | Todo |
| VS-6005 | 로비·전투·결과·캠프 UI | Todo |
| VS-6006 | 루나 스킬·VFX·타격감 | Todo |
| VS-6007 | 저장·튜토리얼·설정 | Todo |
| VS-6008 | 사운드·음악 1차 | Todo |
| VS-6009 | 성능·메모리·로딩 | Todo |
| VS-6010 | 외부 테스트 | Todo |

## Sprint 7. 나머지 캐릭터·전체 콘텐츠

| ID | 작업 | 상태 |
|---|---|---|
| PROD-7001~7004 | 나머지 4인 최종 자산 | Todo |
| PROD-7005 | 추가 환경 | Todo |
| PROD-7006 | 추가 적·보스 | Todo |
| PROD-7007 | 캠프 시설·성장 연출 | Todo |
| PROD-7008 | 해금 임무·친밀도 | Todo |
| PROD-7009 | 대화·로비 상호작용 | Todo |
| PROD-7010 | 전체 UI·VFX·사운드 | Todo |

## Sprint 8. QA·출시 준비

| ID | 작업 | 상태 |
|---|---|---|
| REL-8001 | 전체 회귀 | Todo |
| REL-8002 | 저장 안정화·migration | Todo |
| REL-8003 | Android 기기 매트릭스 | Todo |
| REL-8004 | CPU·GPU·메모리·GC·Draw Call | Todo |
| REL-8005 | 해상도·입력·설정 | Todo |
| REL-8006 | Rig·관통·Animation 폴리시 | Todo |
| REL-8007 | 미승인 WIP 제거 | Todo |
| REL-8008 | 라이선스·AI metadata·유사성 | Todo |
| REL-8009 | 스토어 이미지·트레일러·설명 | Todo |
| REL-8010 | 외부 베타 | Todo |
| REL-8011 | Release Candidate 승인 | Todo |

## 운영 규칙

- 작업 시작 시 해당 ID만 `In Progress`로 변경한다.
- 구현·테스트 근거는 `planning/IMPLEMENTATION_STATUS.md`에 기록한다.
- 전역 결정은 Baseline에서만 변경한다.
- Roadmap과 Backlog에 제품 설명·비율·로스터를 복제하지 않는다.
- 코드 존재만으로 `Done`, 생성 이미지 품질만으로 `APPROVED` 처리하지 않는다.
- 문서 변경 후 `python scripts/validate_project_docs.py`를 실행한다.
