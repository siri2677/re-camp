# Re:Camp Product and Platform Strategy

> 기준일: 2026-07-21  
> 상태: Active Planning Baseline  
> 목적: 수익보다 게임 적합성·완성 가능성·포트폴리오 가치를 우선해 플랫폼을 결정한다.

## 1. 최종 결정

```text
1차 제품 목표: Google Play Android 정식 출시
개발·디버그 기준: Windows PC
외부 테스트: Android APK 제한 배포·Google Play Closed Test
PC 공개 빌드: itch.io 또는 포트폴리오용 Windows Demo
후속 플랫폼: Windows Steam, iOS
```

Re:Camp의 제품 정체성은 **가로형 모바일 3D 쿼터뷰 로그라이트 RPG**다.

Windows는 빠른 개발·Profiler·자동 테스트·아트 검수에 유리하므로 병행하지만, 제품 설계와 UX의 기준은 Android 실기기다.

## 2. 플랫폼 판단 기준

우선순위는 다음과 같다.

1. 게임의 3~5분 세션과 사용 상황이 자연스러운가
2. 조작과 UI가 플랫폼에 잘 맞는가
3. 혼자 완성·테스트·업데이트 가능한가
4. 캐릭터와 비주얼이 목표 품질로 보이는가
5. 포트폴리오로 개발 과정과 결과를 설명할 수 있는가
6. 등록·도구·외주 비용이 감당 가능한가
7. 매출과 손익분기

수익과 손익분기는 마지막 두 항목의 참고 자료이며 제품 방향을 뒤집는 기준으로 사용하지 않는다.

## 3. Android를 1차 제품으로 선택한 이유

Re:Camp의 현재 설계:

- 한 판 3~5분
- 탐험 후 즉시 귀환·정산·캠프 성장
- 가로형 고정 쿼터뷰
- 이동 조이스틱과 소수의 전투 버튼
- 자동 조준 또는 대상 보정이 가능한 전투
- 캐릭터 중심의 서브컬쳐 비주얼
- 짧은 휴식 시간에 반복 가능한 플레이
- 싱글플레이와 로컬 저장

이 구조는 다음 모바일 사용 상황과 잘 맞는다.

```text
출퇴근
점심·휴식 시간
잠들기 전
짧은 대기 시간
한 번에 길게 플레이하기 어려운 상황
```

Android 우선의 장점:

- 원래 설계한 3~5분 루프와 일치
- 조이스틱·스킬 버튼 중심 UI가 자연스러움
- 가로형 화면에서 쿼터뷰 전투와 캐릭터를 함께 보여주기 쉬움
- 무료 APK·Closed Test로 외부 피드백을 빠르게 받을 수 있음
- 포트폴리오에서 모바일 최적화·입력·UI·배포 경험까지 설명 가능

## 4. Android 우선의 위험과 대응

### 기기 파편화

대응:

- 기준 기기 등급을 Low·Mid·High로 나눔
- URP 품질 단계 구성
- Dynamic Resolution은 실제 필요할 때 검토
- 첫 출시 지원 범위를 과도하게 넓히지 않음

### 발열·배터리·메모리

대응:

- 기본 목표 30 FPS, 지원 기기에서 60 FPS 선택
- LOD1 중심 전투
- Particle·Shadow·Post Processing 단계 축소
- 15분 반복 세션과 30분 연속 실행 테스트

### Touch UI

대응:

- 좌측 이동 조이스틱
- 우측 공격·대시·스킬 버튼
- Auto Aim 또는 대상 보정
- Safe Area와 다양한 화면비
- 전투 화면을 가리는 버튼 최소화

### 테스트·스토어 절차

대응:

- APK 내부 테스트
- 소규모 외부 테스트
- Google Play Closed Test
- Store Listing과 정책 항목 준비
- 실제 등록 시점에 최신 테스트 요건과 정책 재확인

## 5. Windows의 역할

Windows는 다음 목적으로 유지한다.

