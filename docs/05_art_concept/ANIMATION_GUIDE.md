# Re:Camp Animation Guide

이 문서는 Re:Camp 플레이어블 캐릭터의 공용·고유 애니메이션 범위, 파일 구조, Unity 연결 기준을 정의한다.

## 1. 기본 원칙

- 모든 플레이어블 캐릭터는 공용 Humanoid Rig를 사용한다.
- 이동·피격·다운과 같은 기본 동작은 최대한 공용으로 사용한다.
- 캐릭터의 개성은 대표 Idle, 기본 공격, 스킬, 승리 모션에서 표현한다.
- 전투 기본 애니메이션은 In-place를 원칙으로 한다.
- 이동 거리와 판정은 게임 코드와 CharacterController가 관리한다.
- Root Motion은 연출과 특수 스킬에서만 선택적으로 사용한다.

## 2. 공용 필수 애니메이션

| ID | Clip | Loop | 비고 |
|---|---|---:|---|
| COM-001 | Idle_Combat | Yes | 전투 기본 대기 |
| COM-002 | Idle_Lobby | Yes | 로비용 기본 대기 |
| COM-003 | Walk_F | Yes | 전진 걷기 |
| COM-004 | Run_F | Yes | 전진 달리기 |
| COM-005 | Strafe_L | Yes | 좌 이동 |
| COM-006 | Strafe_R | Yes | 우 이동 |
| COM-007 | Run_B | Yes | 후퇴 또는 후방 이동 |
| COM-008 | Turn_L | No | 필요 시 제자리 회전 |
| COM-009 | Turn_R | No | 필요 시 제자리 회전 |
| COM-010 | Hit_Front | No | 전방 피격 |
| COM-011 | Hit_Back | No | 후방 피격 |
| COM-012 | Down | No | 전투 불능 진입 |
| COM-013 | Down_Loop | Yes | 전투 불능 유지 |
| COM-014 | Revive | No | 부활 또는 구조 |
| COM-015 | Victory_Common | No | 공용 임시 승리 |

초기 MVP에서는 `Idle_Combat`, `Run_F`, `Hit_Front`, `Down`을 우선 제작한다.

## 3. 캐릭터별 고유 애니메이션

각 캐릭터는 최소 다음 애니메이션을 보유한다.

```text
대표 Idle 1종
기본 공격 세트
회피 또는 이동 스킬
스킬 3종
피니시 또는 강한 공격 1종
승리 모션 1종
캐릭터 선택 연출 1종
```

### 루나

- 빠르고 가벼운 중심 이동
- 짧은 준비 동작과 빠른 회수
- 단검 궤적이 몸에 가려지지 않도록 팔을 바깥쪽으로 사용
- 고양이 후드와 장난스러운 성격을 Idle과 승리 모션에 반영

권장 Clip:

```text
Luna_Idle
Luna_Attack_01
Luna_Attack_02
Luna_Attack_03
Luna_Dash
Luna_ScanPulse
Luna_CrossFang
Luna_Victory
Luna_Select
```

### 미유

- 본체 움직임은 작고 드론 움직임이 강조됨
- 건틀릿 조작과 홀로그램 입력 동작 사용
- 드론은 별도 Animator 또는 코드 기반 이동 가능

### 코코

- 둥글고 안정적인 동작 곡선
- 회복·보호막 시 손과 장비 중심의 읽기 쉬운 포즈
- 공격보다 구조요원다운 단호한 준비 동작 강조

### 이리스

- 긴 라이플의 방향성과 조준선이 명확해야 함
- 준비 동작은 길지만 발사 순간은 빠르게 구성
- 몸통 회전과 라이플 반동이 쿼터뷰에서 보이도록 조정

### 노아

- 무게 중심이 낮고 안정적인 동작
- 방패가 얼굴과 몸 전체를 지속적으로 가리지 않도록 각도 조정
- 가드 성공과 반격의 타이밍을 명확하게 구분

## 4. 애니메이션 타이밍 기준

### 기본 공격

```text
Anticipation
→ Active/Hit
→ Recovery
```

- Hit Frame은 Animation Event 또는 별도 타임라인 데이터와 일치시킨다.
- Damage 판정은 애니메이션 상태만 믿지 않고 게임 로직에서 검증한다.
- 빠른 캐릭터라도 최소한의 준비 동작을 두어 공격 방향을 읽을 수 있게 한다.

### 피격

- 짧은 피격은 조작을 과도하게 끊지 않는다.
- 강한 공격과 보스 공격만 큰 피격 또는 Knockback을 사용한다.
- 무적 시간과 피격 애니메이션 시간은 별도 데이터로 관리한다.

### 회피·대시

- 이동 거리와 속도는 코드에서 관리한다.
- 무적 구간은 Animation Event보다 데이터 기반 타임라인을 우선한다.
- 시작·이동·종료 포즈가 캐릭터 실루엣을 유지해야 한다.

