# Re:Camp Current Generation Workspace

1. 모든 작업 시작 시 현재 branch, short HEAD, `git status --short`를 확인한다.
2. 신규 작업의 기준 브랜치는 `current/recamp-unified`다. `legacy/recamp-pre-generation`은 과거 비교용이며 신규 작업을 진행하지 않는다.
3. 제품·플랫폼·전역 비주얼·Current 로스터·전역 비율·1인 제작 예산·현재 Gate는 `docs/00_project/CURRENT_PROJECT_BASELINE.md`만 기준으로 읽는다. 이 내용을 AGENTS, Skill, README, Roadmap, Backlog에 복제하지 않는다.
4. 사용자가 작업을 지정하지 않았다면 `planning/sprint_backlog.md`의 첫 `In Progress`, 없으면 첫 `Ready` 항목을 선택한다.
5. Baseline의 `LLM 작업별 필수 Read Set`과 대상 작업이 직접 참조하는 문서만 추가로 읽는다. 날짜가 붙은 리셋·정렬 문서는 변경 이력이지 Canonical 기준이 아니다.
6. `.agents/skills/recamp-unity/SKILL.md`의 구현·MCP·검증 절차를 적용한다.
7. 기존 사용자 변경을 보존하고 `Library/`, `Temp/`, 패키지 캐시, 설치된 플러그인·MCP 캐시는 수정하지 않는다.
8. Unity 변경은 Compile, `_ReCamp` Console, 필요한 EditMode·PlayMode·직접 Play Mode 검증을 수행하고 실제 결과만 `planning/IMPLEMENTATION_STATUS.md`에 기록한다.
9. 아트는 사람 승인과 review 기록 전까지 `APPROVED`로 표시하지 않는다. Legacy·REJECTED·INVALID·Gate 실패 자산을 Current 제작 앵커로 사용하지 않는다.
10. 문서 변경 후 `python scripts/validate_project_docs.py`를 실행한다.
11. Current에서 작업 브랜치를 만들 때는 `feature/*`, `art/*`, `docs/*`, `fix/*`로 짧게 분기하고 `current/recamp-unified`로 통합한다.
12. `main` 병합은 Current Generation의 구현·디자인 기준이 안정화된 뒤 별도 검토로 수행한다.
