# Re:Camp ComfyUI Character Consistency Spec

이 문서는 ComfyUI 또는 동등한 이미지 생성 도구로 Re:Camp 캐릭터를 반복 제작할 때 얼굴·헤어·의상·장비·색상 일관성을 유지하기 위한 기준이다.

## 1. 목적

- 동일 캐릭터가 출력마다 다른 인물처럼 변하는 문제를 줄인다.
- 한 번 승인한 기준 이미지를 이후 작업의 고정 입력으로 사용한다.
- 프롬프트, 모델, 시드, 해상도, 후처리 설정을 재현 가능하게 기록한다.
- 생성 결과를 Unity·3D 제작 시트로 안전하게 넘길 수 있도록 구조를 검수한다.

## 2. 캐릭터 생성 단위

다섯 캐릭터를 한 번에 새로 생성하지 않는다.

```text
캐릭터 1명 선택
→ 기준 이미지 승인
→ 동일 캐릭터의 표정·포즈·장비 변형
→ 제작 시트 정리
→ 다음 캐릭터 진행
```

첫 번째 기준 캐릭터는 루나다.

## 3. 고정 변수와 변경 변수

### 고정 변수

캐릭터 기준 이미지가 승인된 뒤에는 다음 항목을 고정한다.

- 얼굴형
- 눈 모양과 눈동자 색
- 피부 톤
- 앞머리와 옆머리 구조
- 헤어 길이와 대표 색
- 신체 비율
- 상의·하의 기본 절개
- 대표 장비의 형태와 크기
- 대표 색상 3개
- 캐릭터별 핵심 실루엣

### 변경 가능 변수

작업 목적에 따라 다음 항목만 변경한다.

- 표정
- 손동작
- 시선
- 카메라 각도
- 전투·일상 포즈
- 배경
- 조명 강도
- 계절 또는 상황에 따른 보조 소품

변경 가능 변수라도 승인된 의상과 장비 구조를 훼손해서는 안 된다.

## 4. 권장 워크플로 구조

```text
Checkpoint / Base Model
→ Character LoRA 또는 Reference Adapter
→ Pose Control
→ Prompt Conditioning
→ Latent Generation
→ High-resolution Fix
→ Face/Hand Correction
→ Background Removal 또는 배경 합성
→ Metadata 저장
```

가능하면 캐릭터별 워크플로를 분리한다.

```text
art_source/comfyui_workflows/
├── common/
├── luna/
├── miyu/
├── coco/
├── iris/
└── noah/
```

## 5. 기준 이미지 사용 규칙

- `APPROVED` 상태의 개별 캐릭터 이미지만 기준 입력으로 사용한다.
- 통합 라인업 이미지는 초기 탐색과 5인 일관성 비교에만 사용한다.
- 새로운 생성 결과가 기존 승인본을 자동으로 대체하지 않는다.
- 기준 이미지를 변경하면 버전과 변경 이유를 기록한다.
- 얼굴 기준, 전신 기준, 장비 기준 이미지를 가능하면 분리한다.

## 6. 프롬프트 구조

프롬프트는 다음 블록으로 분리한다.

```text
[프로젝트 공통 스타일]
[캐릭터 고정 정체성]
[의상·장비 구조]
[현재 포즈·표정]
[카메라·조명]
[출력 목적]
```

### 프로젝트 공통 스타일 예시

```text
stylized subculture game character,
soft hopeful post-apocalyptic world,
clean anime-inspired rendering,
clear silhouette, mobile game readability,
soft toon shading, controlled material detail
```

### 루나 고정 정체성 예시

```text
Luna, female scout and melee explorer,
cat-ear hood, short active jacket,
lightweight 5-to-6-head stylized proportion,
mint and cream main palette with limited pink accents,
compact energy dagger, small scanner and backpack,
playful expression with alert professional eyes
```

### Negative 기준

```text
photorealistic, military realism, gore, horror,
excessive accessories, hidden face, oversized backpack,
inconsistent weapon shape, different hairstyle,
different eye color, different costume,
extra limbs, merged fingers, unreadable silhouette,
text, watermark, logo
```

## 7. 설정 기록 항목

각 결과물은 다음 메타데이터를 동반한다.

