# Re:Camp

Re:Camp는 멸망한 세계에서 생존자 캠프를 성장시키기 위해 위험 구역을 탐험하고 자원을 회수하는 **5분 생존 로그라이트 RPG**입니다.

## Project Status

현재 단계는 **초기 개발 세팅 / MVP 설계 단계**입니다.

## Platform

- Mobile First
- Android / iOS
- PC 확장 가능

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
몬스터가 나온다
공격이 된다
몬스터가 죽는다
자원을 얻는다
결과 화면으로 간다
다시 로비로 돌아온다
```

## Repository Structure

```text
re-camp/
├── Assets/
├── Packages/
├── ProjectSettings/
├── docs/
├── tables/
├── planning/
├── art_refs/
├── README.md
├── AGENT.md
├── CHANGELOG.md
├── .gitignore
└── .gitattributes
```

## Documents

- `AGENT.md`: 개발 운영 가이드
- `docs/00_project/PROJECT_OVERVIEW.md`: 프로젝트 개요
- `docs/01_game_design/GAME_CONCEPT.md`: 게임 콘셉트
- `docs/01_game_design/MVP_SCOPE.md`: MVP 범위
- `docs/01_game_design/CORE_LOOP.md`: 핵심 플레이 루프
- `docs/05_art_concept/ART_DIRECTION.md`: 아트 방향성
- `planning/roadmap.md`: 개발 로드맵
- `tables/`: 캐릭터/스킬/몬스터/아이템/스테이지 테이블

## Branch Strategy

```text
main      : 안정된 데모 버전
develop   : 개발 통합 브랜치
feature/* : 기능 개발 브랜치
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
```
