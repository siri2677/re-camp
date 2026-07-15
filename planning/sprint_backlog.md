# Re:Camp Integrated Sprint Backlog

이 문서는 실제 작업을 시작할 때 가장 먼저 확인하는 통합 작업 목록이다. 원격 계획의 ID 체계를 유지하고, 로컬 Unity 구현의 검증 상태를 반영한다.

상태는 `Todo`, `Ready`, `In Progress`, `Review`, `Deferred`, `Blocked`, `Done`을 사용한다.

- `Done`: 구현과 직접 검증이 모두 끝남
- `Review`: 구현됐지만 Git 재현성·자동 테스트·사람 승인 중 하나가 남음
- `Deferred`: 필요성이 확인될 때 도입하는 선택 작업이며 현재 실행 큐나 선행 조건이 아님
- `Blocked`: 외부 연결, 손상된 기준 자산, 사용자 승인 등 명시적 선행 조건이 없음

## 현재 P0 실행 큐

| 순서 | ID | 작업 | 상태 | 다음 완료 조건 |
|---:|---|---|---|---|
| 1 | RC-0011 | 성인 여성 5인·남성향 통합 라인업 `REVIEW v003` 검토 | Review | 원본 입력·all adult female·SD-lite 교정 완료, 사람 승인 필요 |
| 2 | DEV-0111 | EditMode·PlayMode 테스트 Assembly 구성 | Done | 최종 EditMode 23/23, PlayMode 18/18 통과 |
| 3 | TEST-0202 | 전투·보상·정산 회귀 테스트 | Review | 적 생명주기·선택 상태·캠프 정산 저장까지 자동화, Scene 전환 통합 테스트 남음 |
| 4 | DEV-0108 | Unity 비종속 Core 호환성·중복 규칙 검토 | Ready | 공유 Assembly 또는 Adapter 구조 결정 |
| 5 | CHR-0301 | 공용 CharacterController·Stats 구조 | Done | 5인 Roster·Stats·Ability 기반과 테스트 완료 |
| 6 | CHR-0302 | 캐릭터 선택·데이터 적용 | Done | Lobby 선택 → Battle 이리스 데이터 유지 직접 검증 |
| 7 | CHR-0310 | 루나 대시·근접 연속 공격 | Review | 캣 스텝·3타 콤보와 자동 테스트 완료, VFX·수치 튜닝 남음 |
| 8 | CHR-0311 | 루나 스캔·자원 탐지 | Review | 스캔·강조·획득 반경 확대와 자동 테스트 완료, 최종 피드백 남음 |

## Sprint 0. 저장소·기획·아트 방향

| ID | 작업 | 우선순위 | 상태 | 근거·비고 |
|---|---|---:|---|---|
| RC-0001~0010 | 저장소·기획·테이블·아트 가이드 기반 | High | Done | 원격 `origin/main` 문서 기준 |
| RC-0011 | 통합 캐릭터 라인업 교정 시안 | High | Review | 혼성 v002는 REJECTED. 원본 계보·전원 성인 여성·남성향·SD-lite v003 완료 |
| RC-0012 | Git LFS 규칙을 현재 아트 구조에 맞게 검증 | High | Done | PNG·FBX·BLEND 및 KRA·TGA·EXR 포함, `git check-attr` 검증 |

## Sprint 1. Unity 프로젝트·Core 통합 기반

