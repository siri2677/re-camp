# Re:Camp Unity Art Import Guide

이 문서는 Re:Camp 아트 자산을 Unity 프로젝트에 가져오고 Prefab·Material·Animator로 구성하는 초기 기준을 정의한다.

## 1. 기본 프로젝트 기준

- Unity LTS 사용
- URP 기반 렌더링
- Color Space: Linear
- Visible Meta Files 활성화
- Asset Serialization: Force Text
- 모바일 우선 품질 설정
- 아트 자산은 `Assets/_ReCamp/Art/` 아래에서 관리

## 2. Unity 아트 디렉터리

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

원본 `.blend`, PSD, Figma 원본, ComfyUI Workflow는 Unity `Assets/`에 넣지 않는다.

## 3. Texture Import 공통 규칙

### 캐릭터·환경 3D Texture

| 항목 | 기준 |
|---|---|
| Texture Type | Default |
| sRGB | Base Color/Emission만 활성화 |
| Alpha Source | 필요한 Texture만 활성화 |
| Generate Mip Maps | 기본 활성화 |
| Max Size | 512~2048, 용도별 결정 |
| Wrap Mode | 일반 Texture는 Repeat, Atlas는 Clamp 검토 |
| Filter Mode | Bilinear 기본 |
| Aniso Level | 환경 바닥·긴 표면만 선택 적용 |

### Normal Map

- Texture Type을 `Normal map`으로 지정한다.
- Normal 품질 저하가 눈에 띄면 플랫폼 압축을 별도 조정한다.
- 잘못된 색상 공간으로 Import되지 않았는지 확인한다.

### UI와 2D 일러스트

| 항목 | 기준 |
|---|---|
| Texture Type | Sprite (2D and UI) |
| Sprite Mode | Single 또는 Multiple |
| Mesh Type | Full Rect 기본, 필요한 경우 Tight |
| Pixels Per Unit | UI에서는 기본값 유지, 월드 Sprite는 프로젝트 공통값 사용 |
| Generate Mip Maps | 일반 UI는 비활성화 |
| Wrap Mode | Clamp |
| Alpha Is Transparency | 활성화 |

## 4. 이미지 용도별 초기 해상도

| 용도 | Unity Max Size 초기값 |
|---|---:|
| 캐릭터 전신 일러스트 | 2048 |
| 캐릭터 초상화 | 1024 |
| 캐릭터 선택 카드 | 1024 |
| 스킬·아이템 아이콘 | 256 또는 512 |
| 전투 HUD 아이콘 | 128 또는 256 |
| 전체 화면 배경 | 2048 |
| 9-Slice 패널 | 512 또는 1024 |
| 3D 캐릭터 주요 Texture | 1024 또는 2048 |
| 소형 소품 Texture | 512 또는 1024 |

원본은 더 크게 보관할 수 있으나 빌드용 Import 크기는 실제 표시 크기를 기준으로 제한한다.

## 5. 플랫폼 압축 초기 기준

### Android/iOS

- ASTC를 우선 검토한다.
- 캐릭터 얼굴·UI는 높은 품질 블록 크기를 사용한다.
- 환경과 반복 소품은 더 강한 압축을 허용한다.
- Alpha가 필요한 Texture와 불필요한 Texture를 분리한다.

### PC

- 플랫폼 기본 BC 계열 압축을 사용한다.
- 캐릭터 얼굴, UI, Normal Map은 품질 손실을 별도 확인한다.

플랫폼별 Override 값은 실제 기기 테스트 후 확정한다.

## 6. FBX Import 기준

### Model

| 항목 | 기준 |
|---|---|
| Scale Factor | 1 |
| Convert Units | 결과를 확인해 일관되게 적용 |
| Import BlendShapes | 얼굴·표정 모델만 활성화 |
| Import Visibility | 비활성화 권장 |
| Import Cameras/Lights | 비활성화 |
| Mesh Compression | Off 또는 Low부터 검증 |
| Read/Write | 런타임 수정이 필요한 경우만 활성화 |
| Optimize Mesh | 기본 활성화 검토 |
| Generate Colliders | 사용하지 않고 별도 구성 |

### Rig

- 플레이어블 캐릭터: Humanoid
- 일반 몬스터: Humanoid 또는 Generic
- 장비·소품: None
- 공용 Avatar 재사용 여부를 확인한다.
- Avatar Configure에서 필수 Bone 매핑과 T-Pose를 검증한다.

### Animation

- 모델 FBX와 Animation FBX를 분리한다.
- Loop Clip은 Loop Time과 Loop Pose를 검수한다.
- Root Transform 설정은 In-place 이동 방식과 맞춘다.
- 불필요한 Curve와 Scale Animation은 제거한다.

## 7. Material 구성

