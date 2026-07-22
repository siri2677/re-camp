# Re:Camp Art Asset Structure

이 문서는 Re:Camp 아트 자산의 디렉터리 구조, 파일명, 승인 상태, Git 관리 규칙을 정의한다.

## 1. 디렉터리 구조

```text
art_refs/                         # 방향·검토·제작 시트 Export
├── README.md
├── art_direction/
│   ├── ReCamp_CharacterLineup_REVIEW_v###.png
│   ├── ReCamp_CharacterLineup_REVIEW_v###.metadata.md
│   ├── ReCamp_CharacterLineup_REVIEW_v###.review.md
│   ├── ReCamp_ArtDirectionBoard_REVIEW_v###.png
│   ├── ReCamp_ColorPalette_REVIEW_v###.png
│   └── archive/
├── moodboard/
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
├── CHARACTER_ANCHOR_SPEC.md
├── ART_REVIEW_CHECKLIST.md
├── CHARACTER_SHEET_TEMPLATE_SPEC.md
├── CHARACTER_3D_SPEC.md
├── ANIMATION_GUIDE.md
└── ASSET_NAMING_GUIDE.md

art_source/                       # 편집 원본·대형 바이너리
├── figma_exports/
├── blender/
├── textures/
├── manifests/
└── comfyui_workflows/

Assets/_ReCamp/Art/               # Unity Runtime Art와 명시된 Gray Box 임시 자산
├── Characters/
├── Environments/
├── Monsters/
├── Props/
├── UI/
├── VFX/
├── Materials/
├── Shaders/
└── Animations/

Assets/_ReCamp/Prefabs/           # Gameplay Component·Collider가 붙는 Prefab
├── Player/
├── Enemies/
├── Items/
├── Stage/
└── UI/
```

`art_refs/`의 이미지는 Unity 런타임 자산이 아니다. 최종 Character ID·Stage 연결에는 승인된
FBX, Texture, Material, Animation, Prefab만 사용한다. 현재 `Assets/_ReCamp/Art/Materials`의
`M_*.mat`와 primitive는 기능 검증용 Gray Box 예외다. `art_source/`와 Runtime 폴더는 이미
생성돼 있으나 다수는 최종 자산 제작 전 빈 구조다.

위 문서 트리는 목표 구조다. 현재 `CHARACTER_3D_SPEC.md`만 `ART-2001`의 계획 산출물이며
실제 파일이 생기기 전에는 현재 기준으로 인용하지 않는다. `ASSET_NAMING_GUIDE.md`와
`ANIMATION_GUIDE.md`는 각각 `ART-0109`, `ART-0110`에서 작성한 활성 기준이다.

현재 로컬의 빈 `art_refs/character`, `art_refs/background`는 초기 레거시 폴더다. 새 Export는
각각 `art_refs/characters`, `art_refs/environments` 복수형 경로를 사용하고 실제 이관 시 빈
레거시 폴더를 제거한다.

## 2. 문서별 역할

| 문서 | 역할 |
|---|---|
| ART_DIRECTION.md | 프로젝트 공통 비주얼 방향의 최종 기준 |
| CHARACTER_BIBLE.md | 캐릭터 설정·외형·역할의 단일 기준 |
| ART_PRODUCTION_MCP_GUIDE.md | MCP와 AI 도구 운영 방식 |
| ART_ASSET_STRUCTURE.md | 디렉터리·상태·Git 관리 기준 |
| CHARACTER_ANCHOR_SPEC.md | 5인 얼굴·헤어·실루엣·의상·장비·팔레트 일관성 기준 |
| ART_REVIEW_CHECKLIST.md | 캐릭터·환경·UI/VFX의 Gate A/B/C 공통 판정표와 증거 규칙 |
| CHARACTER_SHEET_TEMPLATE_SPEC.md | 캐릭터 제작 시트 Frame·Component·Gate 증거·Export 규격 |
| CHARACTER_3D_SPEC.md (planned: ART-2001) | 폴리곤, 텍스처, Rig, LOD, 셰이더 규격 |
| ANIMATION_GUIDE.md | 공용·5인 고유 Motion, Animator, Event·Import·Gate 규격 |
| ASSET_NAMING_GUIDE.md | Unity·Blender·이미지 세부 이름·Export·LOD·Socket·GUID 계약 |

## 3. 캐릭터별 필수 산출물

각 캐릭터는 최소 다음 산출물을 갖는다.

```text
[Character]_KeyArt.png
[Character]_Front.png
[Character]_Side.png
[Character]_Back.png
[Character]_Turnaround.png
[Character]_ExpressionSheet.png
[Character]_EquipmentSheet.png
[Character]_MaterialPalette.png
[Character]_3DNotes.md
```

AI 생성 측면·후면은 참고일 뿐이며 사람이 구조를 정리한 Turnaround와 Equipment Sheet가 3D 제작 기준이다.

## 4. 승인 상태

| 상태 | 의미 | 게임 제작 사용 |
|---|---|---|
| WIP | 작업 중, 구조와 색상이 변경될 수 있음 | 금지 |
| REVIEW | 비교·리뷰 후보, 피드백 대기 | Blockout 참고만 허용 |
| APPROVED | 사람이 최종 기준으로 승인 | 허용 |
| SUPERSEDED | 새로운 승인본으로 대체 | 신규 작업 금지 |
| REJECTED | 사람 검토에서 반려 | 제작 기준 재사용 금지 |
| ARCHIVE | 폐기 또는 기록 보존 | 금지 |

AI 결과는 자동으로 APPROVED되지 않는다. 파일 내부 또는 동반 Markdown에 상태, 버전, 담당자, 승인일을 기록하며 승인 후 사소한 수정에도 버전을 올린다.

## 5. 파일명 규칙

