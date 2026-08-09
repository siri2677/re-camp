# Re:Camp Animation and Animator Guide

이 문서는 `ART-0110`의 저장소 기준 산출물이다. 신규 CH101~CH105의 공용·고유 Motion, Animator,
Animation Event, 장비 동기화, Blender/FBX Export와 Unity Import 계약을 정의한다.

캐릭터 성격·능력은 `CHARACTER_BIBLE.md`, 이름·경로·Socket은 `ASSET_NAMING_GUIDE.md`, Gate 판정은
`ART_REVIEW_CHECKLIST.md`가 소유한다. 신규 캐릭터의 최종 Motion은 사람 Gate A와 제작 시트 승인
이후에만 확정한다. Rig·Bone·Polygon·Texture·성능 예산은 `CHARACTER_3D_SPEC.md`가 생긴 뒤
그 문서를 따른다.

## 1. 범위와 상태

| 항목 | 값 |
|---|---|
| 작업 ID | `ART-0110` |
| 문서 상태 | Active — New Character Motion Contract |
| 규격 버전 | `v003` |
| 적용 시작일 | 2026-08-09 |
| 대상 | 공용 Humanoid Motion과 CH101~CH105 고유 Motion 계약 |
| 비대상 | 신규 최종 Bone 수·Rig 구조·Clip 메모리 예산·사람 승인 전 Motion |

이 문서의 `Done`은 제작 계약이 작성됐다는 뜻이다. 실제 Clip, Animator Controller, Avatar와
Prefab 연결이 완료됐다는 뜻은 아니며, 그 증거는 `ART-2008~2010`에서 별도로 판정한다.

기존 CH001~CH005의 Clip·메서드·이름은 Unity Gray Box 회귀용 레거시 계약이다. 기존 자산은
이름을 바꾸지 않고 `HISTORY ONLY`로 유지하며, 신규 CH101~CH105의 승인된 Motion과 연결하지 않는다.

## 2. 현재 구현 기준선

현재 Unity Gray Box에는 신규 최종 Model·Rig·Animator·Animation Clip이 없다.

- `PlayerController`가 Keyboard·Touch 입력과 코드 Transform으로 이동·회전을 처리한다.
- `PlayerAttack`과 기존 능력 컨트롤러가 피해·Cooldown·이동·보호막·표식·방벽을 코드로 처리한다.
- 이동·피해·Cooldown·자원·귀환 판정은 Animation State나 Event에 의존하지 않는다.
- 기존 CH001~CH005는 기능 검증용 임시 프록시이며 신규 아트 모델이 아니다.
- 테스트 기준선은 `planning/IMPLEMENTATION_STATUS.md`의 최신 직접 검증 기록을 따른다.

첫 Animator 통합은 기존 Gameplay 결과를 보존하는 Presentation 작업이어야 한다. Animation을 붙이기
위해 Damage·Cooldown·이동 거리·무적 시간을 Animation Event로 옮기지 않는다.

## 3. 고정 원칙

1. CH101~CH105는 `CHARACTER_3D_SPEC.md`에서 확정할 공용 Humanoid Rig를 사용한다.
2. Locomotion·Hit·Down은 최대한 공용으로 재사용한다.
3. 대표 Idle·기본 공격·Primary·Utility·Victory·Select에서 캐릭터 개성을 만든다.
4. Battle Motion은 모두 In-place다. `Animator.applyRootMotion`은 `false`를 기본으로 한다.
5. 이동 거리·회전·판정·무적·Damage·Cooldown·자원은 코드와 데이터가 소유한다.
6. Animation Event는 SFX·VFX·장비 표시 같은 Presentation Cue에만 사용한다.
7. Orthographic 쿼터뷰와 Android Landscape 축소 화면에서 시작·방향·타격 순간이 읽혀야 한다.
8. 5~6등신 스타일라이즈드 비율의 큰 얼굴·손·장비를 살리되 장비가 얼굴·Grip·실루엣을 가리지 않는다.
9. 공용 Motion 재사용 때문에 캐릭터의 체형·성격·역할이 같아 보이면 고유 Motion으로 보완한다.
10. 최종 Clip은 사람 Gate B/C 검토 전 `APPROVED`로 표시하지 않는다.

## 4. 제작 우선순위

