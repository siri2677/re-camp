# Re:Camp Current Project Baseline

> 최종 갱신: 2026-07-27
> 상태: Active / Canonical
> 기준 브랜치: `main`
> 목적: 사람과 LLM이 프로젝트 전역 결정을 한 곳에서만 읽도록 하는 단일 기준

## 1. 반드시 먼저 읽는 문서

모든 Re:Camp 작업은 이 문서를 가장 먼저 읽는다. 제품·플랫폼·비주얼·로스터·현재 Gate·문서 우선순위는 다른 문서에서 다시 정의하지 않는다.

```text
사용자의 최신 명시적 지시
→ CURRENT_PROJECT_BASELINE.md
→ planning/sprint_backlog.md
→ 작업 분야의 세부 계약 문서
→ tables/
→ APPROVED 자산과 review 기록
→ 코드·Scene·Project Settings의 실제 상태
```

충돌 시 위 순서를 적용한다. `README.md`, `AGENTS.md`, 프로젝트 Skill, Roadmap과 Backlog는 이 문서를 요약하거나 링크할 수 있지만 전역 결정을 복제하지 않는다.

## 2. 제품 정의

Re:Camp는 자연에 잠식된 포스트 아포칼립스 위험 구역을 짧게 탐험하고 자원을 회수해 캠프를 성장시키는 싱글플레이 3D 고정 쿼터뷰 로그라이트 RPG다.

```text
3~5분 탐험의 긴장감
+ 무사 귀환의 성취감
+ 캠프의 누적 성장
+ 성인 여성 캐릭터 5인에 대한 애착
```

핵심 흐름:

```text
로비·탐험 준비
→ 위험 구역 전투·자원 회수
→ 귀환·사망·시간 만료
→ 결과 정산
→ 캠프 강화
→ 다음 탐험
```

## 3. 고정 제품 결정

| 항목 | 단일 기준 |
|---|---|
| 1차 제품 목표 | Google Play Android 정식 배포 가능한 Landscape 모바일 게임 |
| 개발·자동 테스트 | Windows Unity Editor |
| 1차 외부 테스트 | Android APK와 Google Play 테스트 트랙 |
| 입력 | 양손 Touch UI와 조준 보조, PC 입력은 개발·QA용 |
| 플레이·저장 | 싱글플레이·로컬 저장 |
| 플레이어블 | 루나·미유·코코·이리스·노아, 성인 여성 5명 |
| 타깃 표현 | 남성향 서브컬처, 캐릭터 매력·역할·성격 구분 우선 |
| 해금 | 등급·가챠 없이 스토리·탐험 진행으로 확정 해금 |
| 초기 Proof | 루나 1명을 먼저 완성한 뒤 검증된 구조를 나머지 4명에 확장 |
| Unity | `6000.5.3f1`, URP |
| 카메라 | 고정 Orthographic 쿼터뷰 |

초기 출시 제외:

```text
멀티플레이·PvP·길드·실시간 계정 서버
가챠·강제 광고·유료 재화 중심 설계
오픈월드·대규모 시네마틱·풀 보이스
캐릭터별 완전 고유 골격·복잡한 의상 교체
Android와 PC·iOS 동시 정식 출시
```

## 4. 고정 비주얼 결정

```text
2D 약 7등신 성인 서브컬처 캐릭터 일러스트
+ 3D 5~6등신 스타일라이즈드 인게임 캐릭터
+ 툰 셰이딩
+ 자연에 잠식된 부드러운 포스트 아포칼립스
+ 캐릭터보다 낮은 채도·밀도의 환경
+ 고정 Orthographic 쿼터뷰 전투
```

- 2D 대표 일러스트 기본 목표: 약 7등신, 캐릭터별 약 6.8~7.4등신.
- 인게임 3D: 캐릭터별 약 5.2~5.8등신, 전체 허용 범위 5~6등신.
- 2D는 얼굴·패션·체형·표정·재질을, 3D는 얼굴·헤어·대표 장비·전투 실루엣을 우선한다.
- 3D는 2D를 단순 축소하지 않는다. 머리·손·발·대표 장비를 확대하고 미세 장식을 단순화한다.
- 2D 대표 Key Art에서 6.5등신 미만으로 어려 보이는 결과는 사용하지 않는다.
- 3D에서 2~3등신 유아형 치비 또는 6등신을 초과하는 길고 가는 체형은 사용하지 않는다.
- `art_refs/moodboard/battle_vertical_slice_concept.png`는 화면 구도·카메라·환경·색 대비 참고다. 이미지 속 개별 캐릭터 외형·무기·파티 구성은 공식 디자인이 아니다.
- 과거 `ReCamp_CharacterLineup_REVIEW_v003`은 Gate A 실패 이력으로만 보존한다. 새 디자인의 기반 이미지나 교정 출발점으로 사용하지 않는다.
- 현재 Primitive·Gray Box는 기능 검증용이며 최종 아트 품질이 아니다.

