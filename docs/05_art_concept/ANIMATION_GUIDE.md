# Re:Camp Animation and Animator Guide

이 문서는 `ART-0110`의 저장소 기준 산출물이다. Re:Camp 성인 여성 5인의 공용·고유 Motion,
Animator, Animation Event, 장비 동기화, Blender/FBX Export와 Unity Import 계약을 정의한다.

캐릭터 성격·능력은 `CHARACTER_BIBLE.md`, 이름·경로·Socket은 `ASSET_NAMING_GUIDE.md`,
Gate 판정은 `ART_REVIEW_CHECKLIST.md`가 소유한다. Rig·Bone·Polygon·Texture·성능 예산은
`CHARACTER_3D_SPEC.md`가 생긴 뒤 그 문서를 따른다.

## 1. 범위와 상태

| 항목 | 값 |
|---|---|
| 작업 ID | `ART-0110` |
| 문서 상태 | `Active` |
| 규격 버전 | `v001` |
| 적용 시작일 | 2026-07-21 |
| 대상 | 공용 Humanoid Motion, 5인 고유 Motion, Animator, 장비 Animator, Unity Import |
| 비대상 | 최종 Bone 수·Rig 구조·Clip 메모리 예산·캐릭터별 최종 Motion 승인 |

이 문서의 `Done`은 제작 계약이 작성됐다는 뜻이다. 실제 Clip, Animator Controller, Avatar와
Prefab 연결이 완료됐다는 뜻은 아니며, 그 증거는 `ART-2008~2010`에서 별도로 판정한다.

## 2. 현재 구현 기준선

현재 Unity Gray Box에는 최종 Model·Rig·Animator·Animation Clip이 없다.

- `PlayerController`가 Keyboard 입력과 코드 Transform으로 이동·회전을 처리한다.
- `PlayerAttack`이 가장 가까운 적에게 코드로 즉시 피해를 적용하며 루나만 3타 Index를 가진다.
- `CharacterAbilityController`가 5인의 Primary·Utility 기능과 지속 시간을 코드로 관리한다.
- 이동·피해·Cooldown·보호막·표식·방벽은 Animation State나 Event에 의존하지 않는다.
- 현재 테스트 `EditMode 25/25`, `PlayMode 18/18`은 이 기능 Gray Box 기준선이다.

따라서 첫 Animator 통합은 기존 Gameplay 결과를 보존하는 Presentation 작업이어야 한다.
Animation을 붙이기 위해 Damage·Cooldown·이동 거리를 Animation Event로 옮기지 않는다.

## 3. 고정 원칙

1. 5명 모두 `CHARACTER_3D_SPEC.md`에서 확정할 공용 Humanoid Rig를 사용한다.
2. Locomotion·Hit·Down은 최대한 공용으로 재사용한다.
3. 대표 Idle·기본 공격·Primary·Utility·Victory·Select에서 캐릭터 개성을 만든다.
4. Battle Motion은 모두 In-place다. `Animator.applyRootMotion`은 `false`를 기본으로 한다.
5. 이동 거리·회전·판정·무적·Damage·Cooldown·자원은 코드와 데이터가 소유한다.
6. Animation Event는 SFX·VFX·장비 표시 같은 Presentation Cue에만 사용한다.
7. 원본 전투 앵커의 Orthographic 쿼터뷰와 Android Landscape 축소 화면에서 시작·방향·타격
   순간이 읽혀야 한다.
8. 4~5등신 SD-lite의 큰 머리·손·장비를 살리되 얼굴, Grip, 실루엣을 장비가 가리지 않는다.
9. 공용 Motion 재사용 때문에 5명의 체형·성격·역할이 같아 보이면 고유 Motion으로 보완한다.
10. 최종 Clip은 사람 Gate B/C 검토 전 `APPROVED`로 표시하지 않는다.

## 4. 제작 우선순위

