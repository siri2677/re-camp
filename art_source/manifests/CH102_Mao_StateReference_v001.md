# CH102 키사라기 마오 — State Reference Manifest v001

> Backlog: `ART-1101`, `ART-1102`, `ART-1103`
> Status: `REVIEW / unified state package / Gate A pending`
> Primary visual source: `art_refs/characters/roster/current/CH101-105_Roster_FaceDiversity_WIP_v003.png`
> Source commit: `418ef96` — `art: refine current roster gate A visuals`
> Unified sheet: `art_refs/characters/mao/concept/CH102_Mao_CharacterSheet_REVIEW_v001.png`

이 Manifest는 린의 캐릭터 시트·장비 시트처럼 CH102 마오의 여러 이미지를 하나의 캐릭터 패키지로 사용하는 기준을 기록한다. A/B/C는 서로 배타적인 디자인 후보가 아니라 같은 마오의 장비 전개 상태와 포즈 상태다.

## 1. Shared identity lock

- 오전 로스터 이미지의 왼쪽에서 두 번째 인물을 기준으로 한다.
- 얼굴, 긴 실버 라벤더 헤어, 성인 곡선형 체형, 블랙·퍼플 의상, 허벅지 스트랩, 퍼플·블랙 부츠를 공유한다.
- 대형 다크 퍼플 기계식 컴파운드 보우의 형태와 색감을 공유한다.
- 상태가 바뀌어도 다른 캐릭터, 다른 의상, 다른 체형으로 해석하지 않는다.

## 2. State map

| State | Use | Equipment read |
|---|---|---|
| `A` Neutral | 대기·이동·기본 전신 기준 | 활 접힘·휴대 |
| `B` Ready | 작업·조준 준비·전투 진입 | 활 반전개 |
| `C` Full Deploy | 공격·조준·키아트 포즈 | 활 완전 전개 |

## 3. Package references

```text
art_refs/characters/mao/concept/CH102_Mao_CharacterSheet_REVIEW_v001.png
art_refs/characters/mao/concept/CH102_Mao_GateA_Candidates_WIP_v002.png
art_refs/characters/mao/concept/CH102_Mao_GateA_Candidates_REVIEW_v002.png
art_refs/characters/mao/concept/CH102_Mao_FullBody_WIP_A_v001.png
art_refs/characters/mao/concept/CH102_Mao_Face128_WIP_A_v001.png
art_refs/characters/mao/concept/CH102_Mao_Silhouette_ON_WIP_A_v001.png
art_refs/characters/mao/concept/CH102_Mao_Silhouette_OFF_WIP_A_v001.png
```

## 4. Production rule

1. A is the neutral visual anchor.
2. B and C are state references for equipment deployment, animation, and action pose.
3. Face128, turnaround, material, expression, and 2D→3D materials must preserve the shared identity across all three states.
4. State references do not authorize Unity import, Runtime replacement, or 3D Blockout by themselves.
5. Gate A approval applies to the unified package, not to one isolated state.
