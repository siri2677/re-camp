# Re:Camp Scope and Risk Rules

> 목적: Android Portfolio Vertical Slice를 중간 Gate로 사용하면서 실제 모바일 정식 출시까지 Scope와 비용을 통제한다.

## 1. 최종 목표와 단계

```text
최종 목표: Google Play Android 정식 출시
개발 기반: Windows Unity Editor
중간 Gate: Touch Prototype → Character Proof → Android Vertical Slice → Closed Test
후속 확장: Windows Demo·Steam·iOS
```

### Android Portfolio Vertical Slice

```text
루나 1명
+ 버려진 거리 1개
+ 일반 몬스터 3종
+ 보스 1종
+ 캠프 시설 3종
+ Touch HUD·스킬 선택·결과·캠프 강화
+ 로컬 저장
+ 3~5분 핵심 루프
+ APK 실기기 검증
```

### Android Full Release

```text
캐릭터 5명
+ 스테이지 2개 이상 또는 동등한 반복 분량
+ 일반 몬스터 6종 이상
+ 보스 2종 이상
+ 캠프 시설 4종 이상
+ 캐릭터 해금·친밀도·대화
+ 난이도·도전·반복 목표
+ Touch Tutorial·설정·Save·Lifecycle
+ 기기 등급·화면비·발열·메모리 대응
+ Google Play 정식 배포
```

Vertical Slice 승인 전 Full Release 최종 자산을 대량 제작하지 않는다.

## 2. 단계별 Stop Gate

### Gate 1 — Unity·Android 기반

필수:

- 프로젝트 Clone 후 실행
- Core 통합 방식
- 자동 테스트 기반
- Android Build Support
- Landscape·Safe Area
- 첫 APK 실기기 실행

실패 시:

- 외부 Package 추가 중단
- Core 통합 범위를 최소 Adapter로 축소
- Windows Editor Gray Box와 Android Build 문제를 먼저 해결

### Gate 2 — 전투 Gray Box·Touch Prototype

필수:

- 이동·공격·적 추적·사망·보상·정산
- 귀환·캠프 강화·Save·재탐험
- 가상 조이스틱·Touch Button·Auto Aim
- Android Back·Background·Resume

실패 시:

- 나머지 캐릭터 프로토타입 중단
- 루나 1명만 유지
- 보스·스킬 선택·추가 UI 후순위
- Touch 입력과 핵심 루프에 집중

### Gate 3 — 루나 2D·3D Proof

필수:

- 루나 Approved 제작 시트
- 5~6등신 Blockout의 모바일 쿼터뷰 식별
- Coplay Import·Prefab
- Editor Validation Tool
- Android 실기기 Material·LOD·Animation 확인

실패 시:

- 의상 장식·물리 파츠 단순화
- Base Mesh·Rig·Texture 범위 축소
- Android 화면에서 보이지 않는 디테일 제거
- 나머지 캐릭터 최종 제작 보류

### Gate 4 — Android Portfolio Vertical Slice

필수:

- APK에서 3~5분 루프 완주
- 캐릭터 매력·타격감·귀환 성취감 전달
- Touch 조작 이해
- Safe Area·화면비·Back·Resume
- 기준 기기 성능·발열·메모리 기록
- 외부 사용자의 재탐험 의향

실패 시:

- 두 번째 환경과 나머지 캐릭터 제작 금지
- 친밀도·대화·추가 UI 제거
- 한 개 스테이지·루나·Touch UX·성능 개선에 집중

### Gate 5 — APK 외부 테스트

필수:

- 별도 설명 없이 설치·첫 실행
- Touch Tutorial로 핵심 조작 이해
- 진행 불가·Crash·Save 손상 수집
- 여러 화면비와 기기 등급 확인
- 재플레이 의향 기록

실패 시:

- Google Play Closed Test 준비를 미룬다.
- Store 자료보다 설치·입력·Save·성능을 먼저 수정한다.

### Gate 6 — Google Play Closed Test

필수:

- 앱 ID·Version·Signing
- 설치·업데이트·삭제·재설치
- Store Listing·권한·개인정보·콘텐츠 등급
- Background·Back·Save Migration
- 치명적 피드백 해결
- Full Release Scope Lock

실패 시:

- 출시일을 고정한 채 품질을 희생하지 않는다.
- 추가 캐릭터·마케팅·후속 Port 지출을 확대하지 않는다.

### Gate 7 — Android Full Release

필수:

- 본편 콘텐츠와 성장 구조 완결
- 목표 기기 범위에서 안정적 실행
- Patch·지원·Save Migration 준비
- Release Candidate 회귀 테스트
- 혼자 감당 가능한 유지보수 범위

실패 시:

- Steam·iOS 작업을 중단한다.
- Scope와 품질 설정을 다시 조정한다.
- 수익 목표 때문에 미완성 상태로 출시하지 않는다.

## 3. 작업 시간 초과 시 축소 순서

우선 제거 또는 후속 업데이트로 이동:

```text
1. 추가 시네마틱·고급 연출
2. 복잡한 의상·스킨
3. 추가 캠프 시설
4. 개인 에피소드 분량
5. 두 번째 스테이지의 세부 변형
6. 고급 물리·후처리
7. 60 FPS Profile의 고급 효과
```

