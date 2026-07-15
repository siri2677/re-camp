# Re:Camp Art Asset Structure

## 폴더 역할

```text
art_refs/                     # 방향·검토·제작 시트 Export
  art_direction/
  characters/{luna,miyu,coco,iris,noah}/
    concept/ turnaround/ expressions/ equipment/ 3d_reference/ archive/
  environments/ monsters/ props/ ui/ vfx/

art_source/                   # 편집 원본, 대형 바이너리
  figma_exports/ blender/ textures/ comfyui_workflows/

Assets/_ReCamp/Art/           # Unity에서 사용하는 승인 자산
  Characters/ Environments/ Monsters/ Props/ UI/ VFX/
  Materials/ Shaders/ Animations/
```

`art_refs`의 이미지는 Unity 런타임 자산이 아니다. Unity에는 승인된 FBX, Texture, Material, Animation, Prefab을 Import한다.

## 상태

- `WIP`: 제작 중
- `REVIEW`: 비교·검토 가능
- `APPROVED`: 사람 승인 완료, 다음 제작 단계의 기준
- `SUPERSEDED`: 새 방향으로 대체
- `REJECTED`: 사람 검토에서 반려되어 제작 기준으로 재사용 금지
- `ARCHIVE`: 이력 보관

AI 결과는 자동으로 Approved되지 않는다.

## 이름 규칙

검토 이미지는 `PascalCase_AssetType_STATUS_v###.ext` 형식을 사용한다.

```text
ReCamp_CharacterLineup_REJECTED_v002.png
ReCamp_CharacterLineup_REVIEW_v003.png
Luna_FullBody_WIP_v001.png
Luna_Turnaround_APPROVED_v003.png
RuinedStreet_ColorKey_REVIEW_v001.png
```

Unity 자산은 타입·대상 중심의 안정된 이름을 사용한다.

```text
CHR_Luna_Model.fbx
CHR_Luna_Prefab.prefab
CHR_Luna_Mat_Body.mat
CHR_Luna_Anim_Attack01.anim
ENV_RuinedStreet_BuildingA.fbx
VFX_Luna_CrossFang.prefab
```

`Key Art` 표기는 파일명에서 `KeyArt`로 통일한다. 상태와 버전은 레퍼런스 Export에만 넣고 Unity 최종 자산명에는 넣지 않는다.

## Git LFS

PNG, JPG, PSD, KRA, AI, FBX, BLEND, TGA, EXR, 오디오, 영상 등 대형 바이너리는 `.gitattributes`의 LFS 규칙을 따른다. 커밋 전 `git check-attr`과 `git lfs fsck --pointers`로 raw blob 오등록을 확인한다.

## 생성 메타데이터

각 생성 이미지 옆에 `<asset>.metadata.md`를 둔다. 공통 필드는 `AI_ASSET_METADATA_TEMPLATE.md`를 사용한다.

최소 기록:

- Asset Name, Subject, Purpose, Status
- Generated Date, Tool/Model, Workflow Version, Seed
- Input References, Human Edits
- Usage Restriction, Reviewer, Review Notes

## 승인 체크

- Gate A: 얼굴·성격·역할·실루엣·팔레트가 매력적인가
- Gate B: Turnaround와 장비 구조가 3D·리그·애니메이션으로 구현 가능한가
- Gate C: Unity 쿼터뷰에서 얼굴·무기·공격이 읽히고 성능을 만족하는가
