# Re:Camp Character Production Sheet Template Specification

> Version: v002
> 최종 갱신: 2026-07-24
> 상태: REVIEW

이 문서는 `ART-0103`의 저장소 기준 산출물이다. Figma 또는 동등한 벡터 편집 도구에서
루나·미유·코코·이리스·노아의 약 7등신 2D 제작 시트를 같은 구조로 만들기 위한 Frame,
Component, 필드, Gate 증거와 Export 계약을 정의한다.

템플릿은 디자인 내용을 새로 정의하지 않는다. 캐릭터 설정은 `CHARACTER_BIBLE.md`, 고정·가변
앵커는 `CHARACTER_ANCHOR_SPEC.md`, 판정은 `ART_REVIEW_CHECKLIST.md`, 경로·상태는
`ART_ASSET_STRUCTURE.md`, 파일명·Export는 `ASSET_NAMING_GUIDE.md`를 링크해 사용한다.

## 1. 범위와 상태

```yaml
Backlog ID: ART-0103
Template Version: v002
Template Status: REVIEW
Human Approval: Pending
Primary Scope: 2D seven-head adult anime character production sheet
Secondary Scope: 3D five-to-six-head stylized translation notes only
Runtime Asset: No
```

- 템플릿 상태 `REVIEW`는 레이아웃의 사용성 검토 상태다.
- 이 템플릿으로 만든 캐릭터 시트가 자동으로 `APPROVED`되는 것은 아니다.
- 2D Frame에는 캐릭터별 약 6.8~7.4등신 목표를 적용한다.
- 3D 이미지는 2D와 섞지 않고 `Palette_Materials_3DTranslation` Frame의 참고 슬롯에만 배치한다.
- 과거 v003 통합 라인업은 Gate A `FAIL` 권고인 비교 자료이며 승인 이미지로 삽입하지 않는다.
- 실제 Figma Import·Component 변환·Clone·PNG/PDF Export를 확인하기 전 ART-0103은 최대 `Review`다.

## 2. 저장소 산출물

| 파일 | 역할 |
|---|---|
| `docs/05_art_concept/CHARACTER_SHEET_TEMPLATE_SPEC.md` | Frame·Component·필드·Export 단일 규격 |
| `art_source/figma_exports/ReCamp_CharacterSheet_Template_REVIEW_v002.svg` | Figma import 가능한 6-Frame 벡터 템플릿 |
| `art_refs/characters/<character>/...` | 사람 검토에 올릴 캐릭터별 PNG/PDF Export |

기존 `ReCamp_CharacterSheet_Template_REVIEW_v001.svg`는 과거 2D 일반 등신·3D 비율 기준의 이력으로
보존하며 새 캐릭터 시트에는 v002를 사용한다.

Figma 원본 URL이나 파일 키는 저장소에 비밀값으로 기록하지 않는다. 팀 공유가 필요하면 접근
권한이 있는 연결에서 관리하고, Git에는 승인 판단에 사용한 버전 고정 Export를 반드시 둔다.

## 3. 기준 입력

| 구분 | 단일 소스 | 템플릿에서의 사용 |
|---|---|---|
| 캐릭터 설정 | `CHARACTER_BIBLE.md` v2.0 | Character ID·한 문장 훅·역할·2D/3D 목표 |
| 고정/가변 디자인 | `CHARACTER_ANCHOR_SPEC.md` v2.0 | `LOCKED`, `CONTROLLED`, `FORBIDDEN` 필드 |
| 공통 아트 방향 | `ART_DIRECTION.md` v2.0 | 2D 약 7등신·3D 5~6등신 Scope |
| Gate 판정 | `ART_REVIEW_CHECKLIST.md` v2.0 | `CHA-Axx`, `CHA-Bxx` 증거 슬롯 |
| AI 생성 이력 | `AI_ASSET_METADATA_TEMPLATE.md` | companion metadata 경로 |
| 경로·상태 | `ART_ASSET_STRUCTURE.md` | Export manifest |
| 파일명·Export | `ASSET_NAMING_GUIDE.md` | Export basename·버전·동반 파일 |
| 과거 라인업 판정 | `ReCamp_CharacterLineup_REVIEW_v003.review.md` | 실패 원인 참고만 허용 |

