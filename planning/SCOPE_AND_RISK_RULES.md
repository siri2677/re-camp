# Re:Camp Scope and Risk Rules

> 목적: Portfolio Vertical Slice를 중간 Gate로 사용하면서 Steam 정식 출시까지 Scope·비용·플랫폼 확장을 통제한다.

## 1. 최종 목표와 단계

```text
최종 목표: Steam Windows 프리미엄 게임 정식 출시
중간 Gate: Gray Box → Character Proof → Vertical Slice → Steam Demo
후속 확장: Steam 출시 안정화 → Epic·Android 판단
```

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

### Steam Full Release

```text
캐릭터 5명
+ 스테이지 2개 이상 또는 동등한 반복 플레이 분량
+ 일반 몬스터 6종 이상
+ 보스 2종 이상
+ 캠프 시설 4종 이상
+ 캐릭터 해금·친밀도·대화
+ 난이도·도전·업적
+ 20~40분 권장 세션
+ Store Page·Demo·설정·Controller·Save·Crash 대응
```

Vertical Slice가 승인되기 전 Full Release 최종 자산을 대량 제작하지 않는다.

## 2. 단계별 Stop Gate

### Gate 1 — Unity 기반

필수:

- 프로젝트 Clone 후 실행
- 기본 Scene 흐름
- Core 통합 방식
- 자동 테스트 기반
- Windows Build 실행

실패 시:

- 외부 Package 추가 중단
- Core 통합 범위를 최소 Adapter로 축소
- Scene과 전투 Gray Box 우선

### Gate 2 — 전투 Gray Box

필수:

- 이동·공격·적 추적·사망·보상·결과 정산
- 귀환·캠프 강화·Save·재탐험
- 한 판 완주

실패 시:

- 나머지 캐릭터 프로토타입 중단
- 루나 1명만 유지
- 보스와 스킬 선택을 후순위로 이동

### Gate 3 — 루나 2D·3D Proof

필수:

- 루나 Approved 제작 시트
- 5~6등신 Blockout 쿼터뷰 식별
- Coplay Import·Prefab 테스트
- Editor 검증 도구와 Inspector·Console 검수

실패 시:

- 의상 장식·물리 파츠 단순화
- Base Mesh와 Rig 범위 축소
- Import 규칙을 Preset 또는 Editor Script로 보완
- 나머지 캐릭터 최종 제작 보류

### Gate 4 — Portfolio Vertical Slice

필수:

- 3~5분 핵심 루프 완주
- 캐릭터 매력·타격감·귀환 성취감 전달
- Windows 목표 성능
- 외부 사용자의 재탐험 의향
- Store Page에 사용할 수 있는 비주얼 품질

실패 시:

- 두 번째 환경과 나머지 캐릭터 제작 금지
- 친밀도·대화·추가 UI 제거
- 한 개 스테이지와 루나 품질 개선에 집중

### Gate 5 — itch.io 외부 테스트

필수:

- 별도 설명 없이 설치·첫 실행
- Keyboard/Mouse·Gamepad 조작
- 해상도·전체 화면·음량 설정
- Crash·Save 손상·진행 불가 문제 수집
- Session Length와 재플레이 의향 기록

실패 시:

- Steam Direct 등록과 공개 Demo를 미룬다.
- Store Asset 제작보다 설치·입력·Save 안정성을 먼저 수정한다.

### Gate 6 — Steam Demo

필수:

- Steam Store Page 수준의 Screenshot·Capsule·Trailer
- 무료 Demo 완주
- Controller·Settings·Save·Demo 종료 Flow
- Full Release 범위와 가격 설명 가능
- 실제 현금비용과 손익분기 갱신

실패 시:

- Full Release 아트 외주와 마케팅 지출을 확대하지 않는다.
- 가격보다 Demo 품질과 본편 Scope를 먼저 조정한다.

### Gate 7 — Steam Full Release

필수:

- 본편 콘텐츠와 장기 성장 완결
- 20~40분 권장 세션 형성
- Save Migration·Crash·Patch·지원 준비
- 예상 판매량이 현금비용 손익분기보다 높음
- Release Candidate 회귀 테스트 통과

실패 시:

- 출시일을 고정한 채 품질을 희생하지 않는다.
- 두 번째 Store와 Android Port를 중단한다.
- Scope·외주비·마케팅비를 다시 계산한다.

## 3. 작업 시간 초과 시 축소 순서

우선 제거 또는 후속 업데이트로 이동:

```text
1. 추가 시네마틱·고급 연출
2. 복잡한 의상·스킨
3. 추가 캠프 시설
4. 개인 에피소드 분량
5. 두 번째 스테이지의 세부 변형
6. 고급 물리·후처리
```

출시 전 반드시 유지:

```text
핵심 전투
자원 획득과 귀환
결과 정산
캠프 성장
Save 안정성
고정 쿼터뷰 가독성
루나 Character Proof
캐릭터·스테이지·보스의 최소 본편 분량
Controller·Settings·Crash 대응
```

캐릭터 5명 또는 스테이지 2개 목표를 줄여야 한다면 가격·Store 설명·Business Strategy를 같은 PR에서 수정한다.

## 4. 사업·비용 Gate

