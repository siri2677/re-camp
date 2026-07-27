# Re:Camp Asset Naming and Export Guide

이 문서는 `ART-0109`의 저장소 기준 산출물이다. 이미지·Figma·Blender 원본에서 FBX·Texture를
거쳐 Unity Prefab·Material·Animation·VFX로 연결될 때 사용하는 이름, 버전, 계층, Socket과
Export 추적 규칙을 정의한다.

디렉터리와 승인 상태의 의미는 `ART_ASSET_STRUCTURE.md`, 사람 판정과 증거는
`ART_REVIEW_CHECKLIST.md`, 캐릭터 외형은 `CHARACTER_BIBLE.md`와
`CHARACTER_ANCHOR_SPEC.md`가 소유한다. 이 문서는 그 내용을 복제하지 않고 **동일한 자산을
도구 사이에서 식별하는 계약**만 소유한다.

## 1. 범위와 상태

| 항목 | 값 |
|---|---|
| 작업 ID | `ART-0109` |
| 문서 상태 | `Active` |
| 규격 버전 | `v001` |
| 적용 시작일 | 2026-07-21 |
| 적용 대상 | 새로 만드는 아트 소스·검토본·Export·Unity 런타임 자산 |
| 비적용 대상 | 기존 Gray Box 자산의 즉시 일괄 이름 변경 |

이 규격의 도입 때문에 기존 Unity 자산을 탐색기에서 대량 변경하지 않는다. 기존 GUID를 유지할
필요가 있는 이름 변경과 이동은 Unity Editor 안에서 수행한다. 현재 `M_BattleGround.mat` 등의
`M_` Material은 Gray Box 레거시이며, 출시 자산으로 교체할 때 `MAT_` 규칙으로 전환한다.

## 2. 단일 이름 구성 원칙

### 2.1 허용 문자와 구분

- 아트 파일명과 Blender→FBX→Unity로 전달되는 Art Node·Socket 이름은 영문 ASCII, 숫자,
  `_`만 사용한다.
- 공백, 한글, 하이픈, 괄호, 개인 이름, 날짜를 파일명에 넣지 않는다.
- 의미 단위는 `PascalCase`, 필드 경계는 `_`로 구분한다.
- 확장자는 도구가 생성한 표준 소문자를 유지한다.
- 번호는 자릿수를 고정한다. 버전은 `v001`, 연속 동작은 `01`, LOD는 `LOD0` 형식이다.
- 약어는 이 문서의 사전에 있는 것만 사용한다. 새 약어는 가이드와 함께 추가한다.
- `final`, `final2`, `new`, `copy`, `temp`, `test01`로 상태나 버전을 대신하지 않는다.

### 2.2 고정 식별자

| 범위 | 허용 식별자 |
|---|---|
| 캐릭터 | `Luna`, `Miyu`, `Coco`, `Iris`, `Noah` |
| 제작 시트·metadata ID | `CH001`, `CH002`, `CH003`, `CH004`, `CH005` |
| 공용 | `Common` |
| 주요 환경 | `Camp`, `RuinedStreet`, `ContaminatedForest`, `AbandonedLab`, `MachineGraveyard` |
| 방향 | `F`, `B`, `L`, `R` |
| 좌우 | `L`, `R` |

캐릭터 식별자는 `Assets/_ReCamp/Scripts/Data/CharacterId.cs`와 철자·대소문자가 같아야 한다.
`CH001`~`CH005`는 제작 시트·metadata 필드용이며 파일명의 Subject를 대신하지 않는다. 표시용
한국어 이름이나 현지화 문자열도 파일명에 사용하지 않는다.

Unity의 고정 Scene `00_Bootstrap`~`04_Result`와 일반 Scene Hierarchy 이름은 이 아트 파일명
규격의 대상이 아니다. 특히 Build Settings의 Scene 이름을 `SCN_` 규칙으로 일괄 변경하지 않는다.

### 2.3 이름을 소유하는 단계

