# Re:Camp Planning Index

이 디렉터리는 Re:Camp에서 무엇을 어떤 순서로 진행할지 관리하는 단일 실행 진입점이다.

## 1. 확인 순서

```text
1. docs/00_project/CURRENT_PROJECT_BASELINE.md
2. docs/00_project/BUSINESS_AND_PLATFORM_STRATEGY.md
3. planning/sprint_backlog.md
4. planning/roadmap.md
5. 분야별 Backlog와 Spec
6. tables/와 APPROVED art_refs/
```

## 2. 최종 목표

```text
최종 제품: Google Play Android 정식 출시
개발 기준: Windows Unity Editor
현재 Gate: Android Touch Prototype·루나 Character Proof
중간 Gate: Android Portfolio Vertical Slice·Closed Test
후속 확장: Windows Demo·Steam·iOS
```

수익은 필수 성공 기준이 아니다. 비용과 Scope를 통제하기 위한 참고값으로만 기록하며, 실제 완성·배포와 포트폴리오 결과를 우선한다.

## 3. 계획 문서

| 문서 | 역할 |
|---|---|
| `roadmap.md` | Windows 기반부터 Android 출시·후속 Port까지 Milestone |
| `sprint_backlog.md` | 현재부터 실제로 처리할 통합 작업 |
| `SCOPE_AND_RISK_RULES.md` | Android Vertical Slice·Full Release 범위와 축소 기준 |
| `business_cost_log.md` | 실제 비용·시간 기록, 수익 목표가 아닌 지출 통제용 |
| `art_production_roadmap.md` | 2D·3D·환경·UI·VFX 제작 순서 |
| `art_production_backlog.md` | 아트 세부 작업과 상태 |
| `art_production_next_actions.md` | 지금 바로 수행할 아트 작업 |

## 4. 분야별 기준 문서

| 분야 | 기준 문서 |
|---|---|
| 현재 프로젝트 기준 | `docs/00_project/CURRENT_PROJECT_BASELINE.md` |
| 제품·플랫폼 전략 | `docs/00_project/BUSINESS_AND_PLATFORM_STRATEGY.md` |
| 게임 콘셉트 | `docs/01_game_design/GAME_CONCEPT.md` |
| MVP·Vertical Slice·Release | `docs/01_game_design/MVP_SCOPE.md` |
| 카메라·Touch 입력·UI | `docs/04_ui_ux/CAMERA_AND_UI_BASELINE.md` |
| 캐릭터 설정 | `docs/05_art_concept/CHARACTER_BIBLE.md` |
| 공통 아트 방향 | `docs/05_art_concept/ART_DIRECTION.md` |
| 제작 시작 순서 | `docs/05_art_concept/ART_PRODUCTION_START_GUIDE.md` |
| MCP 제작 파이프라인 | `docs/05_art_concept/ART_PRODUCTION_MCP_GUIDE.md` |
| ComfyUI 일관성 | `docs/05_art_concept/COMFYUI_CHARACTER_CONSISTENCY_SPEC.md` |
| 3D 캐릭터 | `docs/05_art_concept/CHARACTER_3D_SPEC.md` |
| Animation | `docs/05_art_concept/ANIMATION_GUIDE.md` |
| Unity Import·Prefab | `docs/05_art_concept/UNITY_ART_IMPORT_GUIDE.md` |
| 환경·몬스터·VFX | `docs/05_art_concept/ENVIRONMENT_AND_VFX_SPEC.md` |
| 기술·Android 성능 | `docs/06_dev_docs/TECHNICAL_TARGETS.md` |
| 구현 데이터 | `tables/` |

## 5. 작업 ID 규칙

| Prefix | 분야 | 예시 |
|---|---|---|
| `PROJ-` | 저장소·문서·플랫폼 기준 | `PROJ-0001` |
| `DEV-` | Unity·Build·기술 기반 | `DEV-0101` |
| `GAME-` | Scene·전투·성장·저장 | `GAME-0201` |
| `MOB-` | Android Touch·Lifecycle·기기 검증 | `MOB-0251` |
| `CHR-PROT-` | 캐릭터 플레이 프로토타입 | `CHR-PROT-0301` |
| `ART-PIPE-` | 아트 제작 파이프라인 | `ART-PIPE-0101` |
| `ART-2D-` | 캐릭터 2D 제작 시트 | `ART-2D-1001` |
| `ART-3D-` | 캐릭터 모델·Rig·Animation | `ART-3D-2001` |
| `ART-ENV-` | 환경·몬스터·소품 | `ART-ENV-3001` |
| `ART-UI-` | UI Design·Export | `ART-UI-4001` |
| `ART-VFX-` | VFX·Feedback | `ART-VFX-5001` |
| `TEST-` | 기능·아트·성능·외부 검증 | `TEST-4001` |
| `VS-` | Android Vertical Slice 통합 | `VS-6001` |
| `REL-` | Closed Test·Store·QA·출시 | `REL-7001` |
| `PROD-` | Android Full Release 콘텐츠 | `PROD-8001` |
| `PORT-` | Windows·Steam·iOS 후속 Port | `PORT-9001` |

