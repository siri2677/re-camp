# Re:Camp Art Production MCP Guide

> Version: v002
> 최종 갱신: 2026-07-27
> 상태: Active Operational Guide

이 문서는 이미지·Figma·Blender·Unity·GitHub 도구를 반복 가능하게 사용하는 절차만 정의한다. 제품·플랫폼·전역 비주얼·로스터는 `docs/00_project/CURRENT_PROJECT_BASELINE.md`, 캐릭터 내용은 `CHARACTER_BIBLE.md`와 `CHARACTER_ANCHOR_SPEC.md`, 표현 규칙은 `ART_DIRECTION.md`를 따른다.

## 1. 기본 원칙

- MCP와 생성 도구는 속도·반복성·기록을 돕는 수단이며 미감과 승인 판단은 사람이 담당한다.
- 도구 설치 자체를 선행 조건으로 두지 않는다. 현재 가능한 경로로 시작하고 실제 병목이 확인될 때 도구를 확장한다.
- 한 번의 생성 결과를 최종 디자인으로 확정하지 않는다.
- 동일 작업을 여러 도구가 동시에 수정하지 않게 단계별 소유 도구를 정한다.
- Source·Export·Runtime을 분리하고 모든 전달 결과에 Version·metadata·review를 남긴다.
- 역사·REJECTED·INVALID·Gate 실패 자산을 새 디자인의 입력 기준으로 사용하지 않는다.

## 2. 도구 역할

| 도구 | 역할 | 사용 시점 |
|---|---|---|
| 이미지 생성·편집 도구 | 후보·표정·포즈·장비·환경 Color Key | 초기 탐색과 부분 수정 |
| Figma 또는 동등 도구 | 제작 시트·팔레트·주석·UI System | 후보 정리부터 승인 Export |
| Blender | 소품 Proof·Blockout·모델·Rig·Animation·FBX | 승인된 기준과 제작 계약 이후 |
| Coplay/unityMCP | Import·Prefab·Material·Animator·Scene·검증 | Unity 통합과 회귀 |
| GitHub 도구 | Branch·PR·Issue·문서·Version 관리 | 모든 기록과 통합 |
| ComfyUI | 대량 일관성·정밀 인페인팅·재현 워크플로 | 반복 비용이 실제 병목일 때만 |

ComfyUI는 현재 `Deferred`다. Seed·LoRA·ControlNet·IP-Adapter 고정이 실제 필요해질 때 별도 Backlog에서 도입한다.

## 3. 작업 시작

1. 현재 브랜치·HEAD·변경 상태를 확인한다.
2. Baseline과 대상 Backlog ID를 읽는다.
3. Baseline의 작업별 필수 Read Set에서 필요한 디자인 계약만 읽는다.
4. 대상 자산의 최신 metadata·review·Approved 여부를 확인한다.
5. 결과 파일명·Source·Export·Runtime 경로를 먼저 정한다.
6. 성공·실패 판정과 사람 승인자가 무엇인지 정한다.

## 4. 2D 후보 제작

```text
Character Bible·Anchor
→ 후보 목적 정의
→ 단독 후보 생성
→ 얼굴·실루엣·저채도 비교
→ 부분 수정
→ metadata
→ REVIEW Export
→ 사람 판정
```

### 생성 입력에 포함할 내용

- 캐릭터 ID와 한 문장 훅.
- `LOCKED`, `CONTROLLED`, `FORBIDDEN` 요소.
- 목적: 전신 후보, 얼굴, 표정, 장비, 포즈 등.
- 필요한 시점과 배경 조건.
- 외부 작품 직접 모방 금지.
- 기존 Approved Reference가 있을 때만 입력 참조로 사용.

### 출력 검토

- 얼굴·손·신체 구조 오류.
- 나이와 성인 인상.
- 헤어·의상·장비 일관성.
- 실루엣과 역할 가독성.
- 캐릭터 간 중복.
- 워터마크·문자 오류·권리 불명 요소.

## 5. Figma 제작 시트