```text
버전이 있는 제작 원본
→ 상태와 버전이 있는 검토 Export
→ APPROVED 원본에서 만든 안정된 Runtime Export
→ 같은 이름과 GUID를 유지하는 Unity Asset
```

- 제작·검토 단계는 변경 이력을 보존하기 위해 상태와 버전을 이름에 넣는다.
- Unity 런타임 단계는 참조 안정성을 위해 상태·버전·날짜를 이름에서 제거한다.
- 런타임 파일의 실제 출처와 승인 버전은 이름이 아니라 metadata·review·import 기록으로 추적한다.
- WIP·REVIEW 파일을 최종 Runtime 경로에 복사하지 않는다. 기능 Blockout은 명시된 임시 폴더와
  Gray Box Material만 예외로 한다.

## 3. 상태와 버전

검토 자산에서 허용하는 상태는 다음 여섯 개뿐이다.

| 상태 | 사용 |
|---|---|
| `WIP` | 제작 중 |
| `REVIEW` | 사람 검토 대기·검토 중 |
| `APPROVED` | 사람이 명시적으로 승인 |
| `SUPERSEDED` | 새 승인본으로 대체 |
| `REJECTED` | 반려되어 제작 기준 재사용 금지 |
| `ARCHIVE` | 기록 보존만 수행 |

`APPROVED`는 사람의 Reviewer·Date·Decision 기록이 있을 때만 사용한다. 도구 생성 성공, 자동
검사 통과 또는 Codex 권고만으로 승격하지 않는다.

버전은 다음과 같이 올린다.

- 새 자산의 첫 저장은 `v001`이다.
- 형태·비율·색·UV·Rig·Animation·Export 결과가 달라지면 1 증가한다.
- 피드백 문구만 추가하고 바이너리가 같으면 원본 버전은 유지하고 `.review.md`를 갱신한다.
- 같은 바이너리의 상태가 바뀌어도 검토 증거는 기존 파일을 덮어쓰지 않는다. 새 상태 이름의
  Export와 review 기록을 만들고 이전 파일은 기록으로 유지한다.
- 버전 번호를 되돌리거나 누락 번호를 재사용하지 않는다.

## 4. 레퍼런스·2D 제작 이미지

### 4.1 파일 형식

```text
<Subject>_<AssetType>_<STATUS>_v###.<ext>
ReCamp_<Scope>_<AssetType>_<STATUS>_v###.<ext>
```

프로젝트 전체 방향 자료만 `ReCamp_`로 시작한다. 캐릭터·환경·소품별 자료는 고정 Subject로
시작한다.

```text
ReCamp_CharacterLineup_REVIEW_v003.png
ReCamp_CharacterSheet_Template_REVIEW_v001.svg
Luna_KeyArt_WIP_v001.png
Luna_Turnaround_REVIEW_v003.png
Luna_CharacterSheet_REVIEW_v001.pdf
Luna_Face128_REVIEW_v001.png
Miyu_CombatDrone_REVIEW_v002.png
RuinedStreet_ColorKey_WIP_v004.png
```

AssetType 사전:

```text
KeyArt
FullBody
Turnaround
ExpressionSheet
EquipmentSheet
MaterialPalette
ColorKey
SilhouetteTest
FaceReadabilityTest
Face128
CharacterSheet
GateEvidence
Portrait
Icon
```

띄어 쓴 명칭은 파일명에서 붙여 쓴다. 예: `Key Art` → `KeyArt`, `Color Key` → `ColorKey`.

### 4.2 동반 파일

원본 이미지와 같은 basename을 사용한다.

```text
Luna_KeyArt_REVIEW_v003.png
Luna_KeyArt_REVIEW_v003.metadata.md
Luna_KeyArt_REVIEW_v003.review.md
```

