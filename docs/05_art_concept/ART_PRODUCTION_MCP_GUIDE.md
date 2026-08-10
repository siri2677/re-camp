# Re:Camp Current Generation Art Production MCP Guide

> 역할: 이미지·Figma·Blender·Unity·GitHub 도구의 반복 가능한 운영 절차

제품·전역 비주얼·로스터·비율·Production Budget은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`, 캐릭터 내용은 Character Bible/Anchor, 표현 규칙은 Art Direction을 따른다. 이 문서에 해당 결정을 다시 적지 않는다.

## 1. 원칙

- MCP와 생성 도구는 속도·반복성·기록을 돕는 수단이며 미감·매력·승인은 사람이 담당한다.
- 현재 가능한 도구로 시작하고 실제 반복 비용이 병목일 때만 추가 도구를 도입한다.
- 한 번의 생성 결과를 최종 디자인으로 확정하지 않는다.
- Source·Export·Runtime을 분리한다.
- 결과에는 Version·metadata·review를 남긴다.
- Legacy·REJECTED·INVALID·Gate 실패 자산을 Current 제작 Anchor로 사용하지 않는다.

## 2. 도구 역할

| 도구 | 역할 | 시점 |
|---|---|---|
| 이미지 생성/편집 | 후보·얼굴·표정·장비·환경 Color Key | 초기 탐색·부분 수정 |
| Figma 또는 동등 도구 | 제작 시트·주석·팔레트·UI System | 후보 정리·승인 Export |
| Blender | 소품 Proof·Blockout·Model·Rig·Animation·FBX | Approved 기준 이후 |
| Coplay/unityMCP | Import·Prefab·Material·Animator·Scene·검증 | Unity 통합 |
| GitHub | Branch·PR·문서·Version 관리 | 모든 단계 |
| ComfyUI | 대량 일관성·정밀 인페인팅 | 실제 병목일 때만 |

## 3. 작업 시작

1. 현재 branch·HEAD·변경 상태 확인.
2. Canonical Baseline과 대상 Backlog ID 확인.
3. Baseline의 필수 Read Set에서 필요한 디자인 계약만 읽기.
4. 대상 자산의 최신 metadata/review/Approved 상태 확인.
5. Source·Export·Runtime 경로와 판정 기준을 먼저 정하기.

## 4. 2D 후보

```text
Character Bible / Anchor
→ 후보 목적 정의
→ 통제 후보 생성
→ 얼굴·실루엣·저채도·장비 on/off 비교
→ 부분 수정
→ metadata
→ REVIEW Export
→ 사람 Gate
```

입력에는 Character ID·한 문장 훅·LOCKED/CONTROLLED/FORBIDDEN·산출물 목적·시점·배경 조건을 넣는다. 외부 작품 직접 모방을 금지하고, 기존 Reference는 Approved Current 자산일 때만 제작 입력으로 사용한다.

## 5. 제작 시트

1. `CHARACTER_SHEET_TEMPLATE_SPEC.md` Frame을 복제한다.
2. 선택한 REVIEW 자산과 metadata를 연결한다.
3. Turnaround·표정·장비·팔레트·2D→3D 변환표를 채운다.
4. Gate 증거와 수정 이력을 기록한다.
5. REVIEW PNG/PDF를 Export한다.
6. 사람 승인 후 새 Version으로 APPROVED Source/Export를 만든다.

## 6. Blender

### 소품 Proof

- 규격 이름의 단순 소품을 만든다.
- 단위·축·Pivot·Socket·Material Slot을 설정한다.
- `.blend` Source와 FBX Export를 저장한다.
- Tool Version과 Export 설정을 Manifest에 기록한다.

### 캐릭터

- Approved 제작 시트와 2D→3D 변환표 이후 시작한다.
- Blockout 단계에서 쿼터뷰 실루엣·관통·장비 크기를 먼저 검증한다.
- 공용 Base/Rig/Shader/Animator를 우선한다.
- Production Budget을 넘는 Cloth/Cable/독립 Physics는 필수 요구로 만들지 않는다.

## 7. Unity 통합

```text
Import
→ Preset
→ Material·Avatar·Clip
→ Prefab
→ Socket·Collider·LOD·Animator
→ Compile·Console
→ EditMode·PlayMode
→ Direct Scene Probe
→ Gate C·Android Evidence
```

Gameplay Root와 Visual Root를 분리하고, Damage·Cooldown·이동·정산을 Presentation 자산으로 옮기지 않는다.

## 8. 수정 기록

수정 요청은 다음 형태로 남긴다.

```text
문제 위치
→ 현재 결과
→ 위반한 Anchor/Gate
→ 변경할 요소
→ 유지할 요소
→ 새 Version
→ 검증 방법
```

부분 수정이 가능하면 전체를 다시 생성하지 않는다.

## 9. Metadata 최소 항목

- Tool/Model·Version·Workflow·Seed.
- Input Reference와 사용 권한.
- 작업 지시 요약.
- Human Edits.
- Status·Reviewer·Date.
- Pass/Fail 근거와 다음 Version.
- External-IP Similarity.
- Source·Export·Runtime 경로.

## 10. 실패 처리

다음은 REVIEW 승격 없이 REJECTED/INVALID 처리한다.

- 빈 파일·손상·LFS 오류.
- Anchor 중대한 위반.
- 외부 IP 고유 요소 직접 복제.
- 워터마크·권리 불명 로고.
- Source/metadata가 없어 재현 불가.

## 11. 완료 보고

- 작업 ID와 상태.
- Source·Export·Runtime 경로.
- Version.
- Gate·Unity Test·기기 증거.
- 사람 승인 여부.
- 실패와 다음 작업.

이 문서는 Current Generation의 디자인 자체를 소유하지 않는다.
