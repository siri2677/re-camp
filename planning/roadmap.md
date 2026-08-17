# Re:Camp Current Generation Roadmap

> 최종 갱신: 2026-08-17
> 역할: 마일스톤·Gate·단계 Exit 조건

제품·플랫폼·Current 로스터·전역 비주얼·1인 제작 예산은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`만 따른다. 실제 작업 순서와 상태는 `planning/sprint_backlog.md`가 우선한다.

## 마일스톤

| ID | 목표 | 상태 | Exit 조건 |
|---|---|---|---|
| M0 | 저장소·문서·세대 기준 | Done | Legacy/Current 분리와 Canonical Baseline·작업 진입 규칙 존재 |
| M1 | Current Generation 디자인 계약 | Review | 캐릭터별 Gate A와 Approved 제작 시트 필요 |
| M2 | Unity·Core·Android 개발 기반 | Review | Android 도구 체인·실기기와 Fresh Clone/CI 증거 필요 |
| M3 | 기능 Gray Box·역할 Prototype | Review | 수동 밸런스·피드백 폴리시와 Current Runtime handoff 준비 필요 |
| M4 | 반복 가능한 2D 제작 Pipeline | In Progress | 캐릭터별 후보·교차 비교·Approved 제작 시트 필요 |
| M5 | CH101 Character Proof·Vertical Slice | Todo | Gate A/B/C·Android Character Proof 통과 |
| M6 | 공용 3D 기반·나머지 캐릭터 | Todo | CH101에서 검증한 품질·비용 구조를 재사용해 4명 완성 |
| M7 | 출시 범위 콘텐츠 | Todo | 환경·적·캠프·UI·VFX·Audio 범위 완성 |
| M8 | QA·Release Candidate | Todo | 회귀·저장·성능·라이선스·스토어·실기기 승인 |

## M0 — 저장소·문서·세대 기준

완료 조건:

- Legacy와 Current Generation이 브랜치로 분리돼 있다.
- Current 작업자는 Canonical Baseline 한 곳에서 전역 결정을 읽는다.
- AGENTS·Skill·README·Planning Index는 전역 결정을 복제하지 않고 Baseline으로 라우팅한다.
- 날짜형 리셋 문서는 역사 기록으로 구분된다.
- 문서 정합성 자동 검사가 존재한다.

## M1 — Current Generation 디자인 계약

현재 준비된 것:

- 캐릭터별 성격·전투·외형 계약.
- Character Anchor와 공통 Art Direction.
- 제작 시트·명명·Animation·Gate 계약.
- 공통 라인업 WIP와 review.

Exit 조건:

- 캐릭터별 통제 후보와 교차 비교 증거.
- 얼굴·실루엣·저채도·원작성 검토.
- 사람 Gate A.
- Approved 2D 제작 시트와 2D→3D 변환표.

## M2 — Unity·Core·Android 개발 기반

현재 준비된 것:

- Unity 프로젝트와 Scene 흐름.
- Domain·UnityAdapter·Runtime 경계.
- 정산·저장·스킬 Command/Event 기반.
- PC/Touch 공통 입력 계층과 HUD 기반.
- EditMode·PlayMode 자동 테스트.

Exit 조건:

- Fresh Clone 재현.
- Hosted CI 결과.
- Android Build Support·SDK·NDK·JDK.
- Landscape·Safe Area·Touch 실기기 검증.
- Application Identifier와 첫 APK.

## M3 — 기능 Gray Box·역할 Prototype

Current 디자인과 별개로 기존 Gray Box 역할은 Gameplay 회귀 Proof로 유지한다.

Exit 조건:

- 전체 핵심 루프 회귀가 안정적이다.
- 5개 역할이 수동 플레이에서도 구분된다.
- Current Generation으로 handoff할 재사용/변경 범위가 확정된다.
- final art 없이도 Gameplay 수치와 입력을 조정할 수 있다.

## M4 — 반복 가능한 2D 제작 Pipeline

```text
후보 제작
→ 교차 비교
→ 사람 Gate A
→ 제작 시트
→ 2D→3D 변환표
→ Gate B
```

Exit 조건:

- 제작 시트 도구의 Import·Clone·Export 검증.
- 5인 후보 비교와 사람 선택.
- Approved 제작 시트.
- 모든 산출물 metadata·review·version 추적.

## M5 — CH101 Character Proof·Vertical Slice

필수 결과:

- CH101 Approved 2D 제작 시트.
- 2D→3D 변환 계약.
- 공용 Rig·Shader·Animator·Prefab Proof.
- CH101 모델·대표 Motion·VFX·Audio.
- 로비·선택·전투 Runtime handoff.
- 첫 환경·적·보스·캠프·UI 세트.
- Android Gate와 사용자 첫인상 평가.

Exit 조건: CH101의 매력, Gameplay 훅, 2D/3D 동일성, 쿼터뷰 가독성, 제작비, 모바일 성능이 동시에 증명된다.

## M6 — 공용 3D 기반·나머지 캐릭터

- CH101에서 검증한 공용 구조를 재사용한다.
- 얼굴·헤어·체형·대표 장비·Signature Motion·VFX만 필요한 범위에서 분리한다.
- Production Budget을 넘기는 캐릭터별 독립 Rig·Physics·Shader 시스템을 만들지 않는다.

Exit 조건: 나머지 4명도 같은 Pipeline으로 제작 가능하고 선택·로비·전투에서 명확히 구분된다.

## M7 — 출시 범위 콘텐츠

- 추가 환경·적·보스.
- 캠프 성장 연출.
- 캐릭터 해금·관계·생활 표현.
- 전체 UI·VFX·Audio.

Exit 조건: Canonical Baseline의 초기 출시 Scope를 처음부터 끝까지 플레이할 수 있다.

## M8 — QA·Release Candidate

- 전체 회귀와 저장 Migration·손상 방지.
- Android 화면비·Cutout·Lifecycle·성능·발열·메모리.
- GC·Draw Call·로딩·입력 최적화.
- Rig·관통·Animation 폴리시.
- WIP·Missing·Placeholder 제거.
- AI metadata·라이선스·외부 IP 유사성 검토.
- 스토어 자산과 외부 테스트.

Exit 조건: 출시 차단 결함이 없고 Release QA 승인을 받는다.

## Gate

Gate 정의는 Baseline이 소유하고, 구체적인 아트 판정 방법은 `ART_REVIEW_CHECKLIST.md`가 소유한다.

이 Roadmap에서 플랫폼·캐릭터 이름·정확한 비율·현재 테스트 개수·P0 실행 순서를 다시 관리하지 않는다.
