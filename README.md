# Re:Camp

Re:Camp는 위험 구역을 짧게 탐험하고 자원을 회수해 생존자 캠프를 성장시키는 3D 고정 쿼터뷰 로그라이트 RPG입니다.

제품·플랫폼·비주얼·로스터·현재 Gate의 최신 결정은 아래 한 문서만 기준으로 합니다.

- **Canonical project context:** `docs/00_project/CURRENT_PROJECT_BASELINE.md`
- **현재 실행 순서와 상태:** `planning/sprint_backlog.md`
- **구현·테스트 증거:** `planning/IMPLEMENTATION_STATUS.md`

README는 프로젝트 소개와 탐색 경로만 제공하며 전역 결정이나 최신 상태표를 복제하지 않습니다.

## Repository Structure

```text
re-camp/
├── Assets/                  # Unity 게임 자산·Runtime·Tests
├── Packages/                # Unity 패키지 설정
├── ProjectSettings/         # Unity 프로젝트 설정
├── docs/                    # 제품 기준과 분야별 설계 계약
├── planning/                # Roadmap·Backlog·구현 증거·인계
├── tables/                  # 구현용 ID·수치 데이터
├── art_refs/                # 이미지와 metadata/review/approval 기록
├── art_source/              # Figma·Blender·Texture 원본과 Export
├── scripts/                 # 저장소·문서 검증 도구
├── AGENTS.md                # AI 작업 운영 규칙
└── .agents/skills/          # 프로젝트 전용 작업 Skill
```

## Start Work

```text
1. 현재 브랜치·HEAD·변경 상태 확인
2. docs/00_project/CURRENT_PROJECT_BASELINE.md 읽기
3. planning/sprint_backlog.md에서 대상 작업 확인
4. Baseline의 작업별 필수 Read Set에 지정된 문서만 읽기
5. 구현·디자인·테스트 수행
6. owning Backlog와 IMPLEMENTATION_STATUS 갱신
7. 문서 변경 시 scripts/validate_project_docs.py 실행
```

AI 에이전트는 `AGENTS.md`와 `.agents/skills/recamp-unity/SKILL.md`를 함께 적용합니다.

## Document Ownership

| 내용 | 단일 소스 |
|---|---|
| 제품·플랫폼·전역 비주얼·로스터·현재 Gate | `docs/00_project/CURRENT_PROJECT_BASELINE.md` |
| 실행 상태 | `planning/sprint_backlog.md` |
| 마일스톤 | `planning/roadmap.md` |
| 구현·테스트 근거 | `planning/IMPLEMENTATION_STATUS.md` |
| 캐릭터별 설정 | `docs/05_art_concept/CHARACTER_BIBLE.md` |
| 아트 표현 규칙 | `docs/05_art_concept/ART_DIRECTION.md` |
| 구현 데이터 | `tables/` |
| 자산 승인 상태 | 해당 `metadata`, `review`, `APPROVED` 제작 시트 |

## Branch Strategy

```text
main       : 통합된 최신 기준과 검증된 구현
<type>/*   : 짧게 유지하는 기능·문서·아트·수정 작업 브랜치
```

- 장기 `develop` 브랜치는 사용하지 않습니다.
- 작업 브랜치는 PR로 `main`에 병합합니다.
- 병합된 브랜치와 대체된 PR은 더 이상 공식 기준이 아닙니다.

## Commit Convention

```text
feat: 기능
fix: 버그
refactor: 구조 개선
test: 테스트
docs: 문서
art: 아트 자산·아트 설정
balance: 밸런스
planning: Roadmap·Backlog
chore: 빌드·도구·기타
```
