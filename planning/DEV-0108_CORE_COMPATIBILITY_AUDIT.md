# DEV-0108 / DEV-0109 Core 호환성 검토와 경계 결정

검토일: 2026-07-15

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

- `ReCamp.Domain`은 별도 `src/` 프로젝트에서 검증하고, Unity로 가져올 때는 Unity 지원 C#/.NET
  프로필에 맞춘 명시적 포트와 전용 asmdef를 사용한다. 현재 원격 원본은 `net8.0`, implicit usings,
  record 등으로 작성돼 있어 Unity 6000.5 프로젝트에 검증 없이 그대로 참조할 수 없다.
- `ReCamp.UnityAdapter`만 `PlayerPrefs`, `JsonUtility`, `SceneLoader`, `MonoBehaviour`와 상호작용한다.
  `GameManager`, `CampManager`, `BattleSceneController`는 이 계층의 소비자/표현 조정자로 남긴다.
- 기존 Unity `ReCamp.Core` 네임스페이스는 현재 원격 Core의 실제 도메인 네임스페이스와 충돌한다.
  Adapter 구현 시 Unity 측 타입은 `ReCamp.UnityAdapter` 또는 `ReCamp.Runtime`로 옮기고, 원격
  도메인의 `ReCamp.Core`를 단독으로 사용한다. 이 이름 변경은 DEV-0113 구현 범위에서 한 번에 한다.

## 호환성 결과

| 영역 | 원격 독립 Core | 현재 Unity 구현 | 판정 |
|---|---|---|---|
| 런 상태 | Lobby / Exploring / Result | Title / Lobby / Battle / Result | Adapter가 상태를 명시적으로 변환 |
| 자원 | Scrap / Rations / DataFragment | Scrap / Food / DataFragment | Food-Rations 명명 및 저장 migration 결정 필요 |
| 전투 보상 | 결과 후 outcome별 정산 | 완료 시 전량 Camp에 입금 | `SettlementPolicy` 적용 시점과 패배/시간 만료 이벤트 연결 필요 |
| 캠프 비용·효과 | Generator 10, Workshop 15+Data 2, Storage 10 Rations | 더 낮은 별도 비용, Storage +20 HP | 현 Unity Gray Box 규칙을 자동 대체하지 않음; 밸런스 승인 후 도메인 값을 채택 |
| 저장 | 버전형 JSON·repository | `PlayerPrefs` v1 | Adapter가 구 저장을 domain save DTO로 migration |
| 탐험·스킬 | 결정적 wave/skill 도메인 규칙 | 런타임 스폰·능력 구현 | 다음 단계에서 이벤트와 명령만 연결 |

## 검토 근거와 제한

- 원격 기준 리비전은 `origin/agent/unity-independent-core`의 `e7caadb`이며,
  `src/ReCamp.Core`와 its dependency-free test program을 검토했다.
- 현재 Unity는 6000.5.3f1이고 `ReCamp.Runtime.asmdef`가 존재한다. Unity의
  `GameManager`는 `MonoBehaviour`이며 기존 Core와 같은 `ReCamp.Core` namespace를 사용한다.
- 이 작업 환경에는 `dotnet` CLI가 없어 원격 `net8.0` test program을 직접 실행하지 못했다.
  원격 Core의 독립 test 실행은 DEV-0113에서 .NET SDK 또는 CI runner를 확보해 별도로 기록한다.

## DEV-0113 구현 착수 조건

1. Unity 지원 target/framework와 portable source layout을 확정한다.
2. `ReCamp.Domain` asmdef와 Domain -> Adapter contract test를 먼저 추가한다.
3. `GameManager`/`CampManager` namespace 이동 및 save migration을 한 change set으로 수행한다.
4. EditMode·PlayMode 전체 회귀와 portable domain suite를 모두 통과시킨다.

현재 플래그십 전투와 저장의 동작을 유지하기 위해, 위 구현 전에는 기존 런타임 규칙을 변경하지 않는다.
