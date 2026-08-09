# Re:Camp 구현 현황 대조표

> 최종 갱신: 2026-08-09
> 상태: Active Snapshot
> 기준 브랜치: `codex/recamp-unity-mvp`
> 기준 HEAD 작성 시점: 원격 `38d1eb9` 기술 문서 기준선과 신규 5인 디자인 문서 패키지 포함
> Unity: `6000.5.3f1`

## 1. 문서 역할

이 문서는 `CURRENT_PROJECT_BASELINE.md`, `planning/sprint_backlog.md`와 원격 브랜치에 반영된 Unity
구현을 대조해 **구현·검증 근거만** 기록한다.

이번 스냅샷은 원격 기술 문서의 Core·저장·Android 계약과 2026-08-09 신규 5인 디자인
Baseline 문서를 함께 반영한다. 실제 Unity 구현 경로는 `Assets/_ReCamp/`다.

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
- EditMode 31개, PlayMode 19개 테스트 기준선
- 기존 5인 선택·역할 능력 Gray Box는 기능 검증용 레거시로 유지
- 신규 CH101~CH105 Character Bible·Anchor·Art Direction·Prompt·Gate A 문서 패키지
- 신규 이미지 후보·제작 시트·사람 승인·최종 3D는 아직 없음

신규 디자인 세부 상태와 승인 경계는 `planning/DESIGN_PROGRESS_2026-08-07.md`를 따른다.

하지만 다음은 아직 완료되지 않았다.

- Core·Unity CI
- 별도 디렉터리 Fresh Clone·Unity Open 재현
- Android Build Support와 SDK·NDK·OpenJDK
- Landscape 고정·Touch HUD·App ID·APK·실기기 검증
- 신규 이미지 후보·승인된 2D 캐릭터 제작 시트와 최종 3D

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
| RC-0008, ART-0001 | 통합 캐릭터 설정·아트 방향 v3.0 | Done | CH101~CH105 성인 여성 5인, 2D 약 7등신·3D 5~6등신, 신규 훅·역할·2D→3D 원칙과 비복제 규칙을 채택한다. |
| RC-0013 | 현재 프로젝트 기준 단일화 | Done | `CURRENT_PROJECT_BASELINE.md`에 Android-first와 Unity 검증 상태를 확정하고 신규 아트 문서를 별도 소유권으로 연결한다. |
| RC-0011, ART-0003 | 과거 통합 캐릭터 라인업 | Review | 과거 라인업과 캐릭터별 자료는 `HISTORY ONLY`로 보존하며 새 후보의 제작 앵커로 재사용하지 않는다. |
| ART-0004 | 아트 MCP 제작·승인 가이드 v3.0 | Done | 신규 후보 생성 대기·사람 Gate A·선택형 도구 도입 원칙을 확정했다. |
| ART-0102 | 신규 캐릭터 앵커·metadata 규칙 v3.0 | Done | `CHARACTER_ANCHOR_SPEC.md`에 CH101~CH105 `LOCKED`/`CONTROLLED`/`OPEN`/`FORBIDDEN`을 확정했다. |
| ART-0103·0111 | 캐릭터 제작 시트 템플릿 v003 | Review | 신규 Instance와 6-Frame 구조가 있으며 실제 Figma Import·Component Clone·한글·PNG/PDF Export 검증은 남았다. |
| ART-0112 | 신규 2D→3D 변환표 | Todo | Gate A 후보 선택 후 작성한다. |
| ART-0107 | Gate A/B/C 공통 리뷰 체크리스트 v3.0 | Done | 신규 캐릭터 매력·원작성·制作 가능성·Unity Gate와 인간 승인 규칙을 확정했다. |
| ART-0108 | ComfyUI·ComfyUI MCP 도입 | Deferred | 대량 일관성 생성·정밀 인페인팅·재현 workflow가 병목일 때만 재평가한다. |
| ART-0109 | 아트 자산·Export 명명 규격 v002 | Done | 신규 Subject·CH101~CH105와 Gray Box 코드 이름 의존성 예외를 확정했다. |
| ART-0110 | 공용·캐릭터 Animation 규격 | Review | 현재 Animation Guide는 레거시 Gray Box와 신규 승인 모션을 분리하는 경계 검토 중이다. |
| ART-1001~1409 | 신규 CH101~CH105 2D 제작 패키지 | Ready | 역할·성격·프롬프트는 준비됐고 이미지 provider 연결 후 각 3안·KeyArt·3뷰·표정·장비를 생성한다. |
| ART-1501~1504 | 신규 5인 일관성·유사성·라인업 리뷰 | Todo | 실제 이미지 생성·동일 크기 보드·metadata·사람 검토가 남았다. |
| ART-4001~ART-4004 | 최종 UI Design System·화면 | Todo | 현재 UGUI는 기능 검증용 Gray Box HUD다. 최종 아트·스킬 선택 UI 완료로 간주하지 않는다. |

현재 제작 방향은 `docs/05_art_concept/ART_DIRECTION.md` v3.0, `CHARACTER_BIBLE.md` v3.0,
`CHARACTER_ANCHOR_SPEC.md` v3.0과 `planning/DESIGN_DIRECTION_2026-08-09.md`로 단일화했다.
원본 전투 이미지는 환경·카메라·색 대비와 캐릭터 존재감의 참고이며 외형·무기·파티 구성은 공식
디자인 기준이 아니다. 정확한 얼굴·체형·의상·무기는 개별 `APPROVED` 시트에서 확정한다.
현재 신규 Approved 2D 제작 시트는 `0/5`, 최종 3D Model·Prefab·Animator도 `0/5`다.
신규 후보 문서는 `REVIEW`/`Ready`이며 자동으로 `APPROVED`되지 않는다.

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
| 탐험 Outcome 정산 | Done | Domain 정책·idempotence, Runtime 연결, Result/Camp 정산 통합 테스트 `19/19` |
| 스킬 Command/Event | Done | Domain cooldown/event, Runtime 연결, HUD 표시, Unity Compile/EditMode/PlayMode 검증 |
| 중복 수치 제거 | Done | 캠프 비용·시설 효과를 Domain 단일 소유자로 이동하고 CampManager는 Adapter 역할만 수행 |

