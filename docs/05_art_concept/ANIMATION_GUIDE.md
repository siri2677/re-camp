# Re:Camp Animation and Animator Guide

> Version: v002
> 최종 갱신: 2026-07-27
> 상태: Active Domain Contract
> Backlog: `ART-0110`

제품·전역 비주얼·캐릭터 허용 범위는 `docs/00_project/CURRENT_PROJECT_BASELINE.md`를 따른다. 캐릭터별 성격·역할·장비는 `CHARACTER_BIBLE.md`, 이름·Socket은 `ASSET_NAMING_GUIDE.md`, Gate 판정은 `ART_REVIEW_CHECKLIST.md`가 소유한다.

이 문서의 `Done`은 Animation 제작 계약이 준비됐다는 뜻이다. 실제 Clip·Avatar·Controller·Prefab 연결 완료는 해당 3D Backlog에서 별도로 검증한다.

## 1. 책임 경계

- 이동 거리·회전·Damage·무적·Cooldown·자원·정산은 Gameplay 코드와 데이터가 소유한다.
- Animation은 자세·타이밍·캐릭터성·타격 인지와 Presentation Cue를 소유한다.
- Animation Event는 SFX·VFX·장비 표시·발사 Cue에만 사용한다.
- Battle Motion은 In-place를 기본으로 하고 `Animator.applyRootMotion = false`를 사용한다.
- Animation 변경으로 기존 Gameplay 결과와 자동 테스트가 달라지면 안 된다.
- 최종 Rig·Bone·Polygon·Texture·성능 예산은 향후 `CHARACTER_3D_SPEC.md`가 소유한다.

## 2. 현재 구현 기준

현재 Gray Box는 코드 기반 이동·공격·능력을 사용하며 최종 Model·Rig·Animator가 없다.

- `PlayerController`: 이동·회전.
- `PlayerAttack`: 자동 공격과 루나 Combo Step.
- `CharacterAbilityController`: 캐릭터별 Primary·Utility 기능.
- `Damageable`: 피해·보호막·회복·사망.

첫 Animator 통합은 위 기능을 보존하는 Presentation 작업이다.

## 3. 공통 원칙

1. 캐릭터는 공용 Humanoid 호환 Rig를 사용한다.
2. Locomotion·Hit·Down은 가능한 범위에서 재사용한다.
3. Signature Idle·기본 공격·Primary·Utility·Victory·Select에서 개성을 만든다.
4. 쿼터뷰와 모바일 화면에서 준비·방향·타격 순간이 읽혀야 한다.
5. 얼굴·손·대표 장비를 Motion이 가리지 않게 한다.
6. 체형·성격·역할 차이가 공용 Motion 때문에 사라지면 Override 또는 Additive Layer를 사용한다.
7. 사람 Gate B/C 전에는 Clip이나 Controller를 `APPROVED`로 표시하지 않는다.

## 4. 제작 우선순위

| 단계 | 범위 | 목적 |
|---|---|---|
| P0 | 공용 Idle·Run·Hit·Down, 루나 기본 공격·Dash·Scan | Character Proof와 Gameplay 회귀 |
| P1 | 5인 기본 공격·Primary·Utility·Victory·Select·장비 Motion | Vertical Slice 역할·표현 검증 |
| P2 | Lobby Idle·Turn·추가 피격·표정 Additive·추가 Skill | 반복 플레이와 캐릭터 매력 강화 |

Jump·Climb·Revive·동료 구조는 실제 Gameplay Backlog가 생길 때 추가한다.

## 5. 공용 Clip 계약

| ID | Clip | Loop | 용도 |
|---|---|---:|---|
| COM-001 | `ANM_Common_Idle_Combat` | Yes | 전투 기본 대기 |
| COM-002 | `ANM_Common_Run_F` | Yes | 전진 Locomotion |
| COM-003 | `ANM_Common_Hit_Front` | No | 짧은 피격 Cue |
| COM-004 | `ANM_Common_Down` | No | 전투 불능 진입 |
| COM-005 | `ANM_Common_Down_Loop` | Yes | 전투 불능 유지 |
| COM-006 | `ANM_Common_Idle_Lobby` | Yes | 로비 기본 대기 |
| COM-007 | `ANM_Common_Victory` | No | 임시 공용 승리 |
| COM-008 | `ANM_Common_Select` | No | 임시 공용 선택 |

