# Re:Camp Integrated Roadmap

## 프로젝트 목표

Re:Camp는 매력적인 성인 여성 캐릭터와 함께 폐허를 탐험하고 자원을 회수해 캠프를 성장시키는 남성향 서브컬쳐 3D 쿼터뷰 로그라이트 RPG다.

```text
2D 일반 등신 캐릭터 일러스트
+ 3D 4~5등신 SD-lite 스타일라이즈드 인게임 캐릭터
+ 자연에 잠식된 3D 폐허와 따뜻한 캠프
+ 툰 셰이딩
+ 고정 Orthographic 쿼터뷰 전투
+ Unity UGUI
```

출시 목표 범위는 PC 우선 싱글플레이, 캐릭터 5명, 스테이지 2개, 일반 몬스터 6종, 보스 2종, 캠프 시설 4종 이상, 로컬 저장이다. Android는 PC 버전의 조작·성능 검증 이후 검토한다.

## 핵심 우선순위

1. 전투 한 판과 캠프 성장 루프가 처음부터 끝까지 동작하는가
2. 캐릭터가 매력적이고 작은 화면에서도 구분되는가
3. 2D 일러스트와 3D 모델이 같은 캐릭터로 보이는가
4. 루나·미유·코코·이리스·노아의 플레이 경험이 구분되는가
5. 작은 범위라도 출시 가능한 완성도를 갖추는가

## 2026-07-14 구현 기준선

Unity `6000.5.3f1` 로컬 프로젝트에서 다음이 구현·수동 검증됐다.

- Bootstrap, Title, Lobby, Battle, Result 5개 Scene
- `Bootstrap → Lobby → Battle → Result → Lobby` 전체 흐름
- 카메라 상대 XZ 이동, 자동 공격, 적 웨이브·보스, 승리·패배
- 자원 3종 드랍·흡수·결과 정산·캠프 인벤토리 반영
- 캠프 시설 3종 강화와 `PlayerPrefs` 저장
- `35.3° / 45°` Orthographic 카메라, 전투 경계와 카메라 Clamp
- Screen Space UGUI 전투 HUD와 safe-area 처리
- Play Mode 전체 흐름에서 `_ReCamp` 코드 오류 0건

이 결과는 전투 Gray Box의 기능 기준선이다. 현재 캐릭터 프록시는 최종 아트가 아니지만, 기존 `battle_vertical_slice_concept.png`는 원본 전투 콘셉트이자 화면 톤·구도·여성 주인공 존재감의 시각 기준으로 유지한다.

## 현재 핵심 리스크

### 1. 통합 라인업 기준 이미지 불량

원격 `art_refs/art_direction/ReCamp_Character_Lineup.png`는 `1200×500` 이미지지만 실제 내용이 상단 흰 띠와 검정 화면뿐이다. 문서상 `REVIEW` 자산이지만 시각 검토에 사용할 수 없으며 PNG LFS 규칙과 달리 raw blob으로 저장됐다.

원격 파일을 승인 기준으로 사용할 수는 없다. 이를 복원본으로 오인해 새로 만든 `REVIEW v002` 역시 전원 여성 조건을 누락하고 원본 전투 콘셉트를 참조하지 않아 사용자 검토에서 반려됐다. v002는 `REJECTED`로 보존했다. 교정 v003은 원본 전투 콘셉트를 입력 레퍼런스로 사용하고 전원 성인 여성·남성향·4~4.5등신 SD-lite 조건을 명시해 다시 생성했으며 사람 검토를 기다린다.

### 2. Git 재현성

로컬 Unity 프로젝트는 동작하지만 `Assets/`, `Packages/`, `ProjectSettings/` 대부분이 아직 untracked다. 커밋·clone-open 검증 전에는 M2 전체를 Done으로 보지 않는다.

### 3. 게임 규칙 코어

