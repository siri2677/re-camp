# Re:Camp Art Asset Structure

> Version: v002
> 최종 갱신: 2026-07-27
> 상태: Active Domain Contract

이 문서는 아트 자산의 디렉터리·상태·버전·Git 관리 규칙만 정의한다. 제품·전역 비주얼·로스터는 `docs/00_project/CURRENT_PROJECT_BASELINE.md`, 캐릭터 설정은 `CHARACTER_BIBLE.md`, 파일 이름과 Export 규칙은 `ASSET_NAMING_GUIDE.md`를 따른다.

## 1. 디렉터리 구조

```text
art_refs/
├── README.md
├── moodboard/                       # 화면 분위기·구도 참고
├── art_direction/                   # 통합 비교·역사 자산
├── characters/
│   ├── luna/
│   ├── miyu/
│   ├── coco/
│   ├── iris/
│   └── noah/
│       ├── concept/
│       ├── turnaround/
│       ├── expressions/
│       ├── equipment/
│       ├── production_sheet/
│       ├── 3d_review/
│       └── archive/
├── environment/
├── monsters/
├── ui/
└── vfx/

art_source/
├── figma_exports/
├── blender/
│   ├── characters/
│   ├── equipment/
│   ├── environment/
│   └── proof/
├── textures/
├── comfyui_workflows/
└── manifests/

Assets/_ReCamp/Art/
├── Characters/
├── Environment/
├── Monsters/
├── UI/
├── VFX/
└── Materials/
```

- `art_refs/`: 사람이 비교·검토하는 이미지와 companion 기록.
- `art_source/`: 편집 가능한 원본과 Export Manifest.
- `Assets/_ReCamp/Art/`: Unity Runtime에 Import된 자산.
- 소스와 Runtime 파일을 같은 경로에서 직접 덮어쓰지 않는다.

## 2. 상태

| 상태 | 의미 | Runtime 사용 |
|---|---|---|
| `WIP` | 탐색·제작 중 | 금지 |
| `REVIEW` | 비교·검토 가능한 후보 | 개발 임시 참조만 가능 |
| `APPROVED` | 사람 승인과 필수 증거 완료 | 제작·Runtime 승격 가능 |
| `REJECTED` | 요구조건 실패 | 금지, 이력 보존 |
| `INVALID` | 손상·빈 파일·권리 불명·형식 오류 | 금지 |
| `ARCHIVED` | 대체된 과거 버전 | 금지, 비교 이력만 |

생성 도구의 품질 점수나 자동 판정만으로 `APPROVED`로 변경하지 않는다.

## 3. Companion 파일

검토 이미지와 Export에는 가능한 범위에서 같은 Base Name의 companion Markdown을 둔다.

```text
Asset_REVIEW_v003.png
Asset_REVIEW_v003.metadata.md
Asset_REVIEW_v003.review.md
```

### Metadata 최소 항목

- Asset Name·Subject·Purpose·Status.
- Tool/Model·Workflow Version·Seed.
- Input References·Generated Date.
- Human Edits·Usage Restriction.
- Owning documents.
- External-IP Similarity.
- Source·Export 경로와 Version.

### Review 최소 항목

- Reviewer·Date.
- 적용 Gate와 판정.
- Pass·Fail 근거.
- 수정 요청.
- 다음 유효 Version 또는 대체 경로.
- Runtime 사용 가능 여부.

## 4. Version 규칙

- 구조나 시각 결과가 달라지면 Version을 올린다.
- 단순 파일 이동·오탈자 수정은 결과를 바꾸지 않으면 Version을 유지할 수 있다.
- 같은 Version의 이미지·metadata·review가 서로 다른 내용을 가지면 안 된다.
- 새 Version이 생겨도 이전 파일을 덮어쓰지 않고 `archive/` 또는 역사 경로로 이동한다.
- `latest`, `final`, `new`처럼 의미가 불명확한 파일명을 사용하지 않는다.

## 5. 승인 흐름

```text
WIP 생성
→ metadata 기록
→ REVIEW Export
→ Gate 검토
→ 수정 또는 REJECTED
→ 사람 승인
→ APPROVED Source·Export
→ Blender/Unity 제작
→ Gate C·Android 검증
```

- 개별 `APPROVED` 제작 시트가 텍스트 설명과 통합 비교 이미지보다 우선한다.
- 역사·실패 자산은 새 제작의 입력 이미지로 사용하지 않는다.
- APPROVED 자산을 수정할 때는 새 Version과 review를 만든다.

## 6. Source→Export→Runtime 연결

각 Runtime 자산은 다음을 역추적할 수 있어야 한다.

```text
Approved reference
→ editable source
→ export manifest
→ FBX/PNG/TGA/WAV 등 전달 파일
→ Unity import asset
→ Prefab/Material/Animator
```

Manifest에는 다음을 기록한다.

- Source SHA 또는 Version.
- Export Tool과 Version.
- Export 설정.
- 출력 파일 경로.
- Socket·LOD·Material Slot.
- Unity Import Preset.
- Reviewer와 사용 제한.

## 7. Git·LFS

- 대용량 이미지·모델·편집 원본은 `.gitattributes`의 LFS 규칙을 따른다.
- `.meta`를 함께 커밋하고 GUID를 임의 재생성하지 않는다.
- `Library/`, `Temp/`, Cache, 자동 생성 Preview는 커밋하지 않는다.
- Export 전에 `git status`를 확인해 관련 없는 사용자 변경을 보존한다.
- 손상된 LFS Pointer나 빈 이미지가 발견되면 `INVALID`로 기록하고 제작을 중단한다.

## 8. Unity 승격 조건

다음 조건을 만족하기 전 최종 Runtime 폴더로 승격하지 않는다.

- 승인된 Source와 review 경로 존재.
- 파일명·Socket·Material·LOD 규격 통과.
- Missing Script·Material·Texture 없음.
- Prefab Validation 통과.
- 쿼터뷰 가독성·관통·Animation 검증.
- 필요한 Android 성능 증거.

Gray Box와 임시 Proxy는 별도 Prototype 경로와 이름을 유지하고 최종 자산처럼 보이게 명명하지 않는다.

## 9. 폐기·보존

- `REJECTED`, `INVALID`, Gate 실패 결과는 원인을 설명하는 review와 함께 보존한다.
- 보존 목적은 실패 회귀 방지이며 제작 기준 재사용이 아니다.
- 권리 불명·개인정보·불필요한 대용량 중간 파일은 정책에 따라 제거할 수 있다.
- 제거 전 참조 링크와 Manifest를 확인한다.

이 문서에서 전역 비율·플랫폼·캐릭터 방향을 다시 정의하지 않는다.