| 단계 | 범위 | 완료 목적 |
|---|---|---|
| P0 Character Proof | `Idle_Combat`, `Run_F`, `Hit_Front`, `Down`, `Down_Loop`, 루나 3타·CatStep·ScanPulse | 루나 Rig·Gameplay·쿼터뷰 가독성 검증 |
| P1 Vertical Slice | 5인 기본 공격·Primary·Utility, Victory·Select, 장비 Motion | 5인 역할과 Android 전투 Presentation 검증 |
| P2 출시 확장 | Lobby Idle, Turn, 추가 피격, 디자인 후보 스킬·표정 Additive | 반복 플레이와 캐릭터 매력 강화 |

Walk·Jump·Climb·Revive·동료 구조는 현재 단일 플레이 Ground Combat Scope가 아니므로 필수
목록에 넣지 않는다. 실제 Gameplay가 추가될 때 Backlog ID와 함께 확장한다.

## 5. 공용 필수 Clip

### 5.1 P0·P1 목록

| ID | Runtime Clip | Loop | 우선 | 용도 |
|---|---|---:|---|---|
| COM-001 | `ANM_Common_Idle_Combat` | Yes | P0 | 전투 기본 대기 |
| COM-002 | `ANM_Common_Run_F` | Yes | P0 | 현재 이동·회전 방식의 기본 전진 이동 |
| COM-003 | `ANM_Common_Hit_Front` | No | P0 | 짧은 피격 Presentation |
| COM-004 | `ANM_Common_Down` | No | P0 | 전투 불능·Result 전환 전 포즈 |
| COM-005 | `ANM_Common_Idle_Lobby` | Yes | P1 | Lobby 기본 대기 |
| COM-006 | `ANM_Common_Victory` | No | P1 | 고유 Victory가 없을 때 임시 대체 |
| COM-007 | `ANM_Common_Select` | No | P1 | 고유 Select가 없을 때 임시 대체 |
| COM-008 | `ANM_Common_Down_Loop` | Yes | P0 | Result 전환 지연 시 전투 불능 포즈 유지 |

현재 `PlayerController`는 이동 방향으로 Character Root를 회전시키므로 P0 Blend Tree는
`Idle_Combat ↔ Run_F`만으로 충분하다. Aim과 이동 방향을 분리할 때 다음 Clip을 P2로 추가한다.

```text
ANM_Common_Run_B
ANM_Common_Strafe_L
ANM_Common_Strafe_R
ANM_Common_Turn_L
ANM_Common_Turn_R
```

미구현 Aim Strafe를 미리 필수 제작하지 않는다.

### 5.2 공용 Motion의 캐릭터 차이

공용 Clip은 Retargeting 기준이다. 모든 캐릭터가 같은 속도·무게로 보여야 한다는 뜻은 아니다.

- `Animator.speed`를 Gameplay 속도에 직접 비례시켜 과장하지 않는다.
- 보폭 차이는 Character별 Override 또는 Additive Layer로 조정한다.
- 루나는 가벼운 상체, 미유는 작은 본체 동작, 코코는 안정된 곡선, 이리스는 정돈된 중심,
  노아는 낮고 무거운 중심이 읽혀야 한다.
- Character Root 이동속도는 계속 `PlayerStats.MoveSpeed`가 소유한다.

## 6. 캐릭터별 Motion 계약

모든 캐릭터는 최소 `Idle_Signature`, 기본 공격, 현재 Primary, 현재 Utility, `Victory`, `Select`를
가진다. `Design Later`는 Character Bible에 있으나 현재 Gameplay가 없는 항목이다. Clip을 먼저
만들 수는 있지만 Vertical Slice 완료 증거에는 포함하지 않는다.

### 6.1 루나 — CH001