- Unity Editor 개발과 디버깅
- 자동 테스트와 CI
- Profiler·Frame Debugger·Memory Profiler
- Blender·Coplay 자산 Import 검수
- Keyboard/Mouse·Gamepad Adapter 테스트
- 포트폴리오 영상과 고해상도 Screenshot
- Android 빌드가 어려운 초기 단계의 빠른 외부 테스트

Windows 공개 빌드는 가능하지만, Android 정식 출시를 늦추지 않는 범위에서 진행한다.

## 6. Steam의 역할

Steam은 1차 목표가 아니다.

다음 조건에서 후속 PC 제품화를 검토한다.

```text
Android 핵심 루프와 콘텐츠 완성
+ PC 입력·UI가 단순 Port가 아니라 자연스럽게 동작
+ PC용 화면·세션·설정 보완 비용이 감당 가능
+ 별도 Store 운영이 Android 업데이트를 방해하지 않음
```

Steam 출시를 위해 게임을 20~40분 세션 구조로 강제 변경하지 않는다. PC판에서도 3~5분 탐험과 캠프 성장이라는 원래 리듬을 유지한다.

## 7. iOS의 역할

Android 출시와 안정화 후 검토한다.

검토 항목:

- macOS Build 환경
- 서명·TestFlight
- iPhone·iPad 화면비
- 추가 기기 QA
- 유지보수 비용

## 8. 수익·판매 정책

수익 극대화는 프로젝트 성공 조건이 아니다.

출시 형태 후보:

```text
A. 무료 완성형 게임
B. 저가 유료 앱
C. 무료 Demo + 1회 전체 해금
```

결정 시점:

- Android Vertical Slice 외부 테스트 후
- Full Release Scope Lock 전

금지:

- 광고 시청을 핵심 성장에 강제
- 가챠·유료 재화 중심 설계
- 수익 때문에 반복 플레이를 의도적으로 불편하게 만듦
- 라이브 운영을 전제로 한 콘텐츠 분할

## 9. 비용 관리

비용은 수익 목표보다 **완주 가능성**을 보호하기 위해 관리한다.

기록 대상:

- Google Play 등록 비용
- Unity·MCP·소프트웨어 구독
- 외주 모델·Animation·UI·VFX·음원
- Asset Store 구매
- Android 테스트 기기
- 번역·스토어 이미지·영상
- 실제 투입 시간

원칙:

- 월 구독 도구를 필수 선행 조건으로 두지 않는다.
- 루나 Character Proof 전 나머지 캐릭터 외주를 확대하지 않는다.
- Vertical Slice 전 대규모 마케팅·스토어 제작비를 집행하지 않는다.
- 손익분기는 외주·구독 지출을 제한하는 참고값으로만 사용한다.

## 10. 성공 기준

### 개발 성공

- Android 실기기에서 3~5분 루프 완주
- Touch 조작과 UI를 별도 설명 없이 이해
- 저장 후 다음 세션으로 자연스럽게 복귀
- 기준 기기에서 안정적 성능

### 콘텐츠 성공

- 루나와 캐릭터 라인업이 기억에 남음
- 탐험·귀환·캠프 성장의 목적이 명확함
- 다시 한 판 플레이하고 싶다는 반응

### 프로젝트 성공

- Google Play 또는 공개 APK로 실제 배포
- 포트폴리오에서 기획·아트·Unity·모바일 최적화·배포 과정을 설명 가능
- 수익이 적더라도 과도한 부채·구독·외주비 없이 완성

## 11. 출시 단계

```text
Stage 0  Windows Editor Gray Box
Stage 1  Android Touch·Landscape Prototype
Stage 2  루나 Character Proof
Stage 3  Android Portfolio Vertical Slice
Stage 4  APK 외부 테스트
Stage 5  Google Play Closed Test
Stage 6  Android Full Release
Stage 7  Windows Demo·Steam 또는 iOS 후속 판단
```

## 12. 재검토 시점

- Android 첫 실기기 빌드 후
- Vertical Slice 외부 테스트 후
- Google Play Closed Test 준비 전
- Full Release Scope Lock
- Android 출시 30일 후
- Steam 또는 iOS Port 착수 전

플랫폼 정책·등록 요건·비용은 각 재검토 시점에 공식 자료로 다시 확인한다.
