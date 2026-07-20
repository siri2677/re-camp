# Re:Camp Character 3D Spec

> 상태: Review  
> 승인 조건: 루나 Blockout·Coplay/Aura Import·고정 쿼터뷰·Windows 성능 검증

## 1. 목표

```text
3D 5~6등신 스타일라이즈드 캐릭터
+ 고정 쿼터뷰의 명확한 실루엣
+ 2D 대표 일러스트와 동일한 캐릭터 인상
+ 공용 Humanoid Rig·Shader·Prefab
+ Windows 우선 품질
+ Android 확장 가능한 LOD·Texture·Physics
```

## 2. 좌표와 단위

- Unity 1 Unit = 1m
- Up Axis: Y
- Forward: +Z 결과 확인
- 발바닥 중심을 원점으로 사용
- Transform Apply 후 Export
- Unity Prefab Scale `(1,1,1)`
- 캐릭터 높이 초기 기준: 1.45m~1.65m

캐릭터별 키 차이는 허용하되 공용 Animation Retargeting을 방해할 정도로 비율을 바꾸지 않는다.

## 3. 비율

| 항목 | 기준 |
|---|---|
| 등신 | 5~6등신 |
| 머리 | 실사보다 크게, SD처럼 과장하지 않음 |
| 손 | 무기와 상호작용이 보이도록 약간 강조 |
| 발 | 이동 실루엣이 안정적으로 보이도록 약간 강조 |
| 상체 | 쿼터뷰에서 얼굴·상체 장비가 읽히는 비율 |
| 무기 | 현실 비율보다 10~25% 강조 가능 |

금지:

- 3~4등신 치비·SD 인게임 비율
- 머리가 몸의 절반에 가까운 과장
- Camera 기본 거리에서 무기와 역할이 보이지 않는 현실 비율 고집

## 4. 폴리곤 예산

캐릭터 1명과 기본 장비 포함 초기 목표:

| LOD | Triangle | 사용 |
|---|---:|---|
| LOD0 | 35k~60k | Character Select·Lobby·근접 연출 |
| LOD1 | 18k~35k | 전투 기본 |
| LOD2 | 8k~15k | 먼 거리·Android Low |
| Shadow Proxy | 3k~8k | 필요 시 그림자 전용 |

- 얼굴·헤어·손·대표 장비에 우선 배분
- 보이지 않는 내부 면 제거
- 작은 장식은 Normal·Texture로 대체
- 쿼터뷰에서 보이지 않는 장식 삭제

## 5. Mesh 구성

권장:

```text
Body
Face
Eyes
Hair
Outfit
Equipment
```

분리 유지가 필요한 경우:

- 얼굴 BlendShape
- 눈 깜빡임·시선
- 교체 가능한 무기
- 별도 물리 파츠
- 다른 Shader가 필요한 파츠

최종 Draw Call을 줄일 수 있는 결합 여부를 Character Proof에서 검토한다.

## 6. Material 예산

| 항목 | Slot |
|---|---:|
| 얼굴·피부 | 1 |
| 눈 | 1 |
| 헤어 | 1 |
| 의상·신체 | 1~2 |
| 장비·Emission | 1 |
| 전체 | 4~6 이하 목표 |

작은 파츠는 Texture Atlas와 공유 Material을 우선한다.

## 7. Texture

| 용도 | Source | Unity |
|---|---:|---:|
| 얼굴·신체·주요 의상 | 2048 | 1024~2048 |
| 헤어 | 2048 | 1024~2048 |
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

- Base Color·Emission: sRGB
- Normal·Mask: Linear
- Android에서는 Mask 채널 통합과 Max Size Override를 우선

## 8. 툰 셰이딩

- 얼굴 그림자를 최소화하고 인상을 우선
- 1~2단 명암
- Outline은 거리 보정 적용
- Rim Light는 배경 분리에 제한 사용
- Emission은 무기·장비·Skill 활성 상태에 사용
- 환경보다 캐릭터 명도·채도 대비를 높게 유지
- Windows High와 Android Low에서 같은 캐릭터 인상이 유지되어야 함

## 9. Rig

- Unity Humanoid Avatar 호환
- 공용 T-Pose 또는 A-Pose
- 캐릭터 간 Bone 이름·계층 통일
- Root Bone 명확히 분리
- 기본 이동 In-place
- Root Motion은 특정 연출·Skill에만 사용

초기 Bone 목표:

| 구분 | 목표 |
|---|---:|
| Humanoid + Twist | 65~85 |
| 얼굴 | 10~25 |
| 헤어·의상 Physics | 10~30 |
| 전체 | 120 이하 |

Physics Bone은 High / Medium / Off로 단계 조정 가능해야 한다.

## 10. 얼굴·표정

필수:

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

- 실제 사용하는 BlendShape 중심
- 초기 목표 20개 이하
- Lobby 고품질 얼굴과 Battle 경량 얼굴 분리 가능
- Camera 기본 거리에서 표정이 안 보이는 경우 과도한 BlendShape 추가 금지

## 11. Physics와 관통

- 헤어·의상 Physics는 대표 파츠에만 적용
- 팔·무기·몸통과 자주 충돌하는 장식은 디자인 단계에서 단순화
- Collider 수 최소화
- High / Medium / Off 품질 단계
- Physics를 꺼도 실루엣이 무너지지 않아야 함

## 12. LOD와 Culling

- 모든 플레이어 캐릭터에 LODGroup
- 전투 기본 거리는 LOD1 기준 검수
- 거리별 얼굴 표정·Physics·추가 그림자 감소
- LOD 전환 후 머리·무기·대표 실루엣 유지
- Android Low에서 LOD2 사용 가능

## 13. Export

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

## 14. Coplay / Aura Import Proof

### Coplay

- FBX Import Property
- Material·Texture 연결
- Prefab Hierarchy
- Animator·Collider·Socket
- Scene 배치

### Aura

- Scale·Axis·Rig·Avatar 검증
- Material·Animator·Prefab 누락 확인과 보완
- Missing Reference·Console Error

같은 FBX를 별도 테스트 폴더 또는 원복 후 비교하며 결과를 `ART-PIPE-0105~0107`에 기록한다.

## 15. Unity 검증

- Humanoid Avatar 오류 없음
- 발바닥과 지면 일치
- 공용 Idle·Run·Hit·Down 재생
- 손과 Weapon Grip 일치
- Default Camera에서 얼굴·헤어·대표 장비 식별
- 5~6등신이 치비로 보이지 않음
- LOD 전환이 자연스러움
- Material·Texture 누락 없음
- Windows Target FPS 확인
- Android Low 품질 확장 가능

## 16. 루나 Character Proof

통과 기준:

- 고양이 후드와 에너지 단검이 기본 Camera에서 즉시 식별
- 2D Approved 시트와 얼굴·헤어·의상 인상 일치
- LOD1에서 Attack·Dash·Skill·VFX 정상
- 손·무기·후드·재킷의 치명적 관통 없음
- Windows 목표 성능 유지
- Coplay와 Aura Import·Prefab 결과가 재현 가능
- 다른 캐릭터 Blockout을 시작할 공용 구조 승인
