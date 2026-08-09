# Re:Camp Planning Index

> 최종 갱신: 2026-08-09

이 디렉터리는 Re:Camp 개발·아트 작업의 단일 실행 진입점이다. 게임 기획과 기술·아트 기준은
`docs/`에 보관하지만 실제 작업 순서와 상태는 `planning/`을 기준으로 판단한다.

## 작업 시작 순서

1. 제품·플랫폼·비주얼 방향이 필요한 작업은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`를 확인한다.
2. `sprint_backlog.md`의 현재 P0 실행 큐를 확인한다.
3. 첫 `In Progress`, 없으면 첫 `Ready` 항목 하나를 선택한다.
4. 작업 ID와 완료 조건을 확인한 뒤 필요한 `docs/`·`tables/` 문서만 읽는다.
5. 기능·아트·최소 관련 문서를 함께 갱신한다.
6. Unity 작업은 Compile, `_ReCamp` Console, EditMode·PlayMode 결과를 남긴다.
7. Android 작업은 Build Profile·기기·OS·APK/AAB·Lifecycle 증거를 남긴다.
8. 아트는 사람 승인 전까지 `APPROVED`로 표시하지 않는다.

## 고정 제품 방향

- 1차 제품 목표는 Google Play Android 가로형 출시이며 Windows는 개발·자동 테스트 기준이다.
- 제품 디자인 로스터는 CH101 아마사와 린, CH102 키사라기 마오, CH103 카나데 노조미, CH104 시온 타테가미, CH105 쿠로가네 아카리다.
- 현재 Unity의 기존 레거시 5인 로스터는 기능 검증용 Gray Box이며 신규 제품 로스터로 자동 마이그레이션하지 않는다.
- 타깃은 남성향 일본 모바일 서브컬처이며 성인 여성 캐릭터의 매력·여성성·역할 구분을 우선한다.
- 2D 대표 일러스트는 캐릭터별 약 6.8~7.4등신, 기본 약 7등신을 사용한다.
- 인게임 3D는 캐릭터별 약 5.2~5.8등신을 중심으로 하는 5~6등신 스타일라이즈드 체형을 사용한다.
- 2D는 패션·체형·표정·재질을, 3D는 얼굴·헤어·대표 장비·쿼터뷰 실루엣을 우선한다.
- 사용자 지정 레퍼런스는 `ART_DIRECTION.md`의 품질 매트릭스로만 흡수하며 고유 IP 요소는 복제하지 않는다.
- 신규 캐릭터는 사람 Gate A 전까지 후보 PNG 0/5, 상태 `REVIEW`, 승인 0/5로 유지한다.
- 2D 제작 시트마다 `2D to 3D Simplification`을 작성하고 단순 축소로 모델링하지 않는다.
- `battle_vertical_slice_concept.png`는 캐릭터 존재감·환경·카메라·색 대비의 전투 비주얼 참고이며 개별 캐릭터 외형·무기·파티 구성은 공식 디자인 기준이 아니다.
- 과거 v003 라인업은 Gate A `FAIL` 이력인 `HISTORY ONLY` 비교 자료다.
- 현재 Primitive·Gray Box는 기능 검증용이며 최종 아트 품질이 아니다.
- ComfyUI·대용량 로컬 생성 모델은 세부 일관성·인페인팅이 실제 병목이 될 때 도입하는 선택 사항이다.

원격 문서나 과거 시안과 충돌하면 위 사용자 결정과 최신 검증된 구현 상태가 우선한다.

## 문서 역할

| 문서 | 역할 | 확인 시점 |
|---|---|---|
| `docs/00_project/CURRENT_PROJECT_BASELINE.md` | 제품·플랫폼·비주얼·현재 Gate의 단일 기준 | 방향 충돌 또는 큰 단계 결정 |
| `roadmap.md` | 개발·아트·출시 마일스톤과 승인 게이트 | 큰 단계와 우선순위 결정 |
| `sprint_backlog.md` | 실제 작업 순서와 상태의 단일 기준 | 매 작업 시작 전 |
| `IMPLEMENTATION_STATUS.md` | 계획 ID와 구현·검증 근거 대응표 | 구현·검증 후 |
| `DEV-0113_CORE_INTEGRATION_RESULT.md` | Domain·Adapter·Runtime 통합 결과와 잔여 범위 | Core 경계 변경 시 |
| `DESIGN_REFACTOR_ALIGNMENT_2026-08-09.md` | 게임 루프·전투·경제·UI·저장·아트 handoff 계약 | 디자인 문서 정렬·구현 전 검토 |
| `art_production_roadmap.md` | 캐릭터·환경·UI·3D 아트 제작 단계 | 아트 단계 결정 |
| `art_production_backlog.md` | 캐릭터 5명과 아트 자산의 세부 작업 | 아트 작업 시작·완료 시 |
| `DESIGN_DIRECTION_2026-08-09.md` | 사용자 지정 레퍼런스 품질 매트릭스와 5인 매력·여성성 재검토 계획 | 디자인 방향 변경 또는 Gate A 재검토 시 |
| `COPLAY_MCP_HANDOFF.md` | Unity MCP 연결·회귀·다음 작업 인계 | 연결 또는 회귀 문제 시 |

## 분야별 기준 문서

| 분야 | 기준 문서 |
|---|---|
| 현재 프로젝트 기준 | `docs/00_project/CURRENT_PROJECT_BASELINE.md` |
| 게임 콘셉트 | `docs/01_game_design/GAME_CONCEPT.md` |
| 핵심 루프 | `docs/01_game_design/CORE_LOOP.md` |
| MVP 범위 | `docs/01_game_design/MVP_SCOPE.md` |
| 시스템 아키텍처 | `docs/02_system_design/MVP_SYSTEM_ARCHITECTURE.md` |
| 저장 Schema·Migration | `docs/02_system_design/SAVE_DATA_SPEC.md` |
| 모바일 입력·Lifecycle | `docs/04_ui_ux/MOBILE_INPUT_AND_LIFECYCLE.md` |
| Android Build·배포 | `docs/06_technical/ANDROID_BUILD_AND_RELEASE.md` |
| 캐릭터 설정 | `docs/05_art_concept/CHARACTER_BIBLE.md` v3.0 |
| 캐릭터 제작 앵커 | `docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md` v3.0 |
| 캐릭터 제작 시트 템플릿 | `docs/05_art_concept/CHARACTER_SHEET_TEMPLATE_SPEC.md` v003 |
| 아트 Gate 리뷰 | `docs/05_art_concept/ART_REVIEW_CHECKLIST.md` v3.0 |
| 신규 5인 Gate A 패키지 | `planning/ART_DIRECTION_RESET_BRIEF_2026-08-09.md`, `planning/DESIGN_DIRECTION_2026-08-09.md`, `art_refs/characters/` |
| 디자인 정렬 계약 | `docs/plans/DESIGN_REFACTOR_ALIGNMENT_2026-08-09.md` |
| 디자인 진척도 | `planning/DESIGN_PROGRESS_2026-08-07.md` (내용 갱신 2026-08-09) |
| 과거 5인 라인업 판정 | `art_refs/art_direction/ReCamp_CharacterLineup_REVIEW_v003.review.md` (`HISTORY ONLY`) |
| 공통 아트 방향 | `docs/05_art_concept/ART_DIRECTION.md` v3.0 |
| 아트 MCP 파이프라인 | `docs/05_art_concept/ART_PRODUCTION_MCP_GUIDE.md` |
| 아트 디렉터리·승인 규칙 | `docs/05_art_concept/ART_ASSET_STRUCTURE.md` |
| 아트 자산·Export 명명 계약 | `docs/05_art_concept/ASSET_NAMING_GUIDE.md` |
| 공용·캐릭터 Animation 계약 | `docs/05_art_concept/ANIMATION_GUIDE.md` |
| 캐릭터·스킬·몬스터 수치 | `tables/` |

## 상태

- `Todo`: 아직 시작하지 않음
- `Ready`: 선행 조건이 충족돼 바로 시작 가능
- `In Progress`: 현재 작업 중
- `Review`: 구현됐지만 테스트·Git 재현·사람 승인 중 하나가 남음
- `Deferred`: 필요성이 확인될 때 도입하는 선택 작업
- `Blocked`: 명시적 외부 조건이나 의사결정을 기다림
- `Done`: 완료 조건과 검증을 모두 충족

## 우선순위 원칙

```text
플레이 가능한 한 판
→ Android Landscape·Touch·Lifecycle·첫 APK
→ 신규 5인 캐릭터 역할과 한 문장 훅
→ 약 7등신 2D 제작 시트와 2D→3D 변환표
→ 승인된 캐릭터 5~6등신 Character Proof
→ 반복 가능한 제작 파이프라인
→ Vertical Slice 품질
→ 출시 범위 확장
```

멀티플레이, PvP, 길드, 실시간 서버, 가챠, 오픈월드, 풀 보이스, 캐릭터별 완전 고유 골격, 대량 스토리 컷신은 초기 출시 범위에서 제외한다.

## 계획 갱신 원칙

- 코드나 아트를 완료해도 계획 상태와 검증 근거가 갱신되지 않으면 완료로 간주하지 않는다.
- 새 기능이나 아트 산출물은 구현 전에 Backlog ID를 등록한다.
- 요구사항 변경은 관련 `docs/`와 `planning/`에 같은 변경 범위로 반영한다.
- `roadmap.md`는 방향과 완료 기준을, 각 Backlog는 세부 구현 상태를 관리한다.
- 기술 계약 문서가 추가돼도 구현·실기기 검증 없이 Backlog 상태를 `Done`으로 변경하지 않는다.
- 디자인 문서 정렬은 Runtime roster, Save schema, CharacterId를 자동 변경하지 않는다.