| 상태 | Clip | 구현 연결 |
|---|---|---|
| Signature | `ANM_Luna_Idle_Signature` | 장난스러움과 정찰 집중의 대비 |
| Basic 1 | `ANM_Luna_Attack_01` | `PlayerAttack.ComboStep == 1` |
| Basic 2 | `ANM_Luna_Attack_02` | `ComboStep == 2` |
| Basic 3 | `ANM_Luna_Attack_03` | `ComboStep == 3`, 가장 강한 마무리 |
| Primary | `ANM_Luna_CatStep` | 현재 `ActivateLunaDash` Presentation |
| Utility | `ANM_Luna_ScanPulse` | 현재 `ActivateLunaScan` Presentation |
| Design Later | `ANM_Luna_CrossFang` | Character Bible 후보, Gameplay 미구현 |
| Result | `ANM_Luna_Victory` | Result·Lobby |
| Select | `ANM_Luna_Select` | 캐릭터 선택 |

- 3타는 준비 방향과 단검 궤적을 서로 다르게 하되 몸 앞에서 겹치지 않는다.
- CatStep의 실제 4.5m 이동은 코드가 소유한다. Clip Root는 원점에 남는다.
- ScanPulse는 `Socket_Scanner` 또는 `Socket_VFXCenter`가 가려지지 않는 포즈를 사용한다.

### 6.2 미유 — CH002

| 상태 | Clip | 구현 연결 |
|---|---|---|
| Signature | `ANM_Miyu_Idle_Signature` | 본체보다 드론과의 상호작용 강조 |
| Basic | `ANM_Miyu_Attack_Command` | 자동 공격 신호, 짧은 상체 Cue |
| Primary | `ANM_Miyu_DroneBurst` | 현재 `ActivateMiyuDroneBurst` |
| Utility | `ANM_Miyu_Overclock` | 현재 `ActivateMiyuOverclock` |
| Design Later | `ANM_Miyu_DualLink` | 추가 드론 전개, Gameplay 미구현 |
| Passive Cue | `ANM_Miyu_MagnetPickup` | 독립 Skill Motion 필수 아님 |
| Result | `ANM_Miyu_Victory` | Result·Lobby |
| Select | `ANM_Miyu_Select` | 캐릭터 선택 |

- 자동 공격 간격이 짧으므로 매 발마다 큰 전신 동작을 반복하지 않는다.
- 드론은 `AC_Miyu_Drone` 별도 Animator 또는 코드 Orbit + 짧은 Fire Clip을 사용한다.
- 본체의 건틀릿 Cue와 `Socket_Drone`, Drone `Socket_Muzzle`의 발사 Cue를 같은 Gameplay 신호에
  연결하되 Damage 시점은 코드가 소유한다.

### 6.3 코코 — CH003

| 상태 | Clip | 구현 연결 |
|---|---|---|
| Signature | `ANM_Coco_Idle_Signature` | 부드러움과 응급 대응의 대비 |
| Basic | `ANM_Coco_Attack_Injector` | 기본 자동 공격 |
| Primary | `ANM_Coco_RecoveryPulse` | 현재 `ActivateCocoRecovery` |
| Utility | `ANM_Coco_SafeZone` | 현재 `ActivateCocoShield` |
| Passive Cue | `ANM_Coco_EmergencyTreatment` | 자동 회복 Gameplay 추가 전 필수 아님 |
| Result | `ANM_Coco_Victory` | Result·Lobby |
| Select | `ANM_Coco_Select` | 캐릭터 선택 |

- 회복과 보호막은 손·Injector·발생기에서 시작하는 위치가 명확해야 한다.
- 큰 의료 가방·Cape가 팔꿈치와 손을 가리지 않도록 정면·쿼터뷰를 함께 검사한다.
- 현재 `SafeZone` Prototype은 개인 Shield 6초이고 Character Bible의 범위 피해 감소 Zone은
  미구현이다. 첫 Motion은 자기 보호막 Cast로 검증하고 범위 Skill 구현 시 별도 Variant를 만든다.

### 6.4 이리스 — CH004

