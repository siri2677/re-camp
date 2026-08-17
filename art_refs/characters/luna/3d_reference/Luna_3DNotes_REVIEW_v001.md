# Luna 3D Notes REVIEW v001

```yaml
Character: CH001 Luna
Purpose: ART-1002 to ART-2001 2D-to-3D implementation handoff
Status: REVIEW
Human Reviewer: Pending
Approval: NOT GRANTED
Identity Source: ../concept/Luna_KeyArt_REVIEW_v001.png
3D Visual Source: Luna_3DReference_REVIEW_v001.png
Translation Board: Luna_2DTo3DTranslation_REVIEW_v004.png
Actual Mesh Budget: Pending ART-2001 Character Proof blockout
```

이 문서는 선택된 2D 루나를 5-6등신 3D로 옮길 때의 제작 의도를 고정한다. 이미지가 메시, 리그,
런타임 재질 또는 물리 안정성을 증명하지는 않는다. 아래 수치는 Blockout 시작 기준이며 실제
Character Proof에서 검증해야 한다.

## 1. Exact proportion evidence

| Source | Image | Crown | Chin | Sole | Head unit | Crown-to-sole | Calculation | Gate |
|---|---:|---:|---:|---:|---:|---:|---:|---|
| Selected 2D | 866x1817 | `(409,116)` | `(419,339)` | `(611,1698)` | 223 px | 1582 px | `1582 / 223 = 7.094` | 7.09H PASS |
| Selected 3D | 1024x1536 | `(524,153)` | `(512,392)` | `(425,1442)` | 239 px | 1289 px | `1289 / 239 = 5.393` | 5.39H PASS |

- Crown은 후드 위 센서 귀 끝이 아니라 후드 아래 해부학적 두개골 상단을 사용한다.
- 2D 루나의 잠금 목표는 6.9-7.1H, 3D 기본 목표는 5.2-5.5H이며 캐릭터별 5-6H를 허용한다.
- 3D는 2D를 균일 축소한 결과가 아니다. 머리 단위가 커지고, 다리 길이 과장이 줄며, 손·부츠·골반
  질량이 gameplay camera에서 읽히도록 확대된다.

## 2. Identity lock

다음 항목은 모델링 편의 때문에 교체하거나 삭제하지 않는다.

1. 성인 여성: 유아형 볼, 과대 두상, 짧은 팔다리의 SD 회귀를 금지한다. 얼굴은 작은 코와 입을
   쓰되 눈매와 턱선은 성숙하게 유지한다.
2. 얼굴과 헤어: 두 눈이 보여야 하며, 민트 실버 비대칭 울프 보브와 안쪽 시안 그라데이션을 유지한다.
3. 대표 실루엣: 기계식 방향 센서 후드 2개, 크롭 재킷, 패널 없는 차콜 하이웨이스트 쇼츠,
   허리 스캐너·벨트의 작은 비대칭, 저중심 부츠다.
4. 역할 장비: 짧은 Fang 쌍단검, 손목 스캐너, 소형 백팩, 단일 케이블 Probe다.
5. 팔레트: Cream 55 / Charcoal 35 / Cyan 10을 화면상 우선순위로 사용한다. 시안은 센서와 기능
   피드백에 집중하고 장식 발광으로 전신에 분산하지 않는다.
6. 여성성: 허리를 분명히 하고 골반-허벅지 볼륨을 유지하되, 전투 가독성을 해치는 하이힐이나 긴
   천 조각은 추가하지 않는다.

## 3. 2D to 3D Expand / Delete / Combine

| Region | EXPAND in 3D | DELETE from 2D detail | COMBINE for implementation |
|---|---|---|---|
| Head / face | 머리, 눈, 눈썹, 입 모양을 카메라 거리용으로 확대 | 속눈썹 한 올, 피부의 미세 하이라이트 | 얼굴 윤곽과 앞머리를 안정적인 하나의 읽기로 정리 |
| Hood / sensors | 센서 귀 두께, 원형 Hinge, 시안 Scan 창 | 미세 패널선, 작은 나사와 중복 절개 | 후드 Shell과 센서 Frame을 하나의 대표 실루엣으로 결합 |
| Torso / jacket | 재킷 소매 부피, 목선, 허리 대비 | 반복 봉제선, 작은 금속 장식 | 크림 재킷 큰 면과 차콜 이너 큰 면으로 정리 |
| Hips / legs | 골반, 허벅지, 무릎 주변 질량 | 2D의 긴 다리 패션 과장 | 허리 패널은 한쪽 1개 Physics Layer로 결합 |
| Hands / scanner | 손, Grip, 손목 스캐너 면적 | 손가락 장식선, 작은 버튼 반복 | 스캐너를 하나의 Wrist Module과 Scan Surface로 결합 |
| Fang daggers | 손잡이 두께, Fang 날 윤곽, Emitter | 날의 미세 각인과 작은 홈 | 좌우가 같은 구조를 공유하고 색/손잡이 방향만 구분 |
| Backpack / probe | Pack 외곽, Cable Root, Probe tip | 중복 케이블과 작은 수납 파츠 | Pack과 단일 Cable Root를 하나의 후면 기능 덩어리로 결합 |
| Boots | Toe cap, Sole, 발목 Cuff | 반복 스트랩과 밑창 미세 홈 | 저중심 Boot Shell + Sole + Cyan 기능점으로 단순화 |

