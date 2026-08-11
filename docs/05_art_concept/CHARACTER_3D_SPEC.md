# Character 3D Specification v001

> 상태: `REVIEW / Common 3D Presentation Contract`
> Backlog: `ART-2001`
> 적용 대상: Current Generation CH101~CH105
> 최초 작성: 2026-08-11

이 문서는 승인된 2D 제작 시트를 5~6등신 스타일라이즈드 인게임 캐릭터로 변환하기 위한 공용 예산·계층·Import 계약이다. 최종 캐릭터 Model, Rig, Material, Animation, Prefab의 승인 기록은 별도로 남긴다.

전역 제품·플랫폼·비율은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`, 캐릭터 정체성은 `CHARACTER_BIBLE.md`와 `CHARACTER_ANCHOR_SPEC.md`, 표현 방향은 `ART_DIRECTION.md`, 사람 Gate 판정은 `ART_REVIEW_CHECKLIST.md`가 소유한다.

## 1. Current contract

| 항목 | 기준 |
|---|---|
| Unity | `6000.5.3f1`, URP |
| 대상 기기 | Android Landscape 우선, Windows Editor proof |
| 카메라 | 고정 Orthographic 쿼터뷰 |
| 3D 비율 | Current 캐릭터별 `5.2~5.8H`; CH101은 `5.3~5.4H` |
| Root | Position `(0,0,0)`, Rotation `(0,0,0)`, Scale `(1,1,1)` |
| 축/단위 | 전방 `+Z`, 위 `+Y`, `1 Unity unit = 1 m` |
| Skeleton | 캐릭터별 독립 골격 금지; 공용 Humanoid 호환 Skeleton 1세트 |
| Animation | Battle Clip In-place, Root Motion 기본 `false` |
| Shader | 공용 Toon Shader와 공용 VFX Shader/Material 우선 |
| Runtime 경계 | 승인 전 Blockout은 `Assets/_ReCamp/Art/Blockout/`에만 두고 Character ID/Prefab에서 제외 |

이 문서의 수치는 첫 Character Proof를 위한 보수적 시작 예산이다. 실제 Android frame·memory·overdraw 측정이 끝나기 전에는 최종 출시 예산으로 표시하지 않는다.

## 2. Proof budget

| 항목 | LOD0 목표 | LOD1 목표 | LOD2 목표 | Gate B 확인 |
|---|---:|---:|---:|---|
| 캐릭터 Mesh triangles | `≤18,000` | `≤10,000` | `≤5,000` | 쿼터뷰 실루엣·관절 변형 |
| 대표 장비 포함 추가 triangles | `≤2,000` | `≤1,200` | `≤600` | 세이버·리본 식별 |
| Texture atlas | `2048² max` | `1024² max` | `512² max` | Android 압축·메모리 |
| Material slots | `≤6` | `≤6` | `≤4` | 슬롯 누락·분홍 Material |
| Deform bones | 공용 기준 `≤55` | 동일 | 동일 | Humanoid Avatar |
| Helper bones / drivers | `≤8` | `≤8` | `≤4` | 리본·헤어 물리 금지/제한 |
| Face BlendShapes | `≤8` | `≤8` | `0~4` | 표정 최소 세트 |
| Dynamic VFX | 세이버 emission 1 + 리본 Trail/Ribbon 1 | 동일 | emission 축소 | overdraw·수명 |
| Physics | Cloth/Cable `0` | `0` | `0` | 단일 Transform/Shader 대체 |

### Material slot baseline

1. `MAT_<Subject>_Face`
2. `MAT_<Subject>_Hair`
3. `MAT_<Subject>_Skin`
4. `MAT_<Subject>_Outfit`
5. `MAT_<Subject>_Saber`
6. `MAT_<Subject>_RibbonEmission`

Slot을 더 늘릴 때는 Android memory/SetPass/overdraw 측정과 변경 이유를 기록한다. 색상·재질은 승인된 2D 시트에서 시작하되, 3D Shader 값은 이 문서와 실제 측정 결과로 확정한다.

### LOD proof thresholds

초기 proof의 `LODGroup` screen relative transition height는 `LOD0 0.35`, `LOD1 0.18`, `LOD2 0.06`을 시작값으로 사용한다. 카메라 거리와 실제 화면 높이에서 얼굴·세이버·리본이 읽히지 않으면 수치를 조정하고 캡처를 남긴다.

## 3. CH101 Amasawa Rin profile

| 항목 | CH101 기준 |
|---|---|
| 3D target | `5.3~5.4H`, adult feminine stylized proportion |
| Read priority | 얼굴·높은 포니테일 → 흰/검정 재킷 절개 → 부츠 → 단일 세이버 → 단일 시안 신호 리본 |
| Body/Outfit | 공용 Humanoid body에 재킷, 크롭 쇼츠, 허벅지 스트랩, 하이탑 부츠를 큰 색면으로 유지 |
| Hair | 포니테일 루트와 시안 끝단을 유지; 잔가닥은 2~3개 큰 카드/덩어리로 통합; 물리 본 금지 |
| Saber | `Socket_Weapon_R` 장착, `Socket_BladeTip` 발광/궤적 기준; 하나의 대표 장비만 허용 |
| Signal ribbon | 하나의 큰 Ribbon Mesh 또는 Trail; 금색 격자는 텍스처; Cloth/Cable Physics 금지 |
| Ribbon driver | `Socket_VFXCenter` 기준 단일 driver/Shader parameter; 다중 케이블·다중 독립 본 금지 |
| Camera focus | `Socket_CameraFocus`; 얼굴과 장비가 동시에 쿼터뷰에서 읽히는 위치로 검증 |

## 4. 2D→3D implementation rules

| 2D 요소 | 유지 | 확대/강조 | 단순화/삭제 | 위험/검증 |
|---|---|---|---|---|
| 얼굴 | 눈, 앞머리, 성인 비율, 표정 방향 | 눈 대비·얼굴 면적 | 미세 속눈썹·피부선 | 128px/쿼터뷰 얼굴 read |
| 헤어 | high ponytail, cyan accent | 포니테일 루트·끝단 | 잔가닥을 카드/덩어리로 통합 | 카메라 clipping |
| 상체 | white/black/gold jacket split | 칼라·어깨·허리선 | stitch·small buckle texture화 | 어깨/팔꿈치 deformation |
| 하체 | shorts·thigh straps·boots | 부츠·발 방향 | strap buckle 일부 통합 | 관절 clipping |
| Saber | grip·guard·cyan blade | grip·guard·blade edge | 미세 lattice는 texture | hand socket·attack arc |
| Ribbon | 단일 cyan/gold path | 경로·활성 emission | lattice texture, 하나의 Trail/Mesh | 얼굴 가림·overdraw |
| VFX | cyan emission cue | blade tip·ribbon center | particle count·layers 최소화 | Android GPU cost |

## 5. Required hierarchy and sockets

```text
CHR_AmasawaRin
└── VisualRoot
    ├── GEO_Body_LOD0
    ├── GEO_Hair_LOD0
    ├── GEO_Outfit_LOD0
    ├── Socket_Weapon_R
    │   └── PRP_AmasawaRin_WireSaber
    │       └── Socket_BladeTip
    ├── Socket_VFXCenter
    │   └── RibbonDriver
    └── Socket_CameraFocus