원격 계획은 Unity 비종속 Core와 Presentation 분리를 요구하지만, 현재 로컬 규칙 일부가 `GameManager`, `CampManager`, `ResourceLedger`에 직접 구현돼 있다. 자동 테스트를 먼저 확보하고 Assembly·Adapter 경계를 정리한다.

## 마일스톤

| 마일스톤 | 목표 | 상태 | 현재 판단 |
|---|---|---|---|
| M0 | 저장소·기획 기반 | Done | 저장소와 기본 문서·테이블 존재 |
| M1 | 아트 방향·5인 설정 통일 | Review | 전원 성인 여성·남성향·SD-lite 방향과 v003 교정본 완료, 사람 승인 필요 |
| M2 | Unity 프로젝트·Core 통합 기반 | Review | Unity 흐름은 동작, Git 재현성·Core 경계·CI 남음 |
| M3 | 전투 Gray Box·5인 플레이 프로토타입 | In Progress | 5인 선택·데이터·대표 능력 1차 완료, 보조 능력·역할 깊이 Todo |
| M4 | 아트 파이프라인·5인 Approved 2D 시트 | In Progress | LFS·메타데이터·폴더 구조 진행, 개별 시트 Todo |
| M5 | 루나 Character Proof·Vertical Slice | Todo | 루나 Approved 시트 이후 시작 |
| M6 | 공용 3D 기반·나머지 캐릭터 | Todo | 루나 품질·비용 검증 후 시작 |
| M7 | 출시 범위 전체 콘텐츠 | Todo | 스테이지·적·캠프·UI·VFX·사운드 확장 |
| M8 | QA·Release Candidate | Todo | 회귀·저장·성능·라이선스·출시 자산 검증 |

## 다음 실행 순서

```text
원본 전투 콘셉트 기준 + 전원 성인 여성·남성향 조건 고정
→ 잘못된 라인업 v002 REJECTED 처리
→ 여성 5인 라인업 REVIEW v003 제작 완료·사람 검토
→ Unity EditMode·PlayMode 자동 테스트 확대
→ Core/Presentation 경계 결정
→ 공용 캐릭터 데이터·선택 구조 (완료)
→ 5인 대표 능력 Gray Box 1차 (완료)
→ 루나 근접 연속 공격·스캔과 4인 보조 능력
→ 5인 역할 검증
→ 루나 Approved 2D 제작 시트
→ 4~5등신 SD-lite Blender Blockout
→ Unity 쿼터뷰 Gate C 검증
```

Blender 연결과 소품 Export 테스트는 병행할 수 있다. 다만 루나 최종 모델은 Gate A(매력)와 Gate B(제작 가능성)를 통과한 Approved 2D 시트 이전에 시작하지 않는다.

## 승인 게이트

- Gate A — 캐릭터 매력: 성인 여성으로 명확히 읽히는 얼굴·체형·성격·역할·실루엣·노출도·색상과 남성향 타깃 적합성 검토
- Gate B — 제작 가능성: Turnaround·무기 구조·리그·애니메이션 가능성 검토
- Gate C — 게임 통합: Unity 스케일·쿼터뷰 가독성·성능·피드백 검토

AI 생성 결과는 자동 승인하지 않는다. 모든 이미지에는 도구·모델·날짜·워크플로 버전·Seed·입력 참조·사람 수정·사용 제한·검토자를 기록한다.

## 상세 실행 문서

- 작업 선택과 상태: `planning/sprint_backlog.md`
- 실제 구현 대응표: `planning/IMPLEMENTATION_STATUS.md`
- 아트 단계: `planning/art_production_roadmap.md`
- 아트 세부 작업: `planning/art_production_backlog.md`
- 캐릭터 단일 기준: `docs/05_art_concept/CHARACTER_BIBLE.md`
- 아트 방향: `docs/05_art_concept/ART_DIRECTION.md`
- Unity 인계: `planning/COPLAY_MCP_HANDOFF.md`