권장 Material 분리:

```text
Face
Eyes
Hair
Body/Outfit
Equipment/Emission
```

- Embedded Material을 최종 기준으로 사용하지 않는다.
- Unity Material을 명시적으로 생성하고 Texture를 연결한다.
- 캐릭터 공용 Shader Variant 수를 최소화한다.
- 캐릭터별 차이는 Material Property와 Texture로 표현한다.
- 발광 강도, Outline 두께, Rim Light는 공용 범위를 사용한다.

## 8. 캐릭터 Prefab 표준 구조

```text
CHR_Luna_Prefab
├── VisualRoot
│   ├── Model
│   ├── WeaponSocket
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

원칙:

- 게임 규칙은 캐릭터 Prefab 내부에 중복 구현하지 않는다.
- 캐릭터별 Prefab은 공용 Base Prefab 또는 공용 구성 규칙을 사용한다.
- 무기·VFX·사운드는 Socket과 데이터 참조로 연결한다.
- Collider와 Hitbox는 Visual Mesh와 분리한다.

## 9. Socket 기준

최소 Socket:

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

캐릭터별 임의 이름을 만들지 않고 공용 이름을 우선 사용한다.

## 10. LODGroup 기준

- 캐릭터 Prefab에 LODGroup을 구성한다.
- 전투 기본 카메라에서는 LOD1 품질을 기준으로 검수한다.
- LOD 전환 시 머리·무기·대표 실루엣이 유지되어야 한다.
- 저사양 품질에서는 얼굴 BlendShape, 물리 Bone, 추가 그림자를 단계적으로 줄인다.

정확한 전환 비율은 실제 쿼터뷰 카메라 확정 후 조정한다.

## 11. UI Import와 9-Slice

- 둥근 패널과 버튼은 9-Slice Border를 설정한다.
- 아이콘과 프레임을 하나의 이미지에 과도하게 합치지 않는다.
- 반복 사용 아이콘은 Sprite Atlas로 묶는다.
- UI Text는 이미지에 포함하지 않고 Unity UI Text로 관리한다.
- 선택·비활성·위험 상태는 색상만이 아니라 외곽선·아이콘·명도 차이도 함께 사용한다.

## 12. Sprite Atlas 기준

권장 Atlas:

```text
UI_Common
UI_Lobby
UI_Battle
UI_Result
UI_Character
Icons_Skills
Icons_Items
```

- 서로 다른 화면에서 동시에 사용되지 않는 자산은 Atlas를 분리한다.
- 대형 전신 일러스트와 작은 UI 아이콘을 같은 Atlas에 넣지 않는다.
- 플랫폼별 Max Size와 압축 결과를 확인한다.

## 13. VFX Import 기준

- 캐릭터별 색상 언어를 유지한다.
- Particle Texture는 작은 Atlas로 묶는 것을 우선한다.
- Overdraw가 큰 반투명 Particle을 제한한다.
- VFX가 캐릭터 얼굴, 적, 위험 바닥 표시를 가리지 않도록 한다.
- 모바일 품질에서 Particle 수, Trail 길이, Distortion을 낮출 수 있어야 한다.

## 14. Import 검증 순서

```text
파일명과 경로 확인
→ Texture/FBX Import 설정
→ Material 생성
→ Model과 Avatar 확인
→ Animation 확인
→ Prefab 구성
→ 쿼터뷰 Scene 배치
→ LOD·물리·VFX 확인
→ 실제 기기 성능 확인
→ Review 결과 기록
```

## 15. Coplay/Aura 또는 Unity MCP 자동화 범위

자동화하기 좋은 작업:

- 폴더 생성
- Import Preset 적용
- Material 생성과 Texture 연결
- Prefab 계층 생성
- Animator Controller 연결
- Collider·Socket 존재 여부 검사
- 누락 참조와 Console 오류 확인
- 테스트 Scene 배치와 스크린샷 저장

사람의 최종 검수가 필요한 작업:

- 얼굴과 캐릭터 매력
- Material 미감
- 쿼터뷰 실루엣
- 물리 관통
- 공격 가독성과 타격감
- 모바일 화면의 UI 가독성

## 16. 완료 체크리스트

- 소스 파일과 Export 파일이 분리되어 있는가
- 파일명 규칙을 지키는가
- Import 설정이 용도와 플랫폼에 맞는가
- Material과 Texture 참조가 누락되지 않았는가
- Humanoid Avatar와 공용 애니메이션이 정상인가
- Prefab 계층과 Socket 이름이 공통 규칙과 일치하는가
- 쿼터뷰에서 캐릭터 역할과 무기가 식별되는가
- 실제 기기에서 메모리와 프레임 문제가 없는가
- 승인 상태와 결과 경로가 Backlog에 기록되었는가