| 상태 | Clip | 구현 연결 |
|---|---|---|
| Signature | `ANM_Iris_Idle_Signature` | 정밀함과 생활 허당의 절제된 대비 |
| Basic | `ANM_Iris_Attack_Rifle` | 기본 자동 공격 |
| Primary Start | `ANM_Iris_FocusShot_Start` | 현재 `BeginCharge` |
| Primary Loop | `ANM_Iris_FocusShot_Loop` | `IsCharging`, Loop |
| Primary Release | `ANM_Iris_FocusShot_Fire` | 현재 `ReleaseCharge` |
| Primary Cancel | `ANM_Iris_FocusShot_Cancel` | Target 없음·입력 취소 후 Locomotion 복귀 |
| Utility | `ANM_Iris_MarkTarget` | 현재 `ActivateIrisMark` |
| Passive Cue | `ANM_Iris_ZeroError` | 독립 Skill Motion 필수 아님 |
| Result | `ANM_Iris_Victory` | Result·Lobby |
| Select | `ANM_Iris_Select` | 캐릭터 선택 |

- 긴 Rifle의 `Socket_Muzzle`과 조준 방향이 Orthographic 화면에서 보여야 한다.
- Charge Ratio는 코드가 소유하고 Animator의 `PrimaryCharge`는 시각 보간 값으로만 사용한다.
- 취소·Target 없음에서도 Start/Loop에 갇히지 않고 Locomotion으로 복귀해야 한다.

### 6.5 노아 — CH005

| 상태 | Clip | 구현 연결 |
|---|---|---|
| Signature | `ANM_Noah_Idle_Signature` | 낮고 안정된 무게 중심 |
| Basic | `ANM_Noah_Attack_Shield` | 기본 자동 공격 |
| Primary Start | `ANM_Noah_PerfectGuard_Start` | 현재 `ActivateNoahGuard` |
| Primary Loop | `ANM_Noah_PerfectGuard_Loop` | `IsGuarding`, Loop |
| Counter | `ANM_Noah_PerfectGuard_Counter` | 첫 피격 반격 Presentation |
| Primary End | `ANM_Noah_PerfectGuard_End` | Guard 시간 종료·취소 후 복귀 |
| Utility | `ANM_Noah_BarrierWall` | 현재 `ActivateNoahBarrier` |
| Design Later | `ANM_Noah_ProtectDrive` | Gameplay 미구현 |
| Result | `ANM_Noah_Victory` | Result·Lobby |
| Select | `ANM_Noah_Select` | 캐릭터 선택 |

- 방패가 얼굴과 몸 전체를 계속 가리지 않도록 Guard 각도를 조정한다.
- Guard 지속 2.5초와 Counter 가능 여부는 코드가 소유한다. Loop 길이로 종료를 결정하지 않는다.
- Barrier 생성과 Knockback은 코드 실행 결과이며 `Socket_Shield`·`Socket_VFXCenter`는 연출
  Origin만 제공한다.

## 7. Animator 구조

### 7.1 파일

```text
AC_Character_Common.controller
AOC_Luna.overrideController
AOC_Miyu.overrideController
AOC_Coco.overrideController
AOC_Iris.overrideController
AOC_Noah.overrideController
AVT_Character_UpperBody.mask
```

- `AC_Character_Common`이 공통 Parameter와 State 이름을 소유한다.
- Character별 `AnimatorOverrideController`가 공용 Slot을 고유 Clip으로 교체한다.
- State 구조가 실제로 달라야 하는 Charge·Guard는 공용 Optional State를 사용하고 빈 Dummy
  Motion이 아니라 명시적 전환 조건으로 우회한다.
- Character마다 공용 Controller를 복제해 Parameter 철자가 갈라지지 않게 한다.

### 7.2 Layer

| Layer | 기본 Weight | 역할 |
|---|---:|---|
| `Base` | 1 | Locomotion, 전신 Skill, Hit, Down, Victory·Select |
| `UpperBody` | 0 또는 상태별 | 이동 중 Rifle·Drone·Injector 조작 |
| `Additive` | 0 또는 상태별 | 호흡, 반동, 짧은 감정·장비 반응 |
| `Face` | 선택 | Lobby·Select·Victory 얼굴 표현 |

