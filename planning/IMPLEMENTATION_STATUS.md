# Re:Camp 구현 현황 대조표

## 1. 문서 목적과 기준

이 문서는 GitHub `origin/main`의 통합 로드맵·스프린트 백로그와 현재 로컬 Unity 구현을 대조한 현황 스냅샷이다.

- 기준 원격 리비전: `origin/main` `2b278797`
- 로컬 Unity 버전: `6000.5.3f1`
- 확인일: `2026-07-14`
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

다만 현재 Unity 프로젝트 대부분이 원격 `main`에 반영되지 않은 로컬 작업이므로 다른 환경에서 Clone 후 재현할 수 없다. 자동 테스트 Assembly와 41개 테스트, 5인 선택·대표/역할 능력 Gray Box는 완료했지만 기존 Unity 비종속 `ReCamp.Core` Adapter, CI, 실제 Scene 정산의 심층 자동화, 최종 VFX·밸런스, 승인된 캐릭터 아트, Blender 런타임 연결은 아직 완료되지 않았다. 따라서 전체 마일스톤 M2·M3를 Done으로 판정해서는 안 된다.

ComfyUI와 ComfyUI MCP는 현재 미완료 개발 항목이나 차단 요소가 아니다. 현재 이미지 생성 도구로 초기 후보 검토를 진행하고, 캐릭터 일관성 대량 생성·정밀 인페인팅·Seed/LoRA/ControlNet/IP-Adapter 고정 워크플로가 실제로 필요해질 때만 도입을 재평가한다. 그전에는 로컬 모델 파일, GPU, ComfyUI 설치를 준비하지 않아도 된다.

## 3. 확정된 아트 방향

원격 최신 문서의 제작 방향을 단일 기준으로 사용한다.

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
| RC-0011, ART-0003 | 통합 캐릭터 라인업 | Review | 원격 v001은 INVALID, 혼성 v002는 REJECTED. 원본 이미지를 참조한 성인 여성 5인·남성향·SD-lite v003과 metadata 완료, 사람 승인 대기. |
| ART-0004 | 아트 MCP 제작·승인 가이드 | Done | `origin/main`의 전체 운영 기준을 복원하고 최신 성인 여성·남성향·4~5등신 SD-lite 방향과 선택형 도구 도입 원칙을 병합했다. |
| ART-0108 | ComfyUI·ComfyUI MCP 도입 | Deferred | 현재 필수가 아니다. 대량 일관성 생성·정밀 인페인팅·재현 가능한 고정 워크플로가 병목일 때만 재평가한다. |
| ART-1001~ART-1401 | 5명 단독 전신 후보 | Ready | 전원 성인 여성과 남성향 캐릭터 매력 기준으로 얼굴·체형·실루엣·색상·무기를 검토한다. |
| ART-4001~ART-4004 | 최종 UI Design System·화면 | Todo | 현재 UGUI는 기능 검증용 Gray Box HUD다. 최종 아트·스킬 선택 UI 완료로 간주하지 않는다. |

로컬 `docs/05_art_concept/PRODUCTION_DIRECTION.md`는 원본 전투 콘셉트의 여성 SD 주인공 감성과 Unity 제작성을 결합한 4~5등신 SD-lite 방향으로 교정했다. 원본 이미지는 캐릭터 감성·환경 구도·카메라·가독성의 우선 앵커이며, 정확한 얼굴·체형·의상·무기는 개별 Approved 시트에서 확정한다.

## 4. Unity 프로젝트와 Scene 기반

