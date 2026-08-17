# Re:Camp 구현 현황 대조표

> 최종 갱신: 2026-08-07
> 상태: Active Snapshot
> 기준 브랜치: `codex/recamp-unity-mvp`
> 기준 HEAD 작성 시점: 원격 기술 기준선, 사용자 거절된 5인 v002 패키지 이력과 신규 스타일 캘리브레이션 WIP 포함
> Unity: `6000.5.3f1`

## 1. 문서 역할

이 문서는 `CURRENT_PROJECT_BASELINE.md`, `planning/sprint_backlog.md`와 원격 브랜치에 반영된 Unity
구현을 대조해 **구현·검증 근거만** 기록한다.

이번 스냅샷은 원격 기술 문서의 Core·저장·Android 계약과 2026-08-07 사용자 Gate A `FAIL`, 신규 5인
얼굴·전신 스타일 캘리브레이션 WIP를 함께 반영한다. 실제 Unity 구현 경로는 `Assets/_ReCamp/`다.

- 제품·플랫폼·아트 방향: `docs/00_project/CURRENT_PROJECT_BASELINE.md`
- 실행 순서와 상태: `planning/sprint_backlog.md`
- 시스템 책임 경계: `docs/02_system_design/MVP_SYSTEM_ARCHITECTURE.md`
- Core 통합 결과: `planning/DEV-0113_CORE_INTEGRATION_RESULT.md`

이 문서는 Backlog의 상태를 자동으로 바꾸지 않는다. 코드가 존재하더라도 직접 검증, Fresh Clone,
빌드 플레이어 또는 사람 승인이 남아 있으면 `Done`으로 과장하지 않는다.

| 상태 | 의미 |
|---|---|
| Done | 요구 범위가 구현됐고 직접 실행·자동 테스트·설정 파일 중 필요한 근거가 확인됨 |
| Review | 핵심 구현은 있으나 수동 회귀·통합 검증·사람 승인 중 일부가 남음 |
| Ready | 선행 문서·구현이 준비돼 바로 시작할 수 있음 |
| Blocked | 외부 설치·사용자 결정·기기·승인 없이는 진행 불가 |
| Deferred | 현재 필수가 아니며 실제 병목이 확인될 때 재평가 |
| Todo | 구현 또는 검증 근거가 없음 |

## 2. 현재 결론

원격 `codex/recamp-unity-mvp`에는 다음 기준선이 반영돼 있다.

- Unity Scene 5개와 `Bootstrap → Lobby → Battle → Result → Lobby` 흐름
- Orthographic 쿼터뷰, XZ 이동, 아레나 경계
- 기본 공격·피격·적 AI·웨이브·보스·자원 드랍·정산
- 5분 탐험, 귀환·사망·시간 만료·승리 결과
- 캠프 자원·시설·로컬 저장
- 5인 선택과 역할별 능력 Gray Box
- `ReCamp.Domain → ReCamp.UnityAdapter → ReCamp.Runtime` Assembly 경계
- PlayerPrefs 저장 v1→v2 마이그레이션
- EditMode 25개, PlayMode 18개 테스트 기준선
- 5인 후보·KeyArt·3뷰·8표정·장비·팔레트·Face128·2D→3D의 기술 제작 이력
- 캐릭터별 4096×4608 통합 시트 5개와 4096×2304 보드의 `STYLE REJECTED / HISTORY ONLY` 이력
- 동일 렌더링 문법을 시험하는 5인 얼굴·전신 스타일 캘리브레이션 WIP 2개

디자인 세부 수량과 승인 경계는 `planning/DESIGN_PROGRESS_2026-08-07.md`를 따른다.

하지만 다음은 아직 완료되지 않았다.

- 탐험·스킬 Domain Command/Event 통합
- Runtime과 Domain의 중복 규칙 제거
- Core·Unity CI
- 별도 디렉터리 Fresh Clone·Unity Open 재현
- Android Build Support와 SDK·NDK·OpenJDK
- Landscape 고정·Touch HUD·App ID·APK·실기기 검증
- 승인된 2D 캐릭터 제작 시트와 최종 3D
- 최종 UI·VFX·사운드·밸런스·성능 폴리시

따라서 M2·M3는 여전히 `Review`이며 Android Vertical Slice나 캐릭터 제작 완료로 판정하지 않는다.

## 3. 현재 제품·아트 기준

```text
Google Play Android 1차 제품 목표
+ Windows Editor 개발·디버그·테스트 기준
+ 2D 약 6.8~7.4등신 성인 일본 모바일 서브컬처 Key Art
+ 3D 약 5.2~5.8등신 스타일라이즈드 인게임 캐릭터
+ 3D 스타일라이즈드 환경·툰 셰이딩
+ 고정 Orthographic 쿼터뷰
```

