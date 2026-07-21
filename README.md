# Re:Camp

Re:Camp는 멸망 이후 자연에 잠식된 위험 구역을 3~5분 동안 탐험하고 자원을 회수해 캠프를 성장시키는 **3D 고정 쿼터뷰 로그라이트 RPG**입니다.

## Current Baseline

프로젝트의 최신 단일 기준:

- `docs/00_project/CURRENT_PROJECT_BASELINE.md`
- `docs/00_project/BUSINESS_AND_PLATFORM_STRATEGY.md`

문서 간 내용이 충돌하면 위 순서로 우선합니다.

## Product Goal

최종 목표는 **Steam Windows에 판매 가능한 완성형 프리미엄 게임 정식 출시**입니다.

```text
Gray Box MVP
→ 루나 Character Proof
→ Portfolio Vertical Slice
→ itch.io 외부 테스트
→ Steam Store Page·무료 Demo
→ Full Release 콘텐츠
→ Steam Windows 정식 출시
→ Epic·Android 후속 판단
```

Portfolio Vertical Slice는 최종 결과물이 아니라 정식 출시 가능성을 검증하는 중간 Gate입니다.

## Platform Strategy

| 구분 | 기준 |
|---|---|
| 1차 개발 | Windows PC |
| 1차 상용 출시 | Steam Windows |
| 테스트 배포 | itch.io 제한 공개·무료 Demo |
| 2차 PC 스토어 | Epic Games Store, Steam 안정화 후 검토 |
| 후속 플랫폼 | Google Play Android, PC판 성과 확인 후 Port Gate |
| iOS | 초기 범위 제외 |
| 판매 방식 | 프리미엄 1회 구매 |

Steam을 우선하는 이유는 PC 자체가 아니라, Re:Camp가 서버·F2P·광고·가챠 없이 완결 가능한 프리미엄 패키지 구조이기 때문입니다.

## Business Baseline

현재 계획값:

```text
Steam 기준 정가: 11,000원
가격 검토 범위: 9,900~13,500원
출시 할인 가정: 10%
보수적 1카피 순수익 계획값: 6,000원
최소 상업 검증: 2,000카피
Full Cost 손익분기 목표: 약 8,000카피
안전한 성공 목표: 10,000카피 이상
```

이 수치는 회계 확정값이 아니라 Scope·외주비·마케팅비를 판단하기 위한 계획값이며 실제 비용과 판매 Report로 갱신합니다.

## Technology

| 항목 | 기준 |
|---|---|
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| Input | Unity Input System |
| Camera | 고정 쿼터뷰 |
| PC Input | Keyboard/Mouse + Gamepad |
| Android Input | 후속 Port에서 Touch UI |
| Save | 로컬 저장 |

## Visual Direction

```text
2D 일반 등신 서브컬쳐 대표 일러스트
+ 3D 5~6등신 스타일라이즈드 인게임 캐릭터
+ 툰 셰이딩
+ 자연에 잠식된 부드러운 포스트 아포칼립스
+ 캐릭터보다 낮은 채도와 밀도의 환경
```

## Core Loop

```text
로비
→ 탐험 준비
→ 위험 구역 진입
→ 전투·자원 획득·스킬 선택
→ 귀환 또는 사망·시간 만료
→ 결과 정산
→ 캠프 시설 강화
→ 재탐험
```

한 번의 탐험은 3~5분이지만 PC 본편에서는 탐험 3~6회와 캠프 정비를 묶어 약 20~40분의 권장 세션을 구성합니다.

## Portfolio Vertical Slice

| 항목 | 범위 |
|---|---|
| 캐릭터 | 루나 1명 |
| 스테이지 | 버려진 거리 1개 |
| 일반 몬스터 | 3종 |
| 보스 | 1종 |
| 스킬 | 약 6개 |
| 캠프 시설 | 발전기·작업대·식량 창고 |
| UI | 로비·전투·스킬 선택·결과·캠프 강화 |
| 플레이 시간 | 탐험 3~5분 |
| 저장 | 로컬 저장 |

## Steam Full Release Target

- 플레이어블 캐릭터 5명
- 스테이지 2개 이상 또는 동등한 반복 플레이 분량
- 일반 몬스터 6종 이상
- 보스 2종 이상
- 캠프 시설 4종 이상
- 캐릭터 해금·친밀도·대화·로비 상호작용
- 난이도·도전·업적
- Controller·해상도·설정·저장·Crash 대응
- Steam Store Page·무료 Demo·Trailer·Screenshot

## Production Order

```text
5인 라인업 방향 승인
→ Unity Camera·Gray Box
→ ComfyUI·Figma·Blender 파이프라인
→ 루나 2D Approved 제작 시트
→ 루나 3D Blockout
→ Coplay Unity Import·Prefab 테스트
→ Import Validation Tool·수동 QA
→ 루나 Character Proof
→ Portfolio Vertical Slice
→ itch.io 외부 테스트
→ Steam Store Page·무료 Demo
→ Full Release 콘텐츠
→ Steam Windows 정식 출시
```

## Production Tools

| 도구 | 역할 |
|---|---|
| ComfyUI Cloud MCP | 2D 캐릭터·환경·몬스터·VFX 후보 생성 |
| Figma Remote MCP | 캐릭터 제작 시트와 UI Design System |
| Blender MCP | 3D Blockout·모델·Rig·Animation·FBX Export 보조 |
| Coplay MCP | Unity Import·Scene·Prefab·Component·Material·Animator 자동화 |
| GitHub MCP | 문서·브랜치·PR·승인 자산 관리 |
| Unity Editor Tool | Import Preset·Validation·반복 검사 |
| Unity 수동 QA | Inspector·Console·Prefab Diff·PlayMode·Profiler |

Aura AI는 체험 이후 별도 비용이 발생하므로 필수 제작 파이프라인에서 제외합니다.

## Start Here

```text
1. docs/00_project/CURRENT_PROJECT_BASELINE.md
2. docs/00_project/BUSINESS_AND_PLATFORM_STRATEGY.md
3. planning/sprint_backlog.md
4. planning/roadmap.md
5. 관련 분야별 Spec
6. tables/와 APPROVED art_refs/
```

## Out of Scope

```text
멀티플레이
PvP
길드
실시간 계정 서버
가챠
광고
유료 재화
오픈월드
캐릭터별 완전 고유 골격
복잡한 의상 교체
대량 시네마틱
풀 보이스
```
