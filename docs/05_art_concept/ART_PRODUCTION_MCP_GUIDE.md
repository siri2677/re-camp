# Re:Camp Art Production MCP Guide

이 문서는 Re:Camp의 2D 콘셉트, 캐릭터 제작 시트, 3D 모델, Unity 통합을 반복 가능하게 만드는 MCP·AI 도구 운영 기준이다.

## 1. 기본 원칙

- MCP는 제작 속도와 반복성을 높이지만 최종 미감과 승인 판단은 사람이 담당한다.
- 한 번 생성한 결과를 최종 디자인으로 바로 사용하지 않는다.
- 승인된 기준 이미지와 제작 시트가 없는 상태에서 고비용 최종 모델링을 시작하지 않는다.
- 도구별 역할을 분리하고 같은 파일을 여러 MCP가 동시에 수정하지 않는다.
- 원본·Export·Unity Asset·Metadata를 분리해 Git에서 추적한다.
- 자동화 성공은 Tool 응답이 아니라 실제 파일, Unity Console, Prefab 구조, PlayMode로 검증한다.

## 2. 현재 도구 구성

| 도구 | 주 역할 | 결과물 |
|---|---|---|
| ComfyUI Cloud MCP | 2D 캐릭터·환경·몬스터·VFX 후보 생성 | PNG, Workflow JSON, Metadata |
| Figma Remote MCP | 캐릭터 제작 시트·UI Design System·리뷰 보드 | Figma Frame, PNG/PDF Export |
| Blender MCP | 3D Blockout·소품·Rig·Animation·FBX Export 보조 | blend, FBX, Texture |
| Coplay | Unity Scene·Prefab·Component·Material·Animator 반복 편집 | Prefab, Scene, Material, Animator |
| Aura | Unity FBX/Texture Import와 Prefab·Material·Animator 구성 검증·보완 | Import 기록, Prefab 검증, 오류 목록 |
| GitHub MCP | 문서·Branch·PR·승인 자산·작업 이력 | Commit, PR, Issue, Review 기록 |
| 코드 에이전트 | C#·Importer·Shader 설정·검증 도구·테스트 | Source, Editor Tool, Test |

Coplay와 Aura는 **둘 다 사용한다.** 하나를 제거하거나 서로 완전히 대체하는 구조가 아니다.

## 3. 도입과 실행 순서

```text
1. ComfyUI + Figma로 루나 기준 시트 제작 기반
2. Blender로 단검 또는 소품 Export Proof
3. Unity 6.3 LTS URP 프로젝트 생성
4. Coplay로 Import·Prefab 자동화 Proof
5. Aura로 동일 FBX Import·Prefab 검증 Proof
6. 두 도구의 역할·제약 기록
7. 루나 3D Blockout과 Character Proof
```

GitHub MCP는 전 단계의 문서·Commit·PR·Metadata 관리에 계속 사용한다.

## 4. ComfyUI Cloud MCP

### 담당 작업

- 캐릭터 단독 전신 후보
- 동일 캐릭터 얼굴·의상 변형
- 표정·포즈·장비 후보
- 폐허·캠프 Color Key
- 몬스터와 보스 실루엣
- VFX Concept Sheet

### 작업 흐름

```text
CHARACTER_BIBLE 확인
→ 기준 Reference 선택
→ 고정 변수와 Seed 적용
→ 후보 3안 생성
→ 사람 리뷰
→ 선택 후보만 저장
→ Figma 제작 시트로 정리
```

### 일관성 규칙

- 다섯 캐릭터를 매번 한 장에서 새로 생성하지 않는다.
- 캐릭터별 기준 이미지를 개별 Reference로 사용한다.
- 얼굴·헤어·의상·무기·색상을 고정 변수로 관리한다.
- Checkpoint, VAE, LoRA, Adapter, ControlNet, Seed, Sampler, CFG, 해상도를 기록한다.
- 대량 후보를 모두 Git에 저장하지 않고 리뷰 가치가 있는 후보만 보관한다.
- 생성된 측면·후면을 구조 검증 없이 Turnaround로 승인하지 않는다.