끝까지 유지:

```text
Touch 입력
핵심 전투
자원 획득과 귀환
결과 정산
캠프 성장
Save 안정성
모바일 쿼터뷰 가독성
루나 Character Proof
기준 기기 30 FPS
Back·Background·Resume
```

Full Release 콘텐츠 목표를 줄일 때는 Store 설명·MVP Scope·Roadmap을 같은 PR에서 수정한다.

## 4. 비용 원칙

수익은 성공 조건이 아니다. 비용은 완주 가능성을 보호하기 위해 관리한다.

- 루나 Proof 전 나머지 4명 최종 모델링 비용 금지
- Vertical Slice 전 대규모 마케팅·번역·Store Art 비용 금지
- Android 테스트 기기는 Low·Mid·High 기준을 대표하는 최소 수량으로 시작
- 월 구독 도구를 필수 선행 조건으로 두지 않음
- 손익분기는 외주·구독 지출이 과도한지 판단하는 참고값
- 무료 출시도 프로젝트 성공으로 인정

실제 비용은 `planning/business_cost_log.md`에 기록한다.

## 5. 플랫폼 Scope

### Android

- 1차 제품·정식 출시
- Landscape Touch UI
- Auto Aim·기기 품질 단계
- Google Play Closed Test와 정식 공개
- 가챠·강제 광고·유료 재화 중심 구조 사용 금지

### Windows

- Unity 개발·QA·Profiler·자동 테스트
- 포트폴리오 Screenshot·Video
- 필요 시 itch.io Demo
- Android 출시를 지연시키는 별도 PC 콘텐츠 금지

### Steam

- Android Full Release 안정화 후 별도 평가
- PC 입력·UI·세션 보완이 자연스러울 때만 진행
- Steam을 위해 3~5분 모바일 핵심 루프를 변경하지 않음

### iOS

- Android 안정화 후 Build 환경과 추가 QA 비용 평가

## 6. 아트 비용 제어

- 루나 Unity·Android 승인 전 나머지 4명 최종 모델링 금지
- 생성 후보 대량 Git 저장 금지
- 모바일 쿼터뷰에서 보이지 않는 장식 제거·Texture화
- 공용 Rig·Shader·Animator·Prefab·Base Mesh 우선
- 환경은 Modular Kit·공유 Material
- Monster Animation·Rig 재사용 검토
- 고해상도 원본보다 실제 Android LOD1 화면 품질 우선

## 7. 도구 리스크

### ComfyUI

- Model·LoRA·Seed·Workflow가 없으면 승인 금지
- 일관성이 낮으면 생성량보다 기준 이미지 수정

### Figma

- Git Export가 없으면 승인 완료로 보지 않음
- Android 화면비와 Touch 영역을 Frame에 포함

### Blender

- Retopology·UV·Weight·관통을 사람이 검수
- LOD와 모바일 Texture 예산을 초기부터 고려

### Coplay MCP

- 대상 Scene·Prefab·파일을 명확히 지정
- Git Diff·Console·Prefab Diff·PlayMode·APK 검증
- 반복 작업은 Editor Script·Preset으로 승격

### 유료 도구

- 월 구독 도구를 필수 선행 조건으로 두지 않음
- Aura AI는 기본 파이프라인에서 제외
- 유료 도구 도입 시 절감 시간·대체 수단·총비용 기록

## 8. 변경 통제

새 기능·콘텐츠·플랫폼 추가 전 기록:

```text
왜 필요한가
Android Full Release에 직접 필요한가
Touch UX와 성능 비용은 무엇인가
선행 작업은 무엇인가
제거할 기존 Scope가 있는가
완료 기준은 무엇인가
유지보수를 혼자 감당할 수 있는가
```

Android 출시와 직접 관련이 없고 기존 Scope를 제거하지 않는 기능은 기본적으로 후순위로 이동한다.

## 9. 사용자 검증 기준

### Character Proof

- 같은 캐릭터로 인식되는가
- 후드·단검·색상이 작은 화면에서도 기억에 남는가
- 공격 방향이 보이는가

### Touch Prototype

- 조이스틱·공격·대시·스킬을 설명 없이 이해하는가
- 손가락이 위험 표시를 가리지 않는가
- Auto Aim이 불편하지 않은가

### Vertical Slice

- 3~5분 플레이를 끝까지 이해하는가
- 귀환 여부를 고민하는가
- 캠프 강화 후 다시 탐험하고 싶은가
- 중단·종료 후 다시 실행하고 싶은가

## 10. 상태 전환 규칙

- 완료 조건과 결과 링크가 없으면 `Done` 금지
- 실제 실기기 검증 전 모바일 수치 문서는 `Review`
- Approved 이미지가 없으면 최종 모델링 `Blocked`
- Android APK가 없으면 Touch·성능 작업 `Done` 금지
- Vertical Slice 승인 전 Full Release 콘텐츠는 `Todo` 또는 `Blocked`
- Android 출시 전 Steam·iOS 작업은 `Blocked`
