# Re:Camp MVP, Vertical Slice and Release Scope

## 1. 목적

Re:Camp의 최종 목표는 **Steam Windows 프리미엄 게임 정식 출시**다.

MVP와 Portfolio Vertical Slice는 최종 제품이 아니라 정식 출시 가능성을 단계적으로 검증하는 Gate다.

```text
Gray Box MVP
→ Portfolio Vertical Slice
→ Steam Store Page·무료 Demo
→ Full Release Scope
→ Steam Windows 정식 출시
```

## 2. 단계 구분

### Gray Box MVP

게임 규칙과 Scene 흐름을 임시 Capsule·Cube로 검증한다.

### Portfolio Vertical Slice

루나와 첫 번째 스테이지를 최종 방향에 가까운 품질로 제작해 전투·아트·성능·재플레이 의향을 검증한다.

### Steam Demo

Vertical Slice를 외부 사용자에게 배포 가능한 무료 Demo로 정리한다. Store Page·Trailer·Screenshot 제작 가능성도 함께 검증한다.

### Steam Full Release

캐릭터·스테이지·장기 성장·설정·업적·저장 안정성을 포함한 완성형 유료 패키지 게임을 출시한다.

## 3. 핵심 루프

```text
로비
→ 탐험 준비
→ 전투 진입
→ 몬스터 전투
→ 자원 획득
→ 스킬 선택
→ 귀환·사망·시간 만료
→ 결과 정산
→ 캠프 강화
→ 로비 복귀
```

### 플레이 시간

```text
1회 탐험: 3~5분
캠프 정비: 1~3분
권장 PC 세션: 탐험 3~6회, 약 20~40분
```

## 4. Gray Box MVP 포함 범위

| 구분 | 범위 |
|---|---|
| 캐릭터 | 루나 임시 모델 1명 |
| 플랫폼 | Windows PC |
| 입력 | Keyboard/Mouse, Gamepad |
| 카메라 | 고정 쿼터뷰 Preset 비교 |
| 공격 | 기본 공격과 대시 |
| 적 | 추적형 임시 적 1~3종 |
| 자원 | 고철·식량·데이터 조각 |
| Scene | Bootstrap·Title·Lobby·Battle·Result |
| UI | 기능 검증용 임시 UI |
| 저장 | 로컬 저장 최소 구조 |

## 5. Portfolio Vertical Slice 포함 범위

| 구분 | 범위 |
|---|---|
| 캐릭터 | 루나 1명 |
| 캐릭터 아트 | 2D Approved 제작 시트 + 3D 5~6등신 모델 |
| 렌더링 | URP 툰 셰이딩 |
| 카메라 | 승인된 고정 쿼터뷰 |
| 조작 | Keyboard/Mouse + Gamepad |
| 공격 | 3타 기본 공격, 대시, 주요 스킬 |
| 스킬 | 약 6개, 매 판 선택·강화 |
| 일반 몬스터 | 3종 |
| 보스 | 1종 |
| 스테이지 | 버려진 거리 1개 |
| 자원 | 고철·식량·데이터 조각 |
| 캠프 시설 | 발전기·작업대·식량 창고 |
| UI | 로비·전투 HUD·스킬 선택·결과·캠프 강화·설정 |
| 저장 | 진행도와 시설 강화 로컬 저장 |
| 탐험 시간 | 한 판 3~5분 |

## 6. Steam Demo 범위

Vertical Slice를 그대로 공개하지 않고 다음 항목을 추가한다.

- 첫 실행과 튜토리얼
- Controller·Keyboard/Mouse 안내
- 해상도·전체 화면·음량·Camera Shake 설정
- Crash·Save 손상 방지
- Demo 종료 안내와 본편 Wishlist 유도
- Store Page용 Screenshot·Trailer 장면
- 개인정보 수집이 없는 경우 이를 명확히 표시
- Demo와 본편 Save 호환 여부 결정
- itch.io 제한 테스트 후 Steam 무료 Demo 전환

## 7. Steam Full Release 목표 범위

### 콘텐츠

- 플레이어블 캐릭터 5명
- 스테이지 2개 이상 또는 동등한 반복 플레이 분량
- 일반 몬스터 6종 이상
- 보스 2종 이상
- 캠프 시설 4종 이상
- 캐릭터 해금·친밀도·대화
- 난이도 단계·도전 목표·업적

### 시스템

- 20~40분 권장 플레이 세션을 만드는 연속 탐험 동기
- 캐릭터별 빌드 차이
- 저장·불러오기·데이터 마이그레이션
- Controller·Keyboard/Mouse 완전 지원
- 해상도·창 모드·전체 화면·음량·접근성 설정
- Crash Log와 치명적 진행 차단 버그 대응
- Steam Achievement와 Store Integration 범위 결정

### 상업

```text
판매 방식: 프리미엄 1회 구매
기준 정가: 11,000원
검토 범위: 9,900~13,500원
출시 할인 가정: 10%
무료 Demo: 제공
가챠·광고·유료 재화: 사용하지 않음
```

