# Re:Camp Design Refactor Alignment Record — 2026-08-09

> 상태: `HISTORICAL / SUPERSEDED`
> Current Canonical: `docs/00_project/CURRENT_PROJECT_BASELINE.md`

이 문서는 2026-08-09 디자인 리셋을 기존 Unity Runtime·Save·Gameplay와 분리해 적용하기 위해 작성했던 정렬 계약의 역사 기록이다.

현재 문서 우선순위나 Active 로스터를 정의하지 않는다.

## 보존하는 핵심 원칙

- 디자인 문서 변경은 Runtime CharacterId·HUD·Prefab·Save를 자동 변경하지 않는다.
- `ReCamp.Domain → ReCamp.UnityAdapter → ReCamp.Runtime` 경계를 유지한다.
- 정산·Save·Skill Command/Event 규칙을 Presentation에서 중복 구현하지 않는다.
- 신규 캐릭터 Runtime handoff는 사람 Gate와 별도 Migration 작업을 거친다.
- Android 입력·Lifecycle·APK·실기기 검증은 별도 기술 Gate다.
- 플레이테스트 전 밸런스 수치를 문서만으로 임의 확정하지 않는다.

## 현재 확인 위치

- 세대·제품·디자인·Production Budget: `CURRENT_PROJECT_BASELINE.md`
- 시스템 구조: `docs/02_system_design/MVP_SYSTEM_ARCHITECTURE.md`
- Save: `docs/02_system_design/SAVE_DATA_SPEC.md`
- 모바일 입력·Lifecycle: `docs/04_ui_ux/MOBILE_INPUT_AND_LIFECYCLE.md`
- 실행 상태: `planning/sprint_backlog.md`
- 실제 구현·테스트 증거: `planning/IMPLEMENTATION_STATUS.md`

이 파일과 Current 문서가 충돌하면 Current 소유 문서가 항상 우선한다.