```yaml
asset_name: Luna_KeyArt_REVIEW_v001
character_id: CH001
purpose: fullbody_concept
status: REVIEW
generated_at: YYYY-MM-DD
tool: ComfyUI
workflow_file: art_source/comfyui_workflows/luna/luna_fullbody_v001.json
checkpoint: ""
vae: ""
loras: []
reference_images: []
controlnet: []
seed: 0
sampler: ""
scheduler: ""
steps: 0
cfg: 0
width: 0
height: 0
hires_scale: 1.0
human_edits: ""
license_reviewed: false
reviewer: ""
notes: ""
```

메타데이터는 이미지와 같은 이름의 `.yaml` 또는 `.md` 파일로 저장한다.

## 8. 출력 규격

| 용도 | 권장 해상도 | 비율 | 배경 |
|---|---:|---:|---|
| 전신 후보 | 1536×2304 이상 | 2:3 | 단색 또는 단순 배경 |
| 얼굴 기준 | 1536×1536 이상 | 1:1 | 단색 |
| 표정 시트 | 2048×2048 이상 | 1:1 | 흰색 또는 투명 |
| Turnaround 참고 | 2560×1440 이상 | 16:9 | 흰색 |
| 장비 시트 | 2560×1440 이상 | 16:9 | 흰색 |
| 배경 콘셉트 | 2560×1440 이상 | 16:9 | 완성 배경 |

해상도는 제작 원본 기준이며 Unity에 직접 넣는 크기는 `UNITY_ART_IMPORT_GUIDE.md`를 따른다.

## 9. 후보 생성 규칙

- 한 번에 무제한 생성하지 않는다.
- 한 라운드당 4~8개 후보를 생성한다.
- 후보마다 변경한 변수는 하나 또는 두 개로 제한한다.
- 선택되지 않은 대량 결과는 Git에 저장하지 않는다.
- 선택된 후보와 최종 승인본만 메타데이터와 함께 저장한다.

## 10. 일관성 검수 체크리스트

### 얼굴

- 눈 모양, 눈동자 색, 얼굴형이 기준과 같은가
- 앞머리와 옆머리의 분할이 유지되는가
- 나이와 인상이 갑자기 달라지지 않았는가

### 의상

- 재킷 길이와 절개가 유지되는가
- 소매, 장갑, 벨트, 신발 구조가 시점마다 같은가
- 캐릭터 대표 색상 비율이 유지되는가

### 장비

- 무기 크기와 손잡이 위치가 일치하는가
- 좌우 장착 위치가 임의로 바뀌지 않는가
- 기능을 설명할 수 없는 장식이 추가되지 않았는가

### 제작 가능성

- 정면·측면·후면으로 해석 가능한 구조인가
- 3D 모델링 시 관통이 예상되는 구조가 과도하지 않은가
- 공격·이동 애니메이션을 방해하지 않는가
- 쿼터뷰에서 머리·상체·무기가 식별되는가

## 11. 승인 기준

### REVIEW 진입

- 캐릭터 고정 요소가 기준 이미지와 대부분 일치
- 손·얼굴·장비의 치명적 오류가 없음
- 사람의 수정으로 제작 시트에 사용할 수 있음
- 생성 설정과 라이선스 정보가 기록됨

### APPROVED 진입

- 얼굴·헤어·의상·장비 구조가 사람이 정리됨
- Turnaround의 시점 간 구조가 일치함
- 대표 색상과 재질이 확정됨
- 3D Blockout 제작자가 해석 가능한 주석이 있음
- 기존 승인본과 교체 관계가 기록됨

## 12. 토큰과 도구 호출 절감 원칙

- 캐릭터 공통 방향은 Skill 또는 짧은 기준 문서로 유지한다.
- 전체 프로젝트 문서를 매 요청마다 전달하지 않는다.
- 캐릭터 1명에 필요한 바이블 항목과 승인 이미지만 불러온다.
- MCP는 Compact Tool Mode 또는 Tool allowlist를 우선 사용한다.
- 워크플로 생성 후에는 전체 JSON을 반복 전송하지 않고 변수만 변경한다.
- 생성 결과는 요약과 파일 경로만 반환하고, 이미지 검수가 필요할 때만 상세 정보를 요청한다.