기존 Commit이나 PR의 과거 ID는 변경하지 않되 신규 작업에는 새 ID만 사용한다.

## 6. 상태 정의

| 상태 | 의미 |
|---|---|
| `Todo` | 시작 전 |
| `Ready` | 선행 조건 충족 |
| `In Progress` | 현재 작업 중 |
| `Review` | 코드·문서·아트·실기기 검증 대기 |
| `Blocked` | 선행 작업이나 Gate 때문에 진행 불가 |
| `Done` | 결과물·검증·링크 모두 존재 |

아트 자산은 `WIP`, `REVIEW`, `APPROVED`, `SUPERSEDED`, `ARCHIVE`를 사용한다.

## 7. 현재 우선순위

1. 문서 기준·Android 플랫폼 통합
2. Unity 6.3 LTS URP 프로젝트
3. Android Build Support·Landscape·Safe Area
4. ReCamp.Core Unity 통합
5. Camera·Touch Input Gray Box
6. 완주 가능한 핵심 루프
7. 루나 2D Approved 제작 시트
8. 루나 3D Blockout·Android Character Proof
9. Android Portfolio Vertical Slice
10. APK 외부 테스트
11. Google Play Closed Test
12. Android Full Release
13. Windows·Steam·iOS 후속 판단

## 8. 플랫폼 운영 원칙

- 1차 제품 플랫폼은 Google Play Android다.
- Windows는 Unity 개발·QA·Profiler·포트폴리오 빌드에 사용한다.
- Android 실기기 결과가 PC 결과보다 우선한다.
- Steam과 iOS는 Android 출시·안정화 후 개별 판단한다.
- 모바일 출시를 위해 가챠·강제 광고·F2P 라이브 운영을 추가하지 않는다.

## 9. 비용 기록 원칙

기록 대상:

```text
현금 지출
소프트웨어·스토어 비용
외주·에셋·음원·번역
Android 테스트 기기
월별 투입 시간
```

- 판매량 목표를 작업 완료 조건이나 출시 Gate로 두지 않는다.
- 손익분기는 외주·구독·마케팅비가 과도해지는 것을 막는 참고값이다.
- 무료 출시도 프로젝트 성공으로 인정한다.

## 10. Coplay 운영 규칙

- Coplay MCP를 Unity 자동화 기본 도구로 사용한다.
- 대상 Scene·Prefab·파일을 명확히 지정한다.
- 반복 수정은 Batch Operation으로 묶는다.
- Import·검증 규칙은 Editor Script 또는 Preset으로 코드화한다.
- 성공 기준은 Tool 호출이 아니라 Android APK·Console·Prefab Diff·PlayMode·Profiler다.
- Aura AI는 유료 의존 문제로 필수 도구에서 제외한다.

## 11. 작업 진행 절차

```text
1. sprint_backlog.md에서 가장 위의 Ready 작업 선택
2. 작업 ID를 In Progress로 변경
3. 관련 Roadmap Gate와 Spec 확인
4. 코드·아트·문서 작업
5. 자동 테스트·Windows 검증
6. Android APK·실기기 검증
7. 결과 경로·Commit·PR·Screenshot·Profiler 기록
8. 비용·시간 영향 기록
9. Review 또는 Done 상태 반영
10. 다음 작업의 Blocked/Ready 갱신
```

## 12. 계획 갱신 원칙

- Baseline·Strategy·Roadmap·Backlog가 충돌하면 같은 PR에서 수정한다.
- 실제 검증 전 수치 Spec은 `Review`로 유지한다.
- Android Build가 없으면 Touch·성능 작업을 `Done`으로 처리하지 않는다.
- Approved 제작 시트가 없으면 최종 모델링은 `Blocked`다.
- Vertical Slice 승인 전 Full Release 자산을 대량 제작하지 않는다.
- Android 정식 출시 전 Steam·iOS 동시 작업을 시작하지 않는다.
- 별도 유료 도구를 필수 선행 조건으로 추가하지 않는다.
- 완료 조건과 결과 링크가 없으면 `Done`으로 변경하지 않는다.
