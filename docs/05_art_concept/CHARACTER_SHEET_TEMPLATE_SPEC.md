# Re:Camp Character Production Sheet Template Specification

> Version: v003
> 최종 갱신: 2026-08-10
> 상태: REVIEW
> Backlog: `ART-0103`, `ART-0111`

이 문서는 캐릭터 제작 시트의 **Frame·Component·필드·Gate 증거·Export 형식**만 정의한다. 전역 로스터·비율·플랫폼은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`, 캐릭터 내용은 Character Bible/Anchor, 판정은 Art Review Checklist가 소유한다.

템플릿은 디자인 결정을 새로 만들거나 특정 캐릭터 내용을 하드코딩하지 않는다.

## 1. Page 구조

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

모든 Current 캐릭터는 같은 Page/Frame 구조를 복제한다.

## 2. 공통 Header

- Character ID·Name.
- Sheet Version·Status.
- Baseline·Bible·Anchor Version.
- Source Asset Version.
- Artist/Tool·Reviewer.
- Updated Date.
- Usage Restriction.
- Gate Status.

`APPROVED`는 사람 Gate 기록이 있을 때만 사용할 수 있다.

## 3. Turnaround

필수:

- Front.
- Side.
- Back.
- 선택: 3/4 Front·3/4 Back.
- 키·머리 높이·골반·어깨·발바닥 기준선.
- 대표 장비 장착/제거 상태.

검토:

- 얼굴·헤어라인·의상 레이어의 시점 간 일치.
- 장비 휴대·활성 구조.
- 장비 없이도 유지되는 실루엣.
- 정확한 비율은 Baseline/Approved 시트를 참조하고 템플릿에 전역 수치를 하드코딩하지 않는다.

## 4. Face·Expressions

필수 얼굴:

- Front Neutral.
- 3/4 Neutral.
- Side.
- 눈·눈썹·코·입·귀·헤어라인 상세.

표정 최소 세트:

- Neutral.
- Smile.
- Focus.
- Angry/Command.
- Hurt.
- Surprise.
- Soft/Embarrassed.
- Victory/Signature.

추가 증거:

- 128px 얼굴.
- 평상시↔임무 상태.
- 얼굴 가림 여부.

## 5. Outfit·Equipment

### 의상

- Base inner.
- Outer layer.
- Lower body.
- Footwear.
- Protection/utility.
- Fastener·stitch·camp mark.

### 장비

- Front·Side·Back.
- Idle·Active·Folded/Stored when relevant.
- Grip·장착 위치.
- VFX/Emission 위치.
- Socket.
- 별도 Prefab 여부.
- Animation/Collider/Physics 주의점.

Production Budget을 넘는 동적 구조는 2D→3D Frame에서 단순화 대안을 반드시 기록한다.

## 6. Color·Material

- Primary·Secondary·Accent·Emission.
- Skin·Hair·Eye.
- Fabric·Plastic·Metal·Transparent·Emission 재질.
- Lit·Shadow·Emission 예시.
- 저채도/색각 비교.
- 배경과 명도 대비.

정확한 값은 Character Bible/Approved 시트가 소유한다.

## 7. Poses·Silhouette

필수:

- Lobby Signature Idle.
- Combat Ready.
- 대표 장비 또는 Skill 사용.
- 흑백 실루엣.
- 장비 on/off.
- 작은 Thumbnail.
- 쿼터뷰 3/4.
- 얼굴·손·장비 가림 검토.

## 8. 2D→3D Simplification

| 항목 | 유지 | 확대 | 단순화/삭제 | 제작 위험 |
|---|---|---|---|---|
| 얼굴 |  |  |  |  |
| 헤어 |  |  |  |  |
| 상체 |  |  |  |  |
| 하체 |  |  |  |  |
| 대표 장비 |  |  |  |  |
| 천·링·케이블 |  |  |  |  |
| 발광·VFX |  |  |  |  |

추가:

- Baseline의 캐릭터별 2D/3D 목표 참조.
- Camera readability priority.
- Bone/Physics 후보 수.
- Socket·Material Slot.
- LOD·Texture·VFX 주의점.
- Production Budget 준수 여부.

이 Frame 없이 최종 3D Blockout을 시작하지 않는다.

## 9. Review·Approval

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

Gate 세부 항목은 `ART_REVIEW_CHECKLIST.md`를 따른다.

## 10. Component

- Header.
- Status Badge.
- Character Info Card.
- Turnaround Slot.
- Expression Cell.
- Equipment Callout.
- Color Token.
- Material Swatch.
- Simplification Table.
- Gate Checklist.
- Approval Block.

Component는 구조만 재사용하고 디자인 값을 내부 텍스트로 고정하지 않는다.

## 11. Figma/편집 도구 검증

ART-0111에서 확인:

- SVG Import.
- Frame·Group·Text Layer 유지.
- Component/Instance Clone.
- 한글 Font 대체와 깨짐.
- 이미지 교체 후 Layout.
- PNG/PDF Export.
- 캐릭터 복제 시 Page/Layer 충돌.
- 사람이 수정·리뷰·승인하기 쉬운지.

## 12. Export

- REVIEW PNG.
- REVIEW PDF.
- 승인 후 별도 Version의 APPROVED PNG/PDF.
- 필요한 개별 Crop.

Manifest:

- File·Page·Frame.
- Version·Status.
- Export Date·Tool Version.
- 출력 크기·Scale.
- Source Version.
- Reviewer.
- 출력 경로.

## 13. 금지

- 승인되지 않은 이미지의 `APPROVED` 표시.
- 빈 Frame 제출.
- Turnaround 없이 모델링 추측을 요구하는 시트.
- Grip·Socket·활성 상태 없는 장비 인계.
- Legacy/Rejected 자산을 Current 최종 Reference로 배치.
- 제품·전역 비율·플랫폼·캐릭터 디자인을 템플릿에서 다시 정의.

## 14. Template 완료 조건

- 실제 편집 도구 Import/Clone 성공.
- 한글과 이미지 교체 정상.
- PNG/PDF Export 정상.
- Gate/Approval 필드 사용 가능.
- 2D→3D 변환표 작성 가능.
- 사람 사용성 검토 통과.

개별 캐릭터 시트 승인은 각 자산 review와 Backlog에서 별도 판정한다.
