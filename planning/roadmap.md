# Re:Camp Integrated Roadmap

## 프로젝트 목표

Re:Camp는 매력적인 성인 여성 캐릭터와 함께 폐허를 탐험하고 자원을 회수해 캠프를 성장시키는 남성향 서브컬처 3D 쿼터뷰 로그라이트 RPG다.

```text
2D 일반 등신 캐릭터 일러스트
+ 3D 5~6등신 스타일라이즈드 인게임 캐릭터
+ 자연에 잠식된 3D 폐허와 따뜻한 캠프
+ 툰 셰이딩
+ 고정 Orthographic 쿼터뷰 전투
+ Unity UGUI
```

| 항목 | 출시 목표 |
|---|---|
| 플랫폼 | Google Play Android 1차 제품, Windows는 개발·QA 기준 |
| 플레이 | 싱글플레이 |
| 캐릭터 | 루나·미유·코코·이리스·노아, 성인 여성 5명 |
| 콘텐츠 | 스테이지 2개, 일반 몬스터 6종, 보스 2종, 캠프 시설 4종 이상 |
| 저장 | 로컬 저장 |
| 그래픽 | 3D 쿼터뷰·툰 셰이딩, 2D 일반 등신, 3D 5~6등신 스타일라이즈드 |

## 핵심 우선순위

1. 전투 한 판과 캠프 성장 루프가 처음부터 끝까지 동작하는가
2. 캐릭터가 매력적이고 작은 화면에서도 구분되는가
3. 2D 일러스트와 3D 모델이 같은 캐릭터로 보이는가
4. 5명의 플레이 경험과 역할이 구분되는가
5. 작은 범위라도 출시 가능한 완성도를 갖추는가

## 현재 구현 기준선

Unity `6000.5.3f1` 프로젝트에서 다음을 구현·검증했다.

- Bootstrap, Title, Lobby, Battle, Result 5개 Scene과 `Lobby → Battle → Result → Lobby` 흐름
- 카메라 상대 XZ 이동, 자동 공격, 적 웨이브·보스, 승리·패배
- 자원 3종 드랍·흡수·결과 정산·캠프 인벤토리와 시설 강화 저장
- 5분 탐험 타이머, 60초 경고, 발전기 레벨당 +30초, R 홀드·HUD 버튼 귀환, 종료 사유
- `35.3° / 45°` Orthographic 카메라, 전투 경계와 카메라 Clamp, safe-area HUD
- 5인 선택·Stats·Ability 기반과 캐릭터별 대표·보조 능력 Gray Box
- 루나 대시·3타·스캔, 미유 드론·오버클럭, 코코 회복·보호막, 이리스 차지·표식, 노아 가드·방벽·밀쳐내기
- Unity Test Runner의 EditMode·PlayMode 전체 통과와 `_ReCamp` 오류 0건

최신 테스트 수치와 구현 근거는 `planning/IMPLEMENTATION_STATUS.md`에서만 갱신한다. 이 결과는
Windows Editor 기능 기준선이며 Android APK·Touch·실기기 검증을 뜻하지 않는다. 현재 primitive와
회색 박스는 최종 아트가 아니다. `battle_vertical_slice_concept.png`를 화면 톤·구도·여성
주인공 존재감의 원본 전투 비주얼 앵커로 유지하되 정확한 체형 비율은 최신 Baseline을 따른다.

## 현재 핵심 리스크

### 1. 캐릭터 라인업 사람 승인

원격 v001은 거의 빈 이미지라 기준으로 사용할 수 없고, 혼성 v002는 전원 여성 조건과 원본
앵커를 누락해 `REJECTED` 처리했다. 교정 v003은 성인 여성 5인과 역할·팔레트 방향은 참고할 수
있지만 기존 4~5등신 비율은 최종 기준이 아니다. 역할 모티프·얼굴·실루엣과 5~6등신 비율을
캐릭터별 WIP에서 수정한 뒤 사람이 재검토한다.

### 2. Core 경계와 CI

