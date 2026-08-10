# Re:Camp Planning Index — Current Generation

> 최종 갱신: 2026-08-10
> 역할: 작업 선택·상태·문서 탐색 규칙

전역 제품·디자인 기준은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`만 소유한다. 이 문서에서는 플랫폼·로스터·비율·아트 방향을 다시 설명하지 않는다.

## 작업 시작 순서

1. `current/recamp-unified` 또는 여기서 분기한 작업 브랜치인지 확인한다.
2. `docs/00_project/CURRENT_PROJECT_BASELINE.md`를 읽는다.
3. 사용자가 지정한 작업을 우선한다. 지정이 없으면 `sprint_backlog.md`의 첫 `In Progress`, 그다음 첫 `Ready`를 선택한다.
4. 대상 ID의 완료 조건을 확인한다.
5. Baseline의 `LLM 작업별 필수 Read Set`에 지정된 분야 문서와 관련 코드·테스트만 읽는다.
6. 작업 후 `sprint_backlog.md`와 `IMPLEMENTATION_STATUS.md`에 상태와 실제 증거를 기록한다.
7. 문서 변경은 `python scripts/validate_project_docs.py`로 검증한다.

## Planning 문서 역할

| 문서 | 소유 내용 |
|---|---|
| `sprint_backlog.md` | 실제 작업 ID·순서·상태·완료 조건 |
| `roadmap.md` | 마일스톤·Gate·단계 Exit 조건 |
| `IMPLEMENTATION_STATUS.md` | 구현·테스트·환경·제약의 실제 증거 |
| `art_production_roadmap.md` | 아트 제작 단계와 Gate 의존 관계 |
| `art_production_backlog.md` | 아트 산출물 ID·상태·완료 조건 |
| `DEV-0113_CORE_INTEGRATION_RESULT.md` | Domain·Adapter·Runtime 통합 결과 |
| `COPLAY_MCP_HANDOFF.md` | Unity MCP 연결·복구·회귀 절차 |

## 날짜형 디자인 문서

다음과 같은 날짜형 리셋·정렬 문서는 **결정이 만들어진 과정과 당시 상태를 보존하는 변경 이력**이다.

- `DESIGN_DIRECTION_2026-08-09.md`
- `ART_DIRECTION_RESET_BRIEF_2026-08-09.md`
- `DESIGN_PROGRESS_2026-08-07.md`
- `docs/plans/DESIGN_REFACTOR_ALIGNMENT_2026-08-09.md`

Current Generation의 제품·로스터·비율·Production Budget을 판단할 때 이 문서들을 Canonical source로 사용하지 않는다. 최신 결정은 Baseline, 캐릭터 세부사항은 직접 소유 문서를 따른다.

## 상태

| 상태 | 의미 |
|---|---|
| `Todo` | 결과 없음 |
| `Ready` | 선행 조건 충족 |
| `In Progress` | 현재 작업 중 |
| `Review` | 핵심 결과는 있으나 검증·재현·사람 승인 일부가 남음 |
| `Blocked` | 외부 설치·기기·사용자 결정·승인 필요 |
| `Deferred` | 실제 병목이 생길 때 재평가 |
| `Done` | 완료 조건과 필요한 증거 충족 |

## 갱신 원칙

- 전역 방향을 Planning 문서에 복제하지 않는다.
- 실행 순서 변경은 `sprint_backlog.md`에서만 한다.
- 테스트 수치와 실행 결과는 `IMPLEMENTATION_STATUS.md`에서만 관리한다.
- Roadmap은 마일스톤·Gate, Backlog는 ID·상태·완료 조건만 관리한다.
- 디자인 변경은 Baseline과 직접 소유 문서에만 반영하고 날짜형 리셋 문서를 새 Canonical 문서로 추가하지 않는다.
- Legacy 자료는 필요할 때만 `legacy/recamp-pre-generation`에서 읽는다.
- 코드 존재만으로 `Done`, 생성 이미지 품질만으로 `APPROVED` 처리하지 않는다.