| ID | 항목 | 상태 | 현재 판정 |
|---|---|---|---|
| RC-0008, ART-0001 | 통합 캐릭터 설정·아트 방향 v2.1 | Done | 전원 성인 여성·남성향 일본 모바일 서브컬처, 2D 약 7등신과 캐릭터별 3D 5~6등신, 2D→3D 번역 원칙을 최신 기준으로 채택한다. |
| RC-0013 | 현재 프로젝트 기준 단일화 | Done | `CURRENT_PROJECT_BASELINE.md`에 Android-first, 2D 약 7등신·3D 5~6등신, v003 실패 이력, Unity 검증 상태와 문서 소유권을 확정했다. |
| RC-0011, ART-0003 | 과거 통합 캐릭터 라인업 | Review | v001은 INVALID, v002는 REJECTED, v003은 Gate A `FAIL` 이력으로만 보존한다. 새 후보의 제작 앵커로 재사용하지 않는다. |
| ART-0004 | 아트 MCP 제작·승인 가이드 | Done | 도구 역할·사람 승인·선택형 도구 도입 원칙을 확정했으며 최신 비율·화풍은 Baseline·Art Direction v2.1을 따른다. |
| ART-0102 | 도구 비종속 캐릭터 앵커·메타데이터 규칙 | Done | `CHARACTER_ANCHOR_SPEC.md`에 공통·5인별 `LOCKED`/`CONTROLLED`/`OPEN`/`FORBIDDEN` 변수, 교차 구분 규칙과 산출물별 적용 기준을 확정했다. |
| ART-0103·0111 | 캐릭터 제작 시트 템플릿 v002 | Review | 약 7등신 2D·5~6등신 3D 변환 Frame을 포함한 v002 SVG가 있으며 실제 Figma Import·Component Clone·한글·PNG/PDF Export 검증은 남았다. |
| ART-0112 | 루나 2D→3D 변환표 샘플 | Review | 기존 7.09H→5.39H 수치와 확대·삭제·결합 원칙은 기술 이력으로 유지한다. 새 Gate A KeyArt 확정 후 Face128·비율·통합 시트를 다시 검증해야 한다. |
| ART-0113 | CH101 고품질 3D 시각 제작 모델 | In Progress | A/B 통합 WIP v002·Turnaround v003·3D LookDev 목표 v004·A canonical Turnaround v005·Expression v006·Equipment v007·Pose Board v008·Neutral Body Sculpt v009·Readability v010과 Blender 모델링/리그 템플릿을 생성하고 리그 템플릿 자동 검증 PASS를 기록했다. 공식 CC0 MPFB 인체 바디를 CH101 리그에 자동 웨이트 바인드한 WIP도 생성했으나 얼굴·헤어·의상·장비 스타일링이 남아 있다. 2026-08-17 스타일링 run6/7과 MPFB helper 정렬 run1을 추가 검증했지만 의상·헤어가 실제 인체 표면에 붙은 프리미엄 모델로 읽히지 않아 모두 WIP 반려 상태다. 같은 날짜에 v005/v010을 기준으로 얼굴·헤어·상체를 재정렬한 2D `CH101_A_FaceBustStyleAnchor_WIP_v011`과 4방향 회전 시트 `CH101_A_FaceBustRotation_WIP_v012`, MPFB 와이어 바디·CH101 리그·가이드 포인트를 묶은 `CH101_A_V012_ModelingGuide_WIP_v001.blend`를 추가했으며, 사람 검토 전 3D production mesh 입력으로 잠그지 않는다. 공통 베이스 run3/4·연결 Skin run2는 레고·토이형 실루엣으로 반려됐고, 시각 Gate A 전에는 Gate B/Unity 후보로 취급하지 않는다. |
| ART-0107 | Gate A/B/C 공통 리뷰 체크리스트 | Done | `ART_REVIEW_CHECKLIST.md`에 캐릭터·환경·UI/VFX·Unity Prefab의 Gate별 판정값, 필수 증거, 차단 조건과 인간 승인 규칙을 확정했다. |
| ART-0108 | ComfyUI·ComfyUI MCP 도입 | Deferred | 현재 필수가 아니다. 대량 일관성 생성·정밀 인페인팅·재현 가능한 고정 워크플로가 병목일 때만 재평가한다. |
| ART-0109 | 아트 자산·Export 명명 규격 | Done | `ASSET_NAMING_GUIDE.md`에 Source→Review→Runtime 이름, LOD·Socket, Export manifest, GUID 보존과 Gray Box·코드 이름 의존성 예외를 확정했다. |
| ART-0110 | 공용·캐릭터 Animation 규격 | Done | `ANIMATION_GUIDE.md`에 현재 Gameplay와 디자인 후보를 분리한 5인 Clip, in-place, Animator/AOC, Event Cue, 장비·Import와 Gate B/C 계약을 확정했다. |
| ART-1001~1409 | 5명 약 7등신 2D 제작 패키지 | In Progress | 기존 5인 v002 패키지는 사용자 Gate A `FAIL`. 새 얼굴 마스터 v002와 사용자 선호 노출도·신장·체형, 루나 패널 없는 차콜 쇼츠, 미유 짧은 랩 패널·바닥 케이블 제외를 반영한 전신 패션 v007 WIP를 생성했으며, 전체 스타일 락 뒤 KeyArt와 파생 시트를 재생성한다. |
| ART-1501~1504 | 5인 일관성·유사성·라인업 리뷰 | In Progress | 기존 4096×2304 라인업과 교차 보드는 역사 자료다. 새 KeyArt 5개 확정 후 동일 게임 응집도·Face128·실루엣·유사성을 다시 검토한다. |
| ART-4001~ART-4004 | 최종 UI Design System·화면 | Todo | 현재 UGUI는 기능 검증용 Gray Box HUD다. 최종 아트·스킬 선택 UI 완료로 간주하지 않는다. |

