# Re:Camp Scope and Risk Rules

> 목적: Portfolio Vertical Slice를 끝내기 전에 장기 출시 범위로 확장되는 것을 방지한다.

## 1. 완료 범위

### Portfolio Vertical Slice

```text
루나 1명
+ 버려진 거리 1개
+ 일반 몬스터 3종
+ 보스 1종
+ 캠프 시설 3종
+ 로비·전투·스킬 선택·결과·캠프 강화
+ 저장·불러오기
+ 3~5분 핵심 루프
```

### Full Release

```text
캐릭터 5명
+ 스테이지 2개
+ 일반 몬스터 6종
+ 보스 2종
+ 캠프 시설 4종 이상
+ 캐릭터 해금·친밀도·대화
```

Full Release 범위는 Vertical Slice 승인 후 진행한다.

## 2. 단계별 Stop Gate

### Gate 1 — Unity 기반

- 프로젝트 Clone 후 실행 가능
- Scene 흐름 작동
- Core 통합 방식 확정
- 자동 테스트 기반 존재

실패 시:

- 외부 Package 추가 중단
- Core 통합 범위를 최소 Adapter로 축소
- Scene과 전투 Gray Box 우선 완성

### Gate 2 — 전투 Gray Box

- 이동·공격·적 추적·사망·보상·결과 정산 작동
- 한 판을 끝까지 완주 가능

실패 시:

- 나머지 캐릭터 프로토타입 중단
- 루나 1명만 남기고 게임 루프 완성
- 보스와 스킬 선택을 P2로 연기

### Gate 3 — 루나 2D·3D Proof

- 루나 Approved 제작 시트 확보
- 5~6등신 Blockout이 쿼터뷰에서 식별됨
- Coplay Import·Prefab 테스트 통과
- Unity Editor 검증 도구와 수동 Inspector·Console 검수 통과

실패 시:

- 의상 장식·물리 파츠 단순화
- Base Mesh와 Rig 범위 축소
- Import 규칙을 Preset 또는 Editor Script로 보완
- 나머지 캐릭터 최종 제작 보류

### Gate 4 — Vertical Slice

- 핵심 루프 완주
- 캐릭터 매력·타격감·귀환 성취감 전달
- Windows 목표 성능 충족

실패 시:

- 두 번째 환경과 나머지 캐릭터 제작 금지
- 장비·친밀도·대화·추가 UI 제거
- 한 개 스테이지 품질 개선에 집중

## 3. 작업 시간 초과 시 축소 순서

```text
1. 추가 캐릭터 최종 3D 모델
2. 두 번째 스테이지
3. 친밀도·개인 에피소드
4. 복잡한 장비와 스킨
5. 추가 캠프 시설
6. 고급 물리·후처리·시네마틱
```

끝까지 유지:

```text
루나 Character Proof
핵심 전투
자원 획득과 귀환
결과 정산
캠프 성장
저장
고정 쿼터뷰 가독성
```

## 4. 아트 비용 제어

- 루나가 Unity에서 승인되기 전 나머지 네 캐릭터 최종 모델링을 시작하지 않는다.
- 생성 이미지 후보를 대량으로 Git에 저장하지 않는다.
- 쿼터뷰에서 보이지 않는 장식은 제거 또는 Texture로 대체한다.
- 공용 Rig, Shader, Animator, Prefab, Base Mesh를 우선한다.
- 환경은 Modular Kit와 공유 Material을 사용한다.
- 몬스터는 필요하면 공용 Rig 또는 Animation 재사용을 검토한다.

## 5. 도구 리스크

### ComfyUI

- Model·LoRA·Seed·Workflow를 기록하지 못하면 최종 후보로 승인하지 않는다.
- 일관성이 낮으면 생성 횟수보다 기준 이미지를 수정한다.

### Figma

- 원본만 있고 Git Export가 없으면 승인 완료로 보지 않는다.

### Blender

- 자동 결과는 Retopology·UV·Weight·관통을 사람이 검수한다.

### Coplay MCP

- 변경 전 대상 Scene·Prefab·파일을 명확히 지정한다.
- 자동화 결과는 Git Diff, Unity Console, Prefab Diff, PlayMode로 검증한다.
- 동일 작업을 반복하면 Editor Script 또는 Preset으로 승격한다.
- 지원하지 않는 작업은 수동 Inspector 작업으로 전환한다.

### Unity Editor Script·Preset

- Import Property와 검증 규칙을 재현 가능하게 코드화한다.
- 자동 생성 파일은 리뷰 가능한 텍스트 형태를 우선한다.
- 검증 도구 자체에도 최소 EditMode Test를 둔다.

### 유료 도구

- 별도 월 구독이 필요한 도구는 필수 선행 조건으로 두지 않는다.
- Aura AI는 체험 이후 유료 사용이 필요하므로 기본 파이프라인에서 제외한다.
- 향후 무료 영구 플랜과 명확한 효율이 확인되면 선택 도구로만 재검토한다.

### GitHub

- 대용량 원본은 Git LFS 규칙을 먼저 확인한다.
- WIP와 APPROVED 자산을 같은 파일명으로 덮어쓰지 않는다.

## 6. 변경 통제

새 기능이나 아트 범위 추가 전 다음을 기록한다.

```text
왜 필요한가
Vertical Slice에 직접 필요한가
선행 작업은 무엇인가
예상 제작 비용은 무엇인가
제거할 기존 범위가 있는가
완료 기준은 무엇인가
무료 또는 기존 구독 범위에서 가능한가
```

## 7. 사용자 검증

루나 Character Proof:

- 같은 캐릭터로 인식되는가
- 후드·단검·색상이 기억에 남는가
- 쿼터뷰에서 공격 방향이 보이는가

Vertical Slice:

- 3~5분 플레이를 끝까지 이해하는가
- 귀환 여부를 고민하게 되는가
- 캠프 강화 후 다시 탐험하고 싶은가
- 캐릭터와 전투에 긍정적 첫인상을 받는가

## 8. 상태 전환 규칙

- 완료 조건과 결과 링크가 없으면 `Done` 금지
- 실제 검증 전 수치 문서는 `Review`
- 승인 이미지가 없으면 최종 모델링 `Blocked`
- Unity 프로젝트가 없으면 Import·Prefab 테스트 `Blocked`
- 유료 도구 구매를 기다리는 상태를 `Blocked` 원인으로 사용하지 않음
- Vertical Slice 승인 전 장기 출시 범위는 `Todo` 또는 `Blocked`
