# Re:Camp 구현 현황 대조표

## 1. 문서 목적과 기준

이 문서는 `CURRENT_PROJECT_BASELINE.md`·`planning/sprint_backlog.md`와 현재 로컬 Unity 구현을
대조해, 구현·검증 근거만 기록하는 현황 스냅샷이다.

- 기준 브랜치: `codex/recamp-unity-mvp` (`74f2df4` 이후 현재 작업 포함)
- 로컬 Unity 버전: `6000.5.3f1`
- 확인일: `2026-07-21`
- 실제 구현 경로: `Assets/_ReCamp/`
- 상태 판정은 코드 존재만이 아니라 직접 실행 검증 여부와 원격 저장소 재현 가능 여부를 함께 본다.

상태 의미는 다음과 같다.

| 상태 | 의미 |
|---|---|
| Done | 요구 범위가 구현됐고 직접 실행 또는 설정 파일로 확인됨 |
| Review | 핵심 구현은 있으나 승인, 수동 회귀, 또는 일부 완료 기준 확인이 남음 |
| Deferred | 필요성이 확인될 때 도입하는 선택 작업이며 현재 실행 큐나 선행 조건이 아님 |
| Blocked | 현재 상태에서는 선행 승인·외부 연결·원격 반영 없이는 완료 검증 불가 |
| Todo | 구현 또는 검증 기반이 아직 없음 |

이 문서는 현황을 설명하며 `planning/sprint_backlog.md`의 상태를 자동으로 변경하지 않는다.

## 2. 현재 결론

로컬 Unity 프로젝트에는 5개 Scene과 한 판의 Gray Box 전투 루프가 구현되어 있다. `Bootstrap -> Lobby -> Battle -> Result -> Lobby` 흐름, XZ 지면 이동 기반 쿼터뷰, 전투 HUD, 적 스폰·추적·사망, 자원 드랍·획득, 결과 정산, 캠프 인벤토리 반영과 `PlayerPrefs` 저장 코드가 직접 Play Mode로 검증됐다.

Unity 프로젝트 기준선은 원격 `codex/recamp-unity-mvp`에 반영돼 있지만 현재 Domain·Adapter와
문서 심화 작업은 미커밋 상태다. 자동 테스트 Assembly와 43개 테스트, 5인 선택·대표/역할
능력 Gray Box는 완료했다. CI, fresh clone 재현, Android APK·Touch·실기기 검증, 최종
VFX·밸런스, 승인된 캐릭터 아트, Blender 런타임 연결은 아직 완료되지 않았다. 따라서 전체
마일스톤 M2·M3를 Done으로 판정해서는 안 된다.

ComfyUI와 ComfyUI MCP는 현재 미완료 개발 항목이나 차단 요소가 아니다. 현재 이미지 생성 도구로 초기 후보 검토를 진행하고, 캐릭터 일관성 대량 생성·정밀 인페인팅·Seed/LoRA/ControlNet/IP-Adapter 고정 워크플로가 실제로 필요해질 때만 도입을 재평가한다. 그전에는 로컬 모델 파일, GPU, ComfyUI 설치를 준비하지 않아도 된다.

## 3. 확정된 아트 방향