| 단계 | 범위 | 완료 목적 |
|---|---|---|
| P0 Character Proof | 공용 Idle/Run/Hit/Down, CH101 기본 공격·Slipstream·BeaconThread | CH101 Rig·Gameplay·쿼터뷰 가독성 검증 |
| P1 Vertical Slice | CH101~CH105 기본 공격·Primary·Utility·Victory·Select, 장비 Motion | 신규 역할과 Android 전투 Presentation 검증 |
| P2 출시 확장 | Lobby Idle, Turn, 추가 피격, 고유 스킬·표정 Additive | 반복 플레이와 캐릭터 매력 강화 |

Walk·Jump·Climb·Revive·동료 구조는 현재 단일 플레이 Ground Combat 범위가 아니므로 필수 목록에
넣지 않는다. 실제 Gameplay가 추가될 때 Backlog ID와 함께 확장한다.

## 5. 공용 필수 Clip

### 5.1 P0·P1 목록

| ID | Runtime Clip | Loop | 우선 | 용도 |
|---|---|---:|---|---|
| COM-001 | `ANM_Common_Idle_Combat` | Yes | P0 | 전투 기본 대기 |
| COM-002 | `ANM_Common_Run_F` | Yes | P0 | 이동·회전 방식의 기본 전진 이동 |
| COM-003 | `ANM_Common_Hit_Front` | No | P0 | 짧은 피격 Presentation |
| COM-004 | `ANM_Common_Down` | No | P0 | 전투 불능·Result 전환 전 포즈 |
| COM-005 | `ANM_Common_Idle_Lobby` | Yes | P1 | Lobby 기본 대기 |
| COM-006 | `ANM_Common_Victory` | No | P1 | 고유 Victory가 없을 때 임시 대체 |
| COM-007 | `ANM_Common_Select` | No | P1 | 고유 Select가 없을 때 임시 대체 |
| COM-008 | `ANM_Common_Down_Loop` | Yes | P0 | Result 전환 지연 시 전투 불능 포즈 유지 |

현재 Root는 이동 방향으로 회전하므로 P0 Blend Tree는 `Idle_Combat ↔ Run_F`만으로 충분하다.
Aim과 이동 방향을 분리할 때만 다음 Clip을 P2로 추가한다.

```text
ANM_Common_Run_B
ANM_Common_Strafe_L
ANM_Common_Strafe_R
ANM_Common_Turn_L
ANM_Common_Turn_R
```

### 5.2 공용 Motion의 캐릭터 차이

공용 Clip은 Retargeting 기준이다. 모든 캐릭터가 같은 속도·무게로 보여야 한다는 뜻은 아니다.

- `Animator.speed`를 Gameplay 속도에 직접 비례시켜 과장하지 않는다.
- 보폭 차이는 Character별 Override 또는 Additive Layer로 조정한다.
- 린은 전진하는 상체, 마오는 손끝과 장비 중심, 노조미는 안정된 곡선, 시온은 정돈된 중심,
  아카리는 낮고 무거운 중심이 읽혀야 한다.
- Character Root 이동속도는 계속 Runtime Stats가 소유한다.

## 6. 신규 캐릭터 Motion 계약

모든 캐릭터는 최소 `Idle_Signature`, 기본 공격, 현재 Primary, 현재 Utility, `Victory`, `Select`를
가진다. `Design Later`는 Bible에 있으나 현재 Gameplay가 없는 항목이며, Vertical Slice 완료 증거에
포함하지 않는다.

### 6.1 CH101 아마사와 린 — Amasawa Rin

| 상태 | Clip | 구현 연결 |
|---|---|---|
| Signature | `ANM_AmasawaRin_Idle_Signature` | 자신이 만든 경로를 먼저 확인하는 자신감 |
| Basic 1 | `ANM_AmasawaRin_Attack_01` | 3연격 1타 |
| Basic 2 | `ANM_AmasawaRin_Attack_02` | 3연격 2타 |
| Basic 3 | `ANM_AmasawaRin_Attack_03` | 3연격 마무리 |
| Primary | `ANM_AmasawaRin_Slipstream` | 신호 리본을 박는 짧은 질주 |
| Utility | `ANM_AmasawaRin_BeaconThread` | 경로 비콘·탐지 표시 |
| Result | `ANM_AmasawaRin_Victory` | Result·Lobby |
| Select | `ANM_AmasawaRin_Select` | 캐릭터 선택 |

- 세 타격은 준비 방향과 와이어 세이버 궤적을 다르게 하되 몸 앞에서 겹치지 않는다.
- `Slipstream`의 실제 이동·관통 판정은 코드가 소유하고 Clip Root는 원점에 남긴다.
- 신호 리본은 하나의 큰 경로 오브젝트와 `Socket_VFXCenter`를 사용하며 가는 케이블을 여러 개 만들지 않는다.