첫 루나 Proof는 `Base`만으로 시작해도 된다. Layer를 추가할 때 Avatar Mask 경계, 어깨 비틀림,
손 Grip과 Cape·Hair 관통을 Gate B에서 확인한다.

### 7.3 Base State

```text
Entry
→ Locomotion
↔ Attack_01 / Attack_02 / Attack_03
↔ Primary_OneShot
↔ Primary_Start → Primary_Loop → Primary_Release
↔ Utility_OneShot
↔ Hit
→ Down
→ Victory / Select
```

- `Down`은 모든 일반 State보다 높은 우선순위로 진입하고 자동 복귀하지 않는다.
- One-shot State는 자기 자신으로 `Any State` 재진입하지 않는다.
- Attack·Ability 완료 뒤 Locomotion 복귀는 Recovery와 코드 상태를 함께 고려한다.
- Hit는 짧은 Presentation이며 Gameplay Stun을 새로 만들지 않는다.
- `Write Defaults`는 새 Controller 전체에서 `Off`로 통일하고 필요한 속성을 Clip 또는 State에서
  명시한다.

## 8. Parameter 계약

| Parameter | Type | 소유 입력 | 용도 |
|---|---|---|---|
| `MoveSpeed` | float | `PlayerController` Presentation 값 | 0~1 Locomotion Blend |
| `IsDead` | bool | `Damageable` 상태 | Down 고정 |
| `AttackIndex` | int | `PlayerAttack.ComboStep` 또는 1 | 1~3 Attack 선택 |
| `Attack` | trigger | 공격 Presentation 신호 | 기본 공격 시작 |
| `Primary` | trigger | 능력 성공 신호 | Primary One-shot |
| `Utility` | trigger | Utility 성공 신호 | Utility One-shot |
| `IsCharging` | bool | Iris `IsCharging` | FocusShot Start/Loop/Release |
| `IsGuarding` | bool | Noah `IsGuarding` | Guard Start/Loop/End |
| `PrimaryCharge` | float | Iris `ChargeRatio` | Charge 시각 보간 0~1 |
| `PrimaryCancel` | trigger | Charge·Guard 취소 | 안전한 Locomotion 복귀 |
| `Hit` | trigger | 피해 Presentation 신호 | 짧은 Hit |
| `Counter` | trigger | Noah 반격 성공 신호 | Counter Clip |
| `Victory` | trigger | Result 성공 | Victory |
| `Select` | trigger | Lobby 선택 | Select |

- C#에서는 문자열을 매 Frame 만들지 않고 `Animator.StringToHash`를 캐시한다.
- Animator가 Keyboard·Touch·Gamepad를 직접 읽지 않는다.
- `IsScanning`, `IsShieldActive`, `IsDroneOverclocked`, Mark·Barrier 수명은 VFX Presenter가 읽으며
  Body Animator Parameter를 무분별하게 늘리지 않는다.
- 새 Parameter는 코드에 먼저 하드코딩하지 않고 이 표와 Controller를 같은 변경에서 갱신한다.

## 9. Gameplay와 Motion 동기화

### 9.1 현재 즉시 판정 보존

현재 기본 공격과 대부분의 능력은 성공한 Frame에 결과를 적용한다. 첫 Animation 연결은 같은
Frame에 Presentation 신호를 재생하며 Gameplay 결과를 지연하지 않는다.

타격의 Anticipation·Active·Recovery를 Gameplay에도 반영하려면 별도 작업으로 다음 데이터
계약을 먼저 만든다.

```text
Action ID
Anticipation Duration
Active Start / End
Recovery Duration
Interrupt Policy
Movement Lock Policy
```

이 데이터가 없는데 Animation Event만으로 Damage를 늦추면 테스트·저사양 Frame·Clip 교체에
따라 결과가 바뀌므로 금지한다.

### 9.2 속도와 길이