제품·플랫폼·비주얼의 현재 기준은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`, 세부 아트 방향은
`docs/05_art_concept/ART_DIRECTION.md`를 단일 소스로 사용한다.

```text
2D 일반 등신 캐릭터 일러스트
+ 3D 4~5등신 SD-lite 스타일라이즈드 인게임 캐릭터
+ 3D 스타일라이즈드 환경
+ 툰 셰이딩
+ 고정 쿼터뷰 전투
```

| ID | 항목 | 상태 | 판정 |
|---|---|---|---|
| RC-0008, ART-0001 | 통합 캐릭터 설정·아트 방향 | Done | 전원 성인 여성·남성향, 2D 일반 등신 + 원본 전투 콘셉트 계열 3D 4~5등신 SD-lite를 최신 사용자 기준으로 채택한다. |
| RC-0013 | 현재 프로젝트 기준 단일화 | Done | `CURRENT_PROJECT_BASELINE.md`에 Android-first 제품 목표, Windows 개발 기준, 4~5등신·v003 Review·현 Unity 검증 상태와 문서 소유권을 확정했다. |
| RC-0011, ART-0003 | 통합 캐릭터 라인업 | Review | 원격 v001은 INVALID, 혼성 v002는 REJECTED. v003은 성인 여성 5인·SD-lite 방향은 유효하지만 Gate A `FAIL` 권고다. 루나↔코코 의료 모티프 등 교차 충돌과 얼굴·실루엣 차별화를 캐릭터별 WIP에서 수정한 뒤 사람 재검토한다. |
| ART-0004 | 아트 MCP 제작·승인 가이드 | Done | `origin/main`의 전체 운영 기준을 복원하고 최신 성인 여성·남성향·4~5등신 SD-lite 방향과 선택형 도구 도입 원칙을 병합했다. |
| ART-0102 | 도구 비종속 캐릭터 앵커·메타데이터 규칙 | Done | `CHARACTER_ANCHOR_SPEC.md`에 공통·5인별 `LOCKED`/`CONTROLLED`/`OPEN`/`FORBIDDEN` 변수, 교차 구분 규칙과 산출물별 적용 기준을 확정했다. |
| ART-0103 | 캐릭터 제작 시트 템플릿 | Review | `CHARACTER_SHEET_TEMPLATE_SPEC.md`와 `ReCamp_CharacterSheet_Template_REVIEW_v001.svg`에 6개 Frame, 공통 Component, Gate 증거, 사람 승인·Export 필드를 작성하고 3840×2160 렌더로 잘림을 확인했다. 실제 Figma Import·Clone·PNG/PDF Export는 남음. |
| ART-0107 | Gate A/B/C 공통 리뷰 체크리스트 | Done | `ART_REVIEW_CHECKLIST.md`에 캐릭터·환경·UI/VFX·Unity Prefab의 Gate별 판정값, 필수 증거, 차단 조건과 인간 승인 규칙을 확정했다. |
| ART-0108 | ComfyUI·ComfyUI MCP 도입 | Deferred | 현재 필수가 아니다. 대량 일관성 생성·정밀 인페인팅·재현 가능한 고정 워크플로가 병목일 때만 재평가한다. |
| ART-0109 | 아트 자산·Export 명명 규격 | Done | `ASSET_NAMING_GUIDE.md`에 Source→Review→Runtime 이름, LOD·Socket, Export manifest, GUID 보존과 Gray Box·코드 이름 의존성 예외를 확정했다. |
| ART-0110 | 공용·캐릭터 Animation 규격 | Done | `ANIMATION_GUIDE.md`에 현재 Gameplay와 디자인 후보를 분리한 5인 Clip, in-place, Animator/AOC, Event Cue, 장비·Import와 Gate B/C 계약을 확정했다. |
| ART-1001·1101·1201·1301·1401 | 5명 단독 전신 후보 | Ready | 전원 성인 여성과 남성향 캐릭터 매력 기준으로 얼굴·체형·실루엣·색상·무기를 검토한다. |
| ART-4001~ART-4004 | 최종 UI Design System·화면 | Todo | 현재 UGUI는 기능 검증용 Gray Box HUD다. 최종 아트·스킬 선택 UI 완료로 간주하지 않는다. |

현재 제작 방향은 `CURRENT_PROJECT_BASELINE.md`와 `ART_DIRECTION.md`로 단일화했다. 원본
이미지는 캐릭터 감성·환경 구도·카메라·가독성의 우선 앵커이며, 정확한 얼굴·체형·의상·무기는
개별 Approved 시트에서 확정한다. `PRODUCTION_DIRECTION.md`는 과거 링크 호환용 안내만 유지한다.

## 4. Unity 프로젝트와 Scene 기반

| ID | 항목 | 상태 | 구현·검증 근거 | 남은 범위 |
|---|---|---|---|---|
| DEV-0101 | Unity 버전 확정·프로젝트 생성 | Done | `ProjectSettings/ProjectVersion.txt`에서 Unity `6000.5.3f1` 확인, Editor 실행 및 Coplay 연결 확인 | 원격 Clone 재현은 DEV-0104에서 별도 판정 |
| DEV-0102 | Visible Meta Files·Force Text | Done | `.meta` 파일이 생성되어 있고 `ProjectSettings/EditorSettings.asset`의 serialization mode가 Force Text 값으로 설정됨 | 없음 |
| DEV-0103 | `Assets/_ReCamp` 구조 | Done | Scenes, Scripts, Art, Audio, Prefabs, Resources, ScriptableObjects 등 로컬 구조 확인 | 최종 자산 구조는 아트 파이프라인에서 확장 |
| DEV-0104 | `Assets`, `Packages`, `ProjectSettings`, `.meta` Git 반영 | Review | Unity 프로젝트 기준선은 `origin/codex/recamp-unity-mvp`에 반영돼 있으며 현재 DEV-0113 작업분은 로컬 미커밋 상태 | DEV-0113 완료 후 별도 경로 fresh clone·Unity open 검증 필요 |
| DEV-0105 | Bootstrap·Title·Lobby·Battle·Result Scene | Done | `Assets/_ReCamp/Scenes/00_Bootstrap.unity`부터 `04_Result.unity`까지 존재하며 `ProjectSettings/EditorBuildSettings.asset`에 순서대로 등록됨 | 없음 |
| DEV-0106 | `SceneLoader` | Done | `Assets/_ReCamp/Scripts/GameFlow/SceneLoader.cs`가 enum을 5개 Scene 이름에 매핑하고 비동기 로드 | Play Mode 전체 흐름으로 직접 확인 |
| DEV-0107 | Unity `GameManager`·서비스 초기화 | Done | `Assets/_ReCamp/Scripts/Core/GameManager.cs`가 단일 인스턴스, Scene 간 유지, Run 상태·보상·CampManager 초기화를 관리 | 기존 비종속 Core 통합과는 별개 |

## 5. 기존 Core 통합 현황

| ID | 항목 | 상태 | 판정과 완료 조건 |
|---|---|---|---|
| DEV-0108 | 기존 `ReCamp.Core` Unity 호환성 검토 | Done | `planning/DEV-0108_CORE_COMPATIBILITY_AUDIT.md`에 원격 `origin/agent/unity-independent-core`의 API·의존성·규칙 차이를 기록. 원격 `net8.0` suite는 이 환경의 dotnet CLI 부재로 미실행 |
| DEV-0109 | Core 소스 공유·Assembly·Adapter 방식 확정 | Done | 원격 원본 직접 병합 대신 portable `ReCamp.Domain` + `ReCamp.UnityAdapter` 경계를 확정. namespace 이동·save migration·contract test는 DEV-0113 구현 범위 |
| DEV-0110 | Core 상태와 Unity Presentation 연결 | Review | 현재 GameManager·Scene Controller 연결은 동작하고 Domain save adapter를 추가했으나, 탐험·스킬 command/event와 최종 Presentation 경계 정리가 남음 |
| DEV-0113 | 기존 Unity 비종속 Core PR 검토·통합 | In Progress | `ReCamp.Domain`(Unity 의존성 없음)과 `ReCamp.UnityAdapter` asmdef를 추가하고, 캠프·자원·시설·domain save 포트 및 v1 PlayerPrefs -> v2 저장 migration/contract test를 구현했다. 기존 `ReCamp.Core`의 `GameManager`/`RunState`는 `ReCamp.Runtime`로 이동했다. 2026-07-19 Unity `6000.5.3f1` 컴파일, `_ReCamp` 오류 0, EditMode 25/25, PlayMode 18/18 통과. 원격 탐험·스킬 도메인 포트와 Presentation command/event 연결은 남아 있다. |

### Android 제품 기준 등록

| ID | 항목 | 상태 | 현재 증거와 완료 조건 |
|---|---|---|---|
| DEV-0114 | Android Build Support·SDK·NDK·OpenJDK | Blocked | 2026-07-21 현재 설치된 Unity `6000.5.3f1`의 `Editor/Data/PlaybackEngines/AndroidPlayer`가 없고 SDK·NDK·OpenJDK도 확인되지 않았다. Unity Hub Module 설치, Android Target 전환과 빈 Development Build가 완료 조건이다. |
| DEV-0115 | Android Landscape·Safe Area | Review | `BattleHudController`가 `Screen.safeArea`로 HUD Root를 갱신하지만 `ProjectSettings.asset`은 `defaultScreenOrientation: 4`이고 Portrait·Landscape 네 방향이 모두 허용돼 있다. Landscape 고정, 16:9 외 화면비·Cutout 자동 테스트와 실기기 확인이 남았다. |
| DEV-0116 | Touch Control Scheme·On-screen HUD | Ready | 기본 Input Actions에는 Touch binding이 있으나 실제 이동·능력·귀환은 `Keyboard.current`를 직접 읽고 On-screen Stick/Button은 없다. Touch 이동·공격·능력·귀환과 PC 개발 입력 병행, PlayMode 검증이 완료 조건이다. |
| DEV-0117 | Android App ID·Build Profile·첫 APK | Blocked | Android Application Identifier가 `com.UnityTechnologies.com.unity.template.urpblank` 기본값이다. DEV-0114~0116, 배포용 식별자 결정, APK 설치·3~5분 루프·중단/복귀·로그·스크린샷 증거가 필요하다. |

`GameManager.cs`의 네임스페이스 이름만으로 DEV-0108~DEV-0113을 완료 처리하지 않는다.

## 6. Scene 흐름과 Gray Box 전투

| ID | 항목 | 상태 | 구현·검증 근거 | 제한 |
|---|---|---|---|---|
| DEV-0201 | Bootstrap 구성 | Done | Bootstrap에서 GameManager 초기화 후 Lobby 진입 확인 | Title은 현재 빠른 MVP 경로에서 우회 가능 |
| DEV-0202 | Lobby Gray Box | Done | Battle 시작과 캠프 인벤토리·시설 UI가 동작 | 최종 캐릭터 선택·아트 UI 아님 |
| DEV-0203 | Battle Gray Box | Done | 플레이어, 적·보스, 아레나, 자원, 런타임 Screen Space UGUI HUD가 한 Scene에서 동작 | 최종 아트·VFX·성능 기준 미적용 |
| DEV-0204 | Result Gray Box | Done | 획득 보상 요약과 Lobby 복귀 확인 | 최종 결과 연출 아님 |
| DEV-0205~DEV-0207 | Lobby -> Battle -> Result -> Lobby | Done | Coplay Play Mode에서 전체 Scene 흐름 직접 완주 | TEST-0201 자동화는 Review이며 실제 Scene 전환·상태 전달 확대가 남음 |
| DEV-0208 | Input System·PlayerController | Review | 카메라 기준 이동 벡터와 플레이어 이동 동작 확인 | 실제 WASD·방향키 입력 및 바라보기 수동 회귀가 남음 |
| DEV-0209 | 쿼터뷰 카메라·이동 경계 | Done | orthographic 쿼터뷰, 카메라 상대 XZ 이동, 배우·카메라 아레나 clamp 직접 확인 | 최종 캐릭터 크기에 맞춘 framing 재조정 가능 |
| DEV-0210 | 기본 공격·Hitbox·Damageable | Done | 자동 공격, 피격, 체력, 보호막, 피해 감소, 사망과 승리 전환 확인. Damageable EditMode 테스트 7개 통과 | 실제 공격 Hitbox의 Scene 통합 자동화는 남음 |
| DEV-0211 | EnemyController·추적 AI | Done | 적·보스 프록시 추적과 전투 참여, 최근접 탐색·사망 즉시 타기팅 제외·레지스트리 정리 자동 검증 | 적 종류별 고유 행동은 미구현 |
| DEV-0212 | EnemySpawner·웨이브 | Done | 일반 웨이브 뒤 보스 스폰과 자연 승리 흐름 확인 | 정식 난이도·다중 웨이브 구성 아님 |
| DEV-0213 | 몬스터 사망·보상 1회 지급 | Done | 사망 후 자원 드랍·흡수와 Result 정산 확인. `Scrap 2 / Food 1 / Data 0` 직접 검증. ResourceLedger 단위 테스트 5개 통과 | 드랍부터 정산까지 통합 자동화는 남음 |
| DEV-0214 | 귀환·사망·시간 만료 상태 | Done | 기본 5분·60초 경고, 발전기 레벨당 +30초, R 홀드·HUD 버튼 조기 귀환, 시간 만료 보존 귀환, 승리·패배 종료 사유 구현. 타이머·수동 귀환 자동 테스트와 실제 Battle 시간 만료 직접 검증 | 최종 모바일 입력·연출·시간 밸런스는 후속 제작 범위 |
| DEV-0215 | 결과 정산·로컬 저장 | Done | 보상이 Result에 전달되고 Lobby 캠프 인벤토리에 유지됨. 원본 Run 보상 불변, 발전기 시간 효과, 정산 인벤토리 저장 자동 검증 | 앱 재시작·손상 데이터·마이그레이션 자동 검증은 없음 |

현재 HUD는 `Assets/_ReCamp/Scripts/UI/BattleHudController.cs` 기반의 기능 검증용 구현이다.
Windows Editor에서 가독성과 `Screen.safeArea` 대응 코드는 확인됐지만 Android 화면비·Cutout·실기기
동작은 검증하지 않았다. 이는 ART-4003의 최종 전투 HUD·스킬 선택 UI 완료를 의미하지 않는다.

## 7. 검증 근거와 한계

2026-07-13 Coplay MCP 회귀에서 다음 항목이 확인됐다.

1. Unity `6000.5.3f1` Editor 연결과 스크립트 컴파일 완료
2. `_ReCamp` 스크립트 관련 Console 오류 0건
3. Battle 직접 실행에서 런타임 UGUI HUD, 로봇 프록시, 카메라 상대 이동 벡터, 아레나 clamp, XZ 자원 흡수 확인
4. `Bootstrap -> Lobby -> Battle -> Result -> Lobby` 전체 흐름 완주
5. 테스트 보상 `Scrap 2 / Food 1 / Data 0`가 Result에 도달하고 Lobby 복귀 후 캠프 인벤토리에 유지됨
6. 테스트 후 활성 Scene을 `Assets/_ReCamp/Scenes/03_Battle.unity`로 복원

2026-07-14 추가 회귀에서 다음 항목이 확인됐다.

1. 새 전투·역할 코드까지 Unity 재컴파일 완료, `_ReCamp` Console 오류 0건
2. EditMode `25/25`, PlayMode `18/18` 통과
3. Battle 직접 실행에서 런타임 HUD·Canvas·귀환 버튼, `05:00` 타이머, 루나 `스캔 펄스` 상태와 7m 탐지 반경 확인
4. 실제 Battle Controller를 `0.2초`로 축약해 `TimeExpired`, 성공 귀환, 남은 시간 `0.00` 상태 확인
5. 테스트와 직접 실행 후 활성 Scene을 다시 `Assets/_ReCamp/Scenes/03_Battle.unity`로 복원

2026-07-19 Core 통합 회귀에서 다음 항목이 확인됐다.

1. Unity `6000.5.3f1`을 직접 실행하고 `ReCamp.Domain`·`ReCamp.UnityAdapter`·`ReCamp.Runtime` 컴파일 성공
2. `_ReCamp` Console 오류 0건
3. EditMode `25/25`, PlayMode `18/18` 통과
4. 새 contract test에서 Food↔Rations 변환, domain facility save 복원, PlayerPrefs v1→v2 migration 확인
5. 테스트 후 활성 Scene을 `Assets/_ReCamp/Scenes/03_Battle.unity`로 복원

시각 자료는 다음 로컬 캡처에 있다.

- `Assets/_ReCamp/Captures/battle_quarter_view_hud.png`
- `Assets/_ReCamp/Captures/battle_vertical_slice_verified.png`
- `Assets/_ReCamp/Captures/battle_xz_quarter_view.png`

직접 실행 검증과 자동 테스트는 로컬 Editor 근거다. fresh clone, 다른 PC, 빌드 플레이어, 모바일 해상도, 장시간 반복 안정성은 아직 증명하지 않는다.

## 8. 테스트와 재현성

| ID | 항목 | 상태 | 현재 부족한 것 |
|---|---|---|---|
| DEV-0111 | EditMode·PlayMode 테스트 Assembly | Done | `ReCamp.Runtime`, `ReCamp.Domain`, `ReCamp.UnityAdapter`, `ReCamp.Tests.EditMode`, `ReCamp.Tests.PlayMode` 구성. EditMode 25/25, PlayMode 18/18 통과 |
| DEV-0112 | Core·Unity 테스트 CI | Todo | Unity 테스트를 실행하는 CI 워크플로 없음 |
| TEST-0201 | Scene 흐름 PlayMode 테스트 | Review | 5개 Build Settings 등록 자동 검증 통과. 실제 Scene 전환과 상태 전달 자동화는 남음 |
| TEST-0202 | 전투·보상·정산 테스트 | Review | Ledger·Damageable·Arena·적 생명주기·선택 상태·캠프 정산 저장 자동 검증 통과. 사망 드랍부터 Scene 전환 정산까지 단일 통합 테스트는 남음 |
| RC-0012, ART-0007 | Git LFS 규칙 실자산 검증 | Done | PNG 등 이미지 7개가 LFS pointer로 원격 브랜치에 반영됐고, FBX·BLEND·KRA·TGA·EXR·PDF 패턴도 `.gitattributes`의 LFS 대상으로 등록됨 |

추가 완료 조건은 통합 Scene/정산 테스트 확대, CI, 현재 작업분 반영 후 별도 디렉터리 fresh
clone, Unity open·compile·Play Mode 재검증이다.

## 9. 캐릭터 5명 프로토타입

| ID | 항목 | 상태 | 판정 |
|---|---|---|---|
| CHR-0301 | 공용 CharacterController·Stats 구조 | Done | `CharacterRoster` 5인 데이터, 공용 `PlayerStats`, `CharacterAbilityController` 구성과 테스트 통과 |
| CHR-0302 | 캐릭터 선택·데이터 적용 | Done | Lobby 5인 선택 UI, GameManager 선택 유지, Battle Stats·팔레트·HUD 적용. 이리스 Scene 전환 직접 검증 |
| CHR-0310~CHR-0311 | 루나 전투 프로토타입 | Review | 캣 스텝, 3타 콤보, 스캔, 자원 강조·획득 반경 확대와 자동 테스트 완료. 최종 VFX·수치 튜닝 남음 |
| CHR-0320~CHR-0321 | 미유 전투 프로토타입 | Review | 상시 궤도 드론 자동 사격, 드론 버스트, 오버클럭, 넓은 자동 회수와 자동 테스트 완료. 수동 대상 지정 남음 |
| CHR-0330~CHR-0331 | 코코 전투 프로토타입 | Review | 즉시 회복과 체력보다 먼저 피해를 흡수하는 시간제 보호막 완료. 상태 이상 시스템·해제 남음 |
| CHR-0340~CHR-0341 | 이리스 전투 프로토타입 | Review | 홀드·릴리스 차지 사격, 보스 피해 보정, 표식·피해 증폭과 자동 테스트 완료. 최종 약점 연출·튜닝 남음 |
| CHR-0350~CHR-0351 | 노아 전투 프로토타입 | Review | 피해 감소·첫 피격 반격, 전방 밀쳐내기와 적 이동을 실제 차단하는 방벽, 자동 테스트 완료. 최종 충돌·연출 튜닝 남음 |
| CHR-0360, TEST-0301 | 5인 역할·밸런스와 핵심 스킬 테스트 | Review | 5인 대표·역할 능력 자동 검증 완료(`TEST-0301` Done). 실제 장기 전투 밸런스·역할 중복 플레이테스트 남음 |

현재 플레이어 프록시는 전투 공통 시스템을 검증하는 임시 모델이며 루나 또는 다른 캐릭터의 완료된 프로토타입으로 세지 않는다.

## 10. 선택형 이미지 생성·Blender·3D·Unity 아트 파이프라인

| ID | 항목 | 상태 | 판정과 해제 조건 |
|---|---|---|---|
| ART-0108 | ComfyUI·ComfyUI MCP 도입·고정 워크플로 | Deferred | 현재 이미지 생성 도구만으로 초기 콘셉트 검토가 가능하다. 동일 캐릭터 대량 생성, 정밀 인페인팅, Seed·LoRA·ControlNet·IP-Adapter 고정이 실제 병목이 될 때 `Ready`로 전환한다. |
| ART-0109 | 아트 자산·Export 명명 규격 | Done | `ASSET_NAMING_GUIDE.md` 작성과 관련 문서 링크·LFS PDF 규칙 동기화 완료 |
| ART-0110 | 공용·캐릭터 Animation 규격 | Done | `ANIMATION_GUIDE.md` 작성. 실제 Clip·Avatar·Controller·Prefab 연결은 ART-2008~2010 범위 |
| ART-0104 | Blender MCP 연결·소품 Export | Ready | ART-0109가 완료됐고 Blender 4.5 LTS·add-on 설치 이력이 있다. Blender 직접 실행·MCP 연결 후 규격 이름의 테스트 소품 저장·FBX Export 증거가 필요 |
| ART-0105 | Coplay/Aura FBX Import·Prefab | Todo | 검증된 FBX가 없어 아직 시작하지 않았다. ART-0104 완료 후 Import·Material·Prefab 테스트 진행 |
| ART-2001~ART-2010 | 3D 공용 규격·루나 Proof | Todo | Approved 루나 2D 제작 시트와 공용 4~5등신 SD-lite 규격이 선행돼야 함 |

현재 primitive 프록시를 그대로 다듬어 최종 모델로 쓰지는 않는다. 승인된 일반 등신 2D 시트와 4~5등신 SD-lite 3D 규격을 확정한 뒤 Blender Blockout으로 넘어간다. ComfyUI는 이 전환의 선행 조건이 아니다.

## 11. 다음 작업

실행 순서와 상태는 이 문서에서 중복 관리하지 않는다. 항상
`planning/sprint_backlog.md`의 현재 P0 실행 큐와 첫 `In Progress`·`Ready` 항목을 따른다.
이 문서는 완료된 구현·검증 근거만 갱신한다.
