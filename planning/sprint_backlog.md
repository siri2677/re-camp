# Re:Camp Integrated Sprint Backlog

이 문서는 실제 작업을 시작할 때 가장 먼저 확인하는 통합 작업 목록이다. 원격 계획의 ID 체계를 유지하고 최신 Unity 구현·검증 상태를 반영한다.

상태는 `Todo`, `Ready`, `In Progress`, `Review`, `Deferred`, `Blocked`, `Done`을 사용한다.

- `Done`: 구현과 직접 검증이 모두 끝남
- `Review`: 구현됐지만 통합 회귀·Git 재현성·사람 승인 중 하나가 남음
- `Deferred`: 필요성이 확인될 때 도입하는 선택 작업이며 현재 선행 조건이 아님
- `Blocked`: 외부 연결·손상 자산·사용자 결정 등 명시적 조건을 기다림

## 현재 P0 실행 큐

| 순서 | ID | 작업 | 상태 | 다음 완료 조건 |
|---:|---|---|---|---|
| 1 | RC-0011 | 성인 여성 5인·남성향 통합 라인업 `REVIEW v003` 검토 | Review | 원본 앵커·전원 성인 여성·SD-lite 교정본 사람 승인 |
| 2 | TEST-0202 | 전투·보상·정산 회귀 테스트 | Review | 전체 Scene 전환·정산 통합 자동화 |
| 3 | DEV-0108~0109 | Unity 비종속 Core 호환성·중복 규칙 검토와 경계 결정 | Ready | 공유 Assembly 또는 Adapter 구조 결정 |
| 4 | CHR-0360 | 캐릭터 5명 밸런스·역할 중복 검토 | Review | 수동 플레이와 수치 조정, 역할 피드백 정리 |
| 5 | ART-0103 | Figma 캐릭터 제작 시트 템플릿 | Ready | 필수 2D 산출물 프레임과 승인 필드 완성 |
| 6 | ART-1001~1401 | 성인 여성 5명 단독 전신 WIP 후보 | Ready | 원본 앵커·Character Bible 기반 후보와 메타데이터 |

## Sprint 0. 저장소·기획·아트 방향

### 목표

개발과 아트 제작을 시작할 수 있는 기준 문서와 저장소 구조를 준비한다.

| ID | 작업 | 우선순위 | 상태 | 근거·비고 |
|---|---|---:|---|---|
| RC-0001 | GitHub 저장소 초기화 | High | Done | 저장소 존재 |
| RC-0002 | README | High | Done | 프로젝트 개요 존재 |
| RC-0003 | AGENTS 작업 규칙 | High | Done | 다음 세션 자동 진입 규칙 존재 |
| RC-0004 | Unity `.gitignore` | High | Done | 생성 디렉터리 제외 |
| RC-0005 | Git LFS 규칙 | High | Done | PNG·FBX·BLEND·KRA·TGA·EXR 속성 검증 |
| RC-0006~0010 | 게임 기획·테이블·아트 가이드·실행 계획 | High | Done | `docs/`, `tables/`, `planning/` 기준 |
| RC-0011 | 통합 캐릭터 라인업 교정 시안 | High | Review | v002 REJECTED, 성인 여성 5인·남성향 v003 사람 승인 필요 |
| RC-0012 | LFS 규칙과 현재 아트 구조 검증 | High | Done | `git check-attr` 검증 |

### 완료 기준

- `planning/`에서 다음 작업을 선택할 수 있다.
- 게임·캐릭터·아트 문서가 성인 여성 5인과 2D/3D 비율 방향에서 일치한다.
- 통합 라인업의 승인 또는 수정 방향이 결정된다.

## Sprint 1. Unity 프로젝트·Core 통합 기반