- `PlayerStats.AttackInterval`이 자동 공격 주기를 소유한다.
- Motion이 주기보다 길면 Clip Speed 또는 UpperBody 설계를 조정하고 다음 공격 신호를 잃지 않는다.
- CatStep 4.5m, FocusShot Charge 1.4초, Guard 2.5초 등 현재 수치는 코드 기준이며 Clip에 상수로
  복제하지 않는다.
- 지속 Skill은 Start/Loop/End를 분리하고 Loop 종료를 Code State가 지시한다.

## 10. Animation Event·Presentation Cue

Animation Event Receiver는 한 진입점으로 제한한다.

```text
OnAnimationCue(string cueId)
```

허용 Cue ID:

```text
Footstep_L
Footstep_R
WeaponTrail_On
WeaponTrail_Off
Muzzle
Equipment_Open
Equipment_Close
VFX_Cast
VFX_Release
Camera_Impulse
```

허용 범위:

- Footstep·Swing·장비 SFX
- 무기 궤적·Muzzle·Cast VFX 시작과 종료
- 장비의 비 Gameplay 표시 전환
- 선택적으로 약한 Camera Impulse 요청

금지 범위:

- Damage·Heal·Shield·Cooldown 계산
- 무적·Guard·Counter 성공 판정
- 자원 획득·드랍·정산
- Character 선택·Scene 전환·Save
- 적 Spawn·Target 선택

실제 명중 SFX·Impact VFX는 공격 Clip Event가 아니라 Gameplay Hit 결과에서 발생시킨다. 빗나간
공격이 Impact를 재생하지 않게 하기 위함이다.

## 11. Root Motion·회전·이동

- Battle Character Animator는 `applyRootMotion = false`다.
- 모든 Battle Clip은 Root XZ·Y·Rotation을 Pose에 Bake하고 재생 전후 Root Drift가 0이어야 한다.
- CatStep·ProtectDrive·Knockback도 `PlayerController`·능력 코드의 Transform 이동이 권위다.
- Turn Motion은 시각 보조이며 실제 방향은 `PlayerController`가 소유한다.
- Lobby·Result 전용 연출에서 Root Motion이 필요하면 Battle Prefab과 분리하고, 시작·종료 Transform
  복원 및 Android Frame Drop 동작을 별도 Gate C 증거로 남긴다.

## 12. 장비·Socket·보조 Animator

Socket 이름과 축은 `ASSET_NAMING_GUIDE.md`를 그대로 사용한다.

| 캐릭터 | 주요 Socket | 동기화 대상 |
|---|---|---|
| Luna | `Socket_Weapon_R`, 단검의 `Socket_BladeTip`, `Socket_Scanner` | 단검 Trail·Scan Origin |
| Miyu | `Socket_Drone`, Drone `Socket_Muzzle` | Orbit·Burst·Overclock |
| Coco | `Socket_Weapon_R`, `Socket_Shield`, `Socket_VFXCenter` | Injector·SafeZone |
| Iris | `Socket_Weapon_R`, Rifle의 `Socket_Grip_L`·`Socket_Muzzle`, `Socket_CameraFocus` | 양손 Grip·Rifle·Mark·Charge |
| Noah | `Socket_Shield`, `Socket_VFXCenter` | Guard·Counter·Barrier |

- Socket Transform을 Clip에서 삭제·이름 변경하지 않는다.
- 장비 Spawn·Despawn과 Collision은 코드가 소유하고 Cue는 표시 전환만 요청한다.
- Drone·전개식 Shield처럼 반복 구조가 있는 장비는 별도 `AC_<Subject>_<Equipment>` Controller를
  사용할 수 있다.
- Body와 Equipment Animator는 공통 Gameplay Action ID를 받되 서로의 `normalizedTime`을
  Gameplay 진실 소스로 읽지 않는다.

## 13. Source·Export·Unity Import

### 13.1 경로와 이름

