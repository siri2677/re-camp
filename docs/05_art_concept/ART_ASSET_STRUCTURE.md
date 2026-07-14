# Re:Camp Art Asset Structure

이 문서는 Re:Camp 아트 자산의 최종 디렉터리 구조, 파일명, 승인 상태, Git 관리 규칙을 정의한다.

## 1. 최종 디렉터리 구조

```text
art_refs/
├── README.md
├── art_direction/
│   ├── ReCamp_Character_Lineup.png
│   ├── ReCamp_Art_Direction_Board.png
│   ├── ReCamp_Color_Palette.png
│   └── archive/
├── characters/
│   ├── luna/
│   │   ├── concept/
│   │   ├── turnaround/
│   │   ├── expressions/
│   │   ├── equipment/
│   │   ├── 3d_reference/
│   │   └── archive/
│   ├── miyu/
│   ├── coco/
│   ├── iris/
│   └── noah/
├── environments/
│   ├── camp/
│   ├── ruined_street/
│   ├── contaminated_forest/
│   ├── abandoned_lab/
│   └── machine_graveyard/
├── monsters/
│   ├── normal/
│   └── bosses/
├── props/
│   ├── camp_facilities/
│   ├── weapons/
│   ├── drones/
│   ├── loot/
│   └── environment/
├── ui/
│   ├── design_system/
│   ├── lobby/
│   ├── battle/
│   ├── result/
│   └── character/
└── vfx/
    ├── common/
    ├── luna/
    ├── miyu/
    ├── coco/
    ├── iris/
    └── noah/

docs/05_art_concept/
├── ART_DIRECTION.md
├── CHARACTER_BIBLE.md
├── ART_PRODUCTION_MCP_GUIDE.md
├── ART_ASSET_STRUCTURE.md
├── CHARACTER_3D_SPEC.md
├── ANIMATION_GUIDE.md
└── ASSET_NAMING_GUIDE.md

art_source/
├── figma_exports/
├── blender/
├── textures/
└── comfyui_workflows/

Assets/_ReCamp/Art/
├── Characters/
├── Environments/
├── Monsters/
├── Props/
├── UI/
├── VFX/
├── Materials/
├── Shaders/
└── Animations/
```

`art_source/`와 `Assets/_ReCamp/Art/`는 Unity 프로젝트 생성 이후 추가한다.

## 2. 문서별 역할

| 문서 | 역할 |
|---|---|
| ART_DIRECTION.md | 프로젝트 공통 비주얼 방향의 최종 기준 |
| CHARACTER_BIBLE.md | 캐릭터 설정·외형·역할의 단일 기준 |
| ART_PRODUCTION_MCP_GUIDE.md | MCP와 AI 도구 운영 방식 |
| ART_ASSET_STRUCTURE.md | 디렉터리·상태·Git 관리 기준 |
| CHARACTER_3D_SPEC.md | 폴리곤, 텍스처, Rig, LOD, 셰이더 규격 |
| ANIMATION_GUIDE.md | 공용·고유 애니메이션과 파일 규격 |
| ASSET_NAMING_GUIDE.md | Unity·Blender·이미지 파일명 규칙 |

## 3. 캐릭터별 필수 산출물

각 캐릭터는 최소 다음 산출물을 갖는다.

```text
[Character]_Key_Art.png
[Character]_Front.png
[Character]_Side.png
[Character]_Back.png
[Character]_Turnaround.png
[Character]_Expression_Sheet.png
[Character]_Equipment_Sheet.png
[Character]_Material_Palette.png
[Character]_3D_Notes.png
```

### 상태별 예시

```text
Luna_Key_Art_WIP_v001.png
Luna_Key_Art_REVIEW_v003.png
Luna_Key_Art_APPROVED_v005.png
```

Approved 이후 사소한 수정도 버전을 올린다.

## 4. 승인 상태

| 상태 | 의미 | 게임 제작 사용 |
|---|---|---|
| WIP | 작업 중, 구조와 색상이 변경될 수 있음 | 금지 |
| REVIEW | 리뷰 후보, 피드백 대기 | Blockout 참고만 허용 |
| APPROVED | 최종 기준으로 승인 | 허용 |
| SUPERSEDED | 새로운 승인본으로 대체됨 | 신규 작업 금지 |
| ARCHIVE | 폐기 또는 기록 보존 | 금지 |

