# Re:Camp Planning Index

> 최종 갱신: 2026-07-27
> 역할: 실행 문서 탐색과 상태 규칙

제품·플랫폼·전역 비주얼·로스터·현재 Gate는 `docs/00_project/CURRENT_PROJECT_BASELINE.md`만 소유합니다. 이 문서는 해당 결정을 복제하지 않습니다.

## 작업 시작 순서

1. 현재 브랜치·HEAD·변경 상태를 확인한다.
2. `docs/00_project/CURRENT_PROJECT_BASELINE.md`를 읽는다.
3. 사용자가 지정한 작업을 우선하고, 지정이 없으면 `sprint_backlog.md`의 첫 `In Progress`, 그다음 첫 `Ready`를 선택한다.
4. 대상 ID의 완료 조건을 확인한다.
5. Baseline의 `LLM 작업별 필수 Read Set`에 지정된 문서와 관련 코드·테스트만 읽는다.
6. 작업 후 owning Backlog와 `IMPLEMENTATION_STATUS.md`에 상태와 증거를 기록한다.
7. 문서 변경은 `python scripts/validate_project_docs.py`로 검증한다.

## Planning 문서 역할

| 문서 | 소유 내용 |
|---|---|
| `sprint_backlog.md` | 실제 작업 ID·순서·상태·완료 조건 |
| `roadmap.md` | 마일스톤·Gate·단계 완료 조건 |
| `IMPLEMENTATION_STATUS.md` | 구현·테스트·환경·제한의 증거 |
| `art_production_roadmap.md` | 아트 제작 단계와 Gate 의존 관계 |
| `art_production_backlog.md` | 아트 산출물 ID·상태·완료 조건 |
| `DEV-0113_CORE_INTEGRATION_RESULT.md` | Domain·Adapter·Runtime 통합 결과 |
| `COPLAY_MCP_HANDOFF.md` | Unity MCP 연결·복구·회귀 절차 |

Roadmap과 Backlog는 Baseline의 제품 결정이나 캐릭터 설정을 다시 설명하지 않습니다. 필요한 경우 소유 문서를 링크합니다.

## 상태 정의

| 상태 | 의미 |
|---|---|
| `Todo` | 구현 또는 산출물 없음 |
| `Ready` | 선행 조건이 충족돼 바로 시작 가능 |
| `In Progress` | 현재 작업 중 |
| `Review` | 핵심 결과는 있으나 통합 검증·사람 승인·재현 중 일부가 남음 |
| `Blocked` | 외부 설치·기기·사용자 결정·승인 없이는 진행 불가 |
| `Deferred` | 현재 필수가 아니며 실제 병목이 생길 때 재평가 |
| `Done` | 완료 조건과 필요한 검증을 모두 충족 |

## 갱신 규칙

- 코드 존재만으로 `Done`으로 변경하지 않는다.
- 생성 이미지 품질만으로 `APPROVED`로 변경하지 않는다.
- 실행 순서 변경은 `sprint_backlog.md`에서만 한다.
- 테스트 개수와 실행 결과는 `IMPLEMENTATION_STATUS.md`에서만 갱신한다.
- 전역 결정 변경은 Baseline을 먼저 수정한다.
- 상세 계약 변경은 해당 분야 소유 문서만 수정한다.
- 동일 내용을 여러 문서에 복사하지 않는다.
