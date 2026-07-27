# AI Asset Metadata — ReCamp Character Lineup REJECTED v002

## Identity

- Asset Name: `ReCamp_CharacterLineup_REJECTED_v002.png`
- Subject: 루나·미유·코코·이리스·노아 5인 통합 라인업
- Purpose: 캐릭터별 실루엣·팔레트·무기·세계관 일관성 검토
- Status: `REJECTED`
- Generated Date: `2026-07-14`
- Tool / Model: Codex built-in `image_gen`
- Workflow Version: `lineup-review-v002`
- Seed: built-in tool에서 노출되지 않음
- Output: `1693 × 929`, RGB PNG

## Input References

- `docs/05_art_concept/ART_DIRECTION.md`
- `docs/05_art_concept/CHARACTER_BIBLE.md`
- 기존 원격 v001 이미지는 시각적으로 불량하므로 입력 이미지로 사용하지 않음
- 기존 원본 전투 콘셉트 `art_refs/moodboard/battle_vertical_slice_concept.png`를 입력 레퍼런스로 사용하지 않음

## Final Prompt

```text
Use case: stylized-concept
Asset type: 2D game character lineup production-review concept sheet
Primary request: five full-body young adult survivors on one consistent baseline, left-to-right exactly Luna, Miyu, Coco, Iris, Noah, with no extra characters
Scene/backdrop: clean warm off-white studio background
Style/medium: polished 2D anime/subculture game character concept illustration, normal human-like illustration proportions; coherent style and lighting; not chibi, not SD, not 3D
Luna: cat-ear hood, short active jacket, energy dagger and scanner, mint/cream/pink
Miyu: asymmetric bob, oversized work sleeves, floating combat drone and control gauntlet, lilac/gray/neon blue
Coco: soft wavy hair, short medical cape, pulse injector, medical bag and round shield device, coral/ivory/emerald
Iris: long neat hair, asymmetric long coat, long energy rifle and visor, purple/white/crimson
Noah: broad protective jacket, short neat hair, large deployable energy shield, navy/steel/amber
Composition: characters stand separately without overlap; full feet visible; strong distinct head, torso, and weapon silhouettes
Constraints: practical light tactical streetwear; appealing but nonsexualized; no names, labels, text, logo, watermark; no cropped feet, duplicate characters, gore, heavy realism
```

## Human Edits

- 없음. 내장 생성 결과 원본을 versioned REVIEW 파일로 복사.

## Rejection Decision

- 사용자 결정: 플레이어블 캐릭터는 전원 성인 여성이고 남성향 서브컬쳐 매력을 우선해야 한다.
- 생성 프롬프트에 `all female` 조건이 없었으며 노아가 남성으로 생성됐다.
- 저장소의 기존 원본 전투 콘셉트를 입력 레퍼런스로 사용하지 않아 기존 이미지 계보와 다른 신규 스타일이 됐다.
- 이 파일은 수정 후보가 아니라 실패 기록이다. 후속 이미지·모델·문서의 시각 기준으로 사용하지 않는다.

## Audit Notes

### 생성 결과에서 확인된 부분

- 5명이 한 baseline에서 겹치지 않고 전신으로 보임
- 루나의 고양이 후드·단검, 미유의 드론, 코코의 의료 장비, 이리스의 장총, 노아의 대형 방패가 즉시 구분됨
- 캐릭터별 주조색이 문서와 대체로 일치함
- 공통 택티컬 스트리트 세계관과 2D 일반 등신 방향이 보임

### 반려 원인이 된 부분

- 루나의 의상 노출도와 탐지 장치 형태가 대표 캐릭터에 적합한지
- 미유의 제어 건틀릿과 드론 디자인을 더 단순한 3D 구조로 정리할지
- 코코의 실루엣이 의료 역할을 충분히 강조하는지
- 이리스의 라이플·코트 길이가 쿼터뷰와 애니메이션에 과도하지 않은지
- 노아가 남성으로 읽히며 전원 여성 로스터 조건을 위반함
- 다섯 명의 키 차이와 공용 Humanoid 골격 호환 범위

## Usage Restriction

- 실패 원인 감사와 프롬프트 회귀 방지 기록으로만 사용
- 라인업 비교, 개별 WIP, 최종 원화, Turnaround, Blender 모델링 시트, 출시 자산으로 사용 금지
- `REVIEW` 또는 `APPROVED`로 승격 금지
- 상업 이용·권리 조건은 출시 전 별도 확인

## Reviewer

- User — Rejected on 2026-07-14