현재 제작 방향은 `CURRENT_PROJECT_BASELINE.md`와 `ART_DIRECTION.md` v2.1로 단일화했다.
원본 전투 이미지는 환경·카메라·색 대비와 캐릭터 존재감의 참고이며 외형·무기·파티 구성은
공식 디자인 기준이 아니다. 정확한 얼굴·체형·의상·무기는 개별 Approved 시트에서 확정한다.
`PRODUCTION_DIRECTION.md`는 과거 링크 호환용 안내만 유지한다.

Approved 2D 제작 시트는 `0/5`, 최종 3D Model·Prefab·Animator도 `0/5`다. 기존 5인 제작물은
Gate A `FAIL / HISTORY ONLY`이며, 신규 얼굴·전신 캘리브레이션 2개만 `WIP`다.

## 4. Unity 프로젝트·Scene 기반

| ID | 항목 | 상태 | 근거와 남은 범위 |
|---|---|---|---|
| DEV-0101 | Unity 프로젝트 | Done | `ProjectVersion.txt` 기준 `6000.5.3f1` |
| DEV-0102 | Visible Meta Files·Force Text | Done | `.meta`와 Text Serialization 설정 존재 |
| DEV-0103 | `Assets/_ReCamp` 구조 | Done | Scenes, Scripts, Art, Audio, Prefabs, Tests 등 반영 |
| DEV-0104 | 원격 Git 반영·재현 | Review | 프로젝트 기준선은 원격에 존재. 별도 Fresh Clone·Unity Open 검증 남음 |
| DEV-0105 | Scene 5개 | Done | Bootstrap·Title·Lobby·Battle·Result와 Build Settings 등록 |
| DEV-0106 | `SceneLoader` | Done | `GameScene` enum 기반 중앙 Scene 매핑 |
| DEV-0107 | `GameManager` | Done | 선택 캐릭터·Run 상태·보상·Scene 흐름 유지 |
| DEV-0110 | Domain 상태와 Presentation 연결 | Review | 캠프 저장 Adapter 반영. 탐험·스킬·정산 경계 남음 |

## 5. DEV-0113 Core 통합

현재 Assembly 구조는 다음과 같다.

```text
ReCamp.Domain
→ ReCamp.UnityAdapter
→ ReCamp.Runtime
```

| 항목 | 상태 | 현재 근거 |
|---|---|---|
| Domain Assembly | Done | `noEngineReferences: true`, 자원·시설·세션·저장 DTO 존재 |
| UnityAdapter Assembly | Done | Domain 저장과 Unity 캠프 저장 변환 |
| Runtime Assembly | Done | Unity Input·UI·Scene·전투 Presentation 소유 |
| Food↔Rations 변환 | Done | Adapter와 Contract Test 반영 |
| 시설 저장 왕복 | Done | Generator·Workshop·RationStorage 레벨 복원 검증 |
| PlayerPrefs v1→v2 | Done | Legacy Key 읽기·변환·v2 재저장 구현 |
| 탐험 Outcome 정산 | Review | `ResolveRunCommand`·`RunSettlementPolicy`·`RunResolvedEvent`를 Domain에 추가하고 `GameManager`가 결과만 적용하도록 연결했다. Run ID 증가와 비활성 런 중복 정산 차단도 반영했으며 Scene 통합 테스트는 남아 있다. |
| 스킬 Command/Event | Review | 역할 Gray Box는 동작하지만 Domain·Presentation 경계 미완료 |
| 중복 수치 제거 | Review | 캠프 비용·효과의 최종 단일 소유자 정리 필요 |