## 8. 필수 기능 우선순위

### P0 — 완주 가능한 게임 루프

- Scene 진입·전환
- 플레이어 이동
- 기본 공격과 대시
- 적 스폰·추적·피격·사망
- 자원 드롭·획득
- 귀환·사망·시간 종료
- 결과 정산
- 캠프 강화
- 저장 후 재탐험

### P1 — 로그라이트 전투

- 레벨 또는 조건 기반 스킬 선택
- 스킬 효과 적용
- 일반 몬스터 역할 구분
- 보스 패턴과 약점
- 캐릭터별 빌드 차이

### P2 — Character Proof와 Presentation

- 최종 캐릭터 모델·Rig·Animation
- 툰 셰이더
- 공격·스킬 VFX와 사운드
- 환경 Modular Kit
- UI Design System

### P3 — Steam Product Readiness

- Tutorial·Settings·Controller
- Store Page·Demo·Trailer·Screenshot
- Save Migration·Crash 대응
- Achievement·Localization 범위
- 가격·손익분기·출시 일정

### P4 — 후속 플랫폼

- Epic Games Store 추가 QA
- Android Touch UI와 성능
- Google Play Closed Test 계획
- iOS 투자 여부

## 9. 단계별 완료 기준

### Gray Box MVP

```text
1. 다른 PC에서 프로젝트를 열 수 있다.
2. 로비에서 전투로 진입한다.
3. 이동·공격·적 추적·사망이 작동한다.
4. 자원을 획득하고 전투를 끝낼 수 있다.
5. 결과를 정산하고 캠프를 강화할 수 있다.
6. 저장된 결과로 다시 전투에 진입할 수 있다.
7. 핵심 Scene 흐름 테스트가 통과한다.
```

### Portfolio Vertical Slice

```text
1. 루나의 2D와 3D가 같은 캐릭터로 보인다.
2. 고정 쿼터뷰에서 후드·단검·공격 방향이 읽힌다.
3. 몬스터 3종과 보스의 역할·위험이 구분된다.
4. 3~5분 탐험·귀환·성장 루프가 완주된다.
5. 외부 사용자가 핵심 목적을 이해한다.
6. 다시 탐험하고 싶다는 반응이 확인된다.
7. Windows 목표 성능을 유지한다.
```

### Steam Demo

```text
1. 외부 사용자가 별도 설명 없이 설치·실행한다.
2. Tutorial과 입력 안내가 작동한다.
3. Controller·Keyboard/Mouse·해상도 설정이 정상이다.
4. Crash·Save 손상·진행 불가 버그가 없다.
5. Store Page 품질의 Screenshot·Trailer를 제작할 수 있다.
6. 본편의 가격과 콘텐츠 방향을 설명할 수 있다.
```

### Steam Full Release

```text
1. 본편 콘텐츠와 장기 성장 구조가 완결된다.
2. 약 20~40분의 권장 플레이 세션이 형성된다.
3. 캐릭터 5명의 역할·조작·매력이 구분된다.
4. Windows 성능·Controller·Settings·Save 기준을 통과한다.
5. 예상 판매량이 현금비용 손익분기보다 높다.
6. 출시 후 Patch·지원·Crash 대응 계획이 준비된다.
```

## 10. Vertical Slice 제외 범위

```text
나머지 4명의 최종 3D 모델
두 번째 스테이지
추가 몬스터 3종과 두 번째 보스
실시간 멀티플레이
PvP·길드
계정 서버
가챠·광고·유료 재화
복잡한 장비 파밍
대량 스토리 컷신
풀 보이스
```

나머지 캐릭터는 방향과 최소 역할 프로토타입까지만 Vertical Slice와 병행할 수 있다.

## 11. 범위 통제

상세 축소 기준은 `planning/SCOPE_AND_RISK_RULES.md`를 따른다.

Vertical Slice 승인 전에는 다음을 시작하지 않는다.

- 나머지 캐릭터의 고비용 최종 모델링
- 두 번째 스테이지 최종 환경
- 친밀도·개인 에피소드
- 복잡한 장비·스킨 시스템
- Epic·Android 동시 출시 작업

## 12. Android Port

Android는 PC Vertical Slice 직후 자동으로 진행하지 않는다. **Steam Full Release 안정화 후 사업성과 Port 비용을 다시 판단**한다.

Port 시작 조건:

- Steam 본편 핵심 지표와 사용자 피드백 확보
- Touch UI와 Auto Aim 정책 확정
- Android 기기별 Texture·Shadow·VFX 품질 단계
- 발열·메모리·프레임 기준
- 유료 앱 또는 무료 Demo + 1회 Unlock 모델 검증
- 신규 개인 개발자 계정의 12명·14일 Closed Test 계획
- Google Play 수수료·정책 재확인

모바일 출시를 위해 가챠·광고·라이브 운영을 새로 추가하지 않는다.