Aim과 이동 방향이 분리될 때 `Run_B`, `Strafe_L/R`, `Turn_L/R`을 추가한다. 미구현 Aim Strafe를 선제 필수 제작하지 않는다.

## 6. 캐릭터별 Clip 계약

### 루나

| 상태 | Clip | Gameplay 연결 |
|---|---|---|
| Signature | `ANM_Luna_Idle_Signature` | 장난스러움↔정찰 집중 |
| Basic 1~3 | `ANM_Luna_Attack_01~03` | Combo Step 1~3 |
| Primary | `ANM_Luna_CatStep` | Dash Presentation |
| Utility | `ANM_Luna_ScanPulse` | Scan Presentation |
| Result | `ANM_Luna_Victory` | Result·Lobby |
| Select | `ANM_Luna_Select` | 캐릭터 선택 |

- 실제 Dash 거리는 코드가 소유한다.
- 3타는 준비 방향과 단검 궤적을 구분한다.
- Scanner·VFX Socket이 몸에 가려지지 않게 한다.

### 미유

| 상태 | Clip | Gameplay 연결 |
|---|---|---|
| Signature | `ANM_Miyu_Idle_Signature` | 드론 상호작용 |
| Basic | `ANM_Miyu_Attack_Command` | 자동 공격 Cue |
| Primary | `ANM_Miyu_DroneBurst` | Drone Burst |
| Utility | `ANM_Miyu_Overclock` | Overclock |
| Result | `ANM_Miyu_Victory` | Result·Lobby |
| Select | `ANM_Miyu_Select` | 캐릭터 선택 |

- 드론은 별도 Animator 또는 코드 Orbit과 짧은 Fire Clip을 사용한다.
- 본체 Cue·Drone Muzzle Cue는 같은 Gameplay 신호를 사용하되 Damage는 코드가 적용한다.

### 코코

| 상태 | Clip | Gameplay 연결 |
|---|---|---|
| Signature | `ANM_Coco_Idle_Signature` | 부드러움↔응급 대응 |
| Basic | `ANM_Coco_Attack_Injector` | 자동 공격 |
| Primary | `ANM_Coco_RecoveryPulse` | 회복 |
| Utility | `ANM_Coco_SafeZone` | 보호막 |
| Result | `ANM_Coco_Victory` | Result·Lobby |
| Select | `ANM_Coco_Select` | 캐릭터 선택 |

- 회복·보호막의 발생 위치가 손·Injector·Projector와 일치해야 한다.
- Cape와 의료 장비가 팔·손을 가리지 않게 한다.

### 이리스

| 상태 | Clip | Gameplay 연결 |
|---|---|---|
| Signature | `ANM_Iris_Idle_Signature` | 정밀함↔생활 반전 |
| Basic | `ANM_Iris_Attack_Rifle` | 자동 공격 |
| Primary Start | `ANM_Iris_FocusShot_Start` | Charge 시작 |
| Primary Loop | `ANM_Iris_FocusShot_Loop` | Charge 유지 |
| Primary Fire | `ANM_Iris_FocusShot_Fire` | Release |
| Primary Cancel | `ANM_Iris_FocusShot_Cancel` | 취소·대상 상실 |
| Utility | `ANM_Iris_MarkTarget` | 표식 |
| Result | `ANM_Iris_Victory` | Result·Lobby |
| Select | `ANM_Iris_Select` | 캐릭터 선택 |

- 라이플 Muzzle·Sight 방향과 VFX가 일치해야 한다.
- 긴 헤어와 코트가 총기·팔·바닥을 관통하지 않게 한다.

### 노아