문서 전문을 Figma에 복사하지 않는다. 필드에는 문서 경로, Anchor ID, Check ID와 현재 버전만
기록해 중복 기준을 만들지 않는다.

## 4. Canvas와 Frame 구성

기본 Canvas는 `3840 × 2160`이며 6개의 `1200 × 920` Frame을 3열 × 2행으로 배치한다.
실제 Figma에서는 아래 그룹을 각각 독립 Frame으로 변환한다.

| Frame | 이름 | 필수 내용 |
|---:|---|---|
| 01 | `Identity_KeyArt` | ID·상태·한 문장 훅·약 7등신 전신·대표 특징·앵커 링크 |
| 02 | `Turnaround` | 약 7등신 Front·Side·Back, 머리 단위 가이드, 장비 크기, 구조 주석 |
| 03 | `Face_Expressions` | 얼굴 앵커와 표정 8종, 128px 비교, 평상시↔임무 상태 대비 |
| 04 | `Outfit_Equipment` | 패션 레이어·기능 근거·장비 접힘/발광/손잡이·Socket 후보 |
| 05 | `Palette_Materials_3DTranslation` | 색·재질·2D→3D 확대/삭제/결합·캐릭터별 3D 목표 등신 |
| 06 | `Gate_Evidence_Approval` | 실루엣·128px 얼굴·저채도·색각·유사성 검토와 사람 결정 |

각 Frame 상단에는 Character ID, Name, Sheet Version, Asset Status, 2D/3D Scope, Owner,
Updated Date, Character Bible Version, Anchor Spec Version을 표시한다.

## 5. 공통 Component

| Component 이름 | 내용 | Variant |
|---|---|---|
| `CMP/Sheet/Header` | Character ID·Name·Version·Scope | `WIP`, `REVIEW`, `APPROVED` |
| `CMP/Sheet/ReferenceLink` | 기준 문서·자산 경로 | `Primary`, `Supporting`, `Rejected` |
| `CMP/Sheet/ArtSlot` | 이미지 자리·캡션·Scale 기준 | `Portrait`, `FullBody`, `Detail`, `Evidence`, `3DTranslation` |
| `CMP/Sheet/Annotation` | 번호·제목·설명·Anchor 강도 | `LOCKED`, `CONTROLLED`, `OPEN`, `FORBIDDEN` |
| `CMP/Sheet/PaletteChip` | HEX·sRGB·용도·재질 | `Primary`, `Secondary`, `Accent`, `Neutral`, `Emission` |
| `CMP/Sheet/GateCell` | Check ID·Result·Evidence·Required Change | `PASS`, `CONDITIONAL`, `FAIL`, `N/A`, `NOT TESTED` |
| `CMP/Sheet/Approval` | 사람 Reviewer·Date·Decision·Scope | `Pending`, `Approved`, `Rejected` |

상태색은 템플릿 관리용이며 최종 게임 UI Design System 색 토큰이 아니다.

```text
WIP         #E9B44C
REVIEW      #58C7B4
APPROVED    #75C46B
REJECTED    #E36A6A
SUPERSEDED  #9298A2
PANEL       #172327 / #223439
TEXT        #F2F0E9 / #AFC1BD
```

## 6. Frame별 필드

### 6.1 Identity / Key Art

- 약 7등신 전신 1개와 대표 포즈 1개
- 캐릭터별 `2D Proportion Target`과 머리 단위 가이드
- 한 문장 비주얼 훅
- `Signature Feature` 1개, `Secondary Feature` 2개
- 역할, 평상시↔임무 상태 성격 키워드, 대표 장비와 팔레트
- `LOCKED`, `CONTROLLED`, `FORBIDDEN` 요약 ID
- Source Image·metadata·review 경로
- 다른 4명과 겹칠 수 있는 모티프와 외부 레퍼런스 유사성 경고

