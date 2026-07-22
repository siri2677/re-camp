# Re:Camp Current Project Baseline

> 최종 갱신: 2026-07-21
> 상태: Active
> 목적: 제품 방향과 현재 검증 상태가 문서마다 달라질 때 적용할 단일 기준

## 1. 적용 범위와 우선순위

이 문서는 Re:Camp의 제품·플랫폼·비주얼 방향과 현재 단계만 고정한다. 세부 작업 상태나
제작 규격을 복제하지 않고 아래 단일 소스로 연결한다.

```text
CURRENT_PROJECT_BASELINE.md
→ planning/sprint_backlog.md
→ planning/roadmap.md
→ 분야별 docs/와 planning/art_production_backlog.md
→ tables/
→ APPROVED art_refs/
→ REVIEW·WIP art_refs/
```

- 실행 상태는 `planning/sprint_backlog.md`가 유일한 기준이다.
- 구현·검증 근거는 `planning/IMPLEMENTATION_STATUS.md`에만 누적한다.
- 아트 산출물 상태는 자산의 metadata와 review 기록을 우선한다.
- 캐릭터 외형은 사람 승인을 받은 개별 `APPROVED` 제작 시트가 생긴 뒤 해당 시트를
  텍스트 설명과 통합 라인업보다 우선한다.
- `AGENTS.md`와 Re:Camp 전용 스킬의 작업·검증 규칙은 이 문서와 별개의 운영 기준이다.

## 2. 제품 정의

Re:Camp는 자연에 잠식된 포스트 아포칼립스 위험 구역을 짧게 탐험하고 자원을 회수해
캠프를 성장시키는 가로형 모바일 3D 고정 쿼터뷰 로그라이트 RPG다.

```text
3~5분 탐험의 긴장감
+ 무사 귀환의 성취감
+ 캠프의 누적 성장
+ 성인 여성 캐릭터 5인에 대한 애착
```

핵심 루프는 다음과 같다.

```text
로비·탐험 준비
→ 위험 구역 전투·자원 회수
→ 귀환·사망·시간 만료
→ 결과 정산
→ 캠프 강화
→ 다음 탐험
```

## 3. 플랫폼 기준

| 항목 | 단일 기준 |
|---|---|
| 1차 제품 목표 | Google Play Android 정식 배포 가능한 가로형 모바일 게임 |
| 개발·자동 테스트 | Windows Unity Editor |
| 1차 외부 테스트 | Android APK와 Google Play 테스트 트랙 |
| 입력 제품 기준 | Landscape 양손 Touch UI와 조준 보조 |
| PC 입력 | 개발·QA용 Keyboard/Mouse·Gamepad |
| 후속 플랫폼 | Android 안정화 후 Windows 공개 빌드·Steam·iOS 별도 판단 |
| 플레이·저장 | 싱글플레이·로컬 저장 |

Android-first는 제품·UX 목표다. 현재 Windows Editor에서 동작하는 기능이 자동으로 Android
완료를 뜻하지 않는다. APK, Safe Area, 화면비, Touch 입력, Lifecycle, 발열, 메모리와 실기기
성능은 별도 증거가 있을 때만 `Done`으로 판정한다. 출시 시점의 Google Play 정책과 등록
요건은 공식 자료로 다시 확인한다.

## 4. 고정 게임·콘텐츠 방향

- 한 판 목표 시간은 3~5분이다.
- 탐험 중 더 진행할지 안전하게 귀환할지 선택하는 위험/보상 구조를 유지한다.
- 캠프 성장은 다음 탐험의 생존력과 선택지를 넓힌다.
- 플레이어블 로스터는 루나·미유·코코·이리스·노아, 성인 여성 5명이다.
- 타깃 표현은 남성향 서브컬처이며 캐릭터의 매력·역할·성격 구분을 우선한다.
- 초기 Character Proof와 Vertical Slice는 루나 1명을 기준으로 완성한 뒤 나머지 4명에
  검증된 구조를 확장한다.

초기 출시 범위에 포함하지 않는다.

```text
멀티플레이·PvP·길드·실시간 계정 서버
가챠·강제 광고·유료 재화 중심 설계
오픈월드·대규모 시네마틱·풀 보이스
캐릭터별 완전 고유 골격·복잡한 의상 교체
Android와 PC·iOS 동시 정식 출시
```

