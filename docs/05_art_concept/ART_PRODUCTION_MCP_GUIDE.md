# Re:Camp Art Production MCP Guide

이 문서는 Re:Camp의 2D 콘셉트, 캐릭터 제작 시트, 3D 모델, Unity 통합을 반복 가능하게 만드는 MCP·AI 도구 운영 기준이다.

## 1. 기본 원칙

- MCP는 제작 속도와 반복성을 높이지만 최종 미감과 승인 판단은 사람이 담당한다.
- 한 번 생성한 결과를 최종 디자인으로 바로 사용하지 않는다.
- 승인된 기준 이미지와 제작 시트 없이 고비용 최종 모델링을 시작하지 않는다.
- 도구별 역할을 분리하고 원본·Export·Unity Asset·Metadata를 구분한다.
- 자동화 성공은 Tool 응답이 아니라 실제 파일, Unity Console, Prefab 구조, PlayMode로 검증한다.
- 별도 월 구독이 필요한 도구를 필수 선행 조건으로 두지 않는다.

## 2. 현재 도구 구성

| 도구 | 주 역할 | 결과물 |
|---|---|---|
| ComfyUI Cloud MCP | 2D 캐릭터·환경·몬스터·VFX 후보 생성 | PNG, Workflow JSON, Metadata |
| Figma Remote MCP | 캐릭터 제작 시트·UI Design System·리뷰 보드 | Figma Frame, PNG/PDF Export |
| Blender MCP | 3D Blockout·소품·Rig·Animation·FBX Export 보조 | blend, FBX, Texture |
| Coplay MCP | Unity Scene·Prefab·Component·Material·Animator 반복 편집 | Prefab, Scene, Material, Animator |
| GitHub MCP | 문서·Branch·PR·승인 자산·작업 이력 | Commit, PR, Issue, Review 기록 |
| 코드 에이전트 | C#·Importer·Shader 설정·검증 도구·테스트 | Source, Editor Tool, Test |
| Unity 수동 검수 | Inspector·Console·Prefab Diff·PlayMode·Profiler | QA Report, Screenshot, Profiler Record |

Aura AI는 1회성 무료 크레딧 이후 유료 사용이 필요한 구조이므로 기본 파이프라인에서 제외한다.

## 3. 실행 순서

```text
1. ComfyUI + Figma로 루나 기준 시트 제작 기반
2. Blender로 단검 또는 소품 Export Proof
3. Unity 6.3 LTS URP 프로젝트 생성
4. Coplay로 Import·Prefab 자동화 Proof
5. Import Preset·Validation Editor Tool 작성
6. Inspector·Console·Prefab Diff·PlayMode 수동 QA
7. 루나 3D Blockout과 Character Proof
```

## 4. ComfyUI Cloud MCP

### 담당 작업

- 캐릭터 단독 전신 후보
- 동일 캐릭터 얼굴·의상 변형
- 표정·포즈·장비 후보
- 폐허·캠프 Color Key
- 몬스터·보스 실루엣
- VFX Concept Sheet

### 작업 흐름

```text
Character Bible 확인
→ 기준 Reference 선택
→ 고정 변수와 Seed 적용
→ 후보 3안 생성
→ 사람 리뷰
→ 선택 후보만 저장
→ Figma 제작 시트 정리
```

### 일관성 규칙

- 캐릭터별 기준 이미지를 개별 Reference로 사용한다.
- 얼굴·헤어·의상·무기·색상을 고정 변수로 관리한다.
- Checkpoint, VAE, LoRA, Adapter, ControlNet, Seed, Sampler, CFG, 해상도를 기록한다.
- 대량 후보를 전부 Git에 저장하지 않는다.
- 생성된 측면·후면을 구조 검증 없이 Turnaround로 승인하지 않는다.

## 5. Figma Remote MCP

### 담당 작업

- 5인 라인업 보드
- 캐릭터별 Approved 제작 시트
- 얼굴·표정·Turnaround·장비·재질 주석
- UI Design System
- 화면 Wireframe과 Flow
- VFX·Skill Icon 보드

### 운영 규칙

- 캐릭터별 Page와 Version을 분리한다.
- 공통 Component로 승인 상태·팔레트·주석을 관리한다.
- Figma 원본만 있고 Git Export가 없으면 Approved로 보지 않는다.
- 승인 Frame만 PNG/PDF로 Export하고 Metadata를 저장한다.