### 6.2 Turnaround

- Front·Side·Back 동일 축과 발 기준선
- 머리 정점, 턱, 어깨, 가슴, 허리, 골반, 무릎, 발 기준선
- 캐릭터별 6.8~7.4등신 목표 범위 표기
- 헤어 앞/뒤 덩어리와 의상 절개선
- 장비 장착·분리·접힘 상태와 실측 상대 크기
- 비대칭 파츠의 좌우 방향
- AI 생성 측·후면은 `REFERENCE ONLY`로 표시하고 사람이 정리한 구조와 구분

### 6.3 Face / Expressions

- 얼굴 정면·3/4 앵커
- 눈매, 홍채, 눈썹, 코, 입, 턱선, 화장과 헤어라인 Detail
- 기본·미소·장난/호감·놀람·임무 집중·화남·슬픔·당황 8종
- 평상시와 임무 상태의 반전 매력을 보여주는 최소 2종 비교
- `128px` 축소 Preview와 다른 4명 얼굴 비교 슬롯
- 얼굴 가림 장비의 투명/가동/해제 상태

### 6.4 Outfit / Equipment

- 패션 Layer 분해와 앞·뒤 결합 구조
- 각 Layer의 기능 또는 캐릭터 서사 근거
- 대표 무기·역할 장비·소형 소품
- 손잡이, 접힘, 개폐, 발광부, 탄도/효과 발생부
- 소재, 두께, 봉제/절개, 수리 흔적, 겹침과 관절 간섭 주석
- `Weapon`, `BladeTip`, `Muzzle`, `Scanner`, `Drone`, `Shield`, `VFXCenter` 중 해당 Socket 후보
- 다른 캐릭터 전용 모티프 침범 여부
- 외부 작품과 유사해 보일 수 있는 절개·무기 구조의 차별화 기록

### 6.5 Palette / Materials / 3D Translation

- Primary·Secondary·Accent와 피부·헤어·눈·금속·발광색
- HEX, sRGB 0–255, 용도, 예상 Material Slot
- 저채도와 명암만 남긴 Palette 비교
- `2D Proportion Target`과 `3D Proportion Target`
- 2D 약 7등신에서 3D 5~6등신으로 옮길 때 확대할 요소
- 삭제할 미세 장식, 결합할 Layer, 줄일 헤어·천 길이
- 머리·손·발·대표 장비 크기, 관절·Rig·관통 위험
- Toon Face/Hair/Outfit/Equipment/Emission 분리 계획
- Poly·Texture·Bone·LOD 수치는 `CHARACTER_3D_SPEC.md`가 생기기 전 `TBD` 유지

### 6.6 Gate Evidence / Approval

- 장비 포함·제거 흑백 실루엣
- 5인 동일 크기 실루엣 비교
- 128px 얼굴 스트립
- 원색·저채도·색각 보정 Preview
- 대표 특징 1개·보조 특징 2개 주석
- 한 문장 훅 전달 여부
- 외부 IP 유사성 검토와 차별화 기록
- `CHA-A01~A16` 결과와 차단 수정
- Gate B용 `CHA-B01~B10` 증거 링크 자리
- 사람 Reviewer·Date·Decision·Approved Scope

`FAIL`이 하나라도 있으면 Frame Header를 `APPROVED`로 바꾸지 않는다. `CONDITIONAL`과
`NOT TESTED`가 남아 있으면 승인 범위와 재검토 조건을 기록한다.

## 7. 캐릭터별 Instance

| Character ID | Page/Frame Prefix | 기본 Accent | 2D 목표 | 3D 목표 | 시작 상태 |
|---|---|---|---:|---:|---|
| CH001 | `Luna/` | Mint | 6.9~7.1 | 5.3~5.4 | WIP |
| CH002 | `Miyu/` | Electric Cyan | 6.8~7.0 | 5.2~5.3 | WIP |
| CH003 | `Coco/` | Jade | 7.0~7.2 | 5.5~5.6 | WIP |
| CH004 | `Iris/` | Crimson | 7.2~7.4 | 5.7~5.8 | WIP |
| CH005 | `Noah/` | Amber | 7.2~7.4 | 5.7~5.8 | WIP |