파일 내부 또는 동반 Markdown에 상태, 버전, 담당자, 승인일을 기록한다.

## 5. 파일명 규칙

### 공통

```text
PascalCase_AssetType_Status_v###.ext
```

예시:

```text
Luna_ExpressionSheet_APPROVED_v003.png
Miyu_CombatDrone_REVIEW_v002.png
RuinedStreet_ColorKey_WIP_v004.png
CampGenerator_Blockout_v001.blend
```

### Unity

```text
CHR_Luna_Model.fbx
CHR_Luna_Prefab.prefab
CHR_Luna_Mat_Body.mat
CHR_Luna_Anim_Attack01.anim
ENV_RuinedStreet_BuildingA.fbx
PRP_Camp_Generator.fbx
VFX_Luna_CrossFang.prefab
UI_Character_Select_Luna.png
```

## 6. 소스와 Export 분리

### 소스 파일

- `.blend`
- Figma 원본
- ComfyUI workflow JSON
- 고해상도 PSD·Krita 원본
- Substance 원본

### Export 파일

- `.fbx`
- `.png`
- `.tga`
- `.exr`
- Unity용 압축 Texture

소스와 Export를 동일 디렉터리에 혼합하지 않는다.

## 7. Git과 Git LFS

Git LFS 대상 권장:

```text
*.psd
*.kra
*.blend
*.fbx
*.tga
*.exr
*.wav
*.mp4
```

PNG는 크기와 변경 빈도에 따라 LFS 적용 여부를 결정한다. 레퍼런스 PNG는 일반 Git으로 관리할 수 있지만 대형 원화 Export는 LFS 사용을 권장한다.

### 커밋 원칙

- 승인되지 않은 대량 생성 이미지를 전부 Git에 넣지 않는다.
- 후보 중 선택된 WIP와 승인본만 저장한다.
- 한 커밋에는 하나의 목적을 유지한다.
- 최종 승인본을 교체할 때 기존 파일을 `archive/`로 이동한다.
- 라이선스와 생성 도구 정보를 동반 문서에 기록한다.

## 8. AI 생성 자산 메타데이터

AI로 생성한 레퍼런스에는 다음 정보를 기록한다.

```text
Asset Name:
Character/Environment:
Purpose:
Status:
Generated Date:
Tool/Model:
Workflow Version:
Seed:
Input References:
Human Edits:
Usage Restriction:
Reviewer:
```

모델·서비스 약관과 상업적 사용 조건을 확인하지 않은 이미지는 출시 자산으로 사용하지 않는다.

## 9. 리뷰 체크리스트

### 캐릭터

- 얼굴과 헤어가 기준 이미지와 일치하는가
- 캐릭터별 실루엣과 색상이 구분되는가
- 무기·장비 구조가 모든 시점에서 일관적인가
- 3D 모델링과 애니메이션이 가능한 구조인가
- 쿼터뷰에서 머리·상체·무기가 식별되는가

### 환경

- 캐릭터보다 시각적 밀도와 채도가 낮은가
- 이동 가능 영역과 위험 영역이 구분되는가
- 자원과 상호작용 오브젝트가 보이는가
- 부드러운 포스트 아포칼립스 톤을 유지하는가

### UI/VFX

- 모바일에서 텍스트와 버튼이 읽히는가
- 캐릭터별 색상 언어가 일관적인가
- VFX가 캐릭터와 적을 가리지 않는가
- 공격, 회복, 보호막, 위험 피드백이 즉시 구분되는가

## 10. 현재 저장소 적용 범위

현재 커밋에서는 다음을 우선 적용한다.

```text
art_refs/art_direction/ReCamp_Character_Lineup.png
docs/05_art_concept/ART_DIRECTION.md
docs/05_art_concept/CHARACTER_BIBLE.md
docs/05_art_concept/ART_PRODUCTION_MCP_GUIDE.md
docs/05_art_concept/ART_ASSET_STRUCTURE.md
art_refs/README.md
```

향후 캐릭터별 Approved 시트가 추가되면 통합 라인업 이미지보다 개별 Approved 시트를 우선한다.