## 6. Blender MCP

### 우선 Proof

```text
루나 에너지 단검 또는 단순 캠프 소품
→ Scale·Axis·Pivot·Material Slot 확인
→ FBX Export
→ Coplay Import Proof
→ Validation Tool·수동 QA
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

## 7. Coplay MCP

### 담당 작업

- FBX·Texture Import 설정 적용
- Material·Toon Shader 연결
- 표준 캐릭터 Prefab Hierarchy 생성
- Animator Controller·Avatar 연결
- Collider·Hitbox·Socket 배치
- Script와 ScriptableObject Reference 연결
- Scene 배치와 반복 수정
- 다수 GameObject·Component Batch 편집
- 누락 Reference와 Console 오류 확인

### 운영 원칙

- 대상 Scene·Prefab·파일을 명확히 지정한다.
- 여러 수정은 Batch Operation으로 묶는다.
- 변경 후 전체 Hierarchy보다 Diff·Summary·Console을 확인한다.
- Coplay가 지원하지 않는 Property는 Preset·Editor Script·수동 Inspector로 처리한다.

## 8. Unity Import Preset·Validation Tool

반복 가능한 규칙은 Unity Editor 코드로 고정한다.

### 자동 적용 후보

- FBX Scale·Rig·Animation Import
- Texture Type·sRGB·Max Size·Compression
- Material 생성·Texture 연결
- Prefab 기본 Hierarchy
- Socket·Collider·LODGroup 생성

### 자동 검사

```text
파일명·경로
Scale Factor·Axis
Rig Type·Avatar
Material·Texture Missing
Prefab 표준 Hierarchy
필수 Component
Collider·Hitbox·Socket
Animator Controller
LODGroup
Missing Script·Reference
```

검사 결과는 Console뿐 아니라 Text 또는 JSON Report로 저장한다.

## 9. 수동 Unity QA

자동화 후 반드시 확인한다.

- Inspector Import Property
- Console Error·Warning
- Prefab Diff
- Humanoid Avatar Configure
- Animation·Collider·Reference PlayMode
- Default Camera 실루엣
- Profiler CPU·GPU·Memory
- Material 미감과 관통

## 10. GitHub MCP

- 작업 ID와 Issue·PR 연결
- Reference·Spec·Metadata 버전 관리
- WIP·REVIEW·APPROVED 자산 추적
- Unity ProjectSettings·Package 변경 리뷰
- Coplay·Validation Tool·수동 QA 결과 기록

## 11. Token·Context 절감

- 전체 Hierarchy 대신 이름·Tag·Component Filter 사용
- 여러 Component 수정은 Batch Operation으로 묶음
- 변경 후 전체 Scene 대신 Diff·Summary 확인
- 긴 Log는 Error·Warning과 관련 Stack만 요청
- Skill에 반복 작업 순서와 기본 Property 저장
- C#·JSON·문서는 직접 파일 작업 우선
- 검증 결과를 Report로 저장해 같은 Context를 반복 전달하지 않음

## 12. 전체 파이프라인

```text
Current Project Baseline
→ Character Bible·Art Direction
→ ComfyUI 후보와 Metadata
→ Figma Approved 제작 시트
→ Blender Blockout·FBX
→ Camera Gray Box
→ Coplay Import·Prefab
→ Editor Preset·Validation Tool
→ 수동 Unity QA
→ Character Proof
→ GitHub 승인 기록
```

## 13. 인간 승인 Gate

### Gate A — 캐릭터 매력

- 얼굴과 실루엣이 기억에 남는가
- 역할과 성격이 외형에서 느껴지는가

### Gate B — 제작 가능성

- 3D와 Animation으로 구현 가능한가
- 작은 장식과 물리 비용이 통제되는가

### Gate C — Unity 통합

- 2D와 3D가 같은 캐릭터로 보이는가
- 쿼터뷰에서 얼굴·상체·무기가 읽히는가
- Coplay 결과가 Preset·Validation Tool·수동 QA로 재현 가능한가

### Gate D — 성능과 출시

- Windows 목표 성능 유지
- Android 품질 단계 확장 가능
- 라이선스와 AI Metadata 확인