```text
art_source/blender/luna/animation/
├── ANM_Luna_AttackSet_v001.blend
└── ANM_Luna_AbilitySet_v001.blend

Assets/_ReCamp/Art/Animations/
├── Common/
│   ├── ANM_Common_Idle_Combat.fbx
│   └── ANM_Common_Run_F.fbx
└── Characters/
    ├── Luna/
    ├── Miyu/
    ├── Coco/
    ├── Iris/
    └── Noah/
```

- Model FBX와 Animation FBX를 분리한다.
- Animation FBX와 추출 `.anim`은 같은 `ANM_<Subject>_<Action>` stem을 사용한다.
- Source만 `v###`를 사용하고 Runtime FBX·`.anim`에는 상태·버전을 붙이지 않는다.
- 하나의 Take에 여러 Clip을 숨기지 말고 Clip 이름과 파일 범위를 Export manifest에 기록한다.
- Camera·Light·Reference·Control Rig Helper·embedded Texture는 Animation FBX에서 제외한다.

### 13.2 Import 결과 계약

| 항목 | 기준 |
|---|---|
| Animation Type | Humanoid |
| Avatar | 공용 승인 Avatar 또는 해당 Character 승인 Avatar를 명시적으로 사용 |
| Scale·Axis | `ASSET_NAMING_GUIDE.md`의 1m, +Y Up, +Z Forward 결과 |
| Root Motion | Battle Clip의 Rotation·Position Bake, Root Drift 0 |
| Loop | Idle·Run·지속 Loop만 `Loop Time` |
| Loop Pose | 발·손·장비 pop이 없을 때만 사용 |
| Compression | Keyframe Reduction 후 손·발·얼굴·무기 오차 직접 비교 |
| Events | 허용 Cue만 Unity Import/Clip에 기록 |

`Create From This Model`과 `Copy From Other Avatar`의 실제 조합은 공용 Rig Proof에서 확정한다.
Avatar가 유효하지 않거나 Muscle mapping 경고가 있으면 Gate B `FAIL`이다.

### 13.3 Export manifest 필드

`ASSET_NAMING_GUIDE.md`의 manifest에 다음 Animation 필드를 추가한다.

```text
Clip Name:
Loop:
Frame Range:
Sample Rate:
Root Motion:
Avatar Source:
Event Cues:
Expected Socket Motion:
```

## 14. Timing·Sampling·Compression

다음은 첫 Review 범위이며 Gameplay Balance 값이 아니다.

| 동작 | Review 길이 | 기준 |
|---|---:|---|
| Idle Loop | 2.0~4.0초 | 과도한 반복·시선 분산 금지 |
| Run Loop | 0.55~0.90초 | Foot Sliding·속도 mismatch 최소화 |
| Basic Attack | 0.35~1.35초 | Character AttackInterval에 맞춰 Speed 조절 가능 |
| Hit | 0.25~0.50초 | 조작을 새로 잠그지 않음 |
| One-shot Ability | 0.45~1.50초 | Cast·Release가 작은 화면에서 읽힘 |
| Victory | 2.0~4.0초 | Result UI를 가리지 않음 |
| Select | 1.5~3.0초 | 얼굴·대표 장비가 읽힘 |

- Source Sample Rate는 30fps를 기본으로 한다.
- 빠른 Trail·Rifle recoil처럼 필요성이 증명된 Clip만 60fps Source를 보관한다.
- Unity Rendering Frame Rate와 Animation Source Sample Rate를 같은 값으로 오해하지 않는다.
- Compression 전후를 같은 Camera·Lighting·속도에서 비교한다.
- 손·발·무기 Tip·얼굴 Curve 손상이 보이면 용량보다 품질을 우선하고 성능 예산 문서에 근거를
  남긴다.

## 15. Gate B — 제작 가능성

필수 증거:

- Front·Side·Back 기준 포즈와 공용 Rig Retarget 결과
- 각 Clip의 시작·Active·Recovery 썸네일
- Loop 첫/끝 Pose 비교와 Root Drift 수치
- 손 Grip·장비 Pivot·Socket 궤적 Overlay
- 4~5등신 관절, Hair·Cape·가방·방패 관통 검사
- Export manifest와 Source/Runtime basename 대응