현재 게임 규칙 일부가 Unity 서비스에 직접 구현돼 있다. 테스트 기준선을 유지하면서 Unity 비종속 Core·Presentation 사이 Assembly 또는 Adapter 경계를 정하고 CI를 추가해야 한다.

### 3. 최종 아트 품질

현재 비주얼은 기능 검증용이다. 사람 승인된 2D 제작 시트와 루나 Character Proof 없이 최종 3D를 대량 제작하지 않는다. ComfyUI와 대용량 로컬 모델은 일관성·정밀 수정이 실제 병목일 때만 도입한다.

## 마일스톤 요약

| 마일스톤 | 목표 | 상태 | 현재 판단 |
|---|---|---|---|
| M0 | 저장소·기획 기반 | Done | 저장소, 문서, 테이블, 실행 계획 존재 |
| M1 | 아트 방향·5인 설정 통일 | Review | v003 Gate A `FAIL` 항목과 5~6등신 비율 교정, 사람 승인 필요 |
| M2 | Unity 프로젝트·Core·Android 개발 기반 | Review | 프로젝트·Scene·테스트 동작, Core 경계·CI·clone-open·Android 도구 체인/입력 검증 남음 |
| M3 | 전투 Gray Box·5인 프로토타입 | Review | 5인 대표·보조 능력과 테스트 완료, VFX·튜닝·일부 통합 회귀 남음 |
| M4 | 아트 파이프라인·5인 Approved 2D 시트 | In Progress | LFS·메타데이터·구조 완료, 개별 시트 Todo |
| M5 | 루나 Character Proof·Vertical Slice | Todo | 루나 Approved 시트 이후 시작 |
| M6 | 공용 3D 기반·나머지 4인 | Todo | 루나 품질·비용 검증 후 시작 |
| M7 | 출시 범위 전체 콘텐츠 | Todo | 스테이지·적·캠프·UI·VFX·사운드 확장 |
| M8 | QA·Release Candidate | Todo | 회귀·저장·성능·라이선스·출시 자산 검증 |

## M0. 저장소·기획 기반 — Done

- 저장소, README, AGENTS, Unity `.gitignore`·LFS 규칙
- 게임 콘셉트·MVP·코어 루프와 데이터 테이블
- `planning/`, `docs/`, `tables/`, `art_refs/` 구조

저장소에서 방향, 개발 규칙, 데이터 초안, 다음 실행 작업을 확인할 수 있다.

## M1. 아트 방향·캐릭터 설정 — Review

- 캐릭터 5명 이름·역할과 성인 여성 로스터 단일화
- 캐릭터 등급·가챠 전제 제거
- 2D 일반 등신 + 3D 5~6등신 스타일라이즈드·툰 셰이딩·쿼터뷰 확정
- Character Bible, Art Direction, MCP·자산 승인 가이드
- v003 Gate A `FAIL` 항목과 기존 비율 교정, 캐릭터별 실루엣·색상·무기 사람 승인 남음

## M2. Unity 프로젝트·Core·Android 개발 기반 — Review

- Unity 프로젝트 설정과 5개 Scene
- SceneLoader, GameManager, CampManager, 저장·정산
- EditMode·PlayMode 테스트 기반
- `Screen.safeArea` 기반 Battle HUD 대응 구현
- 남은 작업: Domain·Presentation 연결 정리, CI, clone-open, Android Build Support, Landscape 고정,
  Touch HUD, App ID와 첫 APK·실기기 검증

## M3. 전투 Gray Box·5인 프로토타입 — Review

- 공통 이동·카메라·공격·피격·적 AI·웨이브·보스·드랍·귀환·정산
- 캐릭터 5명 모두 임시 모델로 선택·전투 가능
- 캐릭터별 능력 자동 테스트 완료
- 남은 작업: Scene 전환 통합 테스트, 5인 밸런스, 수동 지정·상태 이상·약점 연출·VFX·수치 폴리시

아트 제작 전에 역할과 조작 차이를 검증해 디자인·애니메이션 낭비를 줄인다.

## M4. 아트 파이프라인·5인 2D 제작 시트 — In Progress