| ID | 작업 | 우선순위 | 상태 | 근거·남은 일 |
|---|---|---:|---|---|
| DEV-0101 | Unity 버전 확정 및 프로젝트 생성 | High | Review | 로컬 `6000.5.3f1` 동작, 버전 정책 최종 표기 남음 |
| DEV-0102 | Visible Meta Files·Force Text | High | Done | `m_SerializationMode: 2` 확인 |
| DEV-0103 | `Assets/_ReCamp` 구조 | High | Done | Scenes, Scripts, Art, Prefabs, Captures 존재 |
| DEV-0104 | `Assets`, `Packages`, `ProjectSettings`, `.meta` Git 반영 | High | Review | 저장소 반영 후 별도 clone-open 검증 남음 |
| DEV-0105 | 기본 Scene 5개 | High | Done | Bootstrap·Title·Lobby·Battle·Result 존재 |
| DEV-0106 | SceneLoader | High | Done | Scene 이름 매핑과 흐름 검증 |
| DEV-0107 | GameManager·서비스 초기화 | High | Done | 지속 인스턴스와 CampManager 동작 |
| DEV-0108 | Core 런타임 호환성 검토 | High | Ready | 비종속 Core와 Unity 규칙 비교 필요 |
| DEV-0109 | Core 공유·Assembly·Adapter 결정 | High | Todo | DEV-0108 선행 |
| DEV-0110 | Core 상태를 Unity Presentation에 연결 | High | Review | 현재 기능 동작, 중복 규칙 정리 필요 |
| DEV-0111 | EditMode·PlayMode 테스트 Assembly | High | Done | EditMode 23/23, PlayMode 18/18 통과 |
| DEV-0112 | Core·Unity CI | Medium | Todo | 로컬 테스트 기준선 존재 |
| DEV-0113 | 기존 비종속 Core 통합 | High | Ready | 별도 Core 브랜치 검토 필요 |

### 아트 파이프라인 병행

| ID | 작업 | 우선순위 | 상태 | 근거·남은 일 |
|---|---|---:|---|---|
| ART-0101 | 현재 이미지 도구 기반 반복 워크플로 | High | Review | v002 실패 원인 기록, 원본 앵커·전원 성인 여성 회귀 규칙 보강 |
| ART-0102 | 도구 비종속 일관성 변수·메타데이터 | High | Review | 공통 양식 완료, 캐릭터 앵커 변수 남음 |
| ART-0103 | Figma 제작 시트 템플릿 | High | Ready | 템플릿 구성 필요 |
| ART-0104 | Blender MCP 연결·소품 Export | Medium | Blocked | Blender 런타임 소켓 미검증 |
| ART-0105 | FBX Import·Material·Prefab | Medium | Todo | ART-0104 선행 |
| ART-0106 | `art_source/` 구조 | Medium | Done | 소스 하위 구조 존재 |
| ART-0108 | ComfyUI·ComfyUI MCP 고정 워크플로 | Low | Deferred | 대량 일관성·정밀 인페인팅이 실제 병목일 때 재평가 |

## Sprint 2. Scene 흐름과 Gray Box 전투

### 목표

임시 모델로 Lobby → Battle → Result → Lobby 흐름과 기본 전투·정산을 완성한다.

| ID | 작업 | 우선순위 | 상태 | 근거·남은 일 |
|---|---|---:|---|---|
| DEV-0201~0204 | Bootstrap·Lobby·Battle·Result Gray Box | High | Done | Scene 직접 실행 확인 |
| DEV-0205~0207 | Lobby → Battle → Result → Lobby | High | Done | 전체 Play Mode 흐름 검증 |
| DEV-0208 | Input System·PlayerController | High | Review | 카메라 상대 XZ 이동, 실제 키보드 회귀 1회 필요 |
| DEV-0209 | 쿼터뷰 카메라·이동 경계 | High | Done | Orthographic `35.3° / 45°`, actor/camera clamp |
| DEV-0210 | 기본 공격·Hitbox·Damageable | High | Done | 자동 공격과 사망 처리 검증 |
| DEV-0211 | EnemyController·추적 AI | High | Done | XZ 추적·접촉 피해 검증 |
| DEV-0212 | EnemySpawner·웨이브·보스 | High | Done | 일반 웨이브 후 보스 스폰 |
| DEV-0213 | 사망·보상 1회 지급 | High | Done | 위치 보존과 단일 보상 검증 |
| DEV-0214 | 귀환·사망·시간 종료 | High | Done | 5분, 60초 경고, 발전기 +30초/레벨, R 홀드·버튼 귀환, 종료 사유 |
| DEV-0215 | 결과 정산·로컬 저장 | High | Done | 자원 정산·로비 유지·캠프 저장 검증 |
| TEST-0201 | Scene 흐름 PlayMode 테스트 | High | Review | Build Settings 자동 검증, 실제 전환 자동화 남음 |
| TEST-0202 | 전투·보상·정산 테스트 | High | Review | Ledger·보호막·적 생명주기·저장 검증, 전체 Scene 통합 남음 |