즉시 `FAIL`:

- 승인되지 않은 2D 시트를 최종 Motion 기준으로 사용
- 공용 Avatar가 Invalid이거나 Retargeting으로 손·발이 치명적으로 뒤틀림
- Root Scale이 1이 아니거나 Battle Clip이 Transform 이동을 누적함
- Attack 방향·장비·얼굴이 Orthographic Camera에서 가려짐
- Socket 이름이 Clip·Prefab 재Import에서 사라지거나 바뀜

## 16. Gate C — Unity·Android 통합

필수 검사:

1. Character ID가 올바른 Model·Avatar·AOC·Clip·장비 Animator를 참조한다.
2. Lobby → Battle → Result → Lobby에서 Animator 참조와 State가 유지된다.
3. AttackIndex 1→2→3, Iris Charge 취소·Release, Noah Guard·Counter가 State에 갇히지 않는다.
4. 사망 시 일반 Action보다 `Down`이 우선하고 Result 흐름을 막지 않는다.
5. 모든 Battle Clip의 Root Drift 0, `PlayerController` 위치·Arena Clamp 회귀 없음.
6. SFX·VFX Cue 중복, Missing Receiver, Missing Clip, Invalid Avatar와 `_ReCamp` 오류 0.
7. Android Landscape 기준 화면에서 5인의 공격 방향·장비·Primary·Utility가 구분된다.
8. 목표 기기 성능 예산은 `CHARACTER_3D_SPEC.md`가 생긴 뒤 그 기준으로 판정한다.

자동화 후보:

- 5인 Prefab의 Animator·Avatar·AOC·필수 Clip 참조 누락 검사
- 공통 Parameter Hash와 Controller Parameter 일치 검사
- `applyRootMotion == false` 검사
- 필수 Socket과 장비 Animator 참조 검사
- 허용되지 않은 Gameplay Animation Event 검사
- Character 선택 왕복 후 Animator·VFX 참조 유지 PlayMode 테스트

## 17. 루나 Animation Proof 완료 조건

- Approved 루나 일반 등신 제작 시트와 4~5등신 Model·Rig가 선행된다.
- 공용 `Idle_Combat`, `Run_F`, `Hit_Front`, `Down`, `Down_Loop` Retargeting이 정상이다.
- 3타 `Attack_01~03`의 방향·단검 궤적·회수가 서로 읽힌다.
- CatStep은 코드 이동과 동기화되고 Root Drift·Arena Clamp 회귀가 없다.
- ScanPulse Origin과 탐지 VFX가 `Socket_Scanner` 또는 `Socket_VFXCenter`에 맞는다.
- CrossFang은 Gameplay가 추가되기 전 Clip Proof로만 분리해 판정한다.
- Victory·Select에서 루나의 장난스러움과 임무 집중의 대비가 전달된다.
- Orthographic Battle Camera와 Android Landscape 실기기에서 얼굴·후드·단검이 구분된다.
- 기존 기능 회귀, `_ReCamp` 오류, EditMode·PlayMode 전체 통과 증거가 있다.

## 18. ART-0110 완료 판정

이 문서에서 다음을 확정했다.

- 공용·5인 고유 필수 Motion과 현재 Prototype/Design Later 경계
- In-place·Root Motion·Gameplay 권위 규칙
- 공통 Animator Controller·Override·Layer·Parameter 계약
- Animation Event 허용·금지 Cue
- Drone·Shield·Socket 동기화
- Blender Source→Animation FBX→Unity Import·manifest 규칙
- Gate B/C와 루나 Animation Proof 완료 조건

따라서 문서 작업 `ART-0110`은 `Done`이다. 실제 Clip 제작·Import·Prefab 통합은
`ART-2008~2010`에서 검증하며, `CHARACTER_3D_SPEC.md`가 성능·Rig 예산을 확정하기 전에는 최종
Animation Gate C를 `PASS`로 판정하지 않는다.