공통 Component를 Detach하지 않고 Instance 속성으로 텍스트·상태·Accent만 바꾼다. 캐릭터별
페이지 안에서는 `01`부터 `06`까지 Frame 순서를 유지한다.

## 8. Layer 이름

```text
PAGE/CH001_Luna
FRAME/01_Identity_KeyArt
FRAME/02_Turnaround
FRAME/03_Face_Expressions
FRAME/04_Outfit_Equipment
FRAME/05_Palette_Materials_3DTranslation
FRAME/06_Gate_Evidence_Approval
GROUP/Reference
GROUP/Artwork
GROUP/Annotation
GROUP/GateEvidence
GROUP/Translation
COMP/Header
COMP/Status
COMP/PaletteChip
COMP/Approval
```

레이어 이름에 임시 숫자, 개인명, `final_final`, 공백만 있는 이름을 사용하지 않는다.

## 9. Export Manifest

사람 검토에 사용한 Frame만 Export한다.

| Export | 형식 | Scale | 저장 위치 |
|---|---|---:|---|
| 각 Frame 검토본 | PNG | 1x | `art_refs/characters/<character>/<category>/` |
| 6-Frame 통합본 | PDF | 1x | `art_refs/characters/<character>/` |
| 128px 얼굴 증거 | PNG | 정확히 128px 높이 | `art_refs/characters/<character>/expressions/` |
| Palette·실루엣 증거 | PNG | 1x | 해당 concept/review 디렉터리 |
| 2D→3D 변환 비교 | PNG | 1x | `art_refs/characters/<character>/turnaround/` |

파일명은 `ASSET_NAMING_GUIDE.md`, 경로와 상태 의미는 `ART_ASSET_STRUCTURE.md`를 따른다.
Export 후 다음을 확인한다.

- Frame 밖 객체·숨김 WIP·개인 메모가 포함되지 않음
- 폰트 대체, 잘림, 투명 배경, 색 공간 이상 없음
- 파일 상태·버전과 Frame Header가 일치
- metadata와 review 기록 경로가 존재
- 대형 PNG/PDF에 Git LFS 규칙 적용

## 10. 사용 절차

1. v002 SVG를 Figma 또는 동등한 도구로 Import한다.
2. 6개 Board 그룹을 독립 Frame으로 변환하고 공통 요소를 Component로 만든다.
3. 캐릭터 Page를 만들고 Component Instance를 복제한다.
4. Character ID, 한 문장 훅, 2D·3D 목표 비율과 기준 문서 버전을 먼저 입력한다.
5. WIP 이미지를 배치하되 이미지 상태보다 Frame 상태를 높이지 않는다.
6. 약 7등신 Turnaround와 2D→3D 변환표를 함께 작성한다.
7. Gate A 증거와 차단 수정까지 채운다.
8. 사람 검토용 PNG/PDF를 Export해 Git에 저장한다.
9. 사람 Reviewer가 범위·날짜·결정을 기록한 경우에만 승인 상태를 바꾼다.

## 11. ART-0103 완료 판정

저장소 문서로 충족해야 하는 항목:

- 6개 Frame 구조와 필수 필드
- 약 7등신 2D와 5~6등신 3D 분리
- 공통 Component·Variant·Layer 이름
- Gate A/B 증거와 사람 승인 슬롯
- 캐릭터 5인 Instance 규칙
- PNG/PDF Export manifest
- Figma import 가능한 v002 SVG

남은 검증:

- 실제 Figma Import 시 6개 Board와 한글 텍스트 보존
- Component/Variant 변환과 캐릭터 Page Clone
- 샘플 1개 Frame의 PNG·PDF Export
- 사람이 템플릿 가독성과 누락 필드를 검토

위 네 항목 전에는 ART-0103을 `Done`이 아니라 `Review`로 유지한다.