| ID | 작업 | 우선순위 | 상태 | 근거·남은 일 |
|---|---|---:|---|---|
| DEV-0101 | Unity 버전 확정 및 프로젝트 생성 | High | Review | 로컬 `6000.5.3f1` 동작, LTS 정책 표기와 Git 재현성 남음 |
| DEV-0102 | Visible Meta Files·Force Text | High | Done | `m_SerializationMode: 2` 확인 |
| DEV-0103 | `Assets/_ReCamp` 구조 | High | Done | Scenes, Scripts, Art, Prefabs, Captures 존재 |
| DEV-0104 | `Packages`, `ProjectSettings`, `.meta` Git 반영 | High | Review | 로컬 존재, 아직 untracked |
| DEV-0105 | 기본 Scene 5개 | High | Done | Bootstrap·Title·Lobby·Battle·Result 존재 |
| DEV-0106 | SceneLoader | High | Done | 5개 Scene 이름 매핑 구현·수동 흐름 검증 |
| DEV-0107 | Unity GameManager·서비스 초기화 | High | Done | 지속 인스턴스와 CampManager 초기화 동작 |
| DEV-0108 | Core 런타임 호환성 검토 | High | Ready | 원격 비종속 Core와 로컬 규칙 비교 필요 |
| DEV-0109 | Core 공유·Assembly·Adapter 결정 | High | Todo | DEV-0108 선행 |
| DEV-0110 | Core 상태를 Unity Presentation에 연결 | High | Review | 현재 기능 동작, 중복 규칙 정리 필요 |
| DEV-0111 | EditMode·PlayMode 테스트 Assembly | High | Done | Unity Test Runner EditMode 23/23, PlayMode 18/18 통과 |
| DEV-0112 | Core·Unity CI | Medium | Todo | 로컬 테스트 안정화 후 구성 |
| DEV-0113 | 기존 비종속 Core 통합 | High | Ready | `origin/agent/unity-independent-core` 검토 필요 |

### 아트 파이프라인 병행

| ID | 작업 | 우선순위 | 상태 | 근거·남은 일 |
|---|---|---:|---|---|
| ART-0101 | 현재 이미지 생성 도구 기반 반복 워크플로 | High | Review | v002 실패 원인 기록 완료. 원본 이미지 앵커와 `all adult female` 프롬프트 회귀 조건 추가 필요 |
| ART-0102 | 도구 비종속 일관성 변수·메타데이터 정의 | High | Review | 공통 메타데이터 양식 추가, 캐릭터 앵커 변수 남음 |
| ART-0103 | Figma 캐릭터 시트 템플릿 | High | Ready | 템플릿 구성 필요 |
| ART-0104 | Blender MCP 연결·소품 Export | Medium | Blocked | Blender 런타임 소켓 연결 미검증 |
| ART-0105 | Coplay FBX Import·Prefab | Medium | Todo | ART-0104 선행 |
| ART-0106 | `art_source/` 구조 | Medium | Done | figma_exports·blender·textures·comfyui_workflows 생성 |
| ART-0108 | ComfyUI·ComfyUI MCP 도입·고정 워크플로 | Low | Deferred | 대량 일관성 생성·정밀 인페인팅·고정 Seed/LoRA/ControlNet/IP-Adapter 필요 시 재평가. 현재 모델·GPU·설치 불필요 |

## Sprint 2. Scene 흐름과 Gray Box 전투

| ID | 작업 | 우선순위 | 상태 | 근거·남은 일 |
|---|---|---:|---|---|
| DEV-0201~0204 | Bootstrap·Lobby·Battle·Result Gray Box | High | Done | Scene 4종 직접 실행 확인 |
| DEV-0205~0207 | Lobby → Battle → Result → Lobby | High | Done | 전체 Play Mode 흐름 검증 |
| DEV-0208 | Input System·PlayerController | High | Review | 카메라 상대 XZ 이동 구현, 실제 키보드 회귀 1회 필요 |
| DEV-0209 | 쿼터뷰 카메라·이동 경계 | High | Done | Orthographic `35.3° / 45°`, actor/camera clamp 검증 |
| DEV-0210 | 기본 공격·Hitbox·Damageable | High | Done | 자동 공격과 사망 처리 검증 |
| DEV-0211 | EnemyController·추적 AI | High | Done | XZ 추적·접촉 피해 검증 |
| DEV-0212 | EnemySpawner·웨이브·보스 | High | Done | 일반 웨이브 후 보스 스폰 검증 |
| DEV-0213 | 사망·보상 1회 지급 | High | Done | drop 위치 보존과 단일 보상 검증 |
| DEV-0214 | 귀환·사망·시간 종료 | High | Done | 5분 타이머, 60초 경고, R 홀드·HUD 버튼 귀환, 시간 만료 보존 귀환과 종료 사유 검증 |
| DEV-0215 | 결과 정산·로컬 저장 | High | Done | Scrap 2 / Food 1 결과·로비 유지 검증 |
| TEST-0201 | Scene 흐름 PlayMode 테스트 | High | Review | 5개 Build Settings 등록 자동 검증 통과, 실제 전환 자동화 남음 |
| TEST-0202 | 전투·보상·정산 테스트 | High | Review | Ledger·보호막·적 생명주기·캠프 정산 저장 검증 통과, 전체 Scene 정산 자동화 남음 |