## 4. Material-slot intent

실제 Slot 수와 Texture Set 수는 ART-2001 예산 확정 전까지 `Pending`이다. Blockout에서는 아래
6개 기능 그룹을 넘기지 않는 방향으로 시작한다.

| Working slot | Coverage | Shader intent | Risk / note |
|---|---|---|---|
| `M_Luna_Skin` | 얼굴, 목, 몸, 손, 다리 | toon skin, soft SSS-like ramp | 얼굴과 몸의 색 차이 금지 |
| `M_Luna_Hair` | 헤어 Base와 민트 Tip | anisotropic-like toon highlight | 투명 카드 수는 실제 예산에서 결정 |
| `M_Luna_Cream` | 후드, 크롭 재킷, 부츠 Cream 면 | 반무광 직물/코팅 Shell | 재킷과 센서 Shell의 roughness 분리 필요 |
| `M_Luna_Charcoal` | 이너, 쇼츠, 장갑, 패널, Pack | 저광택 직물/가죽 | 검은 면이 한 덩어리로 뭉치지 않게 값 분리 |
| `M_Luna_HardSurface` | Hinge, Buckle, Fang, Scanner, Probe | 금속/폴리머 마스크 공유 | 작은 파츠별 Slot 분할 금지 |
| `M_Luna_CyanFX` | 센서, Scanner, Fang Emitter, Probe tip | Emission + gameplay pulse | 상시 최대 발광 금지; 상태 피드백용 |

## 5. Humanoid joint intent

- Unity Humanoid 필수 흐름: `Hips -> Spine -> Chest -> UpperChest -> Neck -> Head`, 양측
  `Shoulder -> UpperArm -> LowerArm -> Hand`, 양측 `UpperLeg -> LowerLeg -> Foot -> Toes`.
- Hips는 시각적 골반 중심에 두고, 5.39H 체형의 짧아진 상·하체를 보상하려고 관절을 임의로 늘리지 않는다.
- Shoulder는 크롭 재킷 부피가 아닌 해부학적 어깨 관절에 둔다. 팔을 올릴 때 Hood와 소매가 겹치는
  구간은 보조 Skin Bone 또는 Corrective Shape 후보로 남긴다.
- Elbow와 Knee의 굽힘 축은 정면 실루엣보다 측면 변형을 우선한다. 무릎 보호용으로 허벅지/종아리
  Loop를 충분히 두되 실제 Loop 수는 Mesh 예산 확정 후 결정한다.
- 손은 쌍단검 Grip을 위해 Thumb와 Index 분리가 필요하다. 나머지 손가락 세분화 수준은 실제 Rig
  Budget에서 확정한다.
- 센서 귀, 바깥 머리카락 끝, 허리 패널, 케이블은 Humanoid Mapping 밖의 Accessory Bone이다.
- 얼굴 Bone/BlendShape 방식과 개수는 Pending이다. 최소 요구는 Blink L/R, Look, Mouth Smile,
  Mouth Open을 재현할 수 있는 구조다.

## 6. Equipment sockets

| Socket | Parent intent | Forward / up intent | Use |
|---|---|---|---|
| `Socket_Fang_L` | Left Hand | Blade forward, edge outward | 왼손 Fang 장착/해제 |
| `Socket_Fang_R` | Right Hand | Blade forward, edge outward | 오른손 Fang 장착/해제 |
| `Socket_Holster_L` | Pelvis left side | Grip reachable by left hand | 비전투 Fang 수납 후보 |
| `Socket_Holster_R` | Pelvis right side | Grip reachable by right hand | 비전투 Fang 수납 후보 |
| `Socket_WristScanner` | Scanner-side LowerArm | Screen normal faces camera in scan pose | 손목 Scan Surface와 FX 원점 |
| `Socket_Backpack` | Chest/UpperChest rear helper | Pack forward matches character forward | 소형 Pack 분리 장착 |
| `Socket_ProbeRoot` | Backpack lower-side helper | Cable tangent exits away from torso | 케이블 시뮬레이션 시작점 |
| `Socket_ProbeTip` | Last cable accessory bone | Probe point forward | 탐지 FX와 접촉 판정 원점 |

좌우 손, Holster 위치와 Scanner 측은 Equipment Sheet와 실제 Draw/Sheathe 애니메이션을 함께 놓고
ART-2001에서 최종 확정한다. 이미지 한 장의 화면 좌우를 캐릭터 좌우로 오인하지 않는다.

## 7. Secondary motion and penetration risks

### Hair