### 6.2 CH102 키사라기 마오 — Kisaragi Mao

| 상태 | Clip | 구현 연결 |
|---|---|---|
| Signature | `ANM_KisaragiMao_Idle_Signature` | 설계도를 조용히 수정하는 집중 |
| Basic | `ANM_KisaragiMao_Attack_Command` | 자기 활 발사 Cue |
| Primary | `ANM_KisaragiMao_ScrapBloom` | 자기장 화살 군집 |
| Utility | `ANM_KisaragiMao_ReclaimNet` | 자원·적을 늦추는 자기장 |
| Result | `ANM_KisaragiMao_Victory` | Result·Lobby |
| Select | `ANM_KisaragiMao_Select` | 캐릭터 선택 |

- 자동·지속 공격은 매 발마다 큰 전신 동작을 반복하지 않는다.
- 활 프레임과 구조 링은 세 개 이하의 큰 장비 오브젝트로 통합한다.
- 자기장 판정과 자원 이동은 코드가 소유하고 Event는 발사·광원 Cue만 보낸다.

### 6.3 CH103 카나데 노조미 — Kanade Nozomi

| 상태 | Clip | 구현 연결 |
|---|---|---|
| Signature | `ANM_KanadeNozomi_Idle_Signature` | 평온함과 현장 지휘의 대비 |
| Basic | `ANM_KanadeNozomi_Attack_Command` | 공명 배턴 3파동 |
| Primary | `ANM_KanadeNozomi_PulseCode` | 회복·지속 재생 Cue |
| Utility | `ANM_KanadeNozomi_HushVeil` | 응급 베일·정화 영역 Cue |
| Result | `ANM_KanadeNozomi_Victory` | Result·Lobby |
| Select | `ANM_KanadeNozomi_Select` | 캐릭터 선택 |

- 베일은 네 개 이하의 큰 곡선 패널로 단순화하고 얼굴을 가리지 않는다.
- 회복·정화·피해 감소 판정은 코드가 소유한다.
- 공명 파동의 중심은 `Socket_VFXCenter`와 배턴 Socket에서 읽힌다.

### 6.4 CH104 시온 타테가미 — Shion Tategami

| 상태 | Clip | 구현 연결 |
|---|---|---|
| Signature | `ANM_ShionTategami_Idle_Signature` | 지도를 접어 약점을 읽는 집중 |
| Basic | `ANM_ShionTategami_Attack_Command` | 프리즘 부채 세 갈래 광선 |
| Primary | `ANM_ShionTategami_VectorFold` | 궤도선 일렬 폭발 Cue |
| Utility | `ANM_ShionTategami_FaultLine` | 약점 표식·피해 증폭 Cue |
| Result | `ANM_ShionTategami_Victory` | Result·Lobby |
| Select | `ANM_ShionTategami_Select` | 캐릭터 선택 |

- `VectorFold`의 위치·폭발·피해는 코드가 소유한다.
- 프리즘 부채와 지도 링은 큰 면과 단순한 궤도로 유지해 쿼터뷰에서 얼굴을 가리지 않는다.
- 표식 방향은 Event가 아니라 명시적 능력 데이터와 Runtime 상태를 따른다.

### 6.5 CH105 쿠로가네 아카리 — Kurogane Akari

| 상태 | Clip | 구현 연결 |
|---|---|---|
| Signature | `ANM_KuroganeAkari_Idle_Signature` | 낮은 자세로 전선을 고정하는 대기 |
| Basic | `ANM_KuroganeAkari_Attack_01` | 건틀릿 1타 |
| Basic 2 | `ANM_KuroganeAkari_Attack_02` | 건틀릿 2타 |
| Basic 3 | `ANM_KuroganeAkari_Attack_03` | 앵커 충격파 마무리 |
| Primary | `ANM_KuroganeAkari_AnchorDrop` | 앵커 설치·끌어당김 Cue |
| Utility | `ANM_KuroganeAkari_BraceLine` | 두 지점 케이블·방어선 Cue |
| Result | `ANM_KuroganeAkari_Victory` | Result·Lobby |
| Select | `ANM_KuroganeAkari_Select` | 캐릭터 선택 |

- 케이블은 두 개의 큰 선으로 통합하고 물리 본 수를 제한한다.
- 앵커 설치·경직·밀치기·피해 감소는 코드가 소유한다.
- 건틀릿과 앵커 링의 장비 Motion은 팔꿈치·손목 관통을 우선 검토한다.

