# Re:Camp Character Production Sheet Template Specification

> Version: v003
> 최종 갱신: 2026-07-27
> 상태: REVIEW
> Backlog: `ART-0103`, `ART-0111`

이 문서는 캐릭터 제작 시트의 Frame·Component·필드·Gate 증거·Export 계약만 정의한다. 제품·전역 비율은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`, 캐릭터별 목표와 내용은 `CHARACTER_BIBLE.md`, 외형 Anchor는 `CHARACTER_ANCHOR_SPEC.md`, 판정은 `ART_REVIEW_CHECKLIST.md`가 소유한다.

템플릿은 디자인 결정을 새로 만들지 않는다. 소유 문서와 사람 승인 결과를 일관된 형식으로 조립한다.

## 1. 템플릿 상태

```yaml
Backlog: ART-0103 / ART-0111
Template Version: v003
Template Status: REVIEW
Runtime Asset: false
Primary Use: character production and review sheet
Human Approval: pending template usability review
```

`art_source/figma_exports/ReCamp_CharacterSheet_Template_REVIEW_v002.svg`는 기존 Import Proof 파일이다. v003 문서 계약에 맞춘 Figma Component 정리는 ART-0111에서 검증한다.

## 2. 파일 구조

권장 Page:

```text
00_Cover
01_Turnaround
02_Face_Expressions
03_Outfit_Equipment
04_Color_Material
05_Poses_Silhouette
06_2D_to_3D
07_Review_Approval
```

각 캐릭터는 같은 Page·Frame 구조를 복제한다. 캐릭터별 임의 Page 이름을 만들지 않는다.

## 3. 공통 Header

모든 Frame에 다음 정보를 표시한다.

- Character ID·Name.
- Sheet Version·Status.
- Owning Bible·Anchor Version.
- Source Asset Version.
- Artist/Tool·Reviewer.
- Updated Date.
- Usage Restriction.
- Gate Status.

`APPROVED`는 Gate와 사람 승인 기록이 있을 때만 선택할 수 있다.

## 4. Frame 01 — Turnaround

필수:

- Front.
- Side.
- Back.
- 선택: 3/4 Front·3/4 Back.
- 키 기준선·머리 높이 가이드.
- 발바닥·골반·어깨·정수리 기준선.
- 장비 장착·제거 상태.

검토:

- 얼굴·헤어라인·귀·눈 위치 일치.
- 의상 절개·레이어·잠금 장치의 앞뒤 연결.
- 무기 휴대와 접힘 구조.
- 장비 없는 상태에서도 캐릭터 실루엣 구분.
- 캐릭터별 목표는 Bible·Approved review를 참조하고 템플릿에 전역 수치를 하드코딩하지 않는다.

## 5. Frame 02 — Face·Expressions

필수 얼굴:

- Front Neutral.
- 3/4 Neutral.
- Side.
- 눈·눈썹·코·입·귀·헤어라인 상세.

표정 8종:

1. Neutral.
2. Smile.
3. Focus.
4. Angry or Command.
5. Hurt.
6. Surprised.
7. Embarrassed or Soft reaction.
8. Victory or Character-specific signature.

추가 증거:

- 128px 얼굴 비교.
- 평상시↔임무 상태 비교.
- 눈·입을 가리는 장비 여부.

## 6. Frame 03 — Outfit·Equipment

### 의상 분해

- Base inner.
- Outer layer.
- Lower body.
- Footwear.
- Protection and utility parts.
- Fastener·stitch·camp symbol.

### 장비 분해

- Front·Side·Back.
- Folded·Idle·Active 상태.
- 손 Grip과 장착 위치.
- VFX·Emission 발생 위치.
- Socket 이름.
- 분리 Prefab 여부.
- Animation 또는 Collider 주의점.

장비의 장식과 기능을 구분해 주석으로 표시한다.

## 7. Frame 04 — Color·Material

필수:

- Primary·Secondary·Accent·Emission.
- Skin·Hair·Eye·Makeup.
- Fabric·Plastic·Metal·Transparent·Emission 재질.
- Lit·Shadow·Emission 상태 예시.
- 색약·저채도 비교.
- 배경과의 명도 대비.

정확한 팔레트는 Character Bible·Approved 시트가 소유한다. 이 Frame은 최종 값을 기록하는 장소다.

## 8. Frame 05 — Poses·Silhouette

필수 Pose:

- Lobby Signature Idle.
- Combat Ready.
- Primary Skill 또는 대표 장비 사용.

검토 증거:

- 흑백 실루엣.
- 대표 장비 포함·제거.
- 작은 화면 Thumbnail.
- 쿼터뷰 3/4 방향.
- 얼굴·손·장비 가림.
- 다른 캐릭터와 나란히 비교.

## 9. Frame 06 — 2D to 3D Simplification

필수 표:

| 항목 | 2D 유지 | 3D 확대 | 3D 단순화·삭제 | 제작 위험 |
|---|---|---|---|---|
| 얼굴 |  |  |  |  |
| 헤어 |  |  |  |  |
| 상체 |  |  |  |  |
| 하체 |  |  |  |  |
| 대표 장비 |  |  |  |  |
| 천·케이블 |  |  |  |  |
| 발광·VFX |  |  |  |  |

추가 필드:

- Character-specific 2D target.
- Character-specific 3D target.
- Camera readability priority.
- Bone·Physics candidate count.
- Expected Socket·Material Slot.
- LOD·Texture·VFX 주의점.

이 Frame 없이 최종 3D Blockout을 시작하지 않는다.

## 10. Frame 07 — Review·Approval

### Gate A

- 성인 인상과 캐릭터 매력.
- 한 문장 훅.
- 얼굴·체형·패션·역할·실루엣·팔레트.
- 다른 캐릭터와의 구분.
- 외부 IP 유사성.

### Gate B

- Turnaround 일치.
- 장비 구조와 Grip.
- 2D→3D 변환 가능성.
- Rig·Animation·물리 본 위험.
- Material·Socket·Prefab 분리 가능성.

### 승인 필드

```yaml
Gate A: Pass | Conditional | Fail
Gate B: Pass | Conditional | Fail
Reviewer:
Review Date:
Required Changes:
Approved Source:
Approved Export:
Next Version:
Runtime Permission: No | Proof Only | Yes
```

## 11. Component 규칙

공통 Component 후보:

- Header.
- Status Badge.
- Character Info Card.
- Front/Side/Back Slot.
- Expression Cell.
- Equipment Callout.
- Color Token.
- Material Swatch.
- Gate Checklist.
- Approval Block.

Component는 구조를 재사용하고 디자인 내용을 내부 텍스트로 하드코딩하지 않는다.

## 12. Figma Import·사용성 검증

ART-0111에서 다음을 확인한다.

- SVG Import 성공.
- Frame·Group·Text Layer 구조 유지.
- 공통 Component 생성과 Instance Clone.
- 한글 Font 대체와 깨짐 없음.
- 이미지 교체 후 Layout 유지.
- PNG/PDF Export에서 잘림·누락 없음.
- 5명 복제 시 Page·Layer 이름 충돌 없음.
- 사람이 수정·Review·승인하기에 충분히 명확함.

## 13. Export

필수 Export:

- REVIEW PNG.
- REVIEW PDF.
- APPROVED PNG/PDF는 승인 후 별도 Version.
- 필요한 개별 Crop: Face·Turnaround·Equipment·Palette.

Export Manifest:

- Figma File·Page·Frame.
- Sheet Version·Status.
- Export Date·Tool Version.
- 출력 크기·Scale.
- Source Asset Version.
- Reviewer.
- 출력 경로.

파일명은 `ASSET_NAMING_GUIDE.md`를 따른다.

## 14. 금지

- 승인되지 않은 이미지에 `APPROVED` 표시.
- 빈 Frame을 완료로 제출.
- 정면만 있고 측면·후면 구조를 추측하게 하는 시트.
- 장비 접힘·Grip·Socket 없는 모델링 인계.
- 다른 캐릭터의 Component 내용이 복사된 채 남아 있는 Export.
- 역사·REJECTED·Gate 실패 자산을 최종 Reference로 배치.
- 템플릿에서 제품·전역 비율·플랫폼 결정을 별도로 정의.

## 15. 완료 판정

템플릿 자체는 다음을 만족하면 `Done`으로 전환한다.

- Figma Import와 Component Clone 성공.
- 한글과 이미지 교체 정상.
- PNG/PDF Export 정상.
- Gate와 Approval 필드 사용 가능.
- 2D→3D 변환표 작성 가능.
- 사용자 사용성 검토 통과.

개별 캐릭터 시트의 승인은 각 캐릭터 Backlog와 review에서 별도로 판정한다.
