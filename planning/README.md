# Re:Camp Planning Index

이 디렉터리는 Re:Camp에서 **무엇을 어떤 순서로 진행할지 관리하는 단일 실행 진입점**이다.

프로젝트의 최신 결정은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`를 우선하며, 실제 작업 상태는 `sprint_backlog.md`에서 관리한다.

## 1. 확인 순서

```text
1. docs/00_project/CURRENT_PROJECT_BASELINE.md
2. planning/sprint_backlog.md
3. planning/roadmap.md
4. 분야별 Backlog와 Spec
5. tables/와 APPROVED art_refs/
```

## 2. 계획 문서

| 문서 | 역할 |
|---|---|
| `roadmap.md` | 전체 Milestone, Gate, 장기 선후 관계 |
| `sprint_backlog.md` | 현재부터 실제로 처리할 통합 작업 |
| `SCOPE_AND_RISK_RULES.md` | Vertical Slice 범위와 축소 기준 |
| `art_production_roadmap.md` | 2D·3D·환경·UI·VFX 아트 제작 순서 |
| `art_production_backlog.md` | 아트 세부 작업과 상태 |
| `art_production_next_actions.md` | 지금 바로 수행할 아트 작업 |

## 3. 분야별 기준 문서

| 분야 | 기준 문서 |
|---|---|
| 현재 프로젝트 기준 | `docs/00_project/CURRENT_PROJECT_BASELINE.md` |
| 게임 콘셉트 | `docs/01_game_design/GAME_CONCEPT.md` |
| MVP·Vertical Slice | `docs/01_game_design/MVP_SCOPE.md` |
| 카메라·입력·UI | `docs/04_ui_ux/CAMERA_AND_UI_BASELINE.md` |
| 캐릭터 설정 | `docs/05_art_concept/CHARACTER_BIBLE.md` |
| 공통 아트 방향 | `docs/05_art_concept/ART_DIRECTION.md` |
| 제작 시작 순서 | `docs/05_art_concept/ART_PRODUCTION_START_GUIDE.md` |
| MCP 제작 파이프라인 | `docs/05_art_concept/ART_PRODUCTION_MCP_GUIDE.md` |
| ComfyUI 일관성 | `docs/05_art_concept/COMFYUI_CHARACTER_CONSISTENCY_SPEC.md` |
| 3D 캐릭터 | `docs/05_art_concept/CHARACTER_3D_SPEC.md` |
| Animation | `docs/05_art_concept/ANIMATION_GUIDE.md` |
| Unity Import·Prefab | `docs/05_art_concept/UNITY_ART_IMPORT_GUIDE.md` |
| 환경·몬스터·VFX | `docs/05_art_concept/ENVIRONMENT_AND_VFX_SPEC.md` |
| 자산 구조·승인 | `docs/05_art_concept/ART_ASSET_STRUCTURE.md` |
| 파일명 | `docs/05_art_concept/ASSET_NAMING_GUIDE.md` |
| 기술·성능 | `docs/06_dev_docs/TECHNICAL_TARGETS.md` |
| 구현 데이터 | `tables/` |

## 4. 작업 ID 규칙

| Prefix | 분야 | 예시 |
|---|---|---|
| `PROJ-` | 저장소·문서·운영 | `PROJ-0001` |
| `DEV-` | Unity 프로젝트·기술 기반 | `DEV-0101` |
| `GAME-` | Scene·전투·성장·저장 | `GAME-0201` |
| `CHR-PROT-` | 캐릭터 플레이 프로토타입 | `CHR-PROT-0301` |
| `ART-PIPE-` | 아트 제작 파이프라인 | `ART-PIPE-0101` |
| `ART-2D-` | 캐릭터 2D 제작 시트 | `ART-2D-1001` |
| `ART-3D-` | 캐릭터 모델·Rig·Animation | `ART-3D-2001` |
| `ART-ENV-` | 환경·몬스터·소품 | `ART-ENV-3001` |
| `ART-UI-` | UI Design·Export | `ART-UI-4001` |
| `ART-VFX-` | VFX·Feedback | `ART-VFX-5001` |
| `TEST-` | 기능·아트·성능 검증 | `TEST-4001` |
| `VS-` | Vertical Slice 통합 | `VS-6001` |
| `PROD-` | 출시 범위 확장 | `PROD-7001` |
| `REL-` | QA·최적화·배포 | `REL-8001` |

### 이전 ID 처리

```text
ART-010x → ART-PIPE-010x
ART-100x~140x → ART-2D-1xxx
ART-200x / ART-500x → ART-3D-2xxx
환경 ART-300x → ART-ENV-300x
UI ART-400x → ART-UI-400x
VFX 작업 → ART-VFX-500x
```

기존 Commit이나 PR의 과거 ID는 변경하지 않되 신규 작업에는 새 ID만 사용한다.

## 5. 상태 정의

| 상태 | 의미 |
|---|---|
| `Todo` | 시작 전 |
| `Ready` | 선행 조건 충족, 즉시 시작 가능 |
| `In Progress` | 현재 작업 중 |
| `Review` | 코드·문서·아트·사용자 검증 대기 |
| `Blocked` | 선행 작업이나 결정 때문에 진행 불가 |
| `Done` | 결과물·검증·링크가 모두 존재 |

아트 자산은 `WIP`, `REVIEW`, `APPROVED`, `SUPERSEDED`, `ARCHIVE`를 사용한다.

## 6. 현재 우선순위

1. 문서 기준 통합과 중복 ID 제거
2. Unity 6.3 LTS URP 프로젝트 생성
3. 고정 쿼터뷰 Camera Gray Box
4. ReCamp.Core Unity 통합
5. 완주 가능한 전투 Gray Box
6. 루나 2D Approved 제작 시트
7. 루나 3D Blockout과 Coplay Import·Prefab 검증
8. Editor Script·Preset·수동 Unity 검증
9. 루나 Character Proof
10. Portfolio Vertical Slice
11. 나머지 캐릭터와 출시 콘텐츠

## 7. Coplay 운영 규칙

- Coplay MCP를 Unity 자동화의 기본 도구로 사용한다.
- 작업 전 대상 Scene·Prefab·파일을 명확히 지정한다.
- 동일 속성 반복 수정은 Batch Operation으로 묶는다.
- 변경 후 전체 Scene보다 Diff·Summary·Console을 우선 확인한다.
- 반복되는 Import·검증 규칙은 Unity Editor Script 또는 Preset으로 코드화한다.
- Coplay가 지원하지 않는 작업은 수동 Inspector 작업으로 진행한다.
- 성공 기준은 Tool 호출이 아니라 Unity Console, Prefab Diff, PlayMode, Profiler 결과다.

Aura AI는 체험 이후 유료 사용이 필요한 구조이므로 필수 도구와 Backlog 선행 조건에서 제외한다.

## 8. 작업 진행 절차

```text
1. sprint_backlog.md에서 가장 위의 Ready 작업 선택
2. 작업 ID를 In Progress로 변경
3. 관련 Roadmap Gate와 Spec 확인
4. 코드·아트·문서 작업 수행
5. 자동 테스트 또는 직접 검증
6. 결과 경로·Commit·PR·스크린샷 기록
7. Review 또는 Done 상태 반영
8. 다음 작업의 Blocked/Ready 상태 갱신
```

## 9. 완료 기록

```text
작업 ID
결과 파일 경로
사용 도구와 버전
검증 방법과 결과
Commit 또는 PR
남은 문제
다음 작업
```

## 10. 계획 갱신 원칙

- `CURRENT_PROJECT_BASELINE.md`, Roadmap, Backlog가 충돌하면 같은 PR에서 함께 수정한다.
- 실제 검증 전의 수치 Spec은 `Review`로 유지한다.
- Unity 프로젝트가 없으면 Import·Prefab 작업은 `Blocked`다.
- 개별 Approved 제작 시트가 없으면 최종 캐릭터 모델링은 `Blocked`다.
- Portfolio Vertical Slice 승인 전에는 장기 출시 자산을 대량 제작하지 않는다.
- 별도 유료 도구를 필수 선행 조건으로 추가하지 않는다.
- 완료 조건과 결과 링크가 없으면 `Done`으로 변경하지 않는다.
