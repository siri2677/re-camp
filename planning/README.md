# Re:Camp Planning Index

이 디렉터리는 Re:Camp 개발을 진행할 때 가장 먼저 확인해야 하는 **실행 계획의 단일 진입점**이다.

게임 기획과 아트 기준은 `docs/`에 보관하지만, 실제로 무엇을 어떤 순서로 진행할지는 반드시 `planning/` 문서를 기준으로 판단한다.

## 문서 구성

| 문서 | 역할 | 확인 시점 |
|---|---|---|
| `roadmap.md` | 개발·아트·출시 전체 마일스톤과 선후 관계 | 큰 단계와 우선순위 결정 |
| `sprint_backlog.md` | 현재부터 순서대로 처리할 통합 작업 목록 | 매 작업 시작 전 |
| `art_production_roadmap.md` | 캐릭터·환경·UI·3D 아트 제작 단계 | 아트 단계 결정 |
| `art_production_backlog.md` | 캐릭터 5명과 아트 자산의 세부 작업 ID | 아트 작업 시작·완료 시 |
| `art_production_next_actions.md` | 현재 바로 실행할 아트 작업과 입력·결과물 | 아트 작업을 실제로 시작할 때 |

## 작업 기준 문서

계획에서 특정 작업을 수행할 때 다음 문서를 함께 참조한다.

| 분야 | 기준 문서 |
|---|---|
| 게임 콘셉트 | `docs/01_game_design/GAME_CONCEPT.md` |
| MVP 범위 | `docs/01_game_design/MVP_SCOPE.md` |
| 캐릭터 설정 | `docs/05_art_concept/CHARACTER_BIBLE.md` |
| 공통 아트 방향 | `docs/05_art_concept/ART_DIRECTION.md` |
| 아트 작업 시작 순서 | `docs/05_art_concept/ART_PRODUCTION_START_GUIDE.md` |
| 아트 MCP 파이프라인 | `docs/05_art_concept/ART_PRODUCTION_MCP_GUIDE.md` |
| ComfyUI 캐릭터 일관성 | `docs/05_art_concept/COMFYUI_CHARACTER_CONSISTENCY_SPEC.md` |
| 아트 디렉터리·승인 규칙 | `docs/05_art_concept/ART_ASSET_STRUCTURE.md` |
| 3D 캐릭터 수치 규격 | `docs/05_art_concept/CHARACTER_3D_SPEC.md` |
| 애니메이션 규격 | `docs/05_art_concept/ANIMATION_GUIDE.md` |
| Unity Import·Prefab 규격 | `docs/05_art_concept/UNITY_ART_IMPORT_GUIDE.md` |
| 아트 파일명 규칙 | `docs/05_art_concept/ASSET_NAMING_GUIDE.md` |
| 캐릭터·스킬·몬스터 수치 | `tables/` |

## 작업 진행 순서

```text
1. sprint_backlog.md에서 가장 위의 Todo 또는 In Progress 작업 선택
2. 아트 작업이면 art_production_next_actions.md의 현재 실행 순서 확인
3. roadmap.md에서 해당 작업이 속한 마일스톤과 완료 기준 확인
4. 관련 docs/와 tables/의 기준 확인
5. 기능 또는 아트 작업 수행
6. 테스트·리뷰·승인 기준 충족
7. 작업 상태와 결과 링크를 planning 문서에 반영
8. Git 커밋 또는 PR 생성
```

## 상태 정의

| 상태 | 의미 |
|---|---|
| Todo | 아직 시작하지 않음 |
| Ready | 선행 조건이 완료되어 즉시 시작 가능 |
| In Progress | 현재 작업 중 |
| Review | 코드·아트 리뷰 또는 사용자 검증 대기 |
| Blocked | 선행 작업, 도구, 의사결정 때문에 진행 불가 |
| Done | 완료 기준과 검증을 통과함 |

## 우선순위 규칙

1. 플레이 가능한 Vertical Slice에 직접 필요한 작업
2. 캐릭터 매력과 일관성을 결정하는 작업
3. 반복 제작 비용을 낮추는 공용 기반
4. 콘텐츠 확장
5. 출시 후 기능

아래 기능은 초기 출시 범위에 포함하지 않는다.

```text
멀티플레이
PvP
길드
실시간 서버
가챠
캐릭터별 완전 고유 골격
풀 보이스
오픈월드
대량의 스토리 컷신
```

## 계획 갱신 원칙

- 코드나 아트를 완료했어도 `planning/` 상태가 갱신되지 않으면 프로젝트 기준상 완료로 간주하지 않는다.
- 새 기능이나 아트 산출물을 추가하기 전에 반드시 Backlog ID를 먼저 등록한다.
- 요구사항이 바뀌면 관련 `docs/`와 `planning/`을 같은 변경 범위에서 함께 수정한다.
- `roadmap.md`는 방향과 완료 기준을 관리하고, 세부 구현 상태는 각 backlog에서 관리한다.
- 초기 수치 규격은 실제 Unity·모바일 검증 전까지 `Review`로 취급하며 테스트 결과를 근거로 조정한다.
