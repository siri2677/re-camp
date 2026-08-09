# Re:Camp 신규 5인 아트 리셋 브리프

> 작성일: 2026-08-09
> 상태: New Concept Package — Gate A Pending
> 범위: 5인 캐릭터 기획·2D 후보·검토 패키지
> 코드·Unity 통합: 제외

## 1. 결정된 방향

기존 루나·미유·코코·이리스·노아는 새 캐릭터 디자인의 기준에서 제외한다. 기존 REVIEW 자산은
`HISTORY ONLY`로 보존하고, 새 후보는 이름·얼굴·헤어·의상·장비·한 문장 훅을 모두 독립적으로 설계한다.

유지하는 상위 제약은 다음뿐이다.

- 자연에 잠식된 폐허를 탐험하고 자원을 회수해 캠프를 성장시키는 핵심 루프
- 성인 여성 5명의 일본 모바일 서브컬처 감도
- 2D 약 6.8~7.4등신, 기본 약 7등신
- 3D 5~6등신 스타일라이즈드 체형
- 전투 역할과 탐험 기능이 장비·실루엣·표정으로 함께 읽히는 설계
- 사용자 레퍼런스의 품질·분위기·마감·패션 밀도만 흡수하고 고유 IP는 복제하지 않는 원작성

```text
탐험 준비 → 전투·탐색 → 자원 회수 → 귀환 판단 → 결과 정산 → 캠프 성장
```

## 2. 확정한 신규 로스터

| ID | 이름 | 훅 | 역할 | 대표 장비 |
|---|---|---|---|---|
| CH101 | 아마사와 린 `Amasawa Rin` | 폐허의 길을 빛나는 신호 리본으로 그리는 신호 주자 | 기동 근접·정찰 | 단일 와이어 세이버·신호 리본 |
| CH102 | 키사라기 마오 `Kisaragi Mao` | 버려진 재료로 접히는 활을 만드는 폐허 설계자 | 지속 원거리·수집 제어 | 접이식 자기 활·구조 링 |
| CH103 | 카나데 노조미 `Kanade Nozomi` | 죽어가는 신호를 공명으로 붙잡는 현장 의무관 | 회복·정화·보호 | 공명 배턴·응급 베일 |
| CH104 | 시온 타테가미 `Shion Tategami` | 빛의 지도를 접어 폐허의 약점을 읽는 궤도 측량사 | 약점 표식·정밀 폭발 | 프리즘 측량 부채·지도 링 |
| CH105 | 쿠로가네 아카리 `Kurogane Akari` | 무너지는 길에 닻을 박아 숨 쉴 공간을 만드는 전위 수호자 | 가드·밀치기·반격 | 키네틱 건틀릿·앵커 케이블 |

상세 성격·전투 계약·캠프 역할은 `docs/05_art_concept/CHARACTER_BIBLE.md`, 고정·금지 항목은
`docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md`를 따른다.

## 3. 공통 이미지 프롬프트

아래 공통 프롬프트를 모든 후보에 앞에 붙인다.

```text
original adult female mobile RPG character concept for a hopeful post-apocalyptic expedition game,
premium Japanese mobile anime game key art finish, approximately 7-head-tall adult feminine anatomy,
jewel-like expressive eyes, short midface, small nose and mouth, clean cel-shaded color planes,
fashion-forward layered survival outfit, functional expedition equipment integrated into the silhouette,
soft nature-overgrown ruins in the background, warm camp light against a dangerous world,
clear face, readable full-body silhouette, elegant material contrast, restrained luminous accents,
three-quarter standing pose, original character design, no logo, no copyrighted character resemblance,
no copied costume, no copied pose, no school uniform, no direct weapon reference, no childlike anatomy
```

공통 Negative Prompt:

```text
child, teenager, young-looking, loli, chibi, baby proportions, male, ambiguous gender,
photorealistic face, copied character, recognizable franchise costume, logo, emblem,
existing game weapon, school uniform, generic tactical uniform, excessive armor,
face obstruction, unreadable silhouette, duplicate limbs, extra fingers, broken equipment,
text, watermark, signature, low detail, muddy colors, random floating parts
```