DEV-0113 전체 상태는 `In Progress`를 유지한다. 상세 완료·잔여 범위는
`planning/DEV-0113_CORE_INTEGRATION_RESULT.md`를 따른다.

## 6. Android 제품 기준

| ID | 항목 | 상태 | 현재 증거와 완료 조건 |
|---|---|---|---|
| DEV-0114 | Android Build Support | Blocked | AndroidPlayer·SDK·NDK·OpenJDK 설치와 Android Target 전환 필요 |
| DEV-0115 | Landscape·Safe Area | Review | `ProjectSettings.asset` Landscape 직렬화 값과 Battle HUD Safe Area 계층·anchor 매핑 회귀 테스트를 추가했다. Cutout·다중 화면비·실기기 검증은 남아 있다. |
| DEV-0116 | Touch Control·HUD | Review | `TouchHoldButton`이 활성 Pointer ID를 소유해 다른 손가락의 Up/Exit가 Hold를 해제하지 않도록 수정했고 멀티터치 EditMode 회귀 테스트를 추가했다. 실기기 입력 검증은 남아 있다. |
| DEV-0117 | App ID·첫 APK | Blocked | 템플릿 App ID 교체, Build Profile, APK 설치·3~5분 Loop·중단/복귀 증거 필요 |

현재 Windows Editor HUD 검증은 Android Touch HUD 또는 모바일 UI 완료를 의미하지 않는다.

2026-08-17 기준 Android 사전 검증 변경은 `codex/android-safearea-touch-validation`에서 최신
`main`으로 이식했다. 문서·코드 변경은 반영됐지만 이 환경에서는 Unity 라이선스가 없어 Editor
EditMode/PlayMode를 재실행하지 못했다(반환 코드 198). CI의 Fresh checkout preflight는 별도
검증 대상이며, Android APK·실기기·Lifecycle 검증 전에는 `Done`으로 승격하지 않는다.

## 7. Scene 흐름과 Gray Box 전투

| ID | 항목 | 상태 | 구현·검증 근거 | 제한 |
|---|---|---|---|---|
| DEV-0201~0204 | Bootstrap·Lobby·Battle·Result | Done | 각 Scene과 기능 UI 존재 | 최종 아트·UI 아님 |
| DEV-0205~0207 | 전체 Scene 흐름 | Done | Coplay에서 `Bootstrap → Lobby → Battle → Result → Lobby` 직접 완주 | 단일 자동 통합 테스트 남음 |
| DEV-0208 | Input System·이동 | Review | 카메라 상대 XZ 이동 구현 | 실제 PC 입력 회귀와 Touch 통합 남음 |
| DEV-0209 | 카메라·경계 | Done | Orthographic `35.3° / 45°`, 배우·카메라 Clamp | 최종 캐릭터 크기에 따라 Framing 조정 가능 |
| DEV-0210 | 공격·피격·사망 | Done | Damageable과 자동 공격 검증 | 최종 Hitbox·타격감 아님 |
| DEV-0211 | 적 추적 AI | Done | 등록·추적·사망 제외·정리 자동 검증 | 적 종류별 고유 행동 미구현 |
| DEV-0212 | 웨이브·보스 | Done | 일반 웨이브 후 보스 스폰 | 정식 난이도 구성 아님 |
| DEV-0213 | 자원 드랍·정산 | Done | 드랍·흡수·Result·Camp 입금 검증 | 전체 흐름 단일 통합 테스트 남음 |
| DEV-0214 | 귀환·사망·시간 만료 | Done | 5분·60초 경고·조기 귀환·시간 만료·승패 이유 구현 | 모바일 입력·연출·밸런스 남음 |
| DEV-0215 | 로컬 저장 | Done | 캠프 자원·시설 v2 저장과 Migration | 앱 재시작·손상·향후 Schema 검증 확대 필요 |

## 8. 캐릭터 5명 전투 프로토타입

