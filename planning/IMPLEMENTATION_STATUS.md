# Re:Camp 구현 현황 대조표

> 최종 갱신: 2026-07-27
> 상태: Active Snapshot
> 기준 브랜치: `codex/recamp-unity-mvp`
> 기준 HEAD 작성 시점: `be122c1` 이후 문서 정합성 작업 포함
> Unity: `6000.5.3f1`

## 1. 문서 역할

이 문서는 `CURRENT_PROJECT_BASELINE.md`, `planning/sprint_backlog.md`와 원격 브랜치에 반영된 Unity
구현을 대조해 **구현·검증 근거만** 기록한다.

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
+ 2D 약 6.8~7.4등신 성인 서브컬처 Key Art
+ 3D 약 5.2~5.8등신 스타일라이즈드 인게임 캐릭터
+ 3D 스타일라이즈드 환경·툰 셰이딩
+ 고정 Orthographic 쿼터뷰
```

| ID | 항목 | 상태 | 현재 판정 |
|---|---|---|---|
| RC-0013 | 프로젝트 기준 단일화 | Done | Android-first, 2D 약 7등신·3D 5~6등신, 캐릭터 디자인 v2.0 기준 확정 |
| RC-0011 | 과거 통합 라인업 v003 | Review / Fail | Gate A 실패 이력으로만 보존. 새 후보의 제작 앵커로 사용하지 않음 |
| ART-0102 | 캐릭터 앵커 v2.0 | Done | 5명 고정·가변·금지 요소와 개별 2D/3D 목표 비율 확정 |
| ART-0103 | Figma 제작 시트 v002 | Review | 규격과 SVG 존재. 실제 Figma Import·Clone·한글·PNG/PDF Export 미검증 |
| ART-0107 | Gate A/B/C v2.0 | Done | 약 7등신, 2D→3D 변환, 외부 IP 유사성, Android Gate 기준 반영 |
| ART-1001·1101·1201·1301·1401 | 5인 전신 후보 | Ready | Character Bible v2.0 한 문장 훅 기반 캐릭터별 3안 제작 필요 |
| ART-4001~4004 | 최종 UI Design System | Todo | 현재 UGUI는 기능 검증용 Gray Box |

Approved 2D 제작 시트는 `0/5`, 최종 3D Model·Prefab·Animator도 `0/5`다.

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
| 탐험 Outcome 정산 | Review | Runtime에 남아 있으며 Domain 계약 미완료 |
| 스킬 Command/Event | Review | 역할 Gray Box는 동작하지만 Domain·Presentation 경계 미완료 |
| 중복 수치 제거 | Review | 캠프 비용·효과의 최종 단일 소유자 정리 필요 |

DEV-0113 전체 상태는 `In Progress`를 유지한다. 상세 완료·잔여 범위는
`planning/DEV-0113_CORE_INTEGRATION_RESULT.md`를 따른다.

## 6. Android 제품 기준

| ID | 항목 | 상태 | 현재 증거와 완료 조건 |
|---|---|---|---|
| DEV-0114 | Android Build Support | Blocked | AndroidPlayer·SDK·NDK·OpenJDK 설치와 Android Target 전환 필요 |
| DEV-0115 | Landscape·Safe Area | Review | `Screen.safeArea` 보정 코드는 존재. Landscape 고정·Cutout·다중 화면비·실기기 검증 필요 |
| DEV-0116 | Touch Control·HUD | Ready | 일부 Gameplay가 `Keyboard.current` 직접 사용. On-screen Stick·Attack·Ability·Extract 필요 |
| DEV-0117 | App ID·첫 APK | Blocked | 템플릿 App ID 교체, Build Profile, APK 설치·3~5분 Loop·중단/복귀 증거 필요 |

현재 Windows Editor HUD 검증은 Android Touch HUD 또는 모바일 UI 완료를 의미하지 않는다.

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
| ART-0105 | FBX Import·Prefab | Todo | 검증된 FBX 이후 진행 |
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