## 5. 캐릭터 디자인 소유권

전역 로스터와 비율은 이 문서가 소유한다. 캐릭터별 고유 설정은 다음 문서가 소유한다.

| 내용 | 소유 문서 |
|---|---|
| 캐릭터별 한 문장 훅·성격·관계·역할·개별 목표 비율 | `docs/05_art_concept/CHARACTER_BIBLE.md` |
| 얼굴·헤어·체형·패션·장비의 고정·가변·금지 항목 | `docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md` |
| 색·재질·환경·UI·VFX 표현 규칙 | `docs/05_art_concept/ART_DIRECTION.md` |
| 제작 시트 Frame·Export | `docs/05_art_concept/CHARACTER_SHEET_TEMPLATE_SPEC.md` |
| Gate A/B/C 판정 | `docs/05_art_concept/ART_REVIEW_CHECKLIST.md` |
| 자산 이름·버전·Export·GUID | `docs/05_art_concept/ASSET_NAMING_GUIDE.md` |
| Motion·Animator·Event·Import | `docs/05_art_concept/ANIMATION_GUIDE.md` |
| 자산별 승인 상태 | 해당 `.metadata.md`, `.review.md`, 개별 `APPROVED` 제작 시트 |

사람 승인을 받은 개별 `APPROVED` 제작 시트가 생기면 해당 캐릭터의 얼굴·의상·장비 구조는 텍스트 설명과 통합 라인업 이미지보다 우선한다.

## 6. 현재 검증된 구현 기준선

최근 직접 검증 기준:

- Unity `6000.5.3f1`, URP.
- Bootstrap·Title·Lobby·Battle·Result Scene 5개.
- `Lobby → Battle → Result → Lobby` 흐름.
- XZ 이동, 자동 공격, 적 Wave·Boss, 승리·패배, 자원 드랍·흡수·정산.
- 5분 탐험, 귀환·사망·시간 만료 종료.
- 캠프 자원·시설·로컬 저장과 PlayerPrefs v1→v2 migration.
- 성인 여성 5인의 선택·수치·대표 능력 Gray Box.
- `ReCamp.Domain → ReCamp.UnityAdapter → ReCamp.Runtime` Assembly 경계.
- EditMode 25개, PlayMode 18개 테스트 기준선.
- `_ReCamp` Console 오류 0건.

이 기준선은 Windows Editor 기능 검증이다. 다음은 아직 증명하지 않았다.

- 탐험·스킬 Domain Command/Event 통합과 중복 규칙 제거.
- Core·Unity CI.
- Fresh Clone 후 Unity Open·Build·Test 재현.
- Android Build Support·SDK·NDK·OpenJDK.
- Landscape 고정·Touch HUD·App ID·첫 APK.
- Android 화면비·Cutout·Lifecycle·성능·발열·메모리.
- 승인된 캐릭터 2D 제작 시트와 최종 3D·UI·VFX·Audio.

최신 상세 근거는 `planning/IMPLEMENTATION_STATUS.md`만 갱신한다.

## 7. 현재 Gate와 실행 순서

실제 작업 상태와 순서는 `planning/sprint_backlog.md`가 유일한 기준이다. 현재 큰 흐름은 다음과 같다.

```text
Core Domain·Presentation 잔여 통합
→ Android Landscape·Safe Area·Touch·첫 APK
→ Figma 제작 시트 v002 실사용 검증
→ 5인 캐릭터 후보 재탐색과 Gate A 승인
→ 루나 2D→3D 변환과 Character Proof
→ Android Vertical Slice
→ 나머지 캐릭터·콘텐츠
→ QA·출시 준비
```

Gate를 건너뛰지 않는다.

- Gate A: 캐릭터 매력·성인 여성 가독성·한 문장 훅·역할·실루엣·팔레트·유사성.
- Gate B: Turnaround·2D→3D 변환·장비·재질·Rig·Animation 제작 가능성.
- Gate C: Unity 쿼터뷰 가독성·기능 회귀·성능·피드백.
- Android Gate: Touch·Safe Area·Lifecycle·APK·실기기 성능.