- 앞머리와 얼굴 옆 큰 Hair Clump는 기본 Skin에 가깝게 고정하고, 바깥쪽 끝 2-3개 Chain만 저진폭
  보조 물리 후보로 둔다.
- 얼굴, 눈, 후드 Collar와의 충돌을 먼저 막는다. 달리기에서 머리카락이 센서 귀 앞을 반복적으로
  가려 대표 실루엣이 깨지지 않아야 한다.
- Head turn 후 잔동작은 짧고 빠르게 감쇠시켜 정찰병의 민첩한 인상을 유지한다.

### Probe cable

- Backpack Root에서 처음 구간은 Kinematic에 가깝게 고정하고, 중간 Cable과 Probe tip만 굽힌다.
- 최소 굽힘 반경을 유지하고 허리, 양 허벅지, 양 Fang, Pack 외곽을 Collision 대상으로 본다.
- Idle에서는 몸 옆 바깥으로 작은 C 곡선을 만들고, Run에서는 뒤쪽으로 정렬한다. 다리 사이로 넘어가거나
  Fang 날에 감기는 경로는 실패다.
- Dodge와 180도 Turn에서 진폭을 Clamp한다. 최대 각도, Bone 수, Solver 방식은 실제 Runtime Probe 후 확정한다.

### Asymmetrical waist panel

- 허리 Root 1개와 하단 1-2개 보조 Bone을 우선 검토한다. 좌우로 긴 천을 추가하지 않는다.
- 허벅지와 Fang Holster의 전면을 통과하지 않도록 Cone limit와 Collision capsule을 둔다.
- Run에서 뒤로 젖고 Idle에서 빠르게 원위치하되, 골반 실루엣을 가리는 큰 진폭은 금지한다.

## 8. Motion notes

| Motion | Luna read | Mandatory protection |
|---|---|---|
| Idle | 낮은 호흡, 작은 체중 이동, 센서 귀의 비동기 미세 Scan | 얼굴과 두 눈, Fang 두 개가 계속 보여야 함 |
| Locomotion | 낮은 중심, 짧고 민첩한 보폭, Cable은 뒤로 정렬 | 부츠가 지면을 미끄러지지 않고 패널이 다리를 통과하지 않음 |
| Scan | Scanner를 몸 앞에 열고 센서 귀가 같은 목표로 수렴 | Scanner, 눈, Sensor 세 점의 시선축이 읽힘 |
| Light attack | 짧은 Fang Arc, 팔보다 골반-흉곽 회전으로 힘 전달 | 손목 꺾임과 자기 몸 관통 금지 |
| Dodge | 상체를 낮추고 Cable/Panel 진폭 Clamp | 센서 귀와 Pack이 지면 또는 벽을 뚫지 않음 |
| Hit / recover | 얼굴 가림을 짧게, 빠른 균형 회복 | 유아형 과장 Bounce와 과도한 전신 흔들림 금지 |

## 9. Quarter-view priorities

1. **Gameplay front 3/4:** 얼굴 두 눈, 센서 귀 2개, 가슴-허리-골반 리듬, Fang 쌍이 동시에 읽혀야 한다.
2. **Gameplay rear 3/4:** 비대칭 Hair, Pack, Cable Root, Probe tip, 허리 패널 1개의 겹침 순서를 증명한다.
3. **Side:** 후드 깊이, 가슴과 골반의 전후 부피, Pack 두께, 낮은 Boot heel을 확인한다.
4. **Rear:** 센서 귀 Hinge, Pack 장착면, Cable 출구, Hair/Collar 경계를 확인한다.
5. **Top-biased battle camera:** 얼굴이 완전히 가려지지 않고 Cyan 기능점과 Fang 윤곽이 배경에서 분리돼야 한다.

다음 Gate에는 동일한 5.39H 비율로 front/rear/side/rear-3/4 Blockout Capture, Humanoid T-pose,
Fang 장착/수납 Pose, Scan Pose, Run/Dodge Physics Probe가 필요하다.

## 10. Pending actual Mesh / ART-2001 budget

다음 수치는 현재 이미지로 확정할 수 없으므로 모두 `Pending`이다.

- LOD0/LOD1/LOD2 Triangle과 Vertex 예산
- 실제 Material Slot과 Texture Set 수, Texture 해상도 및 Memory
- Humanoid, Face, Hair, Hood, Panel, Cable을 포함한 Bone 수
- BlendShape 수와 Runtime Facial 방식
- 투명 Hair Card와 Overdraw 허용량
- Physics Solver, Collider 수, Update Rate와 Android 성능 비용
- Skin Weight 수, Corrective Shape 필요량, Draw Call

ART-2001 Character Proof에서 실제 메시와 Rig를 만든 뒤 Android 목표 기기 Capture와 Unity Profiler
근거로 위 항목을 확정한다. 그 전까지 본 문서는 `REVIEW`, 사람 판정은 `Pending`, 승인은
`NOT GRANTED` 상태를 유지한다.
