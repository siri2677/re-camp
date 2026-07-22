# Re:Camp Unity Art Import Guide

이 문서는 Re:Camp 아트 자산을 Unity 6.3 LTS URP 프로젝트에 가져오고 Android용 Material·Animator·Prefab으로 구성하는 기준을 정의한다.

## 1. 프로젝트 기준

- Unity 6.3 LTS
- URP
- Color Space: Linear
- Visible Meta Files
- Asset Serialization: Force Text
- 1차 품질 기준: Android Landscape 실기기
- 개발·디버그 기준: Windows PC
- Unity 아트 자산: `Assets/_ReCamp/Art/`
- 제작 원본: `art_source/`

원본 `.blend`, PSD, Figma 원본, ComfyUI Workflow는 Unity `Assets/`에 넣지 않는다.

## 2. Unity 디렉터리

```text
Assets/_ReCamp/Art/
├── Characters/
│   ├── Models/
│   ├── Textures/
│   ├── Materials/
│   ├── Prefabs/
│   └── Portraits/
├── Environments/
├── Monsters/
├── Props/
├── UI/
├── VFX/
├── Shaders/
└── Animations/
```

## 3. Import 책임

### Unity Preset·Editor Script

반복 가능한 Import Property와 검증 규칙을 코드 또는 Preset으로 고정한다.

### Coplay MCP

- Import Preset 적용
- Material·Texture 연결
- Prefab Hierarchy 생성
- Animator·Collider·Socket·Reference 연결
- Android Test Scene 배치와 Batch 수정

### 수동 Unity·Android 검수

- Inspector Import 값
- Humanoid Avatar Configure
- Console Error·Warning
- Prefab Diff
- PlayMode Animation·Collider·Reference
- Android Camera 실루엣과 Material 미감
- APK의 LOD·Texture·Shader·Memory·Profiler

Aura AI는 Import·Prefab 파이프라인에서 제외한다.

## 4. Texture Import

### 3D Texture

| 항목 | 기준 |
|---|---|
| Texture Type | Default |
| sRGB | Base Color·Emission만 활성 |
| Mip Maps | 기본 활성 |
| Max Size | 512~2048, Android 표시 크기 기준 |
| Wrap | 반복 Texture는 Repeat, Atlas는 Clamp 검토 |
| Filter | Bilinear 기본 |
| Aniso | 바닥·긴 표면에 제한 적용 |

### Normal·Mask

- Normal은 `Normal map` Type
- Normal·Mask·Metallic/Roughness/AO는 Linear
- 채널 통합 Mask를 우선해 Texture 수를 줄임

### UI·2D Illustration

| 항목 | 기준 |
|---|---|
| Texture Type | Sprite (2D and UI) |
| Sprite Mode | Single 또는 Multiple |
| Mip Maps | 일반 UI 비활성 |
| Wrap | Clamp |
| Alpha Is Transparency | 활성 |
| 9-Slice | Panel·Touch Button에 Border 설정 |

## 5. 초기 해상도

| 용도 | Unity Max Size |
|---|---:|
| 캐릭터 전신 Illustration | 2048 |
| Portrait | 1024 |
| Character Card | 1024 |
| Skill·Item Icon | 256~512 |
| Battle HUD Icon | 128~256 |
| Full Screen Background | 2048 |
| 9-Slice Panel | 512~1024 |
| 3D Character Main Texture | 1024 중심, 선택 화면 일부 2048 |
| Prop Texture | 512~1024 |

## 6. 플랫폼 압축

### Android

- ASTC 우선 검토
- 얼굴·UI는 높은 품질 Block Size
- 환경·반복 소품은 더 강한 압축 허용
- Alpha 필요 Texture 분리
- Low·Medium·High Override를 실기기에서 확정
- APK Size·Runtime Memory를 함께 확인

### Windows Debug Build

- BC 계열 기본 압축
- 1920×1080 아트 검수와 포트폴리오 촬영
- Android Override 결과를 대체하지 않음

## 7. FBX Model Import

| 항목 | 기준 |
|---|---|
| Scale Factor | 1 |
| Forward | +Z 결과 확인 |
| Up | Y |
| Transform | Export 전 Apply |
| BlendShapes | 얼굴 모델만 활성 |
| Cameras / Lights | 비활성 |
| Mesh Compression | Off 또는 Low부터 검증 |
| Read / Write | 런타임 수정 필요 시만 |
| Generate Colliders | 사용하지 않음 |
| Embedded Texture | 사용하지 않음 |

## 8. Rig·Animation

### Rig

- 플레이어 캐릭터: Humanoid
- 몬스터: Humanoid 또는 Generic
- 소품: None
- 공용 Avatar 재사용 검토
- T-Pose/A-Pose와 Bone Mapping 검증

### Animation

- Model FBX와 Animation FBX 분리
- 기본 이동 In-place
- Loop Time·Loop Pose 검수
- Root Transform을 코드 이동 방식과 일치
- 불필요한 Scale Curve 제거
- Compression 이후 손·발·무기 변형 확인

## 9. Material 구조

```text
Face
Eyes
Hair
Body / Outfit
Equipment / Emission
```

