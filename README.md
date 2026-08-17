# Re:Camp

Re:Camp는 멸망한 세계에서 생존자 캠프를 성장시키기 위해 위험 구역을 탐험하고 자원을 회수하는 **5분 생존 로그라이트 RPG**입니다.

## Project Status

현재 단계는 **Unity 기능 Gray Box 기준선 확보 / Core·Android·최종 비주얼 통합 진행 단계**입니다.

`Lobby → Battle → Result → Lobby` 흐름, 5분 탐험 타이머, 귀환·사망·시간 만료 정산, 성인 여성 5인의 전투 역할 프로토타입이 구현되어 있습니다. 현재 primitive 기반 화면은 기능 검증용이며 최종 아트 품질이 아닙니다.

개발과 아트 작업은 반드시 `planning/`의 실행 계획을 기준으로 진행합니다.

## Platform

- 1차 제품 목표: Google Play Android, Landscape
- 개발·자동 테스트: Windows Unity Editor
- 후속 검토: Windows 공개 빌드·Steam·iOS

## Genre

- 로그라이트
- 생존 RPG
- 탐험/귀환 구조
- 거점 성장
- 서브컬쳐 캐릭터 수집/성장

## Core Loop

```text
탐험 준비
→ 위험 구역 진입
→ 몬스터 전투
→ 자원 획득
→ 스킬 선택
→ 귀환 또는 사망
→ 캠프 성장
→ 재탐험
```

## MVP Goal

첫 번째 목표는 **전투 1판이 완전히 돌아가는 MVP**를 만드는 것입니다.

```text
캐릭터가 움직인다
→ 몬스터가 등장한다
→ 공격으로 몬스터를 처치한다
→ 자원을 획득한다
→ 귀환·사망·시간 만료로 전투를 종료한다
→ 결과 화면에서 보상을 정산한다
→ 로비로 돌아와 다시 탐험한다
```

## Repository Structure

```text
re-camp/
├── Assets/                  # Unity 게임 자산과 런타임 코드
├── Packages/                # Unity 패키지 설정
├── ProjectSettings/         # Unity 프로젝트 설정
├── planning/                # 개발·아트 실행 계획과 작업 상태
├── docs/                    # 게임·아트·기술의 상세 기준 문서
├── tables/                  # 구현에 사용하는 데이터와 수치 표
├── art_refs/                # 승인 상태가 표시된 이미지 레퍼런스
├── art_source/              # Figma·Blender·Texture 편집 원본과 Export manifest
├── README.md                # 프로젝트 전체 안내와 문서 진입점
├── AGENTS.md                # AI 에이전트와 개발 운영 규칙
├── .agents/skills/          # 프로젝트 전용 Codex 워크플로
├── .codex/config.toml       # 프로젝트 전용 MCP 최소 구성
├── CHANGELOG.md             # 주요 변경 내역
├── .gitignore
└── .gitattributes
```

## Project Documents

문서와 레퍼런스는 다음 다섯 디렉터리를 중심으로 관리합니다.

| 디렉터리 | 역할 | 주요 내용 |
|---|---|---|
| `planning/` | 무엇을 어떤 순서로 진행할지 관리 | 전체 로드맵, Sprint Backlog, 아트 로드맵, 작업 상태와 선행 조건 |
| `docs/` | 게임과 아트를 어떤 기준으로 만들지 정의 | 게임 콘셉트, MVP, 코어 루프, 캐릭터 설정, 아트 방향, 제작 규격 |
| `tables/` | 구현에 필요한 데이터와 수치를 요약 | 캐릭터, 스킬, 몬스터, 아이템, 스테이지, 캠프 시설 데이터 |
| `art_refs/` | 실제 이미지와 시각적 기준을 보관 | 캐릭터 라인업, 개별 캐릭터 시트, 환경, UI, VFX 레퍼런스 |
| `art_source/` | 편집 원본과 도구 간 Export 이력을 보관 | Figma SVG, Blender, Texture 원본, Export manifest |