수익은 필수 성공 기준이 아니다. 완성·배포 가능성, 모바일 적합성, 캐릭터와 핵심 루프의
품질, 유지 가능한 비용, 포트폴리오 설명 가능성을 우선한다.

## 5. 고정 비주얼 방향

```text
2D 일반 등신 서브컬처 캐릭터 일러스트
+ 3D 4~5등신 SD-lite 스타일라이즈드 인게임 캐릭터
+ 툰 셰이딩
+ 자연에 잠식된 부드러운 포스트 아포칼립스
+ 캐릭터보다 낮은 채도·밀도의 환경
+ 고정 Orthographic 쿼터뷰 전투
```

- `art_refs/moodboard/battle_vertical_slice_concept.png`를 캐릭터 존재감, SD-lite 비율,
  환경 구성, 카메라와 색 대비의 원본 전투 비주얼 앵커로 사용한다.
- 현재 Capsule·Sphere·Cube·단색 Material은 기능 검증용 Gray Box이며 최종 품질이 아니다.
- 2D 일반 등신과 3D 4~5등신은 용도가 다르지만 같은 캐릭터로 인식돼야 한다.
- 3D를 5~6등신으로 변경하거나 v003 통합 라인업을 최종 모델링 시트로 사용하는 내용은
  현재 기준에 포함하지 않는다.

## 6. 현재 검증된 Unity 기준선

2026-07-19 기준 로컬 프로젝트에서 확인된 사실은 다음과 같다.

| 항목 | 현재 근거 |
|---|---|
| Unity | `6000.5.3f1`, URP 프로젝트 |
| Scene | Bootstrap·Title·Lobby·Battle·Result 5종 |
| 핵심 흐름 | Lobby → Battle → Result → Lobby |
| 전투 | XZ 이동, 자동 공격, 적 Wave·Boss, 승리·패배, 5분 타이머·조기 귀환 |
| 성장·저장 | 자원 3종, 결과 정산, 캠프 시설 강화, 로컬 저장과 v1→v2 migration |
| 캐릭터 기능 | 성인 여성 5인의 선택·수치·대표/역할 능력 Gray Box |
| Core 경계 | `ReCamp.Domain` + `ReCamp.UnityAdapter` 방향과 캠프·저장 포트 구현 중 |
| 자동 테스트 | EditMode 25/25, PlayMode 18/18 |
| Console | `_ReCamp` 오류 0 |

이 기준선은 Windows Editor 기능 검증이다. 다음은 아직 증명하지 않았다.

- Android Build Support 전체 설정과 재현 가능한 APK Build
- Landscape 고정, Cutout·Safe Area, Touch Control Scheme의 실기기 동작
- Android 저·중·고 기기 성능·발열·메모리·중단/복귀
- fresh clone 후 Unity open·build·test 재현
- 출시 품질 캐릭터·환경·UI·VFX·사운드

## 7. 현재 아트·디자인 상태

| 항목 | 현재 상태 |
|---|---|
| Art Direction·Character Bible | 기준 문서 존재 |
| 5인 캐릭터 앵커 | `CHARACTER_ANCHOR_SPEC.md` 완료 |
| Gate A/B/C 공통 판정 | `ART_REVIEW_CHECKLIST.md` 완료 |
| 통합 라인업 v003 | `REVIEW` 유지, 자동 Gate A `FAIL` 권고, 사람 승인 Pending |
| 개별 Approved 2D 제작 시트 | 0/5 |
| 최종 3D Model·Prefab·Animator | 0/5 |
| 최종 HUD 초상화·Icon·VFX·Audio | 0/5 |
| Unity 적용 | ID·수치·능력·대표색·텍스트 HUD까지 Gray Box 연결 |

v003의 큰 방향은 참고할 수 있으나 루나↔코코 의료 모티프, 미유↔이리스 색, 코코↔노아
방패 인상, 얼굴·체형·표정 차별화를 수정해야 한다. 사람 승인 전 `Direction Approved`나
`APPROVED`로 기록하지 않는다.

## 8. 제작 도구 기준