## 5. 권장 프레임과 길이

| 동작 | 권장 길이 | 비고 |
|---|---:|---|
| Idle Loop | 2.0~5.0초 | 과도한 움직임 금지 |
| Run Loop | 0.5~0.9초 | 속도와 Footstep 동기화 |
| 기본 공격 1타 | 0.35~0.7초 | 캐릭터 역할에 따라 조정 |
| 강한 공격 | 0.8~1.8초 | 준비 동작이 읽혀야 함 |
| 피격 | 0.25~0.55초 | 조작 중단 최소화 |
| 회피·대시 | 0.3~0.7초 | 코드 이동과 동기화 |
| 스킬 | 0.8~3.0초 | 필요 시 Gameplay 구간 분리 |
| 승리 모션 | 2.0~5.0초 | 로비/결과 화면용 |

샘플링은 30fps를 기본으로 하며, 필요 시 60fps 원본을 보관하고 Unity에서는 Curve 품질을 확인해 압축한다.

## 6. Animator 구조

권장 Layer:

```text
Base Layer
UpperBody Layer
Additive Layer
Face Layer 또는 별도 얼굴 제어
```

### Base Layer

```text
Entry
→ Locomotion Blend Tree
→ Attack
→ Skill
→ Hit
→ Down
```

### UpperBody Layer

- 이동 중 조준
- 장비 조작
- 상체 중심 스킬

Avatar Mask를 사용하되 몸통과 팔의 경계에서 부자연스러운 변형이 없는지 검수한다.

## 7. Parameter 규칙

```text
Speed: float
MoveX: float
MoveY: float
IsGrounded: bool
IsDead: bool
AttackIndex: int
Attack: trigger
Skill01: trigger
Skill02: trigger
Skill03: trigger
Hit: trigger
Victory: trigger
```

캐릭터마다 임의의 Parameter 이름을 추가하기보다 공용 Parameter를 우선 사용한다.

## 8. Animation Event 사용 규칙

사용 가능:

- Footstep 사운드
- 무기 궤적 VFX 시작·종료
- 타격 사운드
- 카메라 연출 신호

가급적 사용하지 않는 항목:

- 최종 Damage 수치 계산
- 자원 획득
- 스킬 쿨다운 시작
- 캐릭터 상태의 단일 진실 소스

게임 규칙은 코드와 데이터가 관리하고 Event는 Presentation 동기화에 사용한다.

## 9. 파일 분리와 Export

권장 구조:

```text
art_source/blender/characters/luna/
├── model/
├── rig/
└── animation/

Assets/_ReCamp/Art/Animations/
├── Common/
└── Characters/
    ├── Luna/
    ├── Miyu/
    ├── Coco/
    ├── Iris/
    └── Noah/
```

모델 FBX와 애니메이션 FBX를 분리한다.

```text
CHR_Luna_Model.fbx
CHR_Common_Run_F.fbx
CHR_Luna_Attack_01.fbx
```

## 10. Unity Import 기준

- Rig Type: Humanoid
- Avatar Definition: 공용 모델은 Create From This Model
- 개별 Animation FBX: Copy From Other Avatar 사용 가능
- Looping Clip은 Loop Time 활성화
- Loop Pose는 Foot Sliding 여부를 확인 후 적용
- Root Transform Rotation/Position Bake 설정을 실제 이동 방식과 맞춤
- Animation Compression 적용 후 손·무기·발 변형을 확인

## 11. 검수 체크리스트

### 공통

- 발 미끄러짐이 눈에 띄지 않는가
- 무게 중심이 캐릭터 역할과 맞는가
- 손이 무기 Grip에서 벗어나지 않는가
- 쿼터뷰에서 공격 방향과 타격 순간을 읽을 수 있는가
- 공용 Rig에서 Retargeting 오류가 없는가

### 전투

- Hitbox 활성 구간과 타격 포즈가 일치하는가
- VFX가 무기 궤적과 맞는가
- 공격 종료 후 조작 복귀 시점이 자연스러운가
- 이동·회피 중 의상과 헤어 관통이 치명적이지 않은가

### 모바일

- 화면 축소 상태에서도 큰 동작과 작은 동작이 구분되는가
- 프레임과 Curve 수가 과도하지 않은가
- 동시에 여러 캐릭터·적이 재생될 때 목표 성능을 유지하는가

## 12. 루나 Animation Proof 완료 기준

- 공용 Idle/Run/Hit/Down을 정상적으로 재사용한다.
- 3타 기본 공격의 Hit Frame과 단검 VFX가 일치한다.
- Dash의 이동 거리·무적 구간·애니메이션이 동기화된다.
- Scan Pulse와 Cross Fang이 쿼터뷰에서 즉시 구분된다.
- Victory와 Select 모션에서 루나의 장난스러운 성격이 전달된다.
- 저사양 설정에서도 치명적인 손·무기·의상 오류 없이 재생된다.