| 상태 | Clip | Gameplay 연결 |
|---|---|---|
| Signature | `ANM_Noah_Idle_Signature` | 무게감·보호 자세 |
| Basic | `ANM_Noah_Attack_Shield` | 자동 공격·반격 Cue |
| Primary | `ANM_Noah_BarrierWall` | 방벽 전개 |
| Utility | `ANM_Noah_PerfectGuard` | Guard·Counter |
| Result | `ANM_Noah_Victory` | Result·Lobby |
| Select | `ANM_Noah_Select` | 캐릭터 선택 |

- 방패 전개 Motion과 장비 Animator를 분리할 수 있다.
- 방패가 카메라·얼굴·적 피격 정보를 가리지 않게 한다.
- 방벽 위치·충돌·피해 감소는 코드가 소유한다.

## 7. Animator 구조

```text
Base Layer
├── Locomotion
├── Action
├── Hit
└── Down

Upper Body Layer (선택)
├── Aim / Command
└── Skill Additive

Equipment Layer or Sub Animator
├── Fold / Deploy
├── Fire / Pulse
└── Emission State
```

필수 Parameter 예시:

```text
Speed(float)
IsDown(bool)
AttackIndex(int)
TriggerAttack(trigger)
TriggerPrimary(trigger)
TriggerUtility(trigger)
TriggerHit(trigger)
TriggerVictory(trigger)
TriggerSelect(trigger)
```

Gameplay State를 Animator Parameter가 소유하지 않는다. Runtime이 결과를 계산하고 Animator에 표현 신호를 전달한다.

## 8. Animation Event

허용:

- `CueFootstep`
- `CueWeaponTrailOn/Off`
- `CueMuzzleFlash`
- `CueSkillVfx`
- `CueSkillSfx`
- `CueEquipmentState`

금지:

- 직접 Damage 적용.
- Cooldown 시작·종료 결정.
- 자원 지급·정산.
- 무적·이동 거리·Target 선택.
- Scene 전환.

Event 누락 또는 중복이 Gameplay 결과를 바꾸면 안 된다.

## 9. Blender·FBX Export

- 단위와 축은 `ASSET_NAMING_GUIDE.md`와 Unity Import Preset을 따른다.
- Mesh·Armature·Animation Clip 이름을 Manifest에 기록한다.
- Root Motion은 Bake 또는 In-place 계약에 맞춘다.
- 장비 Bone·Socket·별도 Object의 소유권을 명시한다.
- NLA Track과 Action의 사용 여부를 Export 기록에 남긴다.

## 10. Unity Import·Prefab

- Humanoid Avatar 생성과 Bone Mapping을 검증한다.
- Loop Clip·Root Transform·Compression을 Clip별로 설정한다.
- Animation Event는 Import 후 diff 가능한 형태로 관리한다.
- Animator Controller는 공용 Base와 캐릭터별 Override를 우선한다.
- Prefab은 기능 Root와 Visual Root를 분리한다.
- 장비 Animator·VFX·Audio Socket을 Validation Tool로 검사한다.

## 11. 검증 Gate

### Gate B

- Pose·관절·Grip·장비 구조가 제작 가능하다.
- Turnaround와 Bone 방향이 일치한다.
- 큰 관통과 불가능한 변형이 없다.
- Clip 목록·Loop·Event·장비 동기화가 문서화돼 있다.

### Gate C

- 쿼터뷰에서 시작·방향·타격 순간이 읽힌다.
- 실제 Gameplay 결과와 테스트가 유지된다.
- Blend·Cancel·Hit·Down 복귀가 안정적이다.
- Android 성능과 Animation 메모리 예산을 통과한다.

## 12. 완료 증거

각 캐릭터 또는 공용 세트마다 다음을 남긴다.

- Source·FBX·Import 경로와 버전.
- Avatar·Controller·Override·Prefab 경로.
- Clip 목록과 Event 목록.
- Unity Compile·Console·EditMode·PlayMode 결과.
- 직접 Play Mode 캡처.
- Gate B/C review와 사람 승인.

이 문서에서 전역 비율·플랫폼·로스터를 다시 정의하지 않는다.