| ID | 항목 | 상태 | 구현·검증 근거 | 남은 범위 |
|---|---|---|---|---|
| DEV-0101 | Unity 버전 확정·프로젝트 생성 | Done | `ProjectSettings/ProjectVersion.txt`에서 Unity `6000.5.3f1` 확인, Editor 실행 및 Coplay 연결 확인 | 원격 Clone 재현은 DEV-0104에서 별도 판정 |
| DEV-0102 | Visible Meta Files·Force Text | Done | `.meta` 파일이 생성되어 있고 `ProjectSettings/EditorSettings.asset`의 serialization mode가 Force Text 값으로 설정됨 | 없음 |
| DEV-0103 | `Assets/_ReCamp` 구조 | Done | Scenes, Scripts, Art, Audio, Prefabs, Resources, ScriptableObjects 등 로컬 구조 확인 | 최종 자산 구조는 아트 파이프라인에서 확장 |
| DEV-0104 | `Assets`, `Packages`, `ProjectSettings`, `.meta` Git 반영 | Blocked | Unity 프로젝트와 다수 자산이 현재 로컬 미추적 상태이며 `origin/main`만 Clone하면 열 수 없음 | 로컬 변경 범위 검토 후 Git 반영, 별도 경로 fresh clone·Unity open 검증 필요 |
| DEV-0105 | Bootstrap·Title·Lobby·Battle·Result Scene | Done | `Assets/_ReCamp/Scenes/00_Bootstrap.unity`부터 `04_Result.unity`까지 존재하며 `ProjectSettings/EditorBuildSettings.asset`에 순서대로 등록됨 | 없음 |
| DEV-0106 | `SceneLoader` | Done | `Assets/_ReCamp/Scripts/GameFlow/SceneLoader.cs`가 enum을 5개 Scene 이름에 매핑하고 비동기 로드 | Play Mode 전체 흐름으로 직접 확인 |
| DEV-0107 | Unity `GameManager`·서비스 초기화 | Done | `Assets/_ReCamp/Scripts/Core/GameManager.cs`가 단일 인스턴스, Scene 간 유지, Run 상태·보상·CampManager 초기화를 관리 | 기존 비종속 Core 통합과는 별개 |

## 5. 기존 Core 통합 현황

| ID | 항목 | 상태 | 판정과 완료 조건 |
|---|---|---|---|
| DEV-0108 | 기존 `ReCamp.Core` Unity 호환성 검토 | Todo | 현재 `ReCamp.Core` 네임스페이스의 MonoBehaviour 코드가 존재하지만, 기존 Unity 비종속 Core 소스 전체의 API·Unity 의존성·테스트 호환성을 검토한 기록은 없음 |
| DEV-0109 | Core 소스 공유·Assembly·Adapter 방식 확정 | Review | `ReCamp.Runtime.asmdef`은 추가됐으나 Unity 비종속 Core와 Presentation Adapter 경계는 아직 결정되지 않음 |
| DEV-0110 | Core 상태와 Unity Presentation 연결 | Todo | 현재 GameManager·Scene Controller 연결은 동작하지만, 기존 Core 상태를 Adapter로 Presentation에 연결했다는 근거는 없음 |
| DEV-0113 | 기존 Unity 비종속 Core PR 검토·통합 | Blocked | 대상 PR/소스 리비전과 통합 기준이 현재 로컬 Unity 프로젝트에서 확인되지 않음 |

`GameManager.cs`의 네임스페이스 이름만으로 DEV-0108~DEV-0113을 완료 처리하지 않는다.

## 6. Scene 흐름과 Gray Box 전투

