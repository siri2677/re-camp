# Re:Camp Integrated Roadmap

> 최종 갱신: 2026-07-27
> 역할: 마일스톤·Gate·단계 완료 조건

제품·플랫폼·비주얼·로스터·초기 출시 범위는 `docs/00_project/CURRENT_PROJECT_BASELINE.md`만 따른다. 이 Roadmap은 해당 결정을 복제하지 않는다. 실제 작업 순서와 상태는 `planning/sprint_backlog.md`가 우선한다.

## 마일스톤 요약

| 마일스톤 | 목표 | 상태 | Exit 기준 |
|---|---|---|---|
| M0 | 저장소·문서·데이터 기반 | Done | 작업을 선택하고 관련 기준을 찾을 수 있음 |
| M1 | 캐릭터·아트 설계 계약 | Review | 개별 후보 비교와 사람 승인 제작 시트 필요 |
| M2 | Unity·Core·Android 개발 기반 | Review | Domain 잔여 통합, CI, Fresh Clone, Android 도구·입력·첫 APK 필요 |
| M3 | 전투 Gray Box·5인 역할 프로토타입 | Review | 통합 회귀·수동 밸런스·피드백 폴리시 필요 |
| M4 | 반복 가능한 아트 파이프라인·5인 2D 승인 | In Progress | 도구 실사용 검증과 5인 Approved 시트 필요 |
| M5 | 루나 Character Proof·Vertical Slice | Todo | 루나 2D/3D/Unity/Android Gate 통과 |
| M6 | 공용 3D 기반·나머지 캐릭터 | Todo | 루나에서 검증한 비용·품질 기준을 4명에 재사용 |
| M7 | 전체 출시 범위 콘텐츠 | Todo | 계획된 환경·적·캠프·UI·VFX·사운드 완성 |
| M8 | QA·Release Candidate | Todo | 회귀·저장·성능·라이선스·스토어 자산 승인 |

## M0. 저장소·문서·데이터 기반 — Done

완료:

- Unity 저장소 구조와 LFS 규칙.
- Canonical Baseline과 문서 소유권.
- Sprint Backlog·Implementation Status·분야별 계약 문서.
- 구현용 데이터 테이블.
- LLM 작업 규칙과 프로젝트 Skill.

Exit 기준: 새로운 작업자가 Baseline과 Backlog에서 작업·기준·완료 조건을 찾을 수 있다.

## M1. 캐릭터·아트 설계 계약 — Review

완료:

- Character Bible·Anchor Spec.
- Art Direction·Review Checklist.
- 제작 시트·자산 명명·Animation 계약.
- 역사 자산의 상태와 승인 원칙 정리.

남은 일:

- 캐릭터별 후보 비교.
- 얼굴·실루엣·저채도·유사성 증거.
- 개별 2D→3D 변환표.
- 사람 승인 제작 시트.

Exit 기준: 5명 모두 Gate A와 사람 검토를 통과한 제작 시트를 가진다.

## M2. Unity·Core·Android 개발 기반 — Review

완료:

- Unity 프로젝트와 Scene 흐름.
- Domain·UnityAdapter·Runtime Assembly 기반.
- 캠프·저장 Adapter와 migration.
- EditMode·PlayMode 테스트 기반.
- 모바일 입력·Lifecycle·Android Build 사전 계약.

남은 일:

- 탐험·스킬 Domain Command/Event 연결.
- Runtime 중복 규칙 제거.
- Core·Unity CI.
- Fresh Clone 재현.
- Android Build Support와 도구 체인.
- Landscape·Touch HUD·App ID·첫 APK·실기기 검증.

Exit 기준: 새 Clone과 Android 기기에서 재현 가능한 개발 빌드와 핵심 루프 증거를 확보한다.

## M3. 전투 Gray Box·5인 역할 프로토타입 — Review

완료:

- 이동·카메라·공격·피격·적 AI·웨이브·보스.
- 자원 드랍·귀환·정산·저장.
- 캐릭터 선택과 5인 대표 능력.
- 관련 자동 테스트 기준선.

남은 일:

- 전체 Scene 전환·정산 통합 자동화.
- 수동 입력·밸런스·역할 중복 검토.
- 상태 이상·약점·대상 지정 등 남은 기능.
- 기능 VFX와 피드백 폴리시.

Exit 기준: 임시 자산 상태에서 5명의 플레이 경험이 명확히 다르고 핵심 루프 회귀가 안정적이다.

## M4. 아트 파이프라인·5인 2D 승인 — In Progress

필수 단계:

```text
후보 제작
→ 교차 비교
→ 제작 시트
→ 2D→3D 변환표
→ Gate A/B
→ 사람 승인
```

Exit 기준:

- Figma 제작 시트의 Import·Clone·Export 검증.
- Blender 소품 Export와 Unity Import Proof.
- 5인 Approved 제작 시트.
- 모든 자산에 metadata·review·버전 기록.

## M5. 루나 Character Proof·Vertical Slice — Todo

필수 결과:

- 승인된 루나 2D 제작 시트.
- 제작 가능한 3D 변환 계약.
- 최종 모델·Rig·표정·대표 Animation·VFX·Audio·Prefab.
- 로비·선택·전투 통합.
- 첫 환경·일반 적·보스·캠프·UI·튜토리얼.
- Android Gate와 타깃 사용자 평가.

Exit 기준: 루나가 2D와 3D에서 같은 캐릭터로 인식되고, 핵심 재미·가독성·성능이 한 구간에서 증명된다.

## M6. 공용 3D 기반·나머지 캐릭터 — Todo

- 루나에서 검증한 Base Mesh·Rig·Shader·Animator·Prefab 구조를 재사용한다.
- 캐릭터별 얼굴·헤어·체형·장비·대표 Motion·VFX는 분리한다.
- 공용 구조가 개별 실루엣과 플레이 차이를 훼손하지 않는지 검증한다.

Exit 기준: 5명 모두 선택·로비·전투에서 동작하고 외형·모션·플레이가 구분된다.

## M7. 전체 출시 범위 콘텐츠 — Todo

- 추가 환경·일반 적·보스.
- 캠프 시설과 성장 연출.
- 캐릭터 해금·친밀도·로비 상호작용.
- 전체 UI Design System·VFX·사운드.

Exit 기준: Baseline의 초기 출시 범위를 처음부터 끝까지 플레이할 수 있다.

## M8. QA·Release Candidate — Todo

- 전체 회귀와 저장 migration·손상 방지.
- Android 기기별 성능·발열·Lifecycle.
- 메모리·GC·Draw Call·로딩·입력 최적화.
- 리깅·관통·Animation 폴리시.
- 미승인 WIP 제거.
- 라이선스·AI metadata·외부 IP 유사성 검토.
- 스토어 이미지·스크린샷·트레일러·외부 테스트.

Exit 기준: 출시 차단 결함이 없고 Release QA 승인을 받는다.

## 승인 Gate

Gate의 방향과 전역 기준은 Baseline을 따른다.

- Gate A: 캐릭터 매력과 식별성.
- Gate B: 제작 가능성과 2D→3D 변환.
- Gate C: Unity 통합·가독성·기능·성능.
- Android Gate: Touch·Safe Area·Lifecycle·APK·실기기.

## 실행 문서

- 현재 작업 순서·상태: `planning/sprint_backlog.md`
- 구현·테스트 증거: `planning/IMPLEMENTATION_STATUS.md`
- 아트 단계: `planning/art_production_roadmap.md`
- 아트 산출물 ID: `planning/art_production_backlog.md`

이 Roadmap에서 현재 P0 순서, 테스트 개수, 캐릭터 수치, 전역 디자인 값을 별도로 관리하지 않는다.