### 완료 기준

- 임시 캐릭터가 이동·공격하고 적이 스폰·추적·피격·사망한다.
- 자원 획득, 귀환·사망·시간 만료, 결과 정산과 저장이 동작한다.
- 자동 테스트와 직접 Play Mode 검증이 통과한다.

## Sprint 3. 캐릭터 5명 전투 프로토타입

성인 여성 5명의 최종 아트 제작 전에 primitive/프록시로 플레이 차이를 검증한다. 프록시는 최종 성별 표현이나 아트 품질 기준이 아니다.

| ID | 작업 | 우선순위 | 상태 | 구현·남은 일 |
|---|---|---:|---|---|
| CHR-0301 | 공용 CharacterController·Stats·Ability | High | Done | 5인 Roster·Stats·Ability와 테스트 |
| CHR-0302 | 캐릭터 선택·데이터 적용 | High | Done | Lobby 선택 → Battle 데이터 유지 직접 검증 |
| CHR-0310~0311 | 루나 대시·3타·스캔·자원 탐지 | High | Review | 자동 테스트 완료, VFX·수치 튜닝 |
| CHR-0320~0321 | 미유 드론 자동 사격·오버클럭·자동 회수 | High | Review | 수동 대상 지정 남음 |
| CHR-0330~0331 | 코코 회복·보호막 | High | Review | 상태 이상 시스템·해제 남음 |
| CHR-0340~0341 | 이리스 차지·보스 보정·표식·피해 증폭 | High | Review | 최종 약점 연출 남음 |
| CHR-0350~0351 | 노아 가드·반격·이동 차단 방벽·밀쳐내기 | High | Review | VFX·수치 튜닝 |
| CHR-0360 | 5명 밸런스·역할 중복 검토 | High | Review | 수동 플레이와 밸런스 기록 |
| TEST-0301 | 캐릭터별 핵심 스킬 테스트 | High | Done | 자동 테스트 통과 |

### 완료 기준

- 5명 모두 임시 모델로 선택·전투 가능하다.
- 플레이 방식과 강점이 겹치지 않는다.
- 대표 능력 자동 테스트와 직접 피드백 검증을 통과한다.

## Sprint 4. 성인 여성 5인 Approved 2D 제작 시트

### 목표

5명 모두 3D 모델링에 사용할 사람 승인 제작 시트를 확보한다.

```text
얼굴·헤어 확정
의상·실루엣 확정
정면·측면·후면 Turnaround
표정 8종
무기·장비 상세
컬러·재질표
대표 포즈
3D 제작 주의사항
```

세부 ID는 `planning/art_production_backlog.md`의 `ART-10`~`ART-15`를 따른다. `APPROVED`는 사람 검토를 통과한 경우에만 사용한다.

## Sprint 5. 루나 Character Proof

### 목표

루나를 첫 최종 캐릭터로 완성해 아트·3D·Unity 파이프라인과 타깃 매력을 검증한다.

| ID 범위 | 작업 | 상태 |
|---|---|---|
| ART-2001~2004 | 3D 규격·4~5등신 Base Mesh·Rig·Toon 규칙 | Todo |
| ART-2005~2006 | 루나 Blockout·Unity 쿼터뷰 Gate C | Todo |
| ART-2007~2010 | 최종 모델·Rig·표정·애니메이션·VFX·Prefab | Todo |
| ART-2011 | 타깃 사용자 매력 검증 | Todo |