## 4. 캐릭터별 후보 생성 프롬프트

각 캐릭터는 아래 설명으로 최소 3개 후보를 생성한다. 후보 3안은 같은 캐릭터 설명을 유지하되
`pose`, `expression`, `fabric`, `background light`만 바꿔 비교한다. 얼굴·헤어·장비 구조를 후보마다 바꾸지 않는다.

### CH101 아마사와 린

```text
Amasawa Rin, a confident adult signal runner exploring overgrown ruins,
pearl-black short bob hair with a thin turquoise underlight and one longer tied side lock,
pearl-white asymmetric cropped racing jacket over a deep charcoal high-neck inner layer,
slim athletic adult feminine silhouette, long legs, low forward-ready posture,
one folding mono-wire saber mounted at the wrist, one translucent turquoise signal ribbon
flowing from the shoulder and drawing a route through the air, small vermilion safety marker,
urban street fashion fused with practical salvage gear, playful half-smile with focused eyes,
full-body front three-quarter key art, route beacon visible near the hip
```

후보 변형: `A`는 리본을 크게 휘두르는 역동 포즈, `B`는 귀환 경로를 손가락으로 지시하는 정면 포즈,
`C`는 세이버를 접고 캠프 표지판을 세우는 생활 포즈.

### CH102 키사라기 마오

```text
Kisaragi Mao, an adult salvage architect working inside a collapsed industrial district,
ash-lavender long bob hair with an acid-lemon inner highlight and one long asymmetrical bang,
graphite fitted base layer, oversized single folded violet work sleeve, cropped waistcoat,
short functional pleated panel over fitted leggings, compact adult feminine proportions,
a folding magnetic bow made from brushed salvage metal, three large structural rings unfolding
behind the waist, transparent scraps and blueprint fragments orbiting the bow,
sleepy expression turning intensely excited while adjusting a mechanism,
full-body front three-quarter key art, elegant runway workwear mixed with survival engineering
```

후보 변형: `A`는 활을 완전히 펼친 화력 포즈, `B`는 구조 링을 조립하는 작업 포즈,
`C`는 자원을 자기장으로 끌어오는 통제 포즈.

### CH103 카나데 노조미

```text
Kanade Nozomi, an adult field resonance medic in a rain-wet ruined transit station,
long cream-rose wavy hair fading into coral, one thin side braid,
milk-ivory high-neck base, coral asymmetric wrap jacket, transparent emergency ampoule belt,
subtle aqua accents, balanced adult feminine figure with practical movement layers,
short resonance baton in one hand, four broad translucent emergency veil panels opening
from the shoulders like a waveform and flower petals without covering the face,
warm reassuring smile with a commanding gaze underneath, refined rescue fashion rather than
literal nurse clothing, full-body front three-quarter key art, aqua resonance pulse lighting
```

후보 변형: `A`는 동료를 회복시키는 손짓, `B`는 베일 보호 영역을 지휘하는 포즈,
`C`는 끊긴 신호를 붙잡는 조용한 집중 포즈.

### CH104 시온 타테가미

```text
Shion Tategami, an elegant adult orbit cartographer reading the weak points of a ruined city,
deep indigo long layered hair with hot-magenta light at the ends and one long asymmetrical bang,
porcelain short jacket-dress, indigo high-waist skirt panels, thin map ribbon at the waist,
asymmetrical gloves, long-legged adult feminine silhouette with a poised upright stance,
a folding prism survey fan that looks like a compass when closed and a geometric light map
when open, one thin orbit map ring behind the body, white-to-magenta vector lines marking a
safe route and an enemy fault line, calm refined expression with a hint of everyday absent-mindedness,
full-body front three-quarter key art, no gun, no spear, no visor
```

후보 변형: `A`는 부채를 펼쳐 약점을 표시하는 정면 포즈, `B`는 지도 링을 접는 우아한 포즈,
`C`는 폐허의 안전 경로를 손바닥에 투영하는 탐색 포즈.

### CH105 쿠로가네 아카리

