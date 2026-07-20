# Re:Camp

Re:Camp는 멸망 이후 자연에 잠식된 위험 구역을 3~5분 동안 탐험하고 자원을 회수해 캠프를 성장시키는 **3D 고정 쿼터뷰 로그라이트 RPG**입니다.

## Current Baseline

프로젝트의 최신 단일 기준은 다음 문서입니다.

- `docs/00_project/CURRENT_PROJECT_BASELINE.md`

문서 간 내용이 충돌하면 해당 문서를 우선합니다.

## Current Status

```text
기획·MVP 범위 정리 완료
→ 5인 캐릭터 라인업 방향 승인
→ Unity 프로젝트·Core 통합 준비
→ 루나 Character Proof용 아트 파이프라인 구축
→ 실제 Unity Vertical Slice 제작 전 단계
```

현재 통합 라인업은 **Direction Approved** 상태이며 최종 캐릭터 제작 시트나 3D 모델은 아닙니다.

## Platform and Technology

| 항목 | 기준 |
|---|---|
| Primary Platform | Windows PC |
| Secondary Platform | Android |
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| Input | Unity Input System |
| Camera | 고정 쿼터뷰 |
| Save | 로컬 저장 |

Windows에서 게임 루프와 비주얼 품질을 먼저 완성한 뒤 Android 입력·UI·성능 품질 단계를 추가합니다.

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
| 플레이 시간 | 3~5분 |
| 저장 | 로컬 저장 |

장기 목표인 캐릭터 5명과 스테이지 2개는 Vertical Slice 승인 후 진행합니다.

## Character Production Order

```text
5인 라인업 방향 승인
→ 루나 2D 제작 시트
→ 루나 3D 5~6등신 Blockout
→ Coplay MCP Unity Import·Prefab 테스트
→ Unity Inspector·Console·PlayMode 수동 검증
→ 고정 쿼터뷰 실루엣 검증
→ 루나 Character Proof와 Vertical Slice
→ 나머지 4명 최종 제작
```

## MCP and Production Tools

| 도구 | 역할 |
|---|---|
| ComfyUI Cloud MCP | 2D 캐릭터·환경·몬스터·VFX 후보 생성 |
| Figma Remote MCP | 캐릭터 제작 시트와 UI Design System |
| Blender MCP | 3D Blockout·모델·Rig·Animation·FBX Export 보조 |
| Coplay MCP | Unity Scene·Prefab·Component·Material·Animator 자동화 |
| GitHub MCP | 문서·브랜치·PR·승인 자산 관리 |
| Unity Editor Script·Preset | 반복 Import·검증 규칙 코드화 |
| Unity 수동 검수 | Inspector·Console·Prefab Diff·PlayMode·Profiler 확인 |

Aura AI는 무료 영구 도구가 아니라 체험 이후 유료 사용이 필요한 구조이므로 기본 파이프라인에서 제외합니다. Coplay MCP에서 부족한 부분은 Editor Script·Preset·수동 검수로 보완합니다.

## Repository Structure

```text
re-camp/
├── Assets/
├── Packages/
├── ProjectSettings/
├── planning/
├── docs/
├── tables/
├── art_refs/
├── art_source/
├── README.md
├── AGENT.md
├── CHANGELOG.md
├── .gitignore
└── .gitattributes
```

## Start Here

```text
1. docs/00_project/CURRENT_PROJECT_BASELINE.md
2. planning/sprint_backlog.md
3. planning/roadmap.md
4. 관련 분야별 Spec
5. tables/와 APPROVED art_refs/
6. 작업·검증·상태 갱신
7. Git Commit 또는 PR
```

### 핵심 문서

- `planning/README.md`
- `planning/roadmap.md`
- `planning/sprint_backlog.md`
- `planning/SCOPE_AND_RISK_RULES.md`
- `planning/art_production_roadmap.md`
- `planning/art_production_backlog.md`
- `docs/04_ui_ux/CAMERA_AND_UI_BASELINE.md`
- `docs/05_art_concept/ART_DIRECTION.md`
- `docs/05_art_concept/CHARACTER_BIBLE.md`
- `docs/05_art_concept/ART_PRODUCTION_MCP_GUIDE.md`
- `docs/05_art_concept/CHARACTER_3D_SPEC.md`
- `docs/05_art_concept/ENVIRONMENT_AND_VFX_SPEC.md`
- `docs/06_dev_docs/TECHNICAL_TARGETS.md`

## Branch Strategy

```text
main       안정된 데모와 승인 문서·자산
agent/*    ChatGPT·Codex 작업 브랜치
feature/*  게임 기능
art/*      아트 자산
fix/*      버그 수정
release/*  배포 준비
```

## Commit Convention

```text
feat: 기능
fix: 버그
docs: 문서
refactor: 구조 개선
test: 테스트
chore: 설정·빌드
art: 아트 자산
balance: 수치 조정
planning: 계획·Backlog
```

## Out of Scope

```text
멀티플레이
PvP
길드
실시간 계정 서버
가챠
상점 결제·광고
오픈월드
캐릭터별 완전 고유 골격
복잡한 의상 교체
대량 시네마틱
풀 보이스
유료 Aura AI 의존 파이프라인
```