## Sprint 3. 캐릭터 5명 전투 프로토타입

성인 여성 5명의 최종 아트 제작 전에 primitive/프록시로 플레이 차이를 검증한다. 프록시는 성별 표현을 검증하는 최종 자산이 아니다.

| ID | 작업 | 상태 |
|---|---|---|
| CHR-0301 | 공용 CharacterController·Stats·Ability 구조 | Done |
| CHR-0302 | 캐릭터 선택과 데이터 적용 | Done |
| CHR-0310~0311 | 루나: 대시·3타 콤보·스캔·자원 강조·획득 범위 확대 완료 | Review |
| CHR-0320~0321 | 미유: 드론 버스트·상시 자동 사격·오버클럭·자동 회수 범위 완료, 수동 지정 남음 | Review |
| CHR-0330~0331 | 코코: 즉시 회복·피해 흡수 보호막 완료, 상태 이상 시스템·해제 남음 | Review |
| CHR-0340~0341 | 이리스: 홀드 차지·보스 보정·표식·피해 증폭 완료, 최종 약점 연출 남음 | Review |
| CHR-0350~0351 | 노아: 가드·반격·실제 이동 차단 방벽·전방 밀쳐내기 완료 | Review |
| CHR-0360 | 5명 밸런스·역할 중복 검토 | Review |
| TEST-0301 | 캐릭터별 핵심 스킬 테스트 | Done |

## Sprint 4 이후

- 성인 여성 5명 단독 전신 후보와 남성향 캐릭터 매력·일관성 리뷰
- 각 캐릭터 Approved 2D 제작 시트
- 루나 Character Proof: 4~5등신 SD-lite Blockout, Rig, Toon Shader, 애니메이션, Prefab
- 루나 Vertical Slice 검증 후 나머지 4명과 전체 콘텐츠 확장
- 승인되지 않은 WIP는 최종 빌드에 포함하지 않음

세부 항목은 `planning/art_production_backlog.md`와 `planning/art_production_roadmap.md`를 따른다. 중복 ID는 통합 백로그의 의미를 우선하고, 아트 문서의 세부 ID는 다음 정리 작업에서 `ART-1xxx/2xxx/3xxx` 계층으로 정규화한다.

## 운영 규칙

- 작업 시작 전에 ID를 `In Progress`로 바꾼다.
- 구현 경로와 검증 근거를 `planning/IMPLEMENTATION_STATUS.md`에 기록한다.
- 자동 테스트가 필요한 항목은 수동 Play Mode 통과만으로 Done 처리하지 않는다.
- 아트는 `APPROVED` 전까지 최종 게임 자산으로 사용하지 않는다.
- 플레이어블 캐릭터는 전원 성인 여성으로 제작하며 남성 캐릭터 생성 결과는 승인 후보로 올리지 않는다.
- 캐릭터 최종 모델은 루나 Approved 2D 시트 이전에 대량 제작하지 않는다.
- ComfyUI·ComfyUI MCP는 현재 선행 조건이 아니다. 캐릭터 일관성 대량 생성, 정밀 인페인팅, 재현 가능한 고정 워크플로가 실제 병목일 때만 `ART-0108`을 `Ready`로 전환한다.
- Git 커밋·push·PR은 사용자가 명시적으로 요청할 때 수행한다.