- `.metadata.md`: 도구·모델·입력 레퍼런스·사람 수정·사용 제한·출처를 기록한다.
- `.review.md`: Gate 체크 ID, Reviewer, Date, Decision과 수정 요청을 기록한다.
- metadata가 필요 없는 순수 수작업 자산도 Source 파일과 담당자를 review 또는 제작 기록에 남긴다.
- 파일명과 metadata 내부의 `Asset Name`, `Status`, `Version`은 같아야 한다.

### 4.3 Figma·벡터 내부 이름

Figma Page, Frame, Component는 아래 형식을 사용한다. `/`는 Figma 내부 계층 분류에서만
허용하는 예외이며 Export 파일명과 SVG `id`에는 사용하지 않는다.

```text
PAGE/<CharacterId>_<Subject>
FRAME/<NN>_<Purpose>
GROUP/<Purpose>
COMP/<Purpose>
```

SVG `id`는 같은 token의 `/`를 `_`로 바꾼다.

```text
FRAME_01_Identity_KeyArt
FRAME_02_Turnaround
```

캐릭터 제작 시트의 실제 Frame·Component 이름은 `CHARACTER_SHEET_TEMPLATE_SPEC.md`가
소유한다. Export 파일에는 상태와 버전을 붙이고, Page·Frame 내부 이름에는 붙이지 않는다.

## 5. 제작 원본

### 5.1 Blender 파일

```text
<Category>_<Subject>_<Purpose>_v###.blend
```

```text
CHR_Luna_Model_v001.blend
CHR_Luna_Rig_v002.blend
PRP_Luna_EnergyDagger_v003.blend
MON_Scrapper_Blockout_v002.blend
ENV_RuinedStreet_BuildingA_v001.blend
```

하나의 `.blend`가 여러 Runtime 파일을 내보내면 `<Purpose>`는 `Kit`, `Set`, `Rig`처럼 범위를
나타내고 Export 목록을 제작 기록에 명시한다.

### 5.2 Blender Collection·Object

| 종류 | 형식 | 예시 |
|---|---|---|
| Export Collection | `EXPORT_<RuntimeRoot>` | `EXPORT_CHR_Luna` |
| 작업 Collection | `SOURCE_<Purpose>` | `SOURCE_HighPoly` |
| 참고 Collection | `REFERENCE_<Purpose>` | `REFERENCE_Turnaround` |
| Armature Object | `RIG_<Subject>` | `RIG_Luna` |
| Mesh Object | `GEO_<Part>[_LOD#]` | `GEO_Hair_LOD0` |
| Collision Object | `COL_<Part>` | `COL_Body` |
| Locator·Socket | `Socket_<Purpose>[_L|R]` | `Socket_Weapon_R` |

`SOURCE_`와 `REFERENCE_` Collection은 Export에서 제외한다. Blender Object 이름이 FBX Node와
Unity Transform 이름으로 넘어갈 수 있으므로 `Cube.001`, `Armature.001`을 남기지 않는다.

### 5.3 Texture 제작 원본

편집 원본은 Runtime Texture와 같은 의미 이름 뒤에 버전을 붙인다.

```text
TEX_Luna_Face_BaseColor_v003.kra
TEX_Luna_Outfit_Mask_v002.psd
TEX_RuinedStreet_BuildingA_Normal_v001.psd
```

PSD·KRA·Substance·고해상도 원본은 `art_source/`에 두며 Unity `Assets/`로 복사하지 않는다.

## 6. Runtime 타입 접두사

| 접두사 | 용도 |
|---|---|
| `CHR` | 플레이어블 캐릭터·캐릭터 Visual Root |
| `MON` | 일반 몬스터·보스 |
| `ENV` | 환경 모듈·지형 구조물 |
| `PRP` | 장비·시설·상호작용 소품 |
| `UI` | UI Sprite·Prefab·UI Material |
| `VFX` | 시각 효과 Prefab·Graph |
| `MAT` | Material |
| `TEX` | 3D·VFX용 Texture |
| `ANM` | Animation Clip |
| `AC` | Animator Controller |
| `AOC` | Animator Override Controller |
| `AVT` | Avatar·Avatar Mask |
| `SO` | 아트 연결용 ScriptableObject |
| `SHD` | 프로젝트 전용 Shader·Shader Graph |

