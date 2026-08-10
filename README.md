# Re:Camp — Current Generation

Re:Camp는 위험 구역을 짧게 탐험하고 자원을 회수해 생존자 캠프를 성장시키는 Android-first 가로형 3D 쿼터뷰 로그라이트 RPG입니다.

이 브랜치는 **Current Generation의 유일한 활성 통합 기준**입니다.

- Active integration: `current/recamp-unified`
- Frozen history: `legacy/recamp-pre-generation`
- Canonical product/design context: `docs/00_project/CURRENT_PROJECT_BASELINE.md`
- Execution status: `planning/sprint_backlog.md`
- Implementation/test evidence: `planning/IMPLEMENTATION_STATUS.md`

README는 탐색 경로만 제공하며 캐릭터 이름·비율·플랫폼·현재 Gate 같은 전역 결정을 다시 정의하지 않습니다.

## Start Work

```text
1. branch / HEAD / working tree 확인
2. CURRENT_PROJECT_BASELINE.md 읽기
3. sprint_backlog.md에서 대상 작업 확인
4. Baseline의 필수 Read Set에 지정된 문서만 추가 확인
5. 구현·디자인·테스트 수행
6. owning Backlog와 IMPLEMENTATION_STATUS에 실제 결과 기록
7. 문서 변경 시 scripts/validate_project_docs.py 실행
```

## Repository Areas

```text
Assets/          Unity Runtime·Scenes·Tests·Imported Art
ProjectSettings/ Unity 프로젝트 설정
Packages/        Unity 패키지 설정
docs/            분야별 계약과 Canonical Baseline
planning/        실행 Backlog·Roadmap·검증 증거
art_refs/        WIP·REVIEW·APPROVED 시각 자산과 review
art_source/      Figma·Blender·Texture 원본과 Export
tables/          구현용 ID·수치 데이터
scripts/         저장소·문서 검증 도구
```

## Document Ownership

| 내용 | 소유 문서 |
|---|---|
| Current/Legacy 구분·제품·플랫폼·전역 비주얼·활성 로스터·전역 비율·1인 제작 예산·현재 Gate | `docs/00_project/CURRENT_PROJECT_BASELINE.md` |
| 작업 ID·순서·상태·완료 조건 | `planning/sprint_backlog.md` |
| 구현·테스트 증거 | `planning/IMPLEMENTATION_STATUS.md` |
| 캐릭터별 세부 설정 | `docs/05_art_concept/CHARACTER_BIBLE.md` |
| 캐릭터별 제작 Anchor | `docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md` |
| 색·재질·환경·UI·VFX 표현 | `docs/05_art_concept/ART_DIRECTION.md` |
| 자산별 승인 | 해당 metadata/review/APPROVED 제작 시트 |

## Branch Model

```text
legacy/recamp-pre-generation   frozen history
current/recamp-unified        active generation integration
  ├─ feature/*
  ├─ art/*
  ├─ docs/*
  └─ fix/*
main                           Current Generation 안정화 후 별도 통합
```

`codex/recamp-unity-mvp`는 Current Generation의 출발 이력으로만 남기고 신규 기준을 계속 누적하지 않습니다.
