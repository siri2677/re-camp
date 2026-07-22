# Re:Camp Art Asset Structure

이 문서는 Re:Camp 아트 자산의 디렉터리, 승인 상태, 원본·Export 분리, Git 관리 규칙을 정의한다.

## 1. 기준 구조

```text
art_refs/
├── art_direction/
├── characters/
│   ├── luna/
│   ├── miyu/
│   ├── coco/
│   ├── iris/
│   └── noah/
├── environments/
├── monsters/
├── props/
├── ui/
└── vfx/
```

## 2. 제작 원본

```text
art_source/
├── comfyui_workflows/
├── figma_exports/
├── blender/
├── textures/
└── metadata/
```

원본과 Unity용 Export를 같은 폴더에 혼합하지 않는다.

## 3. Unity 아트 구조

```text
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

`ReCamp_Character_Lineup.png`는 `Direction Approved`다. 역할·대표 색상·무기·큰 실루엣에만 사용하며 최종 얼굴·Turnaround·3D 모델링 기준으로 직접 사용하지 않는다.

## 6. 루나 필수 산출물

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

나머지 네 캐릭터는 루나 Proof 전까지 단독 전신 방향과 3D 위험 요소만 저장한다.

## 7. 파일명

Reference:

```text
PascalCase_AssetType_Status_v###.ext
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

대량 생성 후보를 모두 Git에 넣지 않는다.

## 10. AI 생성 Metadata

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

## 11. Unity 자동화·검증 기록

```text
Task ID:
Asset:
Automation Tool: Coplay 또는 Editor Script
Operations:
Created / Modified Files:
Validation Tool Result:
Inspector Review:
Console Result:
Prefab Diff:
PlayMode Result:
Profiler Result:
Manual Fix:
Approved Result:
```

Aura AI는 체험 이후 유료 사용이 필요한 구조이므로 기본 기록 대상과 필수 승인 도구에서 제외한다.

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
- Unity 자산은 Coplay 또는 Editor Script 실행 기록 보유
- Validation Tool·수동 Unity QA 기록 보유
- Commit·PR 연결
