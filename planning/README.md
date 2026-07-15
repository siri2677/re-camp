# Re:Camp Planning Index

이 디렉터리는 개발·아트 작업의 단일 실행 진입점이다.

## 작업 시작 순서

1. `sprint_backlog.md`의 현재 P0 실행 큐를 확인한다.
2. 첫 `Ready` 또는 `In Progress` 항목 하나를 선택한다.
3. 구현 전에 작업 ID와 완료 조건을 확인한다.
4. 코드·아트·문서를 함께 갱신한다.
5. Unity 작업은 compile, EditMode/PlayMode, Console 결과를 남긴다.
6. 아트는 사람 승인 전까지 `APPROVED`로 표시하지 않는다.

## 문서 역할

| 문서 | 역할 |
|---|---|
| `roadmap.md` | 프로젝트 목표, 마일스톤, 승인 게이트 |
| `sprint_backlog.md` | 실제 작업 순서와 상태의 단일 기준 |
| `IMPLEMENTATION_STATUS.md` | 원격 계획 ID와 로컬 구현·검증 근거 대응표 |
| `art_production_roadmap.md` | 캐릭터·환경·UI·VFX 아트 단계 |
| `art_production_backlog.md` | 아트 산출물 세부 작업 |
| `COPLAY_MCP_HANDOFF.md` | Unity MCP 연결·회귀·다음 작업 인계 |

## 상태

- `Todo`: 아직 시작하지 않음
- `Ready`: 선행 조건이 충족돼 바로 시작 가능
- `In Progress`: 현재 작업 중
- `Review`: 구현됐지만 테스트·Git 재현·사람 승인 중 하나가 남음
- `Blocked`: 명시적 외부 조건을 기다림
- `Done`: 완료 조건과 검증을 모두 충족

## 우선순위 원칙

```text
플레이 가능한 한 판
→ 캐릭터 역할과 매력
→ 반복 가능한 제작 파이프라인
→ Vertical Slice 품질
→ 출시 범위 확장
```

사용자의 최종 방향인 `성인 여성 5인 + 남성향 서브컬쳐 + 2D 일반 등신 + 3D 4~5등신 SD-lite`를 사용한다. `battle_vertical_slice_concept.png`는 기존 원본 전투 콘셉트로서 캐릭터 감성·환경·카메라·색 대비의 우선 앵커다. 원격 문서와 충돌할 경우 이 사용자 결정이 우선한다.
