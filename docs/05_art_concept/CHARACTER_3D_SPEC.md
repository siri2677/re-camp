# Re:Camp Character 3D Spec

> 상태: Review  
> 승인 조건: 루나 Blockout·Coplay Import·Validation Tool·Android 고정 쿼터뷰·실기기 성능 검증

## 1. 목표

```text
3D 5~6등신 스타일라이즈드 캐릭터
+ Android Landscape 고정 쿼터뷰의 명확한 실루엣
+ 2D 대표 일러스트와 동일한 인상
+ 공용 Humanoid Rig·Shader·Prefab
+ Android LOD1 전투 기준
+ Low·Medium·High 품질 단계
```

## 2. 좌표와 단위

- Unity 1 Unit = 1m
- Up Axis: Y
- Forward: +Z 결과 확인
- 발바닥 중심 원점
- Transform Apply 후 Export
- Unity Prefab Scale `(1,1,1)`
- 캐릭터 높이 초기 기준: 1.45m~1.65m

## 3. 비율

| 항목 | 기준 |
|---|---|
| 등신 | 5~6등신 |
| 머리 | 실사보다 크게, SD처럼 과장하지 않음 |
| 손 | 무기 상호작용이 보이도록 약간 강조 |
| 발 | 이동 실루엣이 안정적으로 보이도록 강조 |
| 상체 | 모바일 쿼터뷰에서 얼굴·장비가 읽히는 비율 |
| 무기 | 현실 비율보다 10~25% 강조 가능 |

금지:

- 3~4등신 치비·SD 비율
- 머리가 몸의 절반에 가까운 과장
- Android 기본 거리에서 무기와 역할이 보이지 않는 현실 비율 고집

## 4. 폴리곤 예산

| LOD | Triangle | 사용 |
|---|---:|---|
| LOD0 | 35k~60k | Character Select·Lobby·근접 연출 |
| LOD1 | 18k~35k | Android 전투 기본 |
| LOD2 | 8k~15k | Low Profile·먼 거리 |
| Shadow Proxy | 3k~8k | 필요 시 그림자 전용 |

- 얼굴·헤어·손·대표 장비 우선
- 보이지 않는 내부 면 제거
- 작은 장식은 Normal·Texture로 대체
- 모바일 쿼터뷰에서 안 보이는 장식 삭제

## 5. Mesh·Material

권장 Mesh:

```text
Body
Face
Eyes
Hair
Outfit
Equipment
```

Material 목표:

| 항목 | Slot |
|---|---:|
| 얼굴·피부 | 1 |
| 눈 | 1 |
| 헤어 | 1 |
| 의상·신체 | 1~2 |
| 장비·Emission | 1 |
| 전체 | 4~6 이하 |

## 6. Texture

| 용도 | Source | Android 기본 |
|---|---:|---:|
| 얼굴·신체·주요 의상 | 2048 | 1024 중심 |
| 헤어 | 2048 | 1024 중심 |
| 무기·대표 장비 | 1024~2048 | 1024 |
| 소형 장식 | 512~1024 | 512 |
| 눈 | 512~1024 | 512 |

기본 맵:

```text
Base Color
Normal
Mask Map
Emission Mask
Face Shadow / SDF Map 사용 시
```

Character Select에서 필요할 때만 일부 Texture 2048을 허용한다.

## 7. 툰 셰이딩

- 얼굴 그림자를 최소화하고 인상 우선
- 1~2단 명암
- Outline 거리 보정
- Rim Light는 배경 분리에 제한 사용
- Emission은 무기·장비·Skill 활성 상태에 사용
- 환경보다 캐릭터 명도·채도 대비를 높게 유지
- Android Low에서도 동일한 캐릭터 인상 유지
- 투명 Overdraw와 Shader Variant 최소화

## 8. Rig

- Unity Humanoid Avatar 호환
- 공용 T-Pose 또는 A-Pose
- Bone 이름·계층 통일
- Root Bone 분리
- 기본 이동 In-place
- Root Motion은 특정 연출·Skill에만 사용

초기 Bone 목표:

| 구분 | 목표 |
|---|---:|
| Humanoid + Twist | 65~85 |
| 얼굴 | 10~25 |
| 헤어·의상 Physics | 10~30 |
| 전체 | 120 이하 |

## 9. 얼굴·표정

```text
Blink L/R
Eye Look
Smile
Angry
Sad
Surprised
Serious
Embarrassed
Mouth A/I/U/E/O 또는 최소 발화 Set
```

- 초기 BlendShape 20개 이하
- Lobby 고품질 얼굴과 Battle 경량 얼굴 분리 가능
- 전투 기본 거리에서 보이지 않는 표정을 과도하게 추가하지 않음

## 10. Physics·LOD

- 대표 헤어·의상 파츠에만 Physics 적용
- Collider 수 최소화
- High / Medium / Off 품질 단계
- Physics를 꺼도 실루엣 유지
- 모든 플레이어 캐릭터에 LODGroup
- 전투 기본 거리는 LOD1 기준
- Android Low에서 LOD2 사용 가능

## 11. Export

```text
Format: FBX
Scale: 1.0
Axis: Y Up / +Z Forward 결과 확인
Apply Transform: Yes
Triangulate: 한 단계에서 일관 적용
Animation: Model과 분리 Export
Embedded Texture: No
Material: Unity에서 재구성
```

## 12. Coplay Import·Prefab Proof

- FBX Import Property 적용
- Material·Texture 연결
- Prefab Hierarchy 생성
- Animator·Collider·Socket 구성
- Android Test Scene 배치

작업 ID: `ART-PIPE-0105`, `ART-3D-2005`

## 13. Validation Tool·Android QA

자동 검사:

```text
Scale Factor·Axis
Rig Type·Avatar
Material·Texture Missing
Prefab Hierarchy
필수 Component
Collider·Hitbox·Socket
Animator Controller
LODGroup
Missing Script·Reference
```

수동 확인:

- Inspector Import 값
- Avatar Configure
- Console Error·Warning
- Prefab Diff
- PlayMode Animation·Collider
- Android Default Camera 실루엣
- APK Material·LOD·Physics
- Profiler·Memory·발열

작업 ID: `ART-PIPE-0106~0107`, `ART-3D-2006`

Aura AI는 필수 선행 조건에서 제외한다.

## 14. Unity·Android 검증

- Humanoid Avatar 오류 없음
- 발바닥과 지면 일치
- 공용 Idle·Run·Hit·Down 재생
- 손과 Weapon Grip 일치
- Android 기본 거리에서 얼굴·헤어·대표 장비 식별
- 5~6등신이 치비로 보이지 않음
- LOD 전환 자연스러움
- Material·Texture 누락 없음
- 기준 Android 기기 30 FPS 확인
- Low Profile에서 실루엣과 VFX 가독성 유지

## 15. 루나 Character Proof

- 고양이 후드와 에너지 단검 즉시 식별
- 2D Approved 시트와 얼굴·헤어·의상 인상 일치
- LOD1에서 Attack·Dash·Skill·VFX 정상
- 손·무기·후드·재킷 치명적 관통 없음
- Android 목표 성능·Memory·발열 기준 검증
- Coplay Import와 Validation·실기기 QA 재현 가능
- 다른 캐릭터 Blockout을 위한 공용 구조 승인