| 도구 | 현재 역할 |
|---|---|
| 이미지 생성 도구 | 초기 2D 후보와 교정 WIP |
| Figma 또는 동등한 편집 도구 | 제작 시트·UI Design System·리뷰 Export |
| Blender | 소품 Export Proof, Approved 시트 이후 캐릭터 Blockout |
| Coplay/unityMCP | Unity Scene·Prefab·Material·Animator·검증 자동화 |
| 코드 에이전트 | Runtime·Adapter·Importer·Validation Tool·테스트 |
| ComfyUI | 대량 일관성·정밀 인페인팅이 실제 병목일 때만 도입하는 `Deferred` 선택 사항 |

별도 유료 도구와 대용량 모델 설치를 현재 개발·아트의 필수 선행 조건으로 두지 않는다.
자동 생성 결과는 사람 검토와 제작 시트 없이 출시 자산으로 승격하지 않는다.

## 9. 현재 Gate와 다음 순서

현재 프로젝트는 기능 Gray Box를 보존하면서 Android 제품 기준과 루나 Character Proof를
연결하는 단계다. 실제 실행 순서와 상태는 `planning/sprint_backlog.md`만 갱신한다.

```text
문서·플랫폼 기준 충돌 제거
→ 진행 중인 Core Domain·Adapter 범위 완료
→ Android Landscape·Safe Area·Touch 입력 기준과 첫 APK
→ ART-0103 캐릭터 제작 시트 템플릿
→ 루나 Gate A 교정 WIP·사람 승인
→ 3D 규격·Unity Presentation/Prefab 계약
→ 루나 Blockout·Gate B/C·Android 실기기 Character Proof
→ 환경·UI·VFX를 포함한 Android Vertical Slice
→ 외부 테스트·출시 범위 확정
```

Gate를 건너뛰지 않는다.

- Gate A: 매력·성인 여성 가독성·정체성·역할·실루엣·팔레트
- Gate B: Turnaround·장비·재질·Rig·Animation 제작 가능성
- Gate C: Unity 쿼터뷰 가독성·기능 회귀·성능
- Android Gate: Touch·Safe Area·Lifecycle·APK·실기기 성능

## 10. 문서 소유권

| 내용 | 단일 소스 |
|---|---|
| 현재 제품·플랫폼·비주얼·검증 단계 | 이 문서 |
| 실행 순서·상태 | `planning/sprint_backlog.md` |
| 전체 마일스톤·Gate | `planning/roadmap.md` |
| 구현·테스트 증거 | `planning/IMPLEMENTATION_STATUS.md` |
| 아트 단계 | `planning/art_production_roadmap.md` |
| 아트 세부 작업 | `planning/art_production_backlog.md` |
| 게임 콘셉트·MVP 범위 | `GAME_CONCEPT.md`, `MVP_SCOPE.md` |
| 캐릭터 설정·시각 앵커 | `CHARACTER_BIBLE.md`, `CHARACTER_ANCHOR_SPEC.md` |
| 아트 디렉터리·승인 상태 | `ART_ASSET_STRUCTURE.md` |
| 자산 이름·버전·Export·LOD·Socket·GUID | `ASSET_NAMING_GUIDE.md` |
| 공용·캐릭터 Motion·Animator·Event·Import | `ANIMATION_GUIDE.md` |
| Gate 판정 항목 | `ART_REVIEW_CHECKLIST.md` |
| 자산별 판정 | 해당 `.metadata.md`, `.review.md` |

다른 문서는 위 내용을 요약하거나 링크할 수 있지만 독립 실행 큐, 별도 상태표, 서로 다른
수치·승인 상태를 새로 만들지 않는다.

## 11. 갱신 조건

다음 결정이 바뀌면 이 문서와 직접 소유 문서를 같은 변경 범위에서 갱신한다.

- 1차 제품 플랫폼이나 입력 방식
- 한 판 시간·핵심 루프·출시 Scope
- 캐릭터 수·성별 방향·2D/3D 비율
- Unity 메이저 기준선과 Render Pipeline
- 라인업 또는 개별 제작 시트의 사람 승인 상태
- Android 첫 APK·실기기 Gate 통과

테스트 개수처럼 자주 바뀌는 수치는 여기에서 이력화하지 않는다. 최신 상세 결과는
`planning/IMPLEMENTATION_STATUS.md`에 기록하고, 이 문서에는 기준선이 바뀔 때만 반영한다.
