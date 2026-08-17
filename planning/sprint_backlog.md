# Re:Camp Current Generation Sprint Backlog

> 최종 갱신: 2026-08-10
> 역할: 실제 작업 ID·실행 순서·상태·완료 조건의 단일 기준

전역 제품·디자인 기준은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`를 따른다. 이 Backlog에서는 캐릭터 이름·비율·플랫폼·Production Budget을 다시 정의하지 않는다.

## 상태

| 상태 | 의미 |
|---|---|
| `Todo` | 결과 없음 |
| `Ready` | 선행 조건 충족 |
| `In Progress` | 현재 작업 중 |
| `Review` | 구현/산출물은 있으나 검증·재현·사람 승인 일부가 남음 |
| `Blocked` | 외부 설치·기기·사용자 결정·승인 필요 |
| `Deferred` | 실제 병목이 생길 때 재평가 |
| `Done` | 완료 조건과 필요한 증거 충족 |

## 현재 P0 실행 큐

| 순서 | ID | 작업 | 상태 | 다음 완료 조건 |
|---:|---|---|---|---|
| 1 | DEV-0115 | Landscape·Safe Area | Review | 화면비·Cutout 자동/실기기 증거 |
| 2 | DEV-0116 | Touch 입력·HUD | Review | 포인터 소유권·중단/복귀 자동 회귀 추가 완료. Android 기기 Smoke |
| 3 | DEV-0114 | Android Build Support·도구 체인 | Blocked | Unity AndroidPlayer·SDK·NDK·OpenJDK 설치 |
| 4 | DEV-0117 | App ID·첫 APK·실기기 Smoke | Blocked | AndroidPlayer 설치 + Re:Camp 소유 Identifier 결정 + ARM64 IL2CPP APK·실기기 Smoke |
| 5 | ART-0103·0111 | 제작 시트 도구 실사용 검증 | Review | Import·Clone·한글·PNG/PDF Export·사람 사용성 |
| 6 | ART-1001~1409 | Current 캐릭터 2D 후보·제작 시트 | In Progress | 캐릭터별 통제 후보, 비교 보드, 사람 Gate A, 제작 시트 |
| 7 | ART-1501~1504 | 5인 교차 디자인·유사성 검토 | Todo | 얼굴·실루엣·저채도·원작성 비교 증거 |
| 8 | ART-0112 | 2D→3D 변환표 Proof | Todo | Gate A 선택 후보의 단순화·제작 위험 검증 |
| 9 | ART-0104 | Blender 소품 Export Proof | Ready | 명명 규격 Source→FBX→기록 |
| 10 | ART-0109·0110 | 자산·Animation Handoff 계약 | Review | Current/Legacy 경계와 공용/고유 Motion 검토 |
| 11 | CHR-0360 | 역할 밸런스·중복 검토 | Review | 수동 플레이 기록·수치 보정 |

## Sprint 0 — 저장소·세대·문서 기반

| ID | 작업 | 상태 | 완료 조건 |
|---|---|---|---|
| RC-0001~0012 | 저장소·기획·LFS·문서 기반 | Done | 기존 근거 유지 |
| RC-0013 | Canonical Baseline | Done | 전역 결정 단일 소스 존재 |
| GEN-0001 | Legacy / Current Generation 분리 | Done | `legacy/recamp-pre-generation`, `current/recamp-unified` 역할 고정 |
| GEN-0002 | Current 문서 소유권 정리 | Done | AGENTS·Skill·README·Planning·Design 문서가 소유 범위만 관리 |
| GEN-0003 | Current 문서 정합성 CI | Done | PR #9에서 전체 활성 Markdown 정합성 검사 통과 |

## Sprint 1 — Unity·Core·Android 기반

| ID | 작업 | 상태 | 남은 완료 조건 |
|---|---|---|---|
| DEV-0101~0103 | Unity 프로젝트·저장소 구조 | Done | 없음 |
| DEV-0104 | Fresh Clone 재현 | Review | 별도 Clone·Unity Open·Compile·Test |
| DEV-0105~0107 | Scene·Loader·GameManager | Done | 없음 |
| DEV-0108~0109 | Core 감사·경계 결정 | Done | 없음 |
| DEV-0110 | Domain 상태와 Presentation 연결 | Review | 잔여 중복 규칙 정리 |
| DEV-0111 | 테스트 Assembly | Done | 없음 |
| DEV-0112 | Core·Unity CI | Review | Hosted Unity license 설정 후 실제 Test Runner 성공 결과 |
| DEV-0113 | Domain 정산·스킬 Command/Event 통합 | Done | 현재 회귀 기준 유지 |
| DEV-0114 | Android Build Support | Blocked | `DEV-0114_ANDROID_TOOLCHAIN_PREFLIGHT.json` 기준 Unity AndroidPlayer·Embedded SDK/NDK/OpenJDK 설치 후 preflight PASS |
| DEV-0115 | Landscape·Safe Area | Review | ProjectSettings Landscape preflight PASS, `SafeAreaLayout`·Battle HUD 연결, 화면비/cutout 자동 matrix 증거 추가. AndroidPlayer·실기기 검증 필요 |
| DEV-0116 | Touch Control | Review | `TouchHoldButton` 포인터 ID 소유권과 멀티터치 Up/Exit 회귀 증거 추가. Android 기기 Smoke 필요 |
| DEV-0117 | App ID·Build Profile·첫 APK | Blocked | `DEV-0117_ANDROID_RELEASE_PREFLIGHT.json`의 Template Identifier를 교체하고 DEV-0114 선행 조건 후 APK·Lifecycle 증거 |

실제 테스트 수치는 `IMPLEMENTATION_STATUS.md`에서만 관리한다.

## Sprint 2 — 핵심 루프·Gray Box

| 범위 | 상태 | 남은 완료 조건 |
|---|---|---|
| Scene 흐름 | Done | 회귀 유지 |
| 이동·카메라·아레나 | Done | 최종 아트 framing 재검토 |
| 기본 전투·적·Wave·Boss | Done | 밸런스·피드백 폴리시 |
| 자원·귀환·결과·저장 | Done | Android Lifecycle·손상/업데이트 확대 |
| PC/Touch 공통 입력 | Review | 실기기 입력 감도·중단/복귀 |
| 전투·정산 통합 테스트 | Done | Current migration 후 재실행 |

## Sprint 3 — 역할 Prototype

| 범위 | 상태 | 남은 완료 조건 |
|---|---|---|
| 공용 Stats·Ability·선택 | Done | Current Runtime handoff 전까지 회귀 기반으로 유지 |
| 기존 5개 Gameplay 역할 | Review | 수동 밸런스·Current 표현 매핑 검증 |
| 자동 Ability 테스트 | Done | Current migration 후 재실행 |
| CHR-0360 역할 중복 검토 | Review | 실제 플레이 기록 |

Legacy 외형을 유지한다는 의미가 아니라 **검증된 Gameplay 구조를 Current Generation에서 재사용하기 위한 기능 Proof**다.

## Sprint 4 — Current 캐릭터 2D

세부 산출물 ID와 상태는 `planning/art_production_backlog.md`가 소유한다.

Exit 조건:

- 캐릭터별 후보와 동일 조건 비교.
- 사람 Gate A.
- Approved 제작 시트.
- 2D→3D 변환표.
- metadata·review 추적.

## Sprint 5 — CH101 Character Proof

| 범위 | 상태 |
|---|---|
| Approved 2D 시트 | Todo |
| 3D Blockout·Gate B/C | Todo |
| 공용 Rig·Shader·Animator Proof | Todo |
| 최종 Model·Motion·VFX·Audio | Todo |
| Runtime handoff | Todo |
| Android Character Proof | Todo |

## Sprint 6 — Vertical Slice

| ID | 작업 | 상태 |
|---|---|---|
| VS-6001 | 첫 환경 세트 | Todo |
| VS-6002 | 일반 적 세트 | Todo |
| VS-6003 | 첫 보스 | Todo |
| VS-6004 | 캠프 핵심 시설 Presentation | Todo |
| VS-6005 | 로비·전투·결과·캠프 UI | Todo |
| VS-6006 | CH101 VFX·타격감 | Todo |
| VS-6007 | 저장·튜토리얼·설정 | Todo |
| VS-6008 | 사운드·음악 | Todo |
| VS-6009 | 성능·메모리·로딩 | Todo |
| VS-6010 | 외부 테스트 | Todo |

## Sprint 7 — 나머지 캐릭터·출시 콘텐츠

| ID | 작업 | 상태 |
|---|---|---|
| PROD-7001~7004 | 나머지 Current 캐릭터 최종 자산 | Todo |
| PROD-7005 | 추가 환경 | Todo |
| PROD-7006 | 추가 적·보스 | Todo |
| PROD-7007 | 캠프 성장 연출 | Todo |
| PROD-7008 | 해금·관계 콘텐츠 | Todo |
| PROD-7009 | 로비 상호작용 | Todo |
| PROD-7010 | 전체 UI·VFX·Audio | Todo |

## Sprint 8 — QA·Release

| ID | 작업 | 상태 |
|---|---|---|
| REL-8001 | 전체 회귀 | Todo |
| REL-8002 | Save Migration·손상 방지 | Todo |
| REL-8003 | Android 기기 매트릭스 | Todo |
| REL-8004 | CPU·GPU·메모리·GC·Draw Call | Todo |
| REL-8005 | 화면비·입력·Lifecycle | Todo |
| REL-8006 | Rig·관통·Animation 폴리시 | Todo |
| REL-8007 | WIP·Placeholder 제거 | Todo |
| REL-8008 | 라이선스·AI metadata·유사성 | Todo |
| REL-8009 | Store 자산 | Todo |
| REL-8010 | 외부 베타 | Todo |
| REL-8011 | Release Candidate 승인 | Todo |

## 운영 규칙

- 전역 방향은 Baseline에서만 변경한다.
- 이 파일은 ID·순서·상태·완료 조건만 소유한다.
- 실제 실행 결과와 테스트 수치는 `IMPLEMENTATION_STATUS.md`에만 기록한다.
- 디자인 상세는 Character Bible/Anchor/Art Direction의 소유 범위만 따른다.
- 날짜형 리셋 문서를 새 실행 기준으로 사용하지 않는다.
- Legacy와 Current를 직접 병합하지 않는다.