| ID | 캐릭터 | 상태 | 현재 구현 | 남은 범위 |
|---|---|---|---|---|
| CHR-0301~0302 | 공통·선택 | Done | Roster, Stats, 선택 유지, HUD·팔레트 적용 | 최종 모델·UI 아님 |
| CHR-0310~0311 | 루나 | Review | 3타·스캔·자원 탐지 | VFX·수치·최종 입력 |
| CHR-0320~0321 | 미유 | Review | 드론·버스트·오버클럭 | 수동 대상 지정·폴리시 |
| CHR-0330~0331 | 코코 | Review | 회복·시간제 보호막 | 상태 이상·해제 시스템 |
| CHR-0340~0341 | 이리스 | Review | 차지 사격·보스 보정·표식 | 약점 연출·수치 조정 |
| CHR-0350~0351 | 노아 | Review | 피해 감소·반격·밀치기·방벽 | 충돌·연출 튜닝 |
| CHR-0360 | 5인 역할·밸런스 | Review | 역할 차이와 자동 테스트 존재 | 수동 플레이·중복·수치 검토 |

현재 플레이어 프록시는 공통 기능 검증용이며 승인된 캐릭터 모델이 아니다.

## 9. 검증 근거

### 2026-07-13 수동 회귀

- Unity Editor와 Coplay 연결
- `_ReCamp` Console 오류 0건
- Battle HUD, 로봇 프록시, 카메라 상대 이동, Arena Clamp, 자원 흡수
- 전체 Scene 흐름 완주
- `Scrap 2 / Food 1 / Data 0` Result 전달과 Lobby 유지

### 2026-07-14 자동·수동 회귀

- EditMode `25/25`, PlayMode `18/18`
- 5인 선택·능력 Gray Box
- `05:00` 타이머, 루나 Scan, TimeExpired 결과 직접 확인

### 2026-07-19 Core 통합 회귀

- Domain·UnityAdapter·Runtime 컴파일
- `_ReCamp` Console 오류 0건
- EditMode `25/25`, PlayMode `18/18`
- Food↔Rations, 시설 저장 복원, PlayerPrefs v1→v2 Migration 확인

2026년 7월 27일 문서 갱신 과정에서는 Unity Editor를 다시 실행하지 않았다. 따라서 위 테스트 수치가
최신 직접 실행 기준이며, 이후 문서 변경은 Runtime 검증 결과를 추가하지 않는다.

## 10. 테스트·CI·재현성

| ID | 항목 | 상태 | 남은 작업 |
|---|---|---|---|
| DEV-0111 | EditMode·PlayMode Assembly | Done | 현재 25 + 18 테스트 기준선 |
| DEV-0112 | Core·Unity CI | Todo | GitHub Actions 또는 Runner에서 Domain·EditMode·PlayMode 실행 |
| TEST-0201 | Scene 흐름 자동화 | Review | 실제 Scene 전환과 상태 전달 통합 테스트 |
| TEST-0202 | 전투·보상·정산 자동화 | Review | 사망 드랍부터 Result·Camp 저장까지 단일 통합 테스트 |
| Fresh Clone | Review | 별도 디렉터리 Clone·LFS·Unity Open·Compile·Tests 재현 |
| Android Player | Blocked | Module 설치·Build·기기 실행 필요 |

## 11. 선택형 도구와 아트 파이프라인

| ID | 항목 | 상태 | 판정 |
|---|---|---|---|
| ART-0108 | ComfyUI | Deferred | 대량 일관성·정밀 인페인팅·고정 Seed/LoRA 등이 실제 병목일 때 도입 |
| ART-0104 | Blender 소품 Export | Ready | Blender 연결·테스트 소품 `.blend`→FBX 증거 필요 |
| ART-0105 | FBX Import·Prefab | In Progress | `Assets/_ReCamp/Editor/ReCampCharacterImportProof.cs`가 CH101 v010 FBX의 Humanoid·Material·Socket·LOD·triangle preflight를 기록한다. Blender LOD0/1/2·6 material·2-influence 산출물은 연결됐고 실제 Unity Import/Prefab 캡처가 남아야 Review를 종료한다. |
| ART-2001~2010 | 3D 규격·루나 Proof | Todo | Approved 루나 약 7등신 시트와 5.3~5.4등신 변환표 선행 |

Primitive 프록시를 최종 모델로 전환하지 않는다. v003 이미지를 신규 디자인의 Base로 사용하지 않는다.

## 12. 다음 실행 기준

이 문서에서 별도 우선순위를 만들지 않는다. 항상 `planning/sprint_backlog.md`의 P0 실행 큐를 따른다.

현재 기술 측 최우선은 다음과 같다.

```text
DEV-0113 탐험·스킬 경계
→ DEV-0115 Landscape·Safe Area
→ DEV-0116 Touch 입력·HUD
→ DEV-0114 Android 도구 체인
→ DEV-0117 첫 APK·실기기
→ 통합 테스트·CI·Fresh Clone
```
