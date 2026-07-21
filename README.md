# Re:Camp

Re:Camp는 멸망 이후 자연에 잠식된 위험 구역을 3~5분 동안 탐험하고 자원을 회수해 캠프를 성장시키는 **가로형 모바일 3D 고정 쿼터뷰 로그라이트 RPG**입니다.

## Current Baseline

- `docs/00_project/CURRENT_PROJECT_BASELINE.md`
- `docs/00_project/BUSINESS_AND_PLATFORM_STRATEGY.md`

문서가 충돌하면 위 순서로 우선합니다.

## Product Goal

최종 1차 목표는 **Google Play Android 정식 출시**입니다.

```text
Windows 개발·디버그
→ Android Touch·Landscape Gray Box
→ 루나 Character Proof
→ Android Portfolio Vertical Slice
→ APK 외부 테스트
→ Google Play Closed Test
→ Android Full Release
→ Windows·Steam·iOS 후속 판단
```

수익은 핵심 성공 기준이 아닙니다. 실제 완성·배포, 모바일 플레이 적합성, 캐릭터 매력, 포트폴리오 가치와 유지 가능한 Scope를 우선합니다.

## Platform Strategy

| 구분 | 기준 |
|---|---|
| 1차 제품 플랫폼 | Google Play Android |
| 화면 | 가로형 Landscape |
| 개발·디버그 | Windows PC |
| 외부 테스트 | APK 제한 배포·Google Play Closed Test |
| PC 공개 빌드 | itch.io 또는 포트폴리오용 Windows Demo |
| Steam | Android 출시 후 별도 PC 제품화 검토 |
| iOS | Android 안정화 후 검토 |

**Windows는 1차 출시 플랫폼이 아닙니다.** Unity Editor, 자동 테스트, Profiler, 아트 검수와 포트폴리오 촬영을 위한 개발·QA 기반입니다.

## Technology

| 항목 | 기준 |
|---|---|
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| Input | Unity Input System |
| Camera | 고정 쿼터뷰 |
| Android Input | 가상 조이스틱·공격·대시·스킬 Touch UI |
| PC Input | 개발·QA용 Keyboard/Mouse·Gamepad Adapter |
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

```text
1회 탐험: 3~5분
캠프 정비: 1~3분
권장 모바일 세션: 약 5~15분
```

## Android Portfolio Vertical Slice

| 항목 | 범위 |
|---|---|
| 캐릭터 | 루나 1명 |
| 스테이지 | 버려진 거리 1개 |
| 일반 몬스터 | 3종 |
| 보스 | 1종 |
| 스킬 | 약 6개 |
| 캠프 시설 | 발전기·작업대·식량 창고 |
| UI | Touch Battle HUD·스킬 선택·결과·캠프 강화 |
| 플레이 시간 | 탐험 3~5분 |
| 저장 | 로컬 저장 |
| 검증 | APK·Safe Area·발열·메모리·30/60 FPS 품질 단계 |

## Android Full Release Target

- 플레이어블 캐릭터 5명
- 스테이지 2개 이상 또는 동등한 반복 분량
- 일반 몬스터 6종 이상
- 보스 2종 이상
- 캠프 시설 4종 이상
- 캐릭터 해금·친밀도·대화
- 난이도·도전·반복 목표
- 첫 실행·튜토리얼·설정·저장 안정성
- 다양한 화면비·기기 등급·발열·메모리 대응
- Google Play 테스트·스토어 자료

## Production Order

```text
5인 라인업 방향 승인
→ Windows Unity 개발 기반
→ Android Landscape·Touch Gray Box
→ ComfyUI·Figma·Blender 파이프라인
→ 루나 2D Approved 제작 시트
→ 루나 3D Blockout
→ Coplay Import·Prefab
→ Validation Tool·Android 실기기 QA
→ 루나 Character Proof
→ Android Vertical Slice
→ Closed Test
→ Android Full Release
```

## Production Tools

| 도구 | 역할 |
|---|---|
| ComfyUI Cloud MCP | 2D 캐릭터·환경·몬스터·VFX 후보 |
| Figma Remote MCP | 캐릭터 제작 시트·모바일 UI Design System |
| Blender MCP | 3D Blockout·모델·Rig·Animation·FBX Export |
| Coplay MCP | Unity Import·Scene·Prefab·Component 자동화 |
| GitHub MCP | 문서·브랜치·PR·승인 자산 관리 |
| Unity Editor Tool | Import Preset·Validation·반복 검사 |
| Unity 수동 QA | Android 실기기·Inspector·Console·PlayMode·Profiler |

Aura AI는 체험 이후 별도 비용이 발생하므로 필수 파이프라인에서 제외합니다.

## Start Here

```text
1. docs/00_project/CURRENT_PROJECT_BASELINE.md
2. docs/00_project/BUSINESS_AND_PLATFORM_STRATEGY.md
3. planning/sprint_backlog.md
4. planning/roadmap.md
5. 관련 Spec
6. tables/와 APPROVED art_refs/
```

## Out of Scope

```text
멀티플레이
PvP
길드
실시간 계정 서버
가챠
강제 광고
유료 재화 중심 설계
오픈월드
캐릭터별 완전 고유 골격
복잡한 의상 교체
대량 시네마틱
풀 보이스
Android·PC 동시 정식 출시
```