상세 기준은 `COMFYUI_CHARACTER_CONSISTENCY_SPEC.md`를 따른다.

## 5. Figma Remote MCP

### 담당 작업

- 5인 라인업 보드
- 캐릭터별 Approved 제작 시트
- 얼굴·표정·Turnaround·장비·재질 주석
- UI Design System
- 화면 Wireframe과 Flow
- VFX·Skill Icon 보드
- WIP / REVIEW / APPROVED 상태 표시

### 운영 규칙

- 캐릭터별 Page와 Version을 분리한다.
- 공통 Component로 제목·승인 상태·팔레트·주석을 관리한다.
- Figma 원본만 존재하고 Git Export가 없는 상태를 Approved로 보지 않는다.
- 승인 Frame만 PNG/PDF로 Export하고 Metadata를 함께 저장한다.

## 6. Blender MCP

### 우선 Proof

완성 캐릭터보다 작은 자산으로 Export 규칙을 먼저 검증한다.

```text
루나 에너지 단검
또는 단순 캠프 소품
→ Scale·Axis·Pivot·Material Slot 확인
→ FBX Export
→ Coplay/Aura Import Proof
```

### 담당 범위

- 5~6등신 신체 Blockout
- 헤어·의상·무기의 큰 형태
- 장비 크기·Grip·Socket 위치
- 공용 Humanoid Rig 적용 보조
- Animation Clip 제작·Export 보조
- 캠프 시설·환경 Modular Kit·몬스터 Blockout

### 사람 검수 필수

- 얼굴 조형
- Retopology
- UV·Texture
- Weight Painting
- 관절 변형
- 의상·헤어 관통
- 표정 BlendShape
- 물리 Bone

### 3D 순서

```text
2D Approved 제작 시트
→ 저해상도 Blockout
→ Unity Camera·실루엣 검증
→ 비율·무기·장식 수정
→ 최종 모델·UV·Texture
→ Rig·Weight·표정
→ Animation
→ 최종 Unity 검증
```

## 7. Coplay

Coplay는 Unity Editor 내부의 반복 편집과 구조 생성을 우선 담당한다.

### 담당 작업

- FBX·Texture Import 설정 적용
- Material·Toon Shader 연결
- 표준 캐릭터 Prefab Hierarchy 생성
- Animator Controller·Avatar 연결
- Collider·Hitbox·Socket 배치
- Script와 ScriptableObject Reference 연결
- Scene 배치와 반복 수정
- 다수 GameObject·Component의 Batch 편집
- 누락 Reference와 Console 오류 확인

### 적합한 작업

```text
정의된 Spec을 여러 Asset에 동일 적용
Prefab Template 생성
Scene의 반복 배치·수정
Component Property Batch Patch
변경 후 Hierarchy·Reference 확인
```

## 8. Aura

Aura는 동일한 Unity 통합 작업을 독립적으로 검증하고 Import·Prefab·Material·Animator 설정을 보완하는 경로로 사용한다.

### 담당 작업

- FBX·Texture Import 결과 검증
- Scale·Axis·Rig·Avatar 오류 확인
- Material·Shader·Texture 누락 확인
- Prefab Hierarchy와 Component 구성 검증
- Animator·Animation Clip 연결 확인
- Missing Script·Missing Reference·Console Error 확인
- Coplay 수행이 어려운 작업의 대체 또는 보완

### 운영 원칙

Aura를 단순 읽기 전용으로 제한하지 않는다. 실제 수정에 사용할 수 있지만, 같은 자산을 Coplay가 수정 중일 때 동시에 수정하지 않는다.

## 9. Coplay / Aura 공동 Proof

### 테스트 입력

```text
동일 FBX
동일 Texture
동일 Unity 프로젝트
동일 Import·Prefab Spec
```

### 테스트 단계