접두사는 파일 확장자를 반복하지 않는다. 예를 들어 `CHR_Luna_Model.fbx`는 허용하지만
`FBX_CHR_Luna.fbx`는 사용하지 않는다.

### 6.1 Unity 저장 경로

| 자산 | 기준 경로 |
|---|---|
| Model·Texture·Material·Animation | `Assets/_ReCamp/Art/<Category>/` |
| 캐릭터 Gameplay Prefab | `Assets/_ReCamp/Prefabs/Player/` |
| 적 Gameplay Prefab | `Assets/_ReCamp/Prefabs/Enemies/` |
| 시설·환경 Gameplay Prefab | `Assets/_ReCamp/Prefabs/Stage/` |
| 아이템 Prefab | `Assets/_ReCamp/Prefabs/Items/` |
| UI Prefab | `Assets/_ReCamp/Prefabs/UI/` |
| VFX Prefab | `Assets/_ReCamp/Art/VFX/` |
| 연결용 ScriptableObject | `Assets/_ReCamp/ScriptableObjects/<Category>/` |

`Art/`는 원본 제작 파일 보관소가 아니며 `.blend`, `.psd`, `.kra`를 넣지 않는다. Gameplay
Component와 Collider가 붙는 Prefab은 `Art/`가 아니라 기존 `Prefabs/` 루트에 둔다.

## 7. Unity Runtime 파일

Runtime 파일은 상태와 버전 없이 안정된 이름을 사용한다.

### 7.1 Model·Prefab·Avatar

```text
CHR_Luna_Model.fbx
CHR_Luna_Prefab.prefab
AVT_Luna.asset
MON_Scrapper_Model.fbx
MON_Scrapper_Prefab.prefab
ENV_RuinedStreet_BuildingA_Model.fbx
PRP_Luna_EnergyDagger_Model.fbx
PRP_Camp_Generator_Prefab.prefab
```

Prefab Variant는 역할을 마지막 필드에 붙인다.

```text
CHR_Luna_Prefab.prefab
CHR_Luna_Prefab_Lobby.prefab
CHR_Luna_Prefab_Battle.prefab
```

공통 원본 Prefab을 먼저 만들고 Scene별 차이가 실제로 필요할 때만 Variant를 추가한다.

### 7.2 Material·Texture

```text
MAT_<Subject>_<Part>.mat
TEX_<Subject>_<Part>_<Map>.<ext>
```

허용 Map suffix:

| suffix | 의미 | 기본 색 공간 |
|---|---|---|
| `BaseColor` | 기본 색·알파 | sRGB |
| `Normal` | Tangent-space Normal | Linear |
| `Mask` | Shader별 packed mask | Linear |
| `Emission` | 발광 색·마스크 | Shader 계약에 따름 |
| `FaceShadow` | 얼굴 음영 제어 | Linear |

`Mask` 채널 의미, 해상도, 압축과 Android Import 설정은 `CHARACTER_3D_SPEC.md` 또는 해당
Shader 규격에서 확정한다. 확정 전 파일명만 보고 채널 배치를 추정하지 않는다.

```text
MAT_Luna_Face.mat
MAT_Luna_Hair.mat
MAT_Luna_Outfit.mat
TEX_Luna_Face_BaseColor.png
TEX_Luna_Face_Normal.png
TEX_Luna_Outfit_Mask.png
TEX_Luna_Equipment_Emission.png
```

### 7.3 Animation·Animator

```text
ANM_<Common|Subject>_<Action>[_Variant].anim
AC_<Common|Subject>[_Purpose].controller
AOC_<Subject>.overrideController
```

```text
ANM_Common_Idle_Combat.anim
ANM_Common_Run_F.anim
ANM_Luna_Attack_01.anim
ANM_Luna_ScanPulse.anim
ANM_Luna_CrossFang.anim
ANM_Luna_Victory.anim
AC_Character_Common.controller
AOC_Luna.overrideController
```

