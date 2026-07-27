# Re:Camp Workspace Rules

1. 모든 작업 시작 시 현재 브랜치, HEAD, `git status --short`를 확인한다.
2. 제품·플랫폼·비주얼·로스터·현재 Gate는 `docs/00_project/CURRENT_PROJECT_BASELINE.md`만 기준으로 읽는다. 이 파일에 적힌 전역 결정을 `AGENTS.md`, Skill, README, Roadmap, Backlog에 복제하지 않는다.
3. 사용자가 작업을 명시하지 않았다면 `planning/sprint_backlog.md`에서 첫 `In Progress`, 없으면 첫 `Ready` 항목을 선택한다.
4. 선택한 작업의 완료 조건과 Baseline의 `LLM 작업별 필수 Read Set`에 지정된 문서만 추가로 읽는다. 저장소 전체 문서를 무차별적으로 읽지 않는다.
5. `.agents/skills/recamp-unity/SKILL.md`의 작업·MCP·검증 절차를 적용한다.
6. 기존 사용자 변경을 보존하고 `Library/`, `Temp/`, 패키지 캐시, 설치된 플러그인·MCP 캐시는 수정하지 않는다.
7. Unity 변경은 Compile, `_ReCamp` Console, 필요한 EditMode·PlayMode·직접 Play Mode 검증을 수행하고 결과를 `planning/IMPLEMENTATION_STATUS.md`에 기록한다.
8. 아트는 사람 승인과 review 기록 전까지 `APPROVED`로 표시하지 않는다. `REJECTED`, `INVALID`, Gate 실패 자산은 비교 이력으로만 사용한다.
9. 문서 변경 후 `python scripts/validate_project_docs.py`를 실행한다.
10. 커밋·푸시·PR·병합은 사용자가 명시적으로 요청한 경우에만 수행한다.
