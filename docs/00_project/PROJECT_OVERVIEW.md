# Re:Camp Project Overview

## 1. 프로젝트 정의

Re:Camp는 멸망 이후 자연에 잠식된 위험 구역을 짧게 탐험하고 자원을 회수해 생존자 캠프를 성장시키는 **3D 고정 쿼터뷰 로그라이트 RPG**다.

## 2. 프로젝트 최종 목적

최종 목표는 **Steam Windows에 판매 가능한 프리미엄 완성형 게임 정식 출시**다.

Portfolio Vertical Slice는 다음을 검증하는 중간 단계다.

- 직접 조작 기반의 탐험·전투·귀환 루프
- 서브컬쳐 캐릭터와 부드러운 포스트 아포칼립스의 결합
- 2D 디자인이 3D 게임 캐릭터로 전환되는 제작 파이프라인
- Steam Store Page·무료 Demo에 사용할 수 있는 비주얼 품질
- 정식 출시 범위의 제작비·가격·판매량 현실성

## 3. 기준 문서

- `docs/00_project/CURRENT_PROJECT_BASELINE.md`
- `docs/00_project/BUSINESS_AND_PLATFORM_STRATEGY.md`

## 4. 플랫폼·사업 기준

| 항목 | 기준 |
|---|---|
| 1차 개발 플랫폼 | Windows PC |
| 1차 상용 출시 | Steam Windows |
| 테스트 배포 | itch.io 제한 공개·무료 Demo |
| 2차 PC Store | Epic Games Store |
| 2차 플랫폼 | Google Play Android |
| 판매 방식 | 프리미엄 1회 구매 |
| 기준 정가 | 11,000원 |
| 출시 할인 가정 | 10% |
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| Input | Unity Input System |
| Camera | 고정 쿼터뷰 |
| Save | 로컬 저장 |

Steam을 우선하는 이유는 Re:Camp가 서버·가챠·광고·유료 재화 없이 완결 가능한 유료 패키지 게임이기 때문이다.

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

### 플레이 시간 구조

```text
1회 탐험: 3~5분
캠프 정비: 1~3분
권장 PC 세션: 탐험 3~6회, 약 20~40분
```

## 6. Portfolio Vertical Slice

| 항목 | 범위 |
|---|---|
| 캐릭터 | 루나 1명 |
| 인게임 표현 | 3D 5~6등신 스타일라이즈드, 툰 셰이딩 |
| 스테이지 | 버려진 거리 1개 |
| 일반 몬스터 | 3종 |
| 보스 | 1종 |
| 스킬 | 약 6개 |
| 자원 | 고철·식량·데이터 조각 |
| 캠프 시설 | 발전기·작업대·식량 창고 |
| UI | 로비·전투·스킬 선택·결과·캠프 강화 |
| 탐험 시간 | 3~5분 |

Vertical Slice 승인 후 Steam Demo와 Full Release 제작으로 이동한다.

## 7. Steam Full Release 목표

- 플레이어블 캐릭터 5명
- 스테이지 2개 이상 또는 동등한 반복 플레이 분량
- 일반 몬스터 6종 이상
- 보스 2종 이상
- 캠프 시설 4종 이상
- 캐릭터 해금·친밀도·대화
- 난이도·도전 목표·업적
- Controller·Keyboard/Mouse·해상도·설정
- 안정적인 Save·Crash 대응·패치 구조
- Steam Store Page·무료 Demo·Screenshot·Trailer

## 8. 손익분기 계획

현재 사업 판단용 가정:

```text
정가 11,000원
출시 실판매가 9,900원 가정
보수적 1카피 순수익 6,000원
Direct Fee 상당액 약 26카피
현금비용 1,000만원 회수 약 1,667카피
Full Cost 4,600만원 예시 회수 약 7,667카피
```

목표:

- 최소 상업 검증 2,000카피
- Full Cost 손익분기 8,000카피
- 안전한 성공 10,000카피 이상

이는 회계 확정값이 아니라 초기 계획값이다. 실제 비용·가격·지역 판매·환불·스토어 정산 자료로 갱신한다.

## 9. 비주얼 방향

```text
2D 일반 등신 대표 일러스트
+ 3D 5~6등신 스타일라이즈드 캐릭터
+ 공용 Humanoid Rig와 툰 셰이더
+ 자연에 잠식된 스타일라이즈드 폐허
+ 따뜻하고 희망적인 캠프
```

## 10. 제작 도구

- ComfyUI Cloud MCP: 2D 시안과 반복 생성
- Figma Remote MCP: 캐릭터 제작 시트와 UI
- Blender MCP: 3D Blockout·모델·Rig·Animation·Export
- Coplay MCP: Unity Scene·Prefab·Component 자동화
- GitHub MCP: 문서·PR·자산 승인 이력
- Unity Editor Script·Preset: 반복 Import와 검증 규칙 코드화
- Unity 수동 검수: Inspector·Console·Prefab Diff·PlayMode·Profiler

Aura AI는 체험 이후 유료 사용이 필요한 구조이므로 기본 제작 파이프라인에서 제외한다.

## 11. 현재 제작·출시 순서

```text
기준 문서 통합
→ Unity 프로젝트와 카메라 Gray Box
→ 완주 가능한 핵심 루프
→ 루나 2D Approved 제작 시트
→ 루나 3D Blockout
→ Coplay Import·Prefab 테스트
→ Editor Script·Preset·수동 Unity 검증
→ 루나 Character Proof
→ Portfolio Vertical Slice
→ itch.io 외부 테스트
→ Steam Store Page·무료 Demo
→ 나머지 캐릭터와 Full Release 콘텐츠
→ Steam Windows 정식 출시
→ Epic·Android 확장 판단
```

## 12. 제외 범위

```text
멀티플레이
PvP
길드
실시간 계정 서버
가챠
광고·유료 재화
오픈월드
복잡한 장비 파밍
캐릭터별 완전 고유 골격
대량 시네마틱
풀 보이스
유료 Aura AI 의존 파이프라인
모바일 선출시를 위한 F2P·라이브 운영 전환
```

## 13. 완료 판단

### Vertical Slice

- 한 판의 탐험·전투·귀환·성장이 끝까지 작동
- 루나의 2D와 3D 인상 일치
- 고정 쿼터뷰에서 캐릭터·적·위험·자원 식별
- 외부 사용자가 핵심 재미와 성장 동기 이해

### Steam Full Release

- 본편 콘텐츠와 장기 목표 완결
- 약 20~40분 권장 세션 형성
- Steam Demo와 Store Asset 준비
- Windows 성능·Controller·Settings·Save·Crash 기준 통과
- 예상 판매량이 현금비용 손익분기보다 높음