| ID | 항목 | 상태 | 구현·검증 근거 | 제한 |
|---|---|---|---|---|
| DEV-0201 | Bootstrap 구성 | Done | Bootstrap에서 GameManager 초기화 후 Lobby 진입 확인 | Title은 현재 빠른 MVP 경로에서 우회 가능 |
| DEV-0202 | Lobby Gray Box | Done | Battle 시작과 캠프 인벤토리·시설 UI가 동작 | 최종 캐릭터 선택·아트 UI 아님 |
| DEV-0203 | Battle Gray Box | Done | 플레이어, 적·보스, 아레나, 자원, 런타임 Screen Space UGUI HUD가 한 Scene에서 동작 | 최종 아트·VFX·성능 기준 미적용 |
| DEV-0204 | Result Gray Box | Done | 획득 보상 요약과 Lobby 복귀 확인 | 최종 결과 연출 아님 |
| DEV-0205~DEV-0207 | Lobby -> Battle -> Result -> Lobby | Done | Coplay Play Mode에서 전체 Scene 흐름 직접 완주 | TEST-0201 자동화는 별도 Todo |
| DEV-0208 | Input System·PlayerController | Review | 카메라 기준 이동 벡터와 플레이어 이동 동작 확인 | 실제 WASD·방향키 입력 및 바라보기 수동 회귀가 남음 |
| DEV-0209 | 쿼터뷰 카메라·이동 경계 | Done | orthographic 쿼터뷰, 카메라 상대 XZ 이동, 배우·카메라 아레나 clamp 직접 확인 | 최종 캐릭터 크기에 맞춘 framing 재조정 가능 |
| DEV-0210 | 기본 공격·Hitbox·Damageable | Done | 자동 공격, 피격, 체력, 보호막, 피해 감소, 사망과 승리 전환 확인. Damageable EditMode 테스트 7개 통과 | 실제 공격 Hitbox의 Scene 통합 자동화는 남음 |
| DEV-0211 | EnemyController·추적 AI | Done | 적·보스 프록시 추적과 전투 참여, 최근접 탐색·사망 즉시 타기팅 제외·레지스트리 정리 자동 검증 | 적 종류별 고유 행동은 미구현 |
| DEV-0212 | EnemySpawner·웨이브 | Done | 일반 웨이브 뒤 보스 스폰과 자연 승리 흐름 확인 | 정식 난이도·다중 웨이브 구성 아님 |
| DEV-0213 | 몬스터 사망·보상 1회 지급 | Done | 사망 후 자원 드랍·흡수와 Result 정산 확인. `Scrap 2 / Food 1 / Data 0` 직접 검증. ResourceLedger 단위 테스트 5개 통과 | 드랍부터 정산까지 통합 자동화는 남음 |
| DEV-0214 | 귀환·사망·시간 만료 상태 | Done | 기본 5분·60초 경고, 발전기 레벨당 +30초, R 홀드·HUD 버튼 조기 귀환, 시간 만료 보존 귀환, 승리·패배 종료 사유 구현. 타이머·수동 귀환 자동 테스트와 실제 Battle 시간 만료 직접 검증 | 최종 모바일 입력·연출·시간 밸런스는 후속 제작 범위 |
| DEV-0215 | 결과 정산·로컬 저장 | Done | 보상이 Result에 전달되고 Lobby 캠프 인벤토리에 유지됨. 원본 Run 보상 불변, 발전기 시간 효과, 정산 인벤토리 저장 자동 검증 | 앱 재시작·손상 데이터·마이그레이션 자동 검증은 없음 |

현재 HUD는 `Assets/_ReCamp/Scripts/UI/BattleHudController.cs` 기반의 기능 검증용 구현이다. 런타임 가독성과 safe area는 확인됐지만, 원격 ART-4003의 최종 전투 HUD·스킬 선택 UI 완료를 의미하지 않는다.

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
2. EditMode `23/23`, PlayMode `18/18` 통과
3. Battle 직접 실행에서 런타임 HUD·Canvas·귀환 버튼, `05:00` 타이머, 루나 `스캔 펄스` 상태와 7m 탐지 반경 확인
4. 실제 Battle Controller를 `0.2초`로 축약해 `TimeExpired`, 성공 귀환, 남은 시간 `0.00` 상태 확인
5. 테스트와 직접 실행 후 활성 Scene을 다시 `Assets/_ReCamp/Scenes/03_Battle.unity`로 복원

시각 자료는 다음 로컬 캡처에 있다.

- `Assets/_ReCamp/Captures/battle_quarter_view_hud.png`
- `Assets/_ReCamp/Captures/battle_vertical_slice_verified.png`
- `Assets/_ReCamp/Captures/battle_xz_quarter_view.png`

직접 실행 검증과 자동 테스트는 로컬 Editor 근거다. fresh clone, 다른 PC, 빌드 플레이어, 모바일 해상도, 장시간 반복 안정성은 아직 증명하지 않는다.

