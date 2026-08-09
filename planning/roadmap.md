# Re:Camp Integrated Roadmap

> 최종 갱신: 2026-08-09

## 프로젝트 목표

Re:Camp는 매력적인 성인 여성 캐릭터와 함께 폐허를 탐험하고 자원을 회수해 캠프를 성장시키는
남성향 서브컬처 3D 쿼터뷰 로그라이트 RPG다.

```text
2D 약 7등신 성인 서브컬처 캐릭터 일러스트
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
| 캐릭터 | CH101~CH105 신규 성인 여성 5명 — 아마사와 린·키사라기 마오·카나데 노조미·시온 타테가미·쿠로가네 아카리 |
| 콘텐츠 | 스테이지 2개, 일반 몬스터 6종, 보스 2종, 캠프 시설 4종 이상 |
| 저장 | 로컬 저장 |
| 그래픽 | 3D 쿼터뷰·툰 셰이딩, 2D 약 7등신, 3D 5~6등신 스타일라이즈드 |

## 핵심 우선순위

1. 전투 한 판과 캠프 성장 루프가 처음부터 끝까지 동작하는가
2. 캐릭터가 한 문장으로 기억되고 작은 화면에서도 구분되는가
3. 약 7등신 2D 일러스트와 5~6등신 3D 모델이 같은 캐릭터로 보이는가
4. 5명의 얼굴·체형·패션·장비·플레이 경험이 구분되는가
5. 작은 범위라도 Android에서 출시 가능한 완성도를 갖추는가

## 현재 구현 기준선

Unity `6000.5.3f1` 프로젝트에서 다음을 구현·검증했다.

- Bootstrap, Title, Lobby, Battle, Result 5개 Scene과 `Lobby → Battle → Result → Lobby` 흐름
- 카메라 상대 XZ 이동, 자동 공격, 적 웨이브·보스, 승리·패배
- 자원 3종 드랍·흡수·결과 정산·캠프 인벤토리와 시설 강화 저장
- 5분 탐험 타이머, 60초 경고, 발전기 레벨당 +30초, R 홀드·HUD 버튼 귀환, 종료 사유
- `35.3° / 45°` Orthographic 카메라, 전투 경계와 카메라 Clamp, safe-area HUD
- 신규 디자인과 별개로 기존 5인 Gray Box 선택·Stats·Ability 기반을 기능 검증용으로 유지한다.
- 기존 Gray Box 역할은 루나 대시·3타·스캔, 미유 드론·오버클럭, 코코 회복·보호막, 이리스 차지·표식,
  노아 가드·방벽·밀쳐내기이며 신규 CH101~CH105로 아직 마이그레이션하지 않았다.
- Unity Test Runner의 EditMode·PlayMode 전체 통과와 `_ReCamp` 오류 0건

최신 테스트 수치와 구현 근거는 `planning/IMPLEMENTATION_STATUS.md`에서만 갱신한다. 이 결과는
Windows Editor 기능 기준선이며 Android APK·Touch·실기기 검증을 뜻하지 않는다. 현재 primitive와
회색 박스는 최종 아트가 아니다. `battle_vertical_slice_concept.png`는 화면 톤·구도·캐릭터 존재감
참고이며 개별 캐릭터 외형·파티 구성·무기는 공식 디자인 기준이 아니다.

## 현재 핵심 리스크

신규 CH101~CH105의 문서 기준은 작성됐지만 이미지 후보와 사람 Gate A 승인은 아직 없다.
기존 캐릭터별 REVIEW 패키지는 `HISTORY ONLY`이며 신규 디자인의 입력이 아니다.
현재 남은 핵심은 이미지 provider 연결, 캐릭터별 3안 생성, 사용자 Gate A에서 얼굴 매력·성인성·원작성·역할
차별성을 직접 판정하는 것이다.

### 2. 2D→3D 변환 검증

2D 약 7등신을 그대로 축소하면 쿼터뷰에서 얼굴·장비가 작아진다. 캐릭터별로 5.2~5.8등신 3D
목표를 두고 확대·삭제·결합할 요소를 제작 시트에 기록해야 한다.

### 3. Core 경계와 CI

현재 게임 규칙 일부가 Unity 서비스에 직접 구현돼 있다. 테스트 기준선을 유지하면서 Unity 비종속
Core·Presentation 사이 Assembly 또는 Adapter 경계를 정하고 CI를 추가해야 한다.

### 4. 최종 아트 품질

현재 비주얼은 기능 검증용이다. 사람 승인된 신규 2D 제작 시트와 CH101 Character Proof 없이
최종 3D를 대량 제작하지 않는다. 이미지 provider와 ComfyUI는 연결·병목 상태에 따라 별도로 판단한다.

## 마일스톤 요약

| 마일스톤 | 목표 | 상태 | 현재 판단 |
|---|---|---|---|
| M0 | 저장소·기획 기반 | Done | 저장소, 문서, 테이블, 실행 계획 존재 |
| M1 | 신규 아트 방향·5인 설정 v3.0 | Review | 신규 문서·프롬프트·Gate A 기준 작성, 이미지 후보·사람 승인 대기 |
| M2 | Unity 프로젝트·Core·Android 개발 기반 | Review | 프로젝트·Scene·테스트 동작, Core·CI·Android 도구 체인/입력 검증 남음 |
| M3 | 전투 Gray Box·5인 프로토타입 | Review | 기존 레거시 5인 능력과 테스트 완료, 신규 로스터 마이그레이션 아님 |
| M4 | 신규 아트 파이프라인·5인 2D 제작 시트 | Ready | CH101~CH105 프롬프트 준비, provider 연결·Gate A 이후 시트 제작 |
| M5 | CH101 아마사와 린 Character Proof·Vertical Slice | Todo | CH101 Gate A 승인과 제작 시트 이후 시작 |
| M6 | 공용 3D 기반·나머지 4인 | Todo | CH101 품질·비용 검증 후 CH102~CH105 진행 |
| M7 | 출시 범위 전체 콘텐츠 | Todo | 스테이지·적·캠프·UI·VFX·사운드 확장 |
| M8 | QA·Release Candidate | Todo | 회귀·저장·성능·라이선스·출시 자산 검증 |

## M0. 저장소·기획 기반 — Done

- 저장소, README, AGENTS, Unity `.gitignore`·LFS 규칙
- 게임 콘셉트·MVP·코어 루프와 데이터 테이블
- `planning/`, `docs/`, `tables/`, `art_refs/` 구조

저장소에서 방향, 개발 규칙, 데이터 초안과 다음 실행 작업을 확인할 수 있다.

## M1. 아트 방향·캐릭터 설정 — Review

### 완료

- 신규 CH101~CH105 이름·역할과 성인 여성 로스터 단일화
- 캐릭터 등급·가챠 전제 제거
- 2D 약 7등신 + 3D 5~6등신 스타일라이즈드·툰 셰이딩·쿼터뷰 확정
- `CHARACTER_BIBLE.md`·`CHARACTER_ANCHOR_SPEC.md`·`ART_DIRECTION.md` v3.0
- 각 캐릭터 한 문장 훅, 얼굴·체형·패션·장비·반전 매력 정의
- 제작 시트와 Gate A/B/C v3.0
- 일본 모바일 서브컬처 품질 축을 Re:Camp 세계·기능 장비로 변환하는 비복제 규칙
- 기존 5인 REVIEW 자산을 `HISTORY ONLY`로 분리

### 남은 작업

- 이미지 provider 연결과 캐릭터별 3안 생성
- 신규 5인 얼굴 매력·여성성·응집도에 대한 사람 Gate A 판정
- 외부 IP 유사성의 사람/법률 최종 확인
- 승인된 방향만 `APPROVED` 제작 기준으로 승격

## M2. Unity 프로젝트·Core·Android 개발 기반 — Review

- Unity 프로젝트 설정과 5개 Scene
- SceneLoader, GameManager, CampManager, 저장·정산
- EditMode·PlayMode 테스트 기반
- `Screen.safeArea` 기반 Battle HUD 대응 구현
- 남은 작업: Domain·Presentation 연결 정리, CI, clone-open, Android Build Support, Landscape 고정,
  Touch HUD, App ID와 첫 APK·실기기 검증

## M3. 전투 Gray Box·레거시 5인 프로토타입 — Review

- 공통 이동·카메라·공격·피격·적 AI·웨이브·보스·드랍·귀환·정산
- 기존 런타임 CH001~CH005가 임시 모델로 선택·전투 가능
- 기존 캐릭터별 능력 자동 테스트 완료
- 남은 작업: Scene 전환 통합 테스트, 레거시 5인 밸런스, 수동 지정·상태 이상·약점 연출·VFX·수치 폴리시

이 단계는 신규 CH101~CH105의 아트나 런타임 승인을 의미하지 않는다. 신규 디자인은 Gate A 이후
별도 마이그레이션한다.

## M4. 아트 파이프라인·5인 2D 제작 시트 — Ready

각 신규 캐릭터에 다음 산출물을 작성한다.

- 약 7등신 Key Art와 전신 후보 3안
- 한 문장 훅과 대표 특징 1개·보조 특징 2개
- 약 7등신 Turnaround
- 얼굴·평상시↔임무 상태·표정 8종
- 헤어·패션 Layer와 기능 분해
- 무기 상세와 접힘·발광·Socket
- 팔레트·재질
- 128px 얼굴·실루엣·저채도·유사성 증거
- 캐릭터별 2D→3D 변환표

신규 5인 역할·성격·비주얼 훅·프롬프트·검토 기준은 문서로 작성했다. 이미지 provider 연결 전에는
후보 이미지나 통합 시트를 `완료`로 기록하지 않는다. 사람 승인 전에는 어떤 이미지도 `APPROVED` 또는
최종 게임 자산으로 승격하지 않는다.

## M5. CH101 아마사와 린 Character Proof·Vertical Slice — Todo

### CH101 제작

- 최종 2D 6.9~7.1등신 일러스트와 Approved 제작 시트
- 단일 와이어 세이버·신호 리본·경로 비콘 상세
- 2D 6.9~7.1 → 3D 5.3~5.4 변환표
- 3D 5.3~5.4등신 스타일라이즈드 모델, 공용 Humanoid Rig, BlendShape
- Idle·Run·Attack·Dash·Skill·Hit·Victory
- 전용 툰 셰이더·VFX·사운드·로비·전투 Prefab

### Vertical Slice

- 버려진 거리, 일반 몬스터 3종, 보스 1종
- CH101 스킬·캠프 시설 3종·UI·저장·튜토리얼·기본 사운드와 VFX
- 캐릭터 첫인상, 2D/3D 일치, 조작·타격감, 5분 반복 의향, Android 성능 검증

## M6. 공용 3D 기반·나머지 캐릭터 — Todo

- 캐릭터별 5.2~5.8등신을 수용하는 공용 Base Mesh, Humanoid Rig, Toon Shader, Animator,
  물리 본·Collider·LOD, Prefab 템플릿
- CH102 키사라기 마오 → CH103 카나데 노조미 → CH104 시온 타테가미 → CH105 쿠로가네 아카리 순으로
  얼굴·헤어·체형·패션·장비·대표 모션·스킬·VFX 제작
- 5명 모두 선택·로비·전투에서 동작하고 외형·모션·플레이가 구분돼야 완료

## M7. 전체 콘텐츠 — Todo

- 폐쇄된 연구소, 일반 몬스터 총 6종, 보스 총 2종
- 캠프 시설 4종 이상, 캐릭터별 스킬·해금 임무·친밀도·로비 상호작용
- UI Design System, 환경·소품·VFX·사운드 완성

## M8. Release Candidate — Todo

- 전체 회귀, 저장 마이그레이션·손상 방지, Android 목표 기기 성능·발열·Lifecycle
- 메모리·GC·Draw Call·로딩·해상도·입력 최적화
- 리깅·관통·애니메이션 폴리시
- 2D·3D 캐릭터 최종 일관성 검토
- WIP 제거, 라이선스·AI 메타데이터·외부 IP 유사성 검토
- 약 7등신 스토어 Key Art·스크린샷·트레일러·외부 베타

## 다음 실행 순서

가변 실행 순서와 상태는 이 로드맵에서 복제하지 않는다.
`planning/sprint_backlog.md`의 현재 P0 실행 큐와 첫 `In Progress`·`Ready` 항목을 따른다.

## 승인 게이트

- Gate A — 캐릭터 매력: 약 7등신 성인 여성, 한 문장 훅, 얼굴·체형·패션·역할·실루엣·팔레트·유사성
- Gate B — 제작 가능성: Turnaround·2D→3D 변환·무기 구조·리그·애니메이션 가능성
- Gate C — 게임 통합: 5~6등신 Unity 스케일·쿼터뷰 가독성·성능·피드백
- Android Gate — Touch·Safe Area·Lifecycle·APK·실기기 성능

AI 생성 결과는 자동 승인하지 않는다. 이미지에는 도구·모델·날짜·워크플로 버전·Seed·입력 참조,
사람 수정·사용 제한·유사성 검토·검토자를 기록한다.

## 초기 출시 제외

멀티플레이, PvP, 길드, 실시간 계정 서버, 가챠, 오픈월드, 캐릭터 5명 초과, 풀 보이스,
복잡한 의상 교체, 캐릭터별 완전 고유 골격, 대량 시네마틱 컷신.

## 상세 실행 문서

- 작업 선택과 상태: `planning/sprint_backlog.md`
- 실제 구현 대응표: `planning/IMPLEMENTATION_STATUS.md`
- 아트 단계: `planning/art_production_roadmap.md`
- 아트 세부 작업: `planning/art_production_backlog.md`
- 캐릭터 기준: `docs/05_art_concept/CHARACTER_BIBLE.md`
- 캐릭터 앵커: `docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md`
- 아트 방향: `docs/05_art_concept/ART_DIRECTION.md`
- 제작 시트: `docs/05_art_concept/CHARACTER_SHEET_TEMPLATE_SPEC.md`
- Unity 인계: `planning/COPLAY_MCP_HANDOFF.md`