## 8. LLM 작업별 필수 Read Set

| 작업 유형 | 반드시 읽는 문서 |
|---|---|
| 모든 작업 | 이 문서, `planning/sprint_backlog.md`의 해당 ID |
| Unity Gameplay | `MVP_SYSTEM_ARCHITECTURE.md`, `IMPLEMENTATION_STATUS.md`, 관련 코드·테스트 |
| Core·저장 | `DEV-0113_CORE_INTEGRATION_RESULT.md`, `SAVE_DATA_SPEC.md`, 관련 Domain·Adapter 코드 |
| Android | `MOBILE_INPUT_AND_LIFECYCLE.md`, `ANDROID_BUILD_AND_RELEASE.md`, 관련 Project Settings |
| 캐릭터 디자인 | `CHARACTER_BIBLE.md`, `CHARACTER_ANCHOR_SPEC.md`, `ART_DIRECTION.md`, `ART_REVIEW_CHECKLIST.md`, 해당 최신 metadata/review |
| 3D·Animation | 승인된 제작 시트, `CHARACTER_3D_SPEC.md`, `ASSET_NAMING_GUIDE.md`, `ANIMATION_GUIDE.md` |
| 테스트·QA | 해당 계약 문서, `IMPLEMENTATION_STATUS.md`, 실제 테스트 코드와 실행 결과 |

역사 문서, `REJECTED`, `INVALID`, Gate 실패 자산은 비교 근거로만 읽고 제작 기준으로 사용하지 않는다.

## 9. 문서 역할과 갱신 규칙

| 내용 | 단일 소스 |
|---|---|
| 제품·플랫폼·전역 비주얼·로스터·현재 Gate·LLM 우선순위 | 이 문서 |
| 실행 순서·상태 | `planning/sprint_backlog.md` |
| 마일스톤 | `planning/roadmap.md` |
| 구현·테스트 증거 | `planning/IMPLEMENTATION_STATUS.md` |
| 아트 단계 | `planning/art_production_roadmap.md` |
| 아트 세부 작업 | `planning/art_production_backlog.md` |
| 게임 규칙·기능 계약 | 분야별 `docs/`와 `tables/` |

규칙:

1. 다른 문서에 플랫폼·로스터·전역 비율·현재 Gate를 다시 적지 않는다.
2. 다른 문서는 이 문서를 링크하고 자신의 분야 세부사항만 기록한다.
3. 자주 변하는 테스트 개수와 실행 결과는 `IMPLEMENTATION_STATUS.md`에만 기록한다.
4. Roadmap은 마일스톤과 Gate만, Backlog는 ID·상태·완료 조건만 관리한다.
5. 코드나 자산이 존재해도 검증 근거가 없으면 `Done`이나 `APPROVED`로 올리지 않는다.
6. 전역 결정 변경 시 이 문서를 먼저 수정하고 관련 세부 계약만 함께 갱신한다.
7. `scripts/validate_project_docs.py` 검사를 통과해야 문서 정합성 작업을 완료한다.

## 10. Branch와 PR 기준

- `main`은 통합된 최신 기준과 검증된 구현의 유일한 장기 브랜치다.
- 기능·아트·문서 작업은 짧은 작업 브랜치에서 진행하고 PR로 `main`에 병합한다.
- 장기 `develop` 브랜치는 사용하지 않는다.
- 병합된 작업 브랜치와 대체된 PR은 더 이상 기준으로 사용하지 않는다.
- 브랜치에만 존재하는 문서는 `main`에 병합되기 전까지 공식 기준이 아니다.
- LLM은 시작 시 현재 브랜치, HEAD, 변경 상태를 확인하고 `main`과의 차이를 인지한다.

## 11. 변경 시 반드시 다시 검토할 항목

다음 결정이 바뀌면 이 문서와 직접 소유 문서를 같은 변경 범위에서 갱신한다.

- 1차 제품 플랫폼·입력 방식.
- 한 판 시간·핵심 루프·출시 Scope.
- 캐릭터 수·성별 방향·전역 2D/3D 비율.
- 캐릭터별 한 문장 훅·대표 장비.
- Unity 메이저 기준선·Render Pipeline.
- 개별 제작 시트의 사람 승인 상태.
- Android 첫 APK·실기기 Gate 통과.