- Embedded Material 최종 사용 금지
- Unity Material 명시적 생성
- 공용 Toon Shader Variant 최소화
- 캐릭터 차이는 Texture와 Material Property로 표현
- Outline·Rim·Emission 공용 범위 사용
- 환경보다 캐릭터 명도·채도 대비를 높게 유지
- Android Low에서도 얼굴과 무기 인상 유지

## 10. 캐릭터 Prefab 표준

```text
CHR_Luna_Prefab
├── VisualRoot
│   ├── Model
│   ├── WeaponSockets
│   ├── VFXSockets
│   └── PhysicsParts
├── GameplayRoot
│   ├── CharacterController
│   ├── Hurtbox
│   └── GroundCheck
├── Presentation
│   ├── Animator
│   ├── AudioSource
│   └── CharacterView
└── Debug
```

- 게임 규칙을 Prefab에 중복 구현하지 않음
- 공용 Base Prefab 또는 구성 규칙 사용
- Collider·Hitbox는 Visual Mesh와 분리
- 무기·VFX·Sound는 Socket과 Data Reference로 연결

## 11. 공용 Socket

```text
Socket_Weapon_R
Socket_Weapon_L
Socket_Muzzle
Socket_VFX_Hand_R
Socket_VFX_Hand_L
Socket_VFX_Body
Socket_VFX_Foot
Socket_CameraFocus
```

## 12. LOD·Physics

- 캐릭터 Prefab에 LODGroup 구성
- Android 전투 기본 거리는 LOD1
- LOD 전환 후 머리·무기·실루엣 유지
- Low 품질에서 BlendShape·물리 Bone·그림자 감소
- Physics 품질 High / Medium / Off
- 관통이 잦은 작은 장식은 디자인 단계에서 단순화

## 13. UI·Sprite Atlas

```text
UI_Common
UI_Lobby
UI_Battle
UI_Result
UI_Camp
Icons_Skills
Icons_Resources
```

- 대형 일러스트와 작은 Icon을 같은 Atlas에 넣지 않음
- UI Text를 이미지에 포함하지 않음
- 선택·비활성·위험을 색상만으로 전달하지 않음
- Safe Area·DPI·Touch Target·화면비를 우선
- Windows Focus는 Debug Adapter로 유지

## 14. VFX Import

- 캐릭터별 색상·형태 언어 유지
- Particle Texture Atlas 우선
- 큰 반투명 Overdraw 제한
- 적 위험 장판과 캐릭터 VFX 혼동 금지
- VFX Pooling 사용
- Low·Medium·High에서 Particle·Trail·Distortion·Light 차등

## 15. Coplay Import·Prefab Proof

```text
1. Blender 테스트 FBX·Texture 준비
2. 깨끗한 테스트 폴더 생성
3. Coplay로 Import·Material·Prefab·Android Test Scene 구성
4. Unity Console·Prefab Diff·Screenshot 기록
5. Validation Tool 실행
6. Inspector·Avatar·PlayMode 수동 QA
7. Android APK 실기기 확인
8. 반복 규칙을 Preset 또는 Editor Script로 승격
```

작업 ID:

- `ART-PIPE-0105`: Coplay Proof
- `ART-PIPE-0106`: Import Preset·Validation Tool
- `ART-PIPE-0107`: Android 실기기 Art QA

## 16. Import Validation Tool

자동 적용 후보:

- FBX Model·Rig·Animation 설정
- Texture Type·sRGB·Max Size·Compression
- Material 생성·Texture 연결
- Prefab 기본 Hierarchy

자동 검사:

```text
파일명·경로
Scale Factor·Axis
Rig Type·Avatar
Material·Texture Missing
Prefab 표준 Hierarchy
필수 Component
Collider·Hitbox·Socket
Animator Controller
LODGroup
Missing Script·Reference
Android Texture Override
```

선택 Asset 또는 폴더 단위로 실행하고 Text·JSON Report를 저장한다.

## 17. 루나 Blockout 절차

```text
Approved 2D Sheet
→ Blender 5~6등신 Blockout
→ Coplay Import·Prefab
→ Validation Tool
→ Windows PlayMode 검수
→ Android APK 배치
→ 후드·단검·상체 식별성 확인
→ Low·Medium·High 비교
→ 수정 목록 승인
```

## 18. 사람 검수 필수

- 얼굴과 캐릭터 매력
- Toon Material 미감
- 5~6등신 비율
- Android 쿼터뷰 실루엣
- 손·무기·의상 관통
- 공격 가독성과 타격감
- Touch UI와 손가락 가림
- APK 성능·Memory·발열

## 19. 완료 체크리스트

- 원본과 Export 분리
- 파일명 규칙 준수
- Import Property 재현 가능
- Material·Texture Reference 정상
- Humanoid Avatar 정상
- Animator·Clip 정상
- Prefab Hierarchy와 Socket 정상
- Coplay 실행 기록
- Validation Report
- Android APK 실기기 QA 기록
- 모바일 쿼터뷰에서 역할과 무기 식별
- 기준 기기 30 FPS 또는 수정 계획
- Backlog와 Commit·PR 연결