Approved 2D와 같은 캐릭터로 보이고, 쿼터뷰 식별·관통·성능·플레이 검증을 통과해야 한다.

## Sprint 6. Vertical Slice

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| VS-6001 | 버려진 거리 Color Key·Blockout·최종 환경 | High | Todo |
| VS-6002 | 일반 몬스터 3종 최종 제작 | High | Todo |
| VS-6003 | 첫 보스 최종 제작 | High | Todo |
| VS-6004 | 캠프 시설 3종 최종 제작 | High | Todo |
| VS-6005 | 로비·전투·결과·캠프 UI | High | Todo |
| VS-6006 | 루나 스킬·VFX·타격감 폴리시 | High | Todo |
| VS-6007 | 저장·튜토리얼·설정 | High | Todo |
| VS-6008 | 사운드·음악 1차 | Medium | Todo |
| VS-6009 | 성능·메모리·로딩 최적화 | High | Todo |
| VS-6010 | 외부 Vertical Slice 테스트 | High | Todo |

외부 사용자가 캐릭터 매력, 전투, 탐험, 귀환, 캠프 성장의 핵심 재미를 한 구간에서 경험하면 완료한다.

## Sprint 7. 나머지 캐릭터와 전체 콘텐츠

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| PROD-7001~7004 | 미유·코코·이리스·노아 최종 모델·애니메이션·VFX | High | Todo |
| PROD-7005 | 폐쇄된 연구소 | High | Todo |
| PROD-7006 | 추가 몬스터 3종·보스 1종 | High | Todo |
| PROD-7007 | 캠프 시설 4종 이상과 성장 연출 | High | Todo |
| PROD-7008 | 캐릭터 해금 임무와 친밀도 | Medium | Todo |
| PROD-7009 | 캐릭터별 대화·로비 상호작용 | Medium | Todo |
| PROD-7010 | 전체 UI·VFX·사운드 | High | Todo |

5명, 2개 스테이지, 일반 몬스터 6종, 보스 2종과 성장 루프를 처음부터 끝까지 플레이할 수 있어야 한다.

## Sprint 8. QA와 출시 준비

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| REL-8001 | 전체 회귀 테스트 | High | Todo |
| REL-8002 | 저장 안정화·마이그레이션 | High | Todo |
| REL-8003 | 실제 기기·다양한 PC 사양 | High | Todo |
| REL-8004 | CPU·GPU·메모리·GC·Draw Call 최적화 | High | Todo |
| REL-8005 | 해상도·입력·키 설정 | High | Todo |
| REL-8006 | 리깅·관통·애니메이션 폴리시 | High | Todo |
| REL-8007 | 승인되지 않은 WIP 제거 | High | Todo |
| REL-8008 | 라이선스·AI 생성 메타데이터 | High | Todo |
| REL-8009 | 스토어 이미지·트레일러·설명 | Medium | Todo |
| REL-8010 | 체험판 또는 외부 베타 | High | Todo |
| REL-8011 | Release Candidate 승인 | High | Todo |

## 운영 규칙

- 작업 시작 전에 ID를 `In Progress`로 바꾼다.
- 구현 경로와 검증 근거는 `planning/IMPLEMENTATION_STATUS.md`에 기록한다.
- 코드가 동작해도 필요한 자동 테스트·직접 검증이 없으면 `Done`으로 바꾸지 않는다.
- 아트는 사람 승인 전까지 `APPROVED`나 최종 게임 자산으로 취급하지 않는다.
- 플레이어블은 전원 성인 여성으로 제작하고 남성 생성 결과는 승인 후보로 올리지 않는다.
- 루나 Approved 2D 시트와 Character Proof 전에 최종 3D를 대량 제작하지 않는다.
- ComfyUI·대용량 모델은 현재 선행 조건이 아니며 실제 아트 병목이 생길 때만 `ART-0108`을 `Ready`로 전환한다.
- Git 커밋·push·PR은 사용자가 명시적으로 요청할 때 수행한다.