DEV-0113 전체 상태는 `Done`이다. Fresh Clone과 CI는 각각 별도 검증 항목으로 남아 있다.

| ID | 항목 | 상태 | 현재 증거와 완료 조건 |
|---|---|---|---|
| DEV-0114 | Android Build Support | Blocked | AndroidPlayer·SDK·NDK·OpenJDK 설치와 Android Target 전환 필요 |
| DEV-0115 | Landscape·Safe Area | Review | Portrait autorotation disabled in `ProjectSettings`; `Screen.safeArea`와 Safe Area Touch HUD 구현. Cutout·다중 화면비·실기기 검증 필요 |
| DEV-0116 | Touch Control·HUD | Review | `BattleInputRouter`가 Keyboard·VirtualJoystick·TouchHoldButton을 공통 Command로 연결. EditMode `35/35`·PlayMode `21/21`; Android device smoke 필요 |
| DEV-0117 | App ID·첫 APK | Blocked | 템플릿 App ID 교체, Build Profile, APK 설치·3~5분 Loop·중단/복귀 증거 필요 |

현재 구현은 Android Touch HUD와 공통 입력 경로까지 포함하지만, Android 빌드·실기기 Smoke 완료를 의미하지 않는다.

## 7. Scene 흐름과 Gray Box 전투

| ID | 항목 | 상태 | 구현·검증 근거 | 제한 |
|---|---|---|---|---|
| DEV-0201~0204 | Bootstrap·Lobby·Battle·Result | Done | 각 Scene과 기능 UI 존재 | 최종 아트·UI 아님 |
| DEV-0205~0207 | 전체 Scene 흐름 | Done | Coplay에서 `Bootstrap → Lobby → Battle → Result → Lobby` 직접 완주 | 단일 자동 통합 테스트 남음 |
| DEV-0208 | Input System·이동 | Review | `BattleInputRouter`를 통한 Keyboard·Touch 이동과 카메라 상대 XZ 이동 | 실제 Android 입력·감도 회귀 필요 |
| DEV-0209 | 카메라·경계 | Done | Orthographic `35.3° / 45°`, 배우·카메라 Clamp | 최종 캐릭터 크기에 따라 Framing 조정 가능 |
| DEV-0210 | 공격·피격·사망 | Done | Damageable과 자동 공격 검증 | 최종 Hitbox·타격감 아님 |
| DEV-0211 | 적 추적 AI | Done | 등록·추적·사망 제외·정리 자동 검증 | 적 종류별 고유 행동 미구현 |
| DEV-0212 | 웨이브·보스 | Done | 일반 웨이브 후 보스 스폰 | 정식 난이도 구성 아님 |
| DEV-0213 | 자원 드랍·정산 | Done | 드랍·흡수·Result·Camp 입금 검증 | 전체 흐름 단일 통합 테스트 남음 |
| DEV-0214 | 귀환·사망·시간 만료 | Done | 5분·60초 경고·조기 귀환·시간 만료·승패 이유 구현 | 모바일 입력·연출·밸런스 남음 |
| DEV-0215 | 로컬 저장 | Done | 캠프 자원·시설 v2 저장과 Migration | 앱 재시작·손상·향후 Schema 검증 확대 필요 |

## 8. 기존 5인 Gray Box 전투 프로토타입 (레거시)

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

2026년 8월 9일 현재 working tree에서 Unity `6000.5.3f1` batch 회귀를 다시 실행해 EditMode
`35/35`, PlayMode `21/21`을 확인했다 (`TestResults/editmode-current.xml`,
`TestResults/playmode-current.xml`).

## 10. 테스트·CI·재현성

| ID | 항목 | 상태 | 남은 작업 |
|---|---|---|---|
| DEV-0111 | EditMode·PlayMode Assembly | Done | EditMode 35/35, PlayMode 21/21 통과 |
| DEV-0112 | Core·Unity CI | Review | `.github/workflows/unity-tests.yml`에 GameCI Unity Test Runner v4 설정. Hosted run은 push 후 확인 필요 |
| TEST-0201 | Scene 흐름 자동화 | Done | `Bootstrap → Lobby → Battle → Result → Lobby` 자동 전환 테스트 통과 |
| TEST-0202 | 전투·보상·정산 자동화 | Done | Extracted 보상·Result·Camp 저장 통합 테스트 통과 |
| Fresh Clone | Done | 별도 clone에 최신 Unity 소스 스냅샷을 반영하고 Compile·EditMode `31/31`·PlayMode `19/19` 재현 |
| Android Player | Blocked | Module 설치·Build·기기 실행 필요 |

## 11. 선택형 도구와 아트 파이프라인

| ID | 항목 | 상태 | 판정 |
|---|---|---|---|
| ART-0108 | ComfyUI | Deferred | 대량 일관성·정밀 인페인팅·고정 Seed/LoRA 등이 실제 병목일 때 도입 |
| ART-0104 | Blender 소품 Export | Ready | Blender 연결·테스트 소품 `.blend`→FBX 증거 필요 |
| ART-0105 | FBX Import·Prefab | Todo | 검증된 FBX 이후 진행 |
| ART-2001~2010 | 3D 규격·CH101 Proof | Todo | Approved CH101 약 7등신 시트와 5.3~5.4등신 변환표 선행 |

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