```text
1. 깨끗한 테스트 폴더 준비
2. Coplay를 Primary로 Import·Prefab 구성
3. 결과 Commit 또는 Diff 기록
4. 원복 또는 별도 복제 폴더 준비
5. Aura로 동일 테스트 수행·검증
6. 두 결과의 차이와 수동 작업 기록
7. 작업 종류별 Primary Tool 결정
```

### 비교 항목

- 처리 가능한 Import Property
- Material·Texture 연결 정확도
- Humanoid Avatar 생성
- Prefab Hierarchy
- Animator·Clip 연결
- Collider·Socket 배치
- Reference 누락
- Console Error
- 생성 파일의 예측 가능성
- Batch 작업 효율
- 재실행 시 멱등성

### 기록 Template

```text
Test Asset:
Primary Tool:
Validator Tool:
Tool Version:
Operations:
Created/Modified Files:
Succeeded:
Failed:
Manual Fix:
Unity Console:
Prefab Diff:
Recommended Role:
```

## 10. Unity 통합 원칙

- Blender 원본을 Unity에서 직접 참조하지 않고 승인된 FBX Export를 사용한다.
- Prefab 공통 Hierarchy를 먼저 확정한다.
- 게임 규칙을 캐릭터별 MonoBehaviour에 중복 구현하지 않는다.
- ReCamp.Core와 Adapter·Presentation 계층을 분리한다.
- Import·Material·Animator 규칙은 Editor Script로 고정할 수 있으면 코드화한다.
- 실제 Camera Preset에서 실루엣을 검증한다.
- Windows에서 품질·성능을 먼저 측정하고 Android 품질 단계를 후속 검증한다.

## 11. GitHub MCP

### 담당 작업

- 작업 ID와 Issue·PR 연결
- Reference·Spec·Metadata 버전 관리
- WIP·REVIEW·APPROVED 자산 변경 추적
- Branch와 Draft PR 관리
- Unity ProjectSettings·Package 변경 리뷰
- Tool Proof 결과 기록

### Branch 예시

```text
art/luna-concept
art/luna-3d-proof
art/environment-ruined-street
art/ui-design-system
feature/unity-project-setup
feature/core-loop
```

## 12. Token·Context 절감 규칙

MCP 호출은 필요한 정보만 조회한다.

- 전체 Hierarchy보다 이름·Tag·Component Filter 사용
- 여러 Component 수정은 Batch Operation으로 묶음
- 변경 후 전체 Scene 대신 Diff·Summary 확인
- 긴 Log는 Error·Warning과 관련 Stack만 요청
- Skill에 반복 작업 순서와 기본 Property를 저장
- C#·JSON·문서 파일 편집은 가능한 경우 직접 파일 작업 사용
- Coplay와 Aura에 같은 Context를 중복 전달하지 않고 테스트 기록을 재사용

## 13. 전체 파이프라인

```text
CURRENT_PROJECT_BASELINE
→ Character Bible·Art Direction
→ ComfyUI 후보와 Metadata
→ Figma Approved 제작 시트
→ Blender Blockout·FBX
→ Camera Gray Box
→ Coplay Import·Prefab
→ Aura 검증·보완
→ 사람 Review
→ Character Proof
→ GitHub 승인 기록
```

## 14. 인간 승인 Gate

### Gate A — 캐릭터 매력

- 얼굴과 실루엣이 기억에 남는가
- 역할과 성격이 외형에서 느껴지는가

### Gate B — 제작 가능성

- 3D와 Animation으로 구현 가능한가
- 작은 장식과 물리 비용이 통제되는가

### Gate C — Unity 통합

- 2D와 3D가 같은 캐릭터로 보이는가
- 쿼터뷰에서 얼굴·상체·무기가 읽히는가
- Coplay/Aura 결과가 재현 가능한가

### Gate D — 성능과 출시

- Windows 목표 성능을 유지하는가
- Android 품질 단계로 확장 가능한가
- 라이선스와 AI Metadata가 확인되는가