외부 Animation Export FBX도 같은 stem을 사용한다. 예: `ANM_Luna_Attack_01.fbx`. Unity에서
Clip을 추출할 때만 같은 이름의 `.anim`을 만들고, Model FBX와 Animation FBX를 분리한다.

Action·State·Event의 최종 사전, 공용 Clip과 전용 Clip의 분리, Root Motion 여부는
`ANIMATION_GUIDE.md`가 소유한다. 그 문서가 생기기 전에도 `attack.anim`, `New Animation.anim`
같은 Subject 없는 이름은 금지한다.

### 7.4 VFX

```text
VFX_<Subject>_<Action>[_Part].prefab
```

```text
VFX_Luna_Attack01_Trail.prefab
VFX_Luna_CrossFang_Impact.prefab
VFX_Miyu_Drone_Muzzle.prefab
VFX_Coco_SafeZone_Area.prefab
VFX_Iris_FocusShot_Line.prefab
VFX_Noah_BarrierWall_Shield.prefab
```

색상 Variant만 다른 경우 캐릭터 이름을 생략하지 않는다. 다섯 캐릭터의 Character ID→VFX
참조가 자동 검사 가능해야 한다.

### 7.5 UI

```text
UI_<Screen>_<Element>[_State].png
UI_<Screen>_<Element>.prefab
```

허용 상태 사전은 `Normal`, `Hover`, `Focused`, `Selected`, `Pressed`, `Disabled`, `Locked`,
`Cooldown`이다.

```text
UI_Common_Button_Primary_Normal.png
UI_Common_Button_Primary_Pressed.png
UI_Battle_SkillFrame_Cooldown.png
UI_Character_Luna_Portrait.png
UI_Result_RewardCard.prefab
UI_Lobby_CharacterPanel.prefab
```

Android 밀도별 원본을 파일명에 `2x`, `3x`로 복제하지 않는다. Unity Sprite 해상도·Atlas·압축
규칙으로 관리하고, 실제로 별도 파일이 필요한 경우 UI 규격에 Variant 이름을 먼저 추가한다.

## 8. FBX Node·LOD·Socket 계약

### 8.1 좌표와 Transform 결과

도구별 Export 버튼 값보다 Unity Import 결과를 계약으로 사용한다.

- 단위는 `1 Unity unit = 1 m`다.
- Runtime Root의 Position·Rotation은 0, Scale은 1이어야 한다.
- 캐릭터가 바라보는 기준 전방은 Unity `+Z`, 위는 `+Y`다.
- 캐릭터 Root Pivot은 두 발 중앙의 지면, 소품 Pivot은 배치면·손잡이·힌지처럼 실제 조작
  기준에 둔다.
- Skinned Mesh, Rig, Socket 이름은 재Export 후에도 유지한다.
- 미러링된 음수 Scale과 이름 없는 중간 Transform을 Runtime 계층에 남기지 않는다.
- Camera·Light·Reference와 embedded Texture는 FBX에서 제외하고 필요한 Export 대상만 포함한다.

정확한 Humanoid Rig·Bone·Import Preset은 `CHARACTER_3D_SPEC.md`, Blender→FBX 실제 동작
검증은 `ART-0104`와 `ART-0105`가 소유한다.

### 8.2 LOD

```text
GEO_<Part>_LOD0
GEO_<Part>_LOD1
GEO_<Part>_LOD2
```

LOD 번호는 고해상도부터 0, 1, 2 순서다. 몇 단계가 필요한지와 Screen Relative Transition
Height는 성능 규격에서 확정한다. LOD가 하나뿐인 Blockout에는 임의로 `LOD0`을 붙이지 않아도
되지만 최종 LODGroup 자산은 모든 대응 Mesh의 번호를 맞춘다.

### 8.3 Socket

허용 이름:

```text
Socket_Weapon_R
Socket_Weapon_L
Socket_Grip_L
Socket_BladeTip
Socket_Muzzle
Socket_Scanner
Socket_Drone
Socket_Shield
Socket_VFXCenter
Socket_VFX_Hand_R
Socket_VFX_Hand_L
Socket_VFX_Body
Socket_VFX_Foot
Socket_CameraFocus
```

- 좌우가 있는 Socket만 `_L`, `_R`을 사용한다.
- `_L`, `_R`은 캐릭터가 바라보는 방향을 기준으로 한다.
- `Socket_Grip_L`은 Rifle·대형 장비 Prefab의 왼손 IK 보조 Grip이며 Character Hand Socket을
  대신하지 않는다.
- 동일 용도의 두 번째 Socket은 임의 번호를 붙이지 말고 실제 역할을 구분해 사전에 추가한다.
- Socket 축과 위치는 장비 시트의 표시와 같아야 한다.
- 캐릭터별로 쓰지 않는 Socket은 억지로 만들지 않되, 같은 용도에는 같은 이름을 사용한다.
- `Hitbox_Attack`, `Hurtbox_Body`, `GroundCheck`는 Runtime helper이며 Socket과 구분한다.

## 9. Export와 Unity Import 추적

### 9.1 Export 전 검사

- Source 파일명·내부 Subject·Export Collection의 Subject가 같다.
- Reference·Source Collection, 숨김 WIP, 개인 메모가 Export에 포함되지 않는다.
- Root Transform, 단위, 전방, Mesh·Rig·Socket 이름이 이 규격과 일치한다.
- Texture basename과 Material 슬롯의 Subject·Part가 같다.
- APPROVED Runtime 후보는 사람 승인 기록과 입력 원본 경로를 가진다.
- Blockout은 이름 또는 경로에서 Gray Box임을 분명히 하고 승인 자산 경로에 섞지 않는다.

### 9.2 Runtime 교체

```text
Source:  art_source/blender/luna/CHR_Luna_Model_v004.blend
Review:  art_refs/characters/luna/3d_reference/Luna_Model_APPROVED_v004.review.md
Runtime: Assets/_ReCamp/Art/Characters/Luna/Models/CHR_Luna_Model.fbx
Prefab:  Assets/_ReCamp/Prefabs/Player/CHR_Luna_Prefab.prefab
```

- Runtime 파일은 승인 버전이 바뀌어도 같은 경로·이름을 유지한다.
- 외부에서 새 `.meta`를 복사하지 않는다. 기존 파일 내용을 교체하거나 Unity Editor에서
  이동·이름 변경해 GUID를 보존한다.
- Model 재Import 뒤 Avatar, Material, Animation Clip, Prefab Override와 Socket 참조를 확인한다.
- Source·Review·Runtime 대응은 Gate C Import 기록에 남긴다.
- 승인 전 검증용 FBX는 `Assets/_ReCamp/Art/Blockout/`처럼 분리된 임시 경로를 사용하고 최종
  Character ID→Prefab 연결에는 넣지 않는다.

### 9.3 Export manifest

첫 FBX·Texture Export와 승인 버전 교체에는 다음 파일을 둔다.

```text
art_source/manifests/<Category>_<Subject>_Export_v###.md
```

필수 필드:

```text
Source:
Source Version:
Review Evidence:
Export Target:
Unity GUID:
Tool Version:
Export Date:
Unit / Forward / Up:
Included Nodes:
Excluded Nodes:
Reviewer:
Notes:
```

manifest는 `Assets/` 아래에 두지 않는다. Unity GUID는 최초 Import 뒤 기록하고, 이후 Source
버전이 올라가도 Export Target과 GUID는 유지한다.

## 10. 금지 예시와 수정