### 1. `planning/` — 실행 계획의 단일 진입점

개발 또는 아트 작업을 시작할 때 가장 먼저 확인합니다.

```text
planning/
├── README.md
├── roadmap.md
├── sprint_backlog.md
├── art_production_roadmap.md
└── art_production_backlog.md
```

- `planning/README.md`: 계획 문서 사용 방법과 상태·우선순위 규칙
- `planning/roadmap.md`: 개발·아트·출시 전체 마일스톤
- `planning/sprint_backlog.md`: 현재부터 실제로 처리할 통합 작업 목록
- `planning/art_production_roadmap.md`: 캐릭터·환경·UI·3D 아트 제작 단계
- `planning/art_production_backlog.md`: 캐릭터 5명과 아트 자산의 세부 작업 ID

### 2. `docs/` — 기획과 제작 기준

`planning/`에서 선택한 작업을 어떤 기준으로 수행해야 하는지 확인합니다.

```text
docs/
├── 00_project/
│   ├── CURRENT_PROJECT_BASELINE.md
│   └── PROJECT_OVERVIEW.md
├── 01_game_design/
│   ├── GAME_CONCEPT.md
│   ├── MVP_SCOPE.md
│   └── CORE_LOOP.md
└── 05_art_concept/
    ├── ART_DIRECTION.md
    ├── CHARACTER_BIBLE.md
    ├── CHARACTER_ANCHOR_SPEC.md
    ├── CHARACTER_SHEET_TEMPLATE_SPEC.md
    ├── ART_REVIEW_CHECKLIST.md
    ├── ASSET_NAMING_GUIDE.md
    ├── ANIMATION_GUIDE.md
    ├── ART_PRODUCTION_MCP_GUIDE.md
    └── ART_ASSET_STRUCTURE.md
```

### 3. `tables/` — 구현 데이터

상세 설정은 `docs/`를 기준으로 하고, 게임 구현에 사용하는 ID·역할·효과·수치는 `tables/`에서 관리합니다.

```text
tables/
├── character_table.md
├── skill_table.md
├── enemy_table.md
├── item_table.md
├── stage_table.md
└── camp_facility_table.md
```

### 4. `art_refs/` — 시각적 레퍼런스

```text
art_refs/
├── README.md
├── moodboard/
│   └── battle_vertical_slice_concept.png
└── art_direction/
    ├── ReCamp_CharacterLineup_REVIEW_v003.png
    ├── ReCamp_CharacterLineup_REVIEW_v003.metadata.md
    ├── ReCamp_CharacterLineup_REVIEW_v003.review.md
    └── ReCamp_CharacterLineup_REJECTED_v002.png
```

v003은 `REVIEW` 상태이며 Gate A `FAIL` 권고가 기록돼 있습니다. 역할 모티프·얼굴·실루엣을
교정하고 사람이 승인하기 전에는 제작 기준이나 `APPROVED` 자산으로 사용하지 않습니다.

## Development Workflow

```text
1. CURRENT_PROJECT_BASELINE.md와 planning/README.md에서 기준·운영 규칙 확인
2. planning/sprint_backlog.md에서 첫 In Progress, 없으면 첫 Ready 작업 선택
3. planning/roadmap.md에서 해당 마일스톤과 완료 기준 확인
4. 관련 docs/와 tables/의 기준 확인
5. 필요한 art_refs/ 이미지 확인
6. 개발·아트 작업과 테스트·리뷰 수행
7. planning/의 작업 상태와 결과 경로 갱신
8. 사용자가 요청한 경우에만 Git 커밋·푸시·PR 수행
```

### 문서 우선순위

충돌이 발생하면 다음 순서로 판단합니다.