이 절은 상태·버전과 Unity 타입 접두사의 요약만 소유한다. 도구별 세부 이름, Socket, LOD,
Animation, Texture suffix, Export·GUID 예외의 단일 기준은 `ASSET_NAMING_GUIDE.md`다.

### 검토 이미지와 소스

```text
PascalCase_AssetType_STATUS_v###.ext
```

예시:

```text
ReCamp_CharacterLineup_REJECTED_v002.png
ReCamp_CharacterLineup_REVIEW_v003.png
Luna_FullBody_WIP_v001.png
Luna_Turnaround_APPROVED_v003.png
Miyu_CombatDrone_REVIEW_v002.png
RuinedStreet_ColorKey_WIP_v004.png
PRP_Camp_Generator_Blockout_v001.blend
```

`Key Art` 표기는 파일명에서 `KeyArt`로 통일한다.

### Unity

Unity 자산은 타입·대상 중심의 안정된 이름을 사용하며 상태와 버전을 붙이지 않는다.

```text
CHR_Luna_Model.fbx
CHR_Luna_Prefab.prefab
MAT_Luna_Body.mat
ANM_Luna_Attack_01.anim
ENV_RuinedStreet_BuildingA_Model.fbx
PRP_Camp_Generator_Model.fbx
VFX_Luna_CrossFang.prefab
UI_Character_Luna_Portrait.png
```

Model·Material·Animation은 `Assets/_ReCamp/Art/`, Gameplay Prefab은
`Assets/_ReCamp/Prefabs/`에 둔다. 정확한 경로 표는 `ASSET_NAMING_GUIDE.md`를 따른다.

## 6. 소스와 Export 분리

### 소스 파일

- `.blend`
- Figma 원본 또는 작업용 Export
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

PNG, JPG, PSD, KRA, AI, PDF, FBX, BLEND, TGA, EXR, 오디오, 영상 등 `.gitattributes`에
등록된 바이너리는 크기와 관계없이 Git LFS를 사용한다. SVG와 Markdown은 일반 Git을 사용한다.
현재 주요 패턴은 다음과 같다.

```text
*.psd
*.kra
*.png
*.pdf
*.blend
*.fbx
*.tga
*.exr
*.wav
*.mp4
```

커밋 전 `git check-attr`과 `git lfs fsck --pointers`로 raw blob 오등록을 확인한다.

### 커밋 원칙

- 승인되지 않은 대량 생성 이미지를 전부 Git에 넣지 않는다.
- 후보 중 선택된 WIP·REVIEW와 승인본만 저장한다.
- 한 커밋에는 하나의 목적을 유지한다.
- 승인본을 교체할 때 기존 파일을 `archive/`로 이동한다.
- 라이선스와 생성 도구 정보를 동반 문서에 기록한다.

## 8. AI 생성 자산 메타데이터

각 생성 이미지 옆에 `<asset>.metadata.md`를 두고 `AI_ASSET_METADATA_TEMPLATE.md`를 사용한다.

```text
Asset Name:
Subject:
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
Review Notes:
```

모델·서비스 약관과 상업적 사용 조건을 확인하지 않은 이미지는 출시 자산으로 사용하지 않는다.

## 9. 리뷰 체크리스트

### 캐릭터

- Gate A: 얼굴·성격·역할·실루엣·팔레트가 매력적이고 다섯 성인 여성이 구분되는가
- Gate B: Turnaround와 장비 구조가 4~5등신 SD-lite 3D·리그·애니메이션으로 구현 가능한가
- Gate C: Unity 쿼터뷰에서 얼굴·무기·공격이 읽히고 성능을 만족하는가
- 무기·장비 구조가 모든 시점에서 일관적인가

### 환경

- 캐릭터보다 시각적 밀도와 채도가 낮은가
- 이동 가능 영역과 위험 영역이 구분되는가
- 자원과 상호작용 오브젝트가 보이는가
- 부드러운 포스트 아포칼립스 톤을 유지하는가

### UI/VFX

- PC·모바일에서 텍스트와 버튼이 읽히는가
- 캐릭터별 색상 언어가 일관적인가
- VFX가 캐릭터와 적을 가리지 않는가
- 공격, 회복, 보호막, 위험 피드백이 즉시 구분되는가

## 10. 현재 저장소 적용 범위

- `art_refs/moodboard/battle_vertical_slice_concept.png`: 원본 전투 비주얼 앵커
- `art_refs/art_direction/ReCamp_CharacterLineup_REVIEW_v003.png`: 검토 후보이며 미승인
- `art_refs/art_direction/ReCamp_CharacterLineup_REVIEW_v003.review.md`: Gate A 자동 리뷰 권고와 수정·Unity 적용 제한
- `art_refs/art_direction/ReCamp_CharacterLineup_REJECTED_v002.png`: 반려본, 재사용 금지
- `art_refs/art_direction/ReCamp_Character_Lineup.png`: 원격 v001 계열의 레거시 레퍼런스, 제작 기준으로 사용하지 않음
- `docs/05_art_concept/ART_DIRECTION.md`
- `docs/05_art_concept/CHARACTER_BIBLE.md`
- `docs/05_art_concept/ART_PRODUCTION_MCP_GUIDE.md`
- `docs/05_art_concept/ART_ASSET_STRUCTURE.md`
- `docs/05_art_concept/ASSET_NAMING_GUIDE.md`
- `docs/05_art_concept/CHARACTER_SHEET_TEMPLATE_SPEC.md`
- `art_source/figma_exports/ReCamp_CharacterSheet_Template_REVIEW_v001.svg`: ART-0103 Figma import용 템플릿
- `art_refs/README.md`

향후 캐릭터별 APPROVED 시트가 추가되면 통합 라인업 이미지보다 개별 APPROVED 시트를 우선한다.