## 7. Animator Controller 계약

```text
AC_Character_Common.controller
AC_AmasawaRin.controller
AC_KisaragiMao.controller
AC_KanadeNozomi.controller
AC_ShionTategami.controller
AC_KuroganeAkari.controller
AOC_AmasawaRin.overrideController
AOC_KisaragiMao.overrideController
AOC_KanadeNozomi.overrideController
AOC_ShionTategami.overrideController
AOC_KuroganeAkari.overrideController
```

공용 Controller의 최소 State는 `Idle_Combat`, `Run_F`, `Hit_Front`, `Down`, `Down_Loop`다. 고유
Controller 또는 Override는 `Idle_Signature`, `Attack`, `Primary`, `Utility`, `Victory`, `Select`만
교체하며 공용 State의 판정 순서와 이동 규칙을 복제하지 않는다.

권장 Parameter:

```text
Speed         float
Hit           trigger
Down          trigger
Primary       trigger
Utility       trigger
Victory       trigger
Select        trigger
IsDisabled    bool
```

Parameter 이름은 Gameplay API가 아니라 Presentation 계약이다. State Transition은 Animation 완료를
기다릴 수 있지만, Gameplay 결과는 그 완료 여부에 종속되지 않는다.

## 8. Animation Event 계약

허용 Event는 다음 Presentation Cue로 제한한다.

| Event | 허용 용도 | 금지 용도 |
|---|---|---|
| `AnimCue_Sfx` | 발소리·타격음·장비음 | Damage·Cooldown 계산 |
| `AnimCue_Vfx` | 리본·파동·표식·먼지 표시 | 판정 위치·적 선택 변경 |
| `AnimCue_Equipment` | 칼날·활·베일·케이블 표시 | 이동·회전 강제 |
| `AnimCue_Footstep` | 발소리와 작은 먼지 | Root 이동 |

Event Receiver가 없어도 Gameplay는 정상 동작해야 한다. Event payload에는 확정된 Socket 이름과
짧은 cue ID만 사용하며, 임의 문자열로 Character ID나 Damage 수치를 전달하지 않는다.

## 9. Blender·FBX·Unity Import

- Source 파일과 Export 파일은 `ASSET_NAMING_GUIDE.md`의 Subject와 같은 stem을 사용한다.
- Runtime Root는 Position·Rotation 0, Scale 1이며 전방 `+Z`, 위 `+Y`, 단위 1 Unity unit = 1 m다.
- Model FBX와 Animation FBX를 분리하고, Unity에서 Clip을 추출할 때만 같은 stem의 `.anim`을 만든다.
- Battle Clip은 In-place로 Export하고 Root Motion을 Bake하지 않는다.
- Humanoid Avatar·Material slot·Animation Clip·Prefab Override·Socket 참조를 Import 후 확인한다.
- 승인 전 Blockout은 `Assets/_ReCamp/Art/Blockout/`에 두고 최종 Character ID→Prefab 연결에서 제외한다.
- 첫 Export와 승인 버전 교체에는 `art_source/manifests/<Category>_<Subject>_Export_v###.md`를 둔다.

예시:

```text
CHR_AmasawaRin_Model.fbx
ANM_AmasawaRin_Attack_01.fbx
ANM_AmasawaRin_Attack_01.anim
AC_AmasawaRin.controller
CHR_AmasawaRin_Prefab.prefab
```

## 10. 검증 순서

1. Gate A 승인된 2D 제작 시트와 2D→3D 변환표를 확인한다.
2. Gate B에서 약 7등신·5~6등신 변환, 장비 관통, 얼굴·실루엣을 확인한다.
3. 공용 P0 Clip과 CH101 고유 Motion을 임시 Model에 연결한다.
4. EditMode에서 Animator Parameter·Event Receiver가 없어도 Gameplay 테스트가 통과하는지 확인한다.
5. Play Mode에서 이동·공격·능력·피격·Down·Victory·Select를 확인한다.
6. Unity Console `_ReCamp` 오류 0건과 Animation Event 누락을 확인한다.
7. Gate C에서 Orthographic 쿼터뷰, Android Landscape Safe Area, 작은 화면 가독성, 관통, 성능을 기록한다.
8. `ART-2008~2010`에 Clip·Controller·Avatar·Prefab·VFX·사운드 증거를 연결한다.

Animation Gate C를 통과하기 전 Clip이나 Controller를 `APPROVED`로 표시하지 않는다.