1. `CHARACTER_SHEET_TEMPLATE_SPEC.md`의 Frame을 복제한다.
2. REVIEW 자산과 metadata를 연결한다.
3. Turnaround·표정·장비·팔레트·변환표를 채운다.
4. Gate 증거와 수정 이력을 기록한다.
5. PNG/PDF REVIEW Export를 만든다.
6. 사람 승인 후 새 Version의 APPROVED Source·Export를 만든다.

Figma 문서는 디자인 결정을 새로 만들지 않고 소유 문서와 승인 결과를 조립한다.

## 6. Blender 제작

### 소품 Proof

- 규격 이름의 단순 소품을 만든다.
- 단위·축·Pivot·Socket·Material Slot을 설정한다.
- `.blend` Source와 FBX Export를 저장한다.
- Manifest와 Blender Version·Export 설정을 기록한다.

### 캐릭터 제작

- Approved 제작 시트와 3D 계약을 확인한다.
- Blockout 단계에서 쿼터뷰 실루엣·관통·장비 크기를 먼저 검증한다.
- Gate B/C 전에는 최종 Texture·세부 장식·대량 Animation을 진행하지 않는다.
- 공용 Base·Rig를 사용하되 개별 얼굴·체형·헤어·장비를 보존한다.

## 7. Unity 통합

```text
FBX/Texture/Audio Import
→ Preset 적용
→ Material·Avatar·Clip 설정
→ Prefab 조립
→ Socket·Collider·LOD·Animator 연결
→ Compile·Console
→ EditMode·PlayMode
→ 직접 Scene Probe
→ Gate C·Android 증거
```

- 기능 Root와 Visual Root를 분리한다.
- Importer·Prefab 변경은 version control에 남는 자산으로 저장한다.
- Damage·Cooldown·이동·정산 규칙을 Presentation 자산으로 옮기지 않는다.
- Unity 결과와 Source·Manifest를 역추적할 수 있어야 한다.

## 8. 수정 루프

수정 요청은 모호한 감상 대신 다음 형식으로 기록한다.

```text
문제 위치
→ 현재 결과
→ 위반한 소유 문서·Anchor·Gate 항목
→ 변경해야 할 요소
→ 유지해야 할 요소
→ 새 Version과 검증 방법
```

부분 수정이 가능한 경우 전체를 다시 생성하지 않는다. 얼굴만, 장비만, 실루엣만 고칠 때 입력 범위를 제한한다.

## 9. Metadata·Review

모든 생성·편집 결과에 다음을 기록한다.

- Tool/Model·Version·Workflow·Seed.
- 입력 Reference와 사용 권한.
- Prompt 또는 작업 지시 요약.
- Human Edits.
- Status·Reviewer·Date.
- Pass·Fail 근거와 다음 Version.
- 외부 IP 유사성.
- Source·Export·Runtime 경로.

## 10. 실패 처리

다음은 즉시 `REJECTED` 또는 `INVALID`로 처리한다.

- 빈 이미지·손상 파일·LFS Pointer 오류.
- 캐릭터 조건이나 Anchor 중대한 위반.
- 성별·연령 인상이 목표와 다름.
- 외부 작품의 고유 디자인 직접 복제.
- 워터마크·권리 불명 로고.
- Source·metadata가 없어 재현할 수 없음.

실패 파일은 원인 기록을 남기되 다음 후보의 제작 Anchor로 사용하지 않는다.

## 11. 도구별 연결 실패

- Figma·Blender·Unity MCP 연결 실패를 자산 실패와 혼동하지 않는다.
- 연결 문제는 Tool Version·Transport·Instance·Port·Error를 기록한다.
- Unity는 `_ReCamp` 오류와 MCP Transport 로그를 분리해 확인한다.
- 도구 연결이 없어도 가능한 문서·후보·코드 작업은 계속하되 검증하지 않은 결과를 완료 처리하지 않는다.

## 12. 완료 보고

작업 종료 시 다음만 간결하게 보고한다.

- 작업 ID와 결과 상태.
- Source·Export·Runtime 경로.
- 생성·수정 Version.
- 검증한 Gate·Unity Test·기기.
- 사람 승인 여부.
- 발견된 실패와 다음 작업.

이 문서에서 제품 방향·전역 비율·캐릭터 설정을 다시 정의하지 않는다.