## 8. 테스트와 재현성

| ID | 항목 | 상태 | 현재 부족한 것 |
|---|---|---|---|
| DEV-0111 | EditMode·PlayMode 테스트 Assembly | Done | `ReCamp.Runtime`, `ReCamp.Tests.EditMode`, `ReCamp.Tests.PlayMode` 구성. EditMode 23/23, PlayMode 18/18 통과 |
| DEV-0112 | Core·Unity 테스트 CI | Todo | Unity 테스트를 실행하는 CI 워크플로 없음 |
| TEST-0201 | Scene 흐름 PlayMode 테스트 | Review | 5개 Build Settings 등록 자동 검증 통과. 실제 Scene 전환과 상태 전달 자동화는 남음 |
| TEST-0202 | 전투·보상·정산 테스트 | Review | Ledger·Damageable·Arena·적 생명주기·선택 상태·캠프 정산 저장 자동 검증 통과. 사망 드랍부터 Scene 전환 정산까지 단일 통합 테스트는 남음 |
| RC-0012, ART-0007 | Git LFS 규칙 실자산 검증 | Done | PNG·FBX·BLEND·KRA·TGA·EXR 등이 LFS filter/diff/merge로 해석됨을 `git check-attr`로 확인. 실제 원격 pointer 교정은 별도 Git 반영 작업 |

추가 완료 조건은 통합 Scene/정산 테스트 확대, CI, 원격 반영, 별도 디렉터리 fresh clone, Unity open·compile·Play Mode 재검증이다.

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
| ART-0104 | Blender MCP 연결·소품 Export | Blocked | Blender 4.5 LTS와 add-on 설치 이력은 있으나 Blender 종료로 런타임 socket 연결과 Export가 검증되지 않음. Blender 실행 유지 -> MCP 연결 -> 테스트 소품 생성·저장·FBX Export가 필요 |
| ART-0105 | Coplay/Aura FBX Import·Prefab | Blocked | 검증된 FBX가 없어 Import·Material·Prefab 테스트를 시작할 수 없음. ART-0104 완료 후 진행 |
| ART-2001~ART-2010 | 3D 공용 규격·루나 Proof | Todo | Approved 루나 2D 제작 시트와 공용 4~5등신 SD-lite 규격이 선행돼야 함 |

현재 primitive 프록시를 그대로 다듬어 최종 모델로 쓰지는 않는다. 승인된 일반 등신 2D 시트와 4~5등신 SD-lite 3D 규격을 확정한 뒤 Blender Blockout으로 넘어간다. ComfyUI는 이 전환의 선행 조건이 아니다.

## 11. 다음 완료 순서

1. `RC-0011 / ART-0003`: 완료된 성인 여성 5인·남성향·SD-lite 라인업 `REVIEW v003` 사람 검토와 수정 방향 확정
2. `CHR-0310~0351 / CHR-0360`: 5인 최종 VFX·수치 튜닝, 미유 수동 지정·코코 상태 해제와 장기 밸런스 검증
3. `TEST-0201 / TEST-0202`: 실제 Scene 전환·사망 드랍·결과 정산 단일 통합 테스트 확대
4. `DEV-0108 / DEV-0109 / DEV-0113`: 기존 Core 원본과 PR을 확보하고 Assembly/Adapter 통합 방식 확정
5. `DEV-0104`: 현재 Unity 작업을 원격에 안전하게 반영한 뒤 fresh clone 재현 검증
6. `ART-0104 / ART-0105`: 루나 Approved 제작 시트가 준비되는 시점에 Blender MCP와 FBX -> Unity Prefab 파이프라인 검증

이 순서를 완료하기 전에는 M2 전체, M3 전체, 5인 아트 제작, 루나 Character Proof를 Done으로 올리지 않는다.

`ART-0108`은 위 필수 완료 순서에 포함하지 않는다. 도입 트리거가 확인되면 별도 실행 항목으로 전환한다.
