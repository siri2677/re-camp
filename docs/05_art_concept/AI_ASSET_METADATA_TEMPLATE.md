# AI Asset Metadata Template

AI로 생성하거나 AI 생성 결과를 참고한 이미지에는 이 템플릿을 복사한 동반 Markdown을 같은 디렉터리에 둔다.

## 작성 규칙

- 파일명은 원본 자산과 동일한 이름에 `.metadata.md`를 붙인다.
  - 예: `AmasawaRin_KeyArt_REVIEW_v001.png` → `AmasawaRin_KeyArt_REVIEW_v001.metadata.md`
- 신규 디자인 Subject는 `AmasawaRin`, `KisaragiMao`, `KanadeNozomi`, `ShionTategami`,
  `KuroganeAkari` 중 하나를 사용하고, 제작 시트 ID는 `CH101`~`CH105`를 기록한다.
- `Status`는 `WIP`, `REVIEW`, `CONDITIONAL`, `APPROVED`, `REJECTED`, `SUPERSEDED`, `ARCHIVE` 중 하나를 사용한다.
- 하나의 이미지가 여러 제작 범위에서 서로 다른 상태라면 `Scope Assessment`에 범위별 상태를 별도로 기록한다.
- 모델명, 버전, 시드처럼 확인할 수 없는 값은 추정하지 않고 `Not available`로 기록한다.
- 모델·서비스 약관과 상업적 사용 조건을 확인하기 전에는 출시 자산으로 사용하지 않는다.
- `APPROVED` 전환은 인간 리뷰어가 승인일과 이름을 기록한 뒤에만 허용한다.

## Metadata

```yaml
Asset Name:
Character ID: CH101 / CH102 / CH103 / CH104 / CH105
Character Subject:
Purpose:
Status: REVIEW
Generated Date: YYYY-MM-DD
Tool/Model:
Workflow Version:
Seed:
Prompt:
Negative Prompt:
Input References:
Reference Quality Axes:
ReCamp Transformation:
Human Edits:
Usage Restriction:
Reviewer: Pending
```

## Scope Assessment

| Scope | Status | Allowed Use | Notes |
|---|---|---|---|
| Character design | WIP | Review only | |
| Environment / composition | WIP | Review only | |
| UI / VFX | WIP | Review only | |

## License and Terms Check

| Check | Result | Evidence |
|---|---|---|
| 생성 도구 이용 약관 확인 | Pending | |
| 상업적 사용 허용 여부 확인 | Pending | |
| 입력 레퍼런스 권리 확인 | Pending | |
| 출시 자산 사용 승인 | Not approved | 인간 승인 전 사용 금지 |

## Review History

| Date | Reviewer | Decision | Notes |
|---|---|---|---|
| YYYY-MM-DD | Pending | Pending | |