각 캐릭터에 Key Art, Turnaround, 얼굴·표정 8종, 헤어·의상 분해, 무기 상세, 팔레트, 대표 포즈, 3D 주의사항을 작성한다. 5명을 한 화면에 배치해 세계관 일관성과 서로 다른 매력을 함께 검토한다.

현재 이미지 도구로 후보를 진행한다. ComfyUI는 대량 일관성·정밀 인페인팅·고정 워크플로가 병목일 때만 `Deferred`에서 전환한다.

## M5. 루나 Character Proof·Vertical Slice — Todo

### 루나 제작

- 최종 2D 일반 등신 일러스트와 Approved 제작 시트
- 3D 5~6등신 스타일라이즈드 모델, 기본 목표 약 5.2~5.5등신, 공용 Humanoid Rig, BlendShape
- Idle·Run·Attack·Dash·Skill·Hit·Victory
- 전용 툰 셰이더·VFX·사운드·로비·전투 Prefab

### Vertical Slice

- 버려진 거리, 일반 몬스터 3종, 보스 1종
- 루나 스킬·캠프 시설 3종·UI·저장·튜토리얼·기본 사운드와 VFX
- 캐릭터 첫인상, 2D/3D 일치, 조작·타격감, 5분 반복 의향, 성능 검증

## M6. 공용 3D 기반·나머지 캐릭터 — Todo

- 공용 5~6등신 스타일라이즈드 Base Mesh, Humanoid Rig, Toon Shader, Animator, 물리 본·Collider·LOD, Prefab 템플릿
- 미유 → 코코 → 이리스 → 노아 순으로 얼굴·헤어·의상·무기·대표 모션·스킬·VFX 제작
- 5명 모두 선택·로비·전투에서 동작하고 외형·모션·플레이가 구분돼야 완료

## M7. 전체 콘텐츠 — Todo

- 폐쇄된 연구소, 일반 몬스터 총 6종, 보스 총 2종
- 캠프 시설 4종 이상, 캐릭터별 스킬·해금 임무·친밀도·로비 상호작용
- UI Design System, 환경·소품·VFX·사운드 완성

## M8. Release Candidate — Todo

- 전체 회귀, 저장 마이그레이션·손상 방지, Android 목표 기기 성능·발열·Lifecycle
- 메모리·GC·Draw Call·로딩·해상도·입력 최적화
- 리깅·관통·애니메이션 폴리시
- WIP 제거, 라이선스·AI 메타데이터 검토
- 스토어 페이지·스크린샷·트레일러·외부 베타

## 다음 실행 순서

가변 실행 순서와 상태는 이 로드맵에서 복제하지 않는다.
`planning/sprint_backlog.md`의 현재 P0 실행 큐와 첫 `In Progress`·`Ready` 항목을 따른다.

## 승인 게이트

- Gate A — 캐릭터 매력: 성인 여성으로 읽히는 얼굴·체형·성격·역할·실루엣·노출도·색상과 남성향 타깃 적합성
- Gate B — 제작 가능성: Turnaround·무기 구조·리그·애니메이션 가능성
- Gate C — 게임 통합: Unity 스케일·쿼터뷰 가독성·성능·피드백

AI 생성 결과는 자동 승인하지 않는다. 이미지에는 도구·모델·날짜·워크플로 버전·Seed·입력 참조·사람 수정·사용 제한·검토자를 기록한다.

## 초기 출시 제외

멀티플레이, PvP, 길드, 실시간 계정 서버, 가챠, 오픈월드, 캐릭터 5명 초과, 풀 보이스, 복잡한 의상 교체, 캐릭터별 완전 고유 골격, 대량 시네마틱 컷신.

## 상세 실행 문서

- 작업 선택과 상태: `planning/sprint_backlog.md`
- 실제 구현 대응표: `planning/IMPLEMENTATION_STATUS.md`
- 아트 단계: `planning/art_production_roadmap.md`
- 아트 세부 작업: `planning/art_production_backlog.md`
- 캐릭터 기준: `docs/05_art_concept/CHARACTER_BIBLE.md`
- 아트 방향: `docs/05_art_concept/ART_DIRECTION.md`
- Unity 인계: `planning/COPLAY_MCP_HANDOFF.md`