```

`SOURCE_`와 `REFERENCE_` Collection은 Export에서 제외한다. Runtime Root·Mesh·Rig·Socket 이름은 `ASSET_NAMING_GUIDE.md`를 따른다. RibbonDriver는 Gameplay 판정을 소유하지 않으며, 표현 위치·발광·Trail만 담당한다.

## 6. Animation and physics boundary

- 공용 Locomotion·Hit·Down을 우선 재사용한다.
- CH101 고유 범위는 Signature Idle, 기본 공격, `Slipstream`, `BeaconThread`, Victory/Select 방향부터 검증한다.
- 이동 거리·회전·Damage·Cooldown·무적·자원은 코드/데이터가 소유한다.
- Animation Event는 SFX/VFX/장비 표시 같은 Presentation Cue만 전달한다.
- Ribbon은 Cloth Simulation 대신 Trail/Ribbon Mesh/Shader를 사용한다.
- Saber는 손 소켓과 단일 장비 Prefab으로 유지하며, 별도 복잡한 물리 시스템을 만들지 않는다.
- Collider는 Gate B Blockout에서 `Hurtbox_Body` 1개와 공격 표현용 임시 probe로 시작한다. 최종 판정은 Runtime 코드 계약과 분리한다.

## 7. Import and validation evidence

최초 Export 및 승인 버전 교체는 `art_source/manifests/<Category>_<Subject>_Export_v###.md`에 기록한다.

필수 확인:

- Root 축·단위·Scale·Pivot.
- Humanoid Avatar mapping과 공용 관절 작동.
- Material slot·Texture basename·Shader 참조.
- `Socket_Weapon_R`, `Socket_BladeTip`, `Socket_VFXCenter`, `Socket_CameraFocus`.
- LOD transition, Android texture compression, overdraw, Console 오류.
- Orthographic 쿼터뷰에서 얼굴·부츠·세이버·리본의 3초 read.
- 승인 전에는 `Assets/_ReCamp/Art/Blockout/` 밖으로 Model/Prefab을 복사하지 않음.

## 8. Gate B relationship

이 문서는 `CHA-B10`의 규격 링크와 `CHA-B03/B06/B07/B08`의 기술 기준을 제공한다. `CHA-B05` 포즈 Blockout과 `CHA-B09` 모션 썸네일은 실제 Blockout/Animation proof가 생길 때까지 `NOT TESTED`다. 이 문서만으로 Gate B, 3D Blockout, Unity Import, Runtime 교체를 승인하지 않는다.
