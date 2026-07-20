# Re:Camp Art Asset Structure

이 문서는 Re:Camp 아트 자산의 디렉터리, 승인 상태, 원본·Export 분리, Git 관리 규칙을 정의한다.

## 1. 기준 구조

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
│   │   ├── material/
│   │   ├── 3d_reference/
│   │   └── archive/
│   ├── miyu/
│   ├── coco/
│   ├── iris/
│   └── noah/
├── environments/
│   ├── ruined_street/
│   ├── camp/
│   ├── abandoned_lab/
│   └── archive/
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
│   ├── skill_select/
│   ├── result/
│   └── camp/
└── vfx/
    ├── common/
    ├── luna/
    ├── enemies/
    └── system/
```

## 2. 제작 원본

Unity 프로젝트 생성 후 다음 구조를 사용한다.

```text
art_source/
├── comfyui_workflows/
│   ├── characters/
│   ├── environments/
│   └── vfx/
├── figma_exports/
├── blender/
│   ├── characters/
│   ├── environments/
│   ├── monsters/
│   └── props/
├── textures/
└── metadata/
```

원본과 Unity용 Export를 같은 폴더에 혼합하지 않는다.

## 3. Unity 아트 구조

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
├── Materials/
├── Shaders/
└── Animations/
```

## 4. 기준 문서

| 분야 | 문서 |
|---|---|
| 프로젝트 최신 기준 | `CURRENT_PROJECT_BASELINE.md` |
| 공통 아트 | `ART_DIRECTION.md` |
| 캐릭터 설정 | `CHARACTER_BIBLE.md` |
| 제작 도구 | `ART_PRODUCTION_MCP_GUIDE.md` |
| 제작 시작 | `ART_PRODUCTION_START_GUIDE.md` |
| ComfyUI 일관성 | `COMFYUI_CHARACTER_CONSISTENCY_SPEC.md` |
| 3D 캐릭터 | `CHARACTER_3D_SPEC.md` |
| Animation | `ANIMATION_GUIDE.md` |
| Unity Import | `UNITY_ART_IMPORT_GUIDE.md` |
| 환경·VFX | `ENVIRONMENT_AND_VFX_SPEC.md` |
| 이름 규칙 | `ASSET_NAMING_GUIDE.md` |
| Camera·UI | `docs/04_ui_ux/CAMERA_AND_UI_BASELINE.md` |
| 기술 예산 | `docs/06_dev_docs/TECHNICAL_TARGETS.md` |

## 5. 승인 상태

| 상태 | 의미 | 최종 게임 사용 |
|---|---|---|
| `WIP` | 구조·색상 변경 가능 | 금지 |
| `REVIEW` | 선택·피드백 대기 | Blockout 참고만 가능 |
| `APPROVED` | 현재 최종 기준 | 허용 |
| `SUPERSEDED` | 새 승인본으로 대체 | 신규 작업 금지 |
| `ARCHIVE` | 폐기·기록 보존 | 금지 |

### 통합 라인업 상태

`ReCamp_Character_Lineup.png`는 `Direction Approved`다.

- 역할·대표 색상·무기·큰 실루엣 참고 가능
- 최종 얼굴·의상·Turnaround·3D 제작 기준으로 직접 사용 불가
- 개별 `APPROVED` 제작 시트가 추가되면 해당 시트를 우선

## 6. 캐릭터 필수 산출물

루나 Character Proof:

```text
Luna_KeyArt_APPROVED_v###.png
Luna_Front_APPROVED_v###.png
Luna_Side_APPROVED_v###.png
Luna_Back_APPROVED_v###.png
Luna_Turnaround_APPROVED_v###.png
Luna_ExpressionSheet_APPROVED_v###.png
Luna_EquipmentSheet_APPROVED_v###.png
Luna_MaterialPalette_APPROVED_v###.png
Luna_3DNotes_APPROVED_v###.png
```

나머지 네 캐릭터는 루나 Proof 전까지 단독 전신 방향과 3D 위험 요소만 저장한다. 최종 제작 시트는 Proof 이후 제작한다.

## 7. 파일명

공통 Reference:

```text
PascalCase_AssetType_Status_v###.ext
```

예시:

```text
Luna_KeyArt_REVIEW_v003.png
Luna_Turnaround_APPROVED_v005.png
RuinedStreet_ColorKey_REVIEW_v002.png
```

Unity Asset:

```text
CHR_Luna_Model.fbx
CHR_Luna_Prefab.prefab
MAT_Luna_Body.mat
ANM_Luna_Attack_01.anim
ENV_RuinedStreet_Building_A.fbx
PRP_Camp_Generator.fbx
VFX_Luna_CrossFang.prefab
UI_Battle_SkillFrame.png
```

세부 Prefix는 `ASSET_NAMING_GUIDE.md`를 따른다.

## 8. Source와 Export

### Source

- `.blend`
- Figma 원본
- ComfyUI Workflow JSON
- PSD·Krita·Substance 원본
- 고해상도 Texture

### Export

- `.fbx`
- `.png`
- `.tga`
- `.exr`
- Unity Material·Prefab·Animation

Blender 원본을 Unity가 직접 참조하지 않고 승인된 FBX를 사용한다.

## 9. Git LFS

권장 대상:

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

PNG는 크기와 변경 빈도에 따라 결정한다. 대량 생성 후보를 모두 Git에 넣지 않는다.

## 10. AI 생성 Metadata

AI 생성 Reference에는 최소 다음을 기록한다.

```text
Asset Name:
Task ID:
Purpose:
Status:
Generated Date:
Tool / Model:
Workflow Version:
Seed:
Input References:
Prompt Variables:
Human Edits:
License / Usage Restriction:
Reviewer:
```

상업 사용 조건을 확인하지 못한 생성물은 최종 게임 자산으로 사용하지 않는다.

## 11. Coplay / Aura 결과 기록

Unity 자동화 작업에는 다음을 기록한다.

```text
Task ID:
Asset:
Primary Tool: Coplay 또는 Aura
Validator Tool: Coplay 또는 Aura
Operations:
Created / Modified Files:
Console Result:
Prefab Diff:
Manual Fix:
Approved Result:
```

한 자산을 두 도구가 동시에 수정하지 않는다.

## 12. 리뷰 체크리스트

### 캐릭터

- 얼굴·헤어·의상·무기가 Approved 시트와 일치
- 5~6등신 유지
- 쿼터뷰에서 머리·상체·무기 식별
- 3D·Rig·Animation 가능 구조
- 작은 장식과 물리 비용 통제

### 환경

- 캐릭터보다 낮은 채도와 밀도
- 이동·위험·상호작용 영역 구분
- Modular 규칙과 Pivot·Collision 준수

### UI·VFX

- Windows 1920×1080에서 읽힘
- Android 변환 가능 Layout
- 적 위험과 캐릭터 VFX 혼동 없음
- VFX가 캐릭터·적·자원을 가리지 않음

## 13. 완료 조건

- 결과물과 Metadata 존재
- 파일명·디렉터리 준수
- Review 또는 Approved 상태 표시
- 관련 Backlog ID 연결
- Unity 자산은 Coplay/Aura 또는 수동 Import 검증 기록
- Commit·PR 연결
