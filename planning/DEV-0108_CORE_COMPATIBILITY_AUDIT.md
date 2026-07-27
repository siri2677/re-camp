# DEV-0108 / DEV-0109 Core 호환성 검토와 경계 결정

> 검토일: 2026-07-15
> 구현 결과 갱신: 2026-07-27
> 상태: Decision Complete / Implementation Continued in DEV-0113

## 결론

`origin/agent/unity-independent-core`의 `ReCamp.Core`를 현재 Unity 프로젝트에 원본 그대로
Assembly로 추가하거나 `ReCamp.Runtime`에 직접 병합하지 않는다. 다음 통합부터는 **portable
domain + Unity adapter** 구조를 사용한다.

```text
ReCamp.Domain (Unity 의존성 없음, 규칙의 단일 소유자)
        ^                         |
        | 상태/명령 DTO            | 도메인 이벤트/결과
        |                         v
ReCamp.UnityAdapter (저장·Scene·MonoBehaviour 경계)
        ^
        |
ReCamp.Runtime (입력·표현·HUD·프리팹)
```

- `ReCamp.Domain`은 별도 순수 C# 규칙 계층으로 유지하고 Unity 지원 C#/.NET 프로필에 맞춘
  명시적 포트와 전용 asmdef를 사용한다.
- `ReCamp.UnityAdapter`만 Domain 자료와 `PlayerPrefs`, `JsonUtility`, Scene·MonoBehaviour 표현
  자료 사이를 변환한다.
- `GameManager`, `CampManager`, `BattleSceneController`는 Runtime Presentation 조정자로 유지한다.
- 기존 Unity 측 타입은 `ReCamp.Runtime`, 순수 규칙은 `ReCamp.Domain`, 변환은
  `ReCamp.UnityAdapter` namespace를 사용한다.

## 호환성 결과

| 영역 | 원격 독립 Core | 현재 Unity 구현 | 결정 |
|---|---|---|---|
| 런 상태 | Lobby / Exploring / Result | Title / Lobby / Battle / Result | Adapter 또는 Domain Result가 상태를 명시적으로 변환 |
| 자원 | Scrap / Rations / DataFragment | Scrap / Food / DataFragment | `Food ↔ Rations` Adapter 사용 |
| 전투 보상 | Outcome별 정산 | Run 완료 시 Camp 입금 | Outcome·Settlement 계약을 DEV-0113에서 Domain으로 이동 |
| 캠프 비용·효과 | Domain 규칙값 | Gray Box Runtime 규칙값 | 검증 없이 자동 교체하지 않고 단일 소유자 정리 |
| 저장 | 버전형 Domain DTO | PlayerPrefs JSON | Unity 저장 v1→v2 Migration과 Domain DTO 변환 |
| 탐험·스킬 | 결정적 규칙 | Runtime 스폰·능력 구현 | Command/Event 경계를 후속 DEV-0113 범위로 유지 |

## 당시 검토 근거와 제한

- 원격 기준 리비전은 `origin/agent/unity-independent-core`의 `e7caadb`였다.
- 원격 프로젝트는 `.NET 8` 전제였으며 당시 작업 환경에는 `dotnet` CLI가 없어 독립 Test Program을
  직접 실행하지 못했다.
- Unity는 `6000.5.3f1`, Runtime은 `MonoBehaviour`·Scene·Input·HUD 책임을 가진다.
- 원격 수치와 Unity Gray Box 수치가 달라 기능 회귀 없이 일괄 교체할 수 없었다.

## DEV-0113 착수 조건 판정

| 착수 조건 | 현재 결과 |
|---|---|
| Unity 지원 Source Layout과 Assembly 확정 | 완료: `ReCamp.Domain`, `ReCamp.UnityAdapter`, `ReCamp.Runtime` |
| Domain→Adapter Contract Test | 완료: Food↔Rations, 시설 Save 복원, v1→v2 Migration |
| Namespace 이동과 Save Migration | 완료 |
| EditMode·PlayMode 회귀 | 마지막 직접 검증 EditMode 25/25, PlayMode 18/18 |
| 탐험·스킬·정산 최종 경계 | 미완료, DEV-0113 계속 진행 |
| Fresh Clone·CI·Android 재현 | 미완료 |

## 구현 후 현재 상태

2026년 7월 19일 기준 다음 구현과 검증이 완료됐다.

- `ReCamp.Domain`은 `noEngineReferences: true`로 컴파일
- `ReCamp.UnityAdapter`가 Domain 저장과 Unity 저장을 왕복 변환
- 기존 Unity Runtime 타입은 `ReCamp.Runtime` 영역으로 정리
- PlayerPrefs `ReCamp.CampSave.v1`을 `ReCamp.CampSave.v2`로 Migration
- Unity `6000.5.3f1` 컴파일, `_ReCamp` 오류 0건
- EditMode 25/25, PlayMode 18/18

상세 결과와 남은 범위는 `planning/DEV-0113_CORE_INTEGRATION_RESULT.md`가 소유한다.
시스템의 현재 책임 경계는 `docs/02_system_design/MVP_SYSTEM_ARCHITECTURE.md`를 따른다.

## 유지 규칙

- Domain에서 Unity API를 참조하지 않는다.
- Runtime과 Domain에 같은 규칙을 중복 추가하지 않는다.
- 저장 버전 변경에는 Migration과 Contract Test를 함께 추가한다.
- 탐험·스킬·정산 경계가 완료되기 전 DEV-0113을 `Done`으로 변경하지 않는다.
- 실행 우선순위는 `planning/sprint_backlog.md`만 관리한다.
