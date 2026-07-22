# Re:Camp Asset Naming Guide

이 문서는 Re:Camp의 아트 소스, Export, Unity Asset 파일명을 통일하기 위한 기준이다.

## 1. 공통 원칙

- 영문과 숫자만 사용한다.
- 공백, 한글, 특수문자를 사용하지 않는다.
- 단어 구분은 PascalCase 또는 `_`를 사용한다.
- 역할과 용도를 파일명만으로 식별할 수 있어야 한다.
- 상태와 버전은 제작 레퍼런스에만 사용하고 Unity 최종 Asset에는 넣지 않는다.

## 2. 레퍼런스·제작 이미지

형식:

```text
[Subject]_[AssetType]_[Status]_v###.ext
```

예시:

```text
Luna_KeyArt_WIP_v001.png
Luna_KeyArt_REVIEW_v003.png
Luna_KeyArt_APPROVED_v005.png
Luna_ExpressionSheet_APPROVED_v002.png
Miyu_CombatDrone_REVIEW_v004.png
RuinedStreet_ColorKey_WIP_v003.png
```

상태:

```text
WIP
REVIEW
APPROVED
SUPERSEDED
ARCHIVE
```

## 3. ComfyUI Workflow와 메타데이터

```text
[subject]_[purpose]_v###.json
[AssetName].yaml
```

예시:

```text
luna_fullbody_v001.json
luna_expression_v002.json
ruined_street_color_key_v001.json
Luna_KeyArt_REVIEW_v003.yaml
```

Workflow 파일은 소문자 `snake_case`를 사용한다.

## 4. Blender 소스

형식:

```text
[Category]_[Subject]_[Purpose]_v###.blend
```

예시:

```text
CHR_Luna_Model_v001.blend
CHR_Luna_Rig_v002.blend
PRP_Luna_EnergyDagger_v003.blend
ENV_RuinedStreet_BuildingA_v001.blend
MON_Scrapper_Blockout_v002.blend
```

## 5. Unity 접두사

| 접두사 | 용도 |
|---|---|
| CHR | 플레이어블 캐릭터와 NPC |
| MON | 몬스터와 보스 |
| ENV | 환경 모듈 |
| PRP | 소품과 장비 |
| UI | UI 이미지·Prefab |
| VFX | 시각 효과 |
| MAT | Material |
| TEX | 일반 Texture |
| ANM | Animation Clip |
| AC | Animator Controller |
| AVT | Avatar |
| SND | Audio Clip |
| SCN | Scene |
| SO | ScriptableObject |

## 6. Unity Model과 Prefab

```text
CHR_Luna_Model.fbx
CHR_Luna_Prefab.prefab
CHR_Luna_Portrait.png
CHR_Luna_Avatar.asset
MON_Scrapper_Model.fbx
MON_Scrapper_Prefab.prefab
ENV_RuinedStreet_BuildingA.fbx
PRP_Luna_EnergyDagger.fbx
```

## 7. Material과 Texture

형식:

```text
MAT_[Subject]_[Part].mat
TEX_[Subject]_[Part]_[Map].png
```

Map 이름:

```text
BaseColor
Normal
Mask
Emission
FaceShadow
```

예시:

```text
MAT_Luna_Face.mat
MAT_Luna_Hair.mat
MAT_Luna_Outfit.mat
TEX_Luna_Face_BaseColor.png
TEX_Luna_Face_Normal.png
TEX_Luna_Outfit_Mask.png
TEX_Luna_Equipment_Emission.png
```

## 8. Animation

형식:

```text
ANM_[Subject]_[Action]_[Variant].anim
```

예시:

```text
ANM_Common_Idle_Combat.anim
ANM_Common_Run_F.anim
ANM_Luna_Attack_01.anim
ANM_Luna_Dash.anim
ANM_Luna_ScanPulse.anim
ANM_Luna_CrossFang.anim
ANM_Luna_Victory.anim
AC_Character_Common.controller
AC_Luna.controller
```

## 9. VFX

```text
VFX_[Subject]_[Action]_[Part].prefab
```

예시:

```text
VFX_Luna_Attack01_Trail.prefab
VFX_Luna_CrossFang_Impact.prefab
VFX_Miyu_Drone_Muzzle.prefab
VFX_Coco_SafeZone_Area.prefab
VFX_Iris_FocusShot_Line.prefab
VFX_Noah_BarrierWall_Shield.prefab
```

## 10. UI

```text
UI_[Screen]_[Element]_[State].png
UI_[Screen]_[Element].prefab
```

예시:

```text
UI_Common_Button_Primary_Normal.png
UI_Common_Button_Primary_Pressed.png
UI_Battle_SkillFrame.png
UI_Character_Luna_Portrait.png
UI_Result_RewardCard.prefab
UI_Lobby_CharacterPanel.prefab
```

## 11. Socket과 GameObject

```text
Socket_Weapon_R
Socket_Weapon_L
Socket_Muzzle
Socket_VFX_Hand_R
Socket_VFX_Hand_L
Socket_VFX_Body
Socket_VFX_Foot
Socket_CameraFocus
Hitbox_Attack
Hurtbox_Body
GroundCheck
```

Scene Hierarchy 이름은 파일명 접두사보다 역할을 우선한다.

## 12. 폴더명

- Unity 폴더는 PascalCase를 사용한다.
- `art_source/`와 `art_refs/` 하위 폴더는 소문자 `snake_case`를 사용한다.

예시:

```text
Assets/_ReCamp/Art/Characters
Assets/_ReCamp/Art/Animations/Common
art_source/comfyui_workflows/luna
art_refs/characters/luna/turnaround
```

## 13. 금지 예시

```text
루나최종.png
Luna final final2.png
character01_new.fbx
material copy.mat
attack.anim
Image (3).png
```

## 14. 이름 변경 시 주의사항

- Unity Asset 이름 변경은 `.meta` 파일이 유지되는 방식으로 Unity Editor 안에서 수행한다.
- 외부에서 파일을 교체할 때 기존 GUID가 필요한지 확인한다.
- Approved 레퍼런스 교체 시 기존 파일은 `archive/`로 이동한다.
- 파일명 변경과 내용 변경을 가능하면 별도 커밋으로 분리한다.
