# AI Asset Metadata — ReCamp Character Lineup REVIEW v003

## Identity

- Asset Name: `ReCamp_CharacterLineup_REVIEW_v003.png`
- Subject: 루나·미유·코코·이리스·노아, 성인 여성 5인 SD-lite 통합 라인업
- Purpose: 원본 전투 콘셉트와 남성향 캐릭터 방향을 연결하는 3D 인게임 제작 방향 검토
- Status: `REVIEW`
- Generated Date: `2026-07-14`
- Tool / Model: Codex built-in `image_gen`
- Workflow Version: `all-female-sd-lineup-v003-pass2`
- Seed: built-in tool에서 노출되지 않음
- Output: `1672 × 941`, RGB PNG
- SHA-256: `CF9EEE6F3AB4739E193D11DA12EC968B77CE1853B6E7D6873DFAEB9F7288A525`

## Input References

1. `art_refs/moodboard/battle_vertical_slice_concept.png`
   - 역할: 기존 원본 전투 콘셉트, SD 비율·툰 렌더·색감·캐릭터 존재감 기준
2. 1차 교정 생성본 `exec-6a5f3b51-6067-4d96-819f-ab9af1bfd765.png`
   - 역할: 성인 여성 5인의 얼굴·헤어·의상·색상·무기·순서 앵커
   - 판정: 6등신 이상으로 길어 프로젝트 자산으로 채택하지 않음

혼성 `ReCamp_CharacterLineup_REJECTED_v002.png`는 입력 이미지로 사용하지 않았다.

## Final Iteration Prompt

```text
Use case: identity-preserve
Asset type: Re:Camp 3D SD-lite in-game character lineup, production REVIEW
Input images: Image 1 is the original battle-concept proportion, rendering, and mood reference. Image 2 is the edit target whose five adult female identities, left-to-right order, outfits, colors, roles, weapons, and attractive male-oriented character appeal must be preserved.
Primary request: change only the body proportions and 3D rendering language of Image 2 so all five women match Image 1's cute in-game SD charm: exactly 4-head-tall to at most 4.5-head-tall SD-lite proportions, with clearly oversized heads, shorter torsos and legs, slightly larger hands and weapons, rounded soft 3D toon forms, and compact Unity-friendly silhouettes.
Critical invariant: keep exactly five unmistakably ADULT WOMEN in the same left-to-right order—Luna, Miyu, Coco, Iris, Noah. Preserve each woman's face identity, hair color/style, outfit concept, feminine silhouette, palette, equipment, and role from Image 2.
Adult female readability: despite SD proportions, retain mature beautiful female faces, bust/waist/hip cues, fashionable silhouettes, varied adult body types, and tasteful male-oriented subculture appeal. They must not look like children or generic mascots.
Composition: same five-character studio lineup, one baseline, full heads and feet visible, generous spacing, no overlap, warm off-white background.
Constraints: no men, boys, male-presenting or androgynous characters; no children; no extra people; no text, names, logo, or watermark; no normal 6-to-8-head anatomy; no 2-to-3-head baby chibi; no cropped limbs; no redesign of costumes, weapons, palettes, or character order; no photorealism; no gore.
```

## Validation

- 정확히 5명이며 모두 성인 여성으로 읽힘
- 왼쪽부터 루나·미유·코코·이리스·노아의 역할 장비와 팔레트가 구분됨
- 노아가 짧은 단발의 여성 수호자로 교정됨
- 전신과 발끝이 보이고 인물 간 겹침이 없음
- 1차 교정본보다 머리가 크고 몸이 짧은 약 4~4.5등신 SD-lite 실루엣
- 텍스트·로고·워터마크 없음
- PNG LFS 속성 적용 여부를 별도 검증

## Human Review Points

- 남성향 매력과 노출도 수준이 프로젝트 의도에 맞는지
- 원본 전투 장면에 배치했을 때 머리·무기·다리 실루엣이 충분히 읽히는지
- 공용 Humanoid 호환을 위해 팔·다리 길이를 어느 정도 보정할지
- 루나의 단검, 미유의 드론, 코코의 의료 방패, 이리스의 장총, 노아의 대형 방패를 3D 제작 가능한 구조로 단순화할지

## Automated Gate Review — 2026-07-19

- Review Record: `ReCamp_CharacterLineup_REVIEW_v003.review.md`
- Reviewer: Codex assistant review recommendation
- Gate A Decision: `FAIL`
- Asset Status: `REVIEW` 유지
- Human Approval: `Pending`
- 3D SD-lite 방향 후보: `CONDITIONAL`
- 2D 일반 등신 제작 시트, Gate B, Gate C: 현재 사용 불가 또는 `NOT TESTED`

주요 차단 항목은 루나의 의료 십자가가 코코의 전용 모티프를 침범하는 점, 미유·이리스의
보라 계열 중첩, 코코·노아의 방패 인상 중첩, 5인의 얼굴·체형·표정 차이가 작은 점이다.
수정본은 통합 이미지를 바로 고정하지 않고 캐릭터별 WIP에서 먼저 검증한다.

## Usage Restriction

- 캐릭터 방향 비교와 Luna 개별 WIP 제작의 참고로만 사용
- 최종 원화, Turnaround, Blender 모델링 시트, 출시 자산으로 직접 사용 금지
- 사람 검토 전 `APPROVED`로 승격 금지
- 상업 이용·권리 조건은 출시 전 별도 확인

## Reviewer

- Pending user review