```text
Kurogane Akari, an adult anchor warden holding a collapsing ruin line for her team,
short black hair fading into forest green with two small copper hair pins,
deep-black cropped armored bolero over a forest-green fitted base, high-waist functional trousers,
bronze-copper buckles, strong adult feminine shoulders and hips with a clear waistline,
kinetic gauntlets on both hands, a large copper anchor ring floating behind the back,
two deployable anchor cables striking the ground and forming a warm golden grid,
calm unsmiling face with a hidden teasing smile, grounded low defensive three-quarter pose,
luxury street armor fused with practical rescue hardware, no large shield, no helmet
```

후보 변형: `A`는 앵커를 바닥에 박는 강한 포즈, `B`는 케이블로 동료를 보호하는 포즈,
`C`는 전투 후 케이블을 정비하는 캠프 포즈.

## 5. Gate A 후보 검토표

각 후보는 이미지 자체와 함께 아래 metadata를 남긴다.

| 항목 | 판정 질문 | 상태 값 |
|---|---|---|
| 3초 인상 | 이름을 가려도 훅과 역할이 즉시 읽히는가 | `PASS` / `FAIL` |
| 성인성 | 얼굴·체형·자세·패션이 성인 여성으로 읽히는가 | `PASS` / `FAIL` |
| 얼굴 식별 | 128px에서 눈매·헤어·대표색이 남는가 | `PASS` / `FAIL` |
| 장비 식별 | 대표 장비를 제거·포함한 실루엣이 구분되는가 | `PASS` / `FAIL` |
| 게임 기능 | 전투·탐험·캠프 역할이 장비와 연결되는가 | `PASS` / `FAIL` |
| 라인업 분리 | 다른 4인과 체형·색·장비가 겹치지 않는가 | `PASS` / `FAIL` |
| 원작성 | 기존 Re:Camp·외부 IP의 고유 요소를 복제하지 않는가 | `PASS` / `FAIL` |
| 2D→3D | 5~6등신 모델로 단순화 가능한가 | `PASS` / `FAIL` |
| 품질 | 사용자 레퍼런스의 마감·감정·패션 밀도 축에 도달하는가 | `PASS` / `FAIL` |

캐릭터 하나라도 `FAIL`이면 해당 후보는 `REJECTED` 또는 수정 후 `REVIEW`로 남긴다.
`APPROVED`는 사용자 Gate A의 명시적 결정에만 사용한다.

## 6. 현재 상태와 다음 실행 경계

- 신규 5인 역할·성격·비주얼 훅: 문서 기준 완료
- 신규 Character Bible: 완료
- 신규 Anchor와 공통 Art Direction: 완료
- 이미지 후보: 공통 라인업 WIP 1장 생성 완료 — `art_refs/characters/lineup/ReCamp_FiveCharacterLineup_WIP_v001.png`; 캐릭터별 3안은 다음 단계
- Gate A 승인: `0/5`
- 2D 제작 시트·Turnaround·2D→3D·3D Blockout: Gate A 이후
- 기존 REVIEW 자산: 신규 기준이 아닌 `HISTORY ONLY`, 이후 `SUPERSEDED` 또는 `ARCHIVE`로 정리

이미지를 생성할 수 없는 상태에서 기존 REVIEW 이미지를 새 컨셉으로 가장하지 않는다.

### 2026-08-09 생성 증거

내장 `image_gen.imagegen`으로 CH101~CH105 공통 하우스 스타일 라인업 WIP를 생성했다. 이 이미지는
공통 조명·선화·성인 여성 비율·캠프 분위기·실루엣 분리를 확인하기 위한 첫 후보이며, 개별 3안·128px
얼굴·장비 on/off 실루엣·저채도 보드가 만들어지기 전에는 Gate A를 통과한 것으로 보지 않는다.

- PNG: `art_refs/characters/lineup/ReCamp_FiveCharacterLineup_WIP_v001.png`
- Metadata: 동명 `.metadata.md`
- Review: 동명 `.review.md`
- 상태: `WIP / GATE A PENDING`, `APPROVED: NOT GRANTED`