| 금지 | 수정 예시 | 이유 |
|---|---|---|
| `루나최종.png` | `Luna_KeyArt_REVIEW_v001.png` | 문자·상태·버전 불명 |
| `Luna final final2.png` | `Luna_KeyArt_WIP_v002.png` | 공백·임의 버전 |
| `character01_new.fbx` | `CHR_Luna_Model.fbx` | Subject·타입 불명 |
| `material copy.mat` | `MAT_Luna_Outfit.mat` | 역할 불명 |
| `attack.anim` | `ANM_Luna_Attack_01.anim` | Subject·순번 불명 |
| `Cube.001` | `GEO_Body_LOD0` | Export Node 역할 불명 |
| `Socket1` | `Socket_Weapon_R` | 부착 용도 불명 |
| `Luna_APPROVED_v001.fbx` | `CHR_Luna_Model.fbx` | Runtime에 상태·버전 사용 |

## 11. 현재 런타임 이름 의존성

현재 Gray Box 코드에는 이름을 직접 읽는 임시 의존성이 있다. 데이터·serialized reference로
교체하기 전에는 아래 token을 보존한다.

- `EnemyController.IsBoss`는 Enemy Root 이름이 정확히 `Boss_`로 시작하는지 검사한다. 보스
  Prefab·Runtime Instance는 데이터 기반 판정으로 교체할 때까지 `Boss_<Subject>`를 유지한다.
- `PlayerStats.ApplyRuntimePalette`는 Renderer 이름을 소문자로 바꾼 뒤 `accent`, `weapon`,
  `visor`, `blade`, `drone`, `shield` 포함 여부로 Accent Color를 선택한다. 최종 Material binding을
  만들기 전까지 해당 역할의 Renderer 이름에 이 token 중 하나를 보존한다.

이 의존성은 최종 아트 명명 규칙이 아니라 현재 기능 회귀 조건이다. `ART-2001` Presentation
계약에서 명시적 Character ID→Renderer·Material binding으로 교체한 뒤 제거한다.

## 12. 현재 저장소 예외와 이행

| 현재 이름 | 판정 | 처리 |
|---|---|---|
| `ReCamp_CharacterLineup_REVIEW_v003.*` | 규격 일치 | 유지 |
| `ReCamp_CharacterSheet_Template_REVIEW_v001.svg` | 규격 일치 | 유지 |
| `battle_vertical_slice_concept.*` | 원본 앵커 레거시 | 이름 변경 없이 metadata와 경로로 고정 |
| `ReCamp_Character_Lineup.png` | 상태·버전 없는 레거시 | 제작 기준 사용 금지, 기록 유지 |
| `M_BattleGround.mat` 등 `M_*.mat` | Gray Box 레거시 | 즉시 일괄 변경 금지, 최종 교체 시 `MAT_` 적용 |
| `Assets/_ReCamp/Captures/*.png` | 기능 검증 캡처 | Runtime 아트가 아니므로 기존 이름 유지 |
| 빈 `art_refs/character`, `art_refs/background` | 생성 초기 레거시 폴더 | 새 Export는 `characters`, `environments` 복수형 경로를 사용하고 이관 후 제거 |

이행 시 이름 정리만을 위한 대량 변경은 하지 않는다. 실제 자산 교체나 해당 Prefab 작업과 함께
한 범위씩 옮기고, Unity 참조·`.meta` GUID·PlayMode 회귀를 확인한다.

## 13. ART-0109 완료 판정

다음 규칙을 이 문서에서 확정했다.

- 제작 이미지 상태·버전과 companion 파일
- Figma·Blender Source, Collection, Object 이름
- Runtime 타입 접두사와 Model·Prefab·Material·Texture·Animation·VFX·UI 이름
- LOD·Socket·좌우 규칙
- Source→Review→Runtime 추적과 GUID 보존
- 기존 Gray Box·원본 앵커의 명시적 예외

이 문서 작성으로 `ART-0109`는 `Done`이다. 다음 검증은 규격 자체의 미완료가 아니라
`ART-0104` Blender 소품 Export와 `ART-0105` Unity Import에서 첫 실사용 증거로 남긴다. 실사용
중 사전이 부족하면 임의 이름을 먼저 만들지 말고 이 문서 버전을 올린 뒤 적용한다.