현재 계획값:

```text
기준 정가: 11,000원
출시 실판매가 가정: 9,900원
보수적 순수익: 6,000원 / 카피
현금비용 1,000만원 BEP: 약 1,667카피
Full Cost 4,600만원 예시 BEP: 약 7,667카피
```

사업 목표:

- 최소 상업 검증: 2,000카피
- Full Cost 손익분기 목표: 8,000카피
- 안전한 성공 목표: 10,000카피 이상

비용 변경 시 `planning/business_cost_log.md`를 갱신한다.

### 비용 승인 규칙

- 루나 Proof 전에 나머지 4명 최종 모델링 비용을 집행하지 않는다.
- Vertical Slice 전에 대규모 마케팅·번역·Store Art 비용을 집행하지 않는다.
- Steam Demo 전 실제 외부 반응 없이 Full Release 외주를 한꺼번에 계약하지 않는다.
- 예상 판매량이 현금 BEP보다 낮으면 가격 인상보다 Scope와 외주비를 먼저 조정한다.
- 기회비용과 현금비용 손익분기를 분리한다.

## 5. 플랫폼 Scope

### Steam Windows

- 1차 상용 출시
- 프리미엄 1회 구매
- 무료 Demo
- Controller·Keyboard/Mouse
- Windows 성능·해상도·Save·Crash 지원

### itch.io

- Alpha·제한 공개·설치 Test
- 주력 매출 플랫폼으로 계산하지 않음

### Epic Games Store

- Steam 출시 안정화 후 예상 추가 매출과 QA·Store 운영비 비교
- Steam 본편 완성 전 동시 출시 작업 금지

### Android

Steam 출시 후 다음 조건을 통과해야 착수한다.

```text
Steam 판매·리뷰·플레이 시간 분석
+ Touch UI·Auto Aim 정책
+ 기기별 성능·발열·메모리
+ 유료 앱 또는 무료 Demo + 1회 Unlock 검증
+ 12명·14일 Closed Test 계획
+ Store 수수료·정책 재확인
```

모바일 Port를 위해 가챠·광고·라이브 운영으로 전환하지 않는다.

### iOS

Steam과 Android 성과 확인 전 투자하지 않는다.

## 6. 아트 비용 제어

- 루나가 Unity에서 승인되기 전 나머지 4명 최종 모델링 금지
- 생성 후보를 대량으로 Git에 저장하지 않음
- 쿼터뷰에서 보이지 않는 장식은 제거 또는 Texture화
- 공용 Rig·Shader·Animator·Prefab·Base Mesh 우선
- 환경은 Modular Kit·공유 Material 사용
- 몬스터 Animation과 Rig 재사용 검토
- Store Screenshot에 보이지 않는 자산보다 실제 플레이 화면 품질 우선

## 7. 도구 리스크

### ComfyUI

- Model·LoRA·Seed·Workflow가 없으면 승인 금지
- 일관성이 낮으면 생성량보다 기준 이미지 수정

### Figma

- Git Export가 없으면 승인 완료로 보지 않음

### Blender

- Retopology·UV·Weight·관통을 사람이 검수

### Coplay MCP

- 대상 Scene·Prefab·파일을 명확히 지정
- Git Diff·Console·Prefab Diff·PlayMode 검증
- 반복 작업은 Editor Script·Preset으로 승격

### 유료 도구

- 월 구독 도구를 필수 선행 조건으로 두지 않음
- Aura AI는 기본 파이프라인에서 제외
- 유료 도구 도입 시 절감 시간·대체 수단·총비용 기록

## 8. 변경 통제

새 기능·콘텐츠·플랫폼 추가 전 기록:

```text
왜 필요한가
Steam 본편 또는 Demo에 직접 필요한가
선행 작업은 무엇인가
예상 현금비용과 투입 시간은 무엇인가
추가 판매량은 얼마나 필요한가
제거할 기존 Scope가 있는가
완료 기준은 무엇인가
```

## 9. 사용자 검증

### Character Proof

- 같은 캐릭터로 인식되는가
- 후드·단검·색상이 기억에 남는가
- 쿼터뷰에서 공격 방향이 보이는가

### Vertical Slice

- 핵심 루프를 이해하는가
- 귀환 여부를 고민하는가
- 다시 탐험하고 싶은가
- 캐릭터와 전투에 긍정적 첫인상을 받는가

### Steam Demo

- 별도 설명 없이 설치·조작하는가
- Demo를 끝까지 플레이하는가
- 본편을 Wishlist하거나 구매하고 싶은가
- 예상 가격이 콘텐츠 기대와 맞는가

## 10. 상태 전환 규칙

- 완료 조건과 결과 링크가 없으면 `Done` 금지
- 실제 검증 전 수치 문서는 `Review`
- 승인 이미지가 없으면 최종 모델링 `Blocked`
- Unity 프로젝트가 없으면 Import·Prefab `Blocked`
- 유료 도구 구매 대기를 `Blocked` 사유로 사용하지 않음
- Vertical Slice 승인 전 Full Release 최종 자산은 `Blocked`
- Steam Demo 검증 전 Epic·Android 작업은 `Blocked`
- Steam 출시 안정화 전 iOS 작업은 `Blocked`
