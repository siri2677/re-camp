# Re:Camp Project Overview

## 1. 프로젝트 정의

Re:Camp는 자연에 잠식된 위험 구역을 짧게 탐험하고 자원을 회수해 캠프를 성장시키는 **가로형 모바일 3D 고정 쿼터뷰 로그라이트 RPG**다.

## 2. 프로젝트 최종 목적

최종 1차 목표는 **Google Play Android 정식 출시**다.

Portfolio Vertical Slice는 다음을 검증하는 중간 단계다.

- 3~5분 탐험·전투·귀환 루프
- 가로형 Touch 조작과 고정 쿼터뷰 가독성
- 서브컬쳐 캐릭터와 부드러운 포스트 아포칼립스의 결합
- 2D 디자인을 모바일용 3D 캐릭터로 전환하는 파이프라인
- Android 실기기 성능·발열·메모리·Safe Area
- 혼자 유지 가능한 콘텐츠와 업데이트 범위

프로젝트 성공은 매출액보다 실제 완성·공개 배포와 포트폴리오 가치로 판단한다.

## 3. 기준 문서

- `docs/00_project/CURRENT_PROJECT_BASELINE.md`
- `docs/00_project/BUSINESS_AND_PLATFORM_STRATEGY.md`

## 4. 플랫폼 기준

| 항목 | 기준 |
|---|---|
| 1차 제품 플랫폼 | Google Play Android |
| 화면 방향 | Landscape |
| 개발·디버그 | Windows PC |
| 외부 테스트 | APK 제한 배포·Google Play Closed Test |
| PC 공개 빌드 | itch.io·포트폴리오 Demo |
| Steam | Android 이후 별도 검토 |
| iOS | Android 안정화 후 검토 |
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| Input | Unity Input System |
| Camera | 고정 쿼터뷰 |
| Save | 로컬 저장 |

수익은 플랫폼 결정을 지배하지 않는다. 게임 적합성, 완성·배포 가능성, 포트폴리오 가치와 유지 비용을 우선한다.

## 5. 핵심 플레이 루프

```text
로비
→ 탐험 준비
→ 위험 구역 진입
→ 몬스터 전투
→ 자원 획득과 스킬 선택
→ 귀환 또는 사망·시간 만료
→ 결과 정산
→ 캠프 성장
→ 로비 복귀
```

```text
1회 탐험: 3~5분
캠프 정비: 1~3분
권장 모바일 세션: 약 5~15분
```

## 6. Android Portfolio Vertical Slice

| 항목 | 범위 |
|---|---|
| 캐릭터 | 루나 1명 |
| 인게임 표현 | 3D 5~6등신 스타일라이즈드·툰 셰이딩 |
| 스테이지 | 버려진 거리 1개 |
| 일반 몬스터 | 3종 |
| 보스 | 1종 |
| 스킬 | 약 6개 |
| 자원 | 고철·식량·데이터 조각 |
| 캠프 시설 | 발전기·작업대·식량 창고 |
| 입력 | 가상 조이스틱·공격·대시·스킬 |
| UI | 로비·전투·스킬 선택·결과·캠프 강화 |
| 검증 | APK·실기기 성능·발열·메모리·Safe Area |

## 7. Android Full Release 목표

- 캐릭터 5명
- 스테이지 2개 이상 또는 동등한 반복 분량
- 일반 몬스터 6종 이상
- 보스 2종 이상
- 캠프 시설 4종 이상
- 캐릭터 해금·친밀도·대화
- 난이도·도전·반복 목표
- Touch Tutorial·설정·저장 안정성
- Low·Medium·High 품질 단계
- 다양한 Android 화면비와 기준 기기 테스트
- Google Play Closed Test·Store Listing·정식 배포

## 8. 비주얼 방향

```text
2D 일반 등신 대표 일러스트
+ 3D 5~6등신 스타일라이즈드 캐릭터
+ 공용 Humanoid Rig와 툰 셰이더
+ 자연에 잠식된 스타일라이즈드 폐허
+ 따뜻하고 희망적인 캠프
```

## 9. 제작 도구

- ComfyUI Cloud MCP: 2D 시안과 반복 생성
- Figma Remote MCP: 캐릭터 제작 시트와 모바일 UI
- Blender MCP: 3D Blockout·모델·Rig·Animation·Export
- Coplay MCP: Unity Scene·Prefab·Component 자동화
- GitHub MCP: 문서·PR·자산 승인 이력
- Unity Editor Script·Preset: Import와 Validation
- Android 실기기·Unity 수동 QA: 입력·가독성·성능·발열

Aura AI는 체험 이후 유료 사용이 필요한 구조이므로 기본 파이프라인에서 제외한다.

## 10. 현재 제작·출시 순서

```text
기준 문서 통합
→ Windows Unity 개발 기반
→ Android Landscape·Touch Gray Box
→ 완주 가능한 핵심 루프
→ 루나 2D Approved 제작 시트
→ 루나 3D Blockout
→ Coplay Import·Prefab
→ Android 실기기 Character Proof
→ Portfolio Vertical Slice
→ APK 외부 테스트
→ Google Play Closed Test
→ Android Full Release
→ Windows·Steam·iOS 후속 판단
```

## 11. 제외 범위

```text
멀티플레이
PvP
길드
실시간 계정 서버
가챠
강제 광고
유료 재화 중심 설계
오픈월드
복잡한 장비 파밍
캐릭터별 완전 고유 골격
대량 시네마틱
풀 보이스
Android·PC 동시 정식 출시
```

## 12. 완료 판단

### Vertical Slice

- Android 실기기에서 한 판을 끝까지 완주
- Touch 조작을 별도 설명 없이 이해
- 루나의 2D·3D 인상이 일치
- 캐릭터·적·위험·자원이 작은 화면에서 식별
- 다시 탐험하고 싶다는 반응 확인

### Android Full Release

- 본편 콘텐츠와 성장 구조 완결
- 목표 Android 기기에서 안정적 실행
- 첫 실행·저장·설정·업데이트 흐름 검증
- Closed Test 피드백 반영
- Google Play 정식 배포 자료 준비

### 프로젝트 성공

- Google Play 또는 공개 APK로 실제 배포
- 기획·아트·Unity·Touch UX·모바일 최적화·배포 과정을 포트폴리오로 설명 가능
- 수익 규모와 무관하게 과도한 부채·외주·구독 없이 완성