```text
docs/00_project/CURRENT_PROJECT_BASELINE.md의 제품·플랫폼·비주얼 기준
→ planning/sprint_backlog.md의 실행 상태
→ docs/의 상세 기획·아트 기준
→ tables/의 구현 데이터와 수치
→ art_refs/의 APPROVED 이미지
→ art_refs/의 REVIEW·WIP 이미지
```

단, 캐릭터 외형처럼 시각적 승인본이 핵심인 경우에는 개별 `APPROVED` 캐릭터 시트가 이전 텍스트와 통합 라인업 이미지보다 우선합니다.

## Current Development Direction

```text
1. 진행 중인 Domain·Unity Presentation 통합과 Gray Box 회귀 완료
2. Android Landscape·Safe Area·Touch 조작과 첫 APK·실기기 기준 확보
3. 원본 전투 콘셉트를 기준으로 캐릭터 5명 단독 2D 콘셉트와 제작 시트 확정
4. 루나 Character Proof와 Android 전투 Vertical Slice 품질 제작
5. 환경·UI·VFX 아트와 Unity용 Prefab/Material 파이프라인 확장
6. 캠프 성장·콘텐츠·밸런스 확장
7. Android 최적화·QA와 Google Play 출시 준비
```

## Key Documents

- `AGENTS.md`: AI 에이전트와 개발 운영 가이드
- `.agents/skills/recamp-unity/SKILL.md`: Re:Camp 전용 작업·검증·MCP 절약 워크플로
- `planning/README.md`: 계획 문서 진입점
- `planning/sprint_backlog.md`: 현재 실행할 통합 작업 목록
- `planning/roadmap.md`: 전체 개발·아트·출시 로드맵
- `docs/00_project/CURRENT_PROJECT_BASELINE.md`: 제품·플랫폼·비주얼·현재 Gate 단일 기준
- `docs/00_project/PROJECT_OVERVIEW.md`: 프로젝트 개요
- `docs/01_game_design/GAME_CONCEPT.md`: 게임 콘셉트
- `docs/01_game_design/MVP_SCOPE.md`: MVP 범위
- `docs/01_game_design/CORE_LOOP.md`: 핵심 플레이 루프
- `docs/05_art_concept/ART_DIRECTION.md`: 공통 아트 방향
- `docs/05_art_concept/CHARACTER_BIBLE.md`: 캐릭터 설정 단일 기준
- `docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md`: 5인 고정·가변·금지 디자인 앵커
- `docs/05_art_concept/CHARACTER_SHEET_TEMPLATE_SPEC.md`: 캐릭터 제작 시트 Frame·Export 규격
- `docs/05_art_concept/ART_REVIEW_CHECKLIST.md`: Gate A/B/C 판정과 증거 기준
- `docs/05_art_concept/ASSET_NAMING_GUIDE.md`: 이미지→Blender→Unity 이름·Export·GUID 계약
- `docs/05_art_concept/ANIMATION_GUIDE.md`: 공용·5인 고유 Motion·Animator·Event·Import 계약
- `docs/05_art_concept/ART_PRODUCTION_MCP_GUIDE.md`: 아트 MCP 제작 흐름
- `docs/05_art_concept/ART_ASSET_STRUCTURE.md`: 아트 디렉터리·승인·파일 규칙
- `tables/`: 구현용 데이터 테이블
- `art_refs/`: 이미지 레퍼런스

## Branch Strategy

```text
main      : 안정된 데모와 승인된 문서·자산
 develop   : 개발 통합 브랜치
feature/* : 기능 개발 브랜치
art/*     : 아트 작업 브랜치
fix/*     : 버그 수정 브랜치
```

## Commit Convention

```text
feat: 새로운 기능 추가
fix: 버그 수정
docs: 문서 수정
style: 코드 포맷 수정
refactor: 구조 개선
test: 테스트 추가
chore: 설정/빌드/기타 작업
art: 아트 리소스 추가
balance: 밸런스 수치 수정
planning: 계획과 Backlog 수정
```
