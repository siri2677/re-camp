# Re:Camp Five-Character Full-Body Fashion Lineup — Prompt Set v001

## Method and reference roles

- Generator/editor: built-in `imagegen`
- `ReCamp_FiveCharacterFaceStyleMaster_WIP_v002.png`: 얼굴·헤어·홍채·선화·피부·셀 렌더 전용 참조
- Full-body v001: 최초 패션·체형·장비 통합 생성
- Full-body v002: 하체 구조 분리 편집; 사용자 노출도 선호와 달라 `HISTORY ONLY`
- Full-body v003: v001의 노출도를 유지하고 장식 스트랩만 정리한 비율 수정 베이스
- Full-body v004: v003의 의상·노출도를 유지하고 신장·체형만 분리한 비율 기준
- Full-body v005: v004에서 미유의 랩 패널·바닥 케이블을 제거한 순수 테크 쇼츠 비교 이력
- Full-body v006: 루나 힙 패널 제거·미유 짧은 랩 패널 복원 후 루나 쇼츠 재질 드리프트가 남은 중간 이력
- Full-body v007: v006의 패널 배분을 유지하고 루나 차콜 유틸리티 쇼츠를 복원한 활성 WIP
- External-IP rule: 외부 작품의 고유 캐릭터·의상·무기·로고·모티프를 복제하지 않는다.

## v001 full-body generation contract

```text
Use case: stylized-concept
Asset type: Re:Camp five-character full-body fashion design lineup for a premium anime action RPG
Input images: Image 1 is the face-and-rendering style reference. Preserve the five identities in left-to-right order:
Luna, Miyu, Coco, Iris, Noah. Use it for facial appeal, eyes, hair and the shared line/cel-render pipeline, not for
the bust crop or identical clothing.

Create exactly five visibly adult women as complete head-to-toe 2D character designs in one horizontal row on a
clean pale studio background. Use one eye-level camera, equal display scale, full feet and equipment, one tapered
line system, luminous jewel irises, short anime midfaces, graphic hair clumps, clean skin and decisive two-step cel
shading. Use 2D adult proportions around 6.8–7.4 heads and original Re:Camp designs only.

Luna: slim athletic mint-silver scout; cream cropped sensor hood-jacket; mechanical sensor-cat modules with hinges
and cyan lenses; fitted inner, short utility shorts and mint asymmetric hip panel; two cyan daggers, wrist scanner,
compact backpack and scanner cable; no biological ears.
Miyu: petite sleepy technician; smoky-lilac asymmetric bob; cropped work bomber with one oversized sleeve; short
asymmetric work skort; exactly two different small drones and one control gauntlet; no gun.
Coco: healthy curvy rescue captain; coral side braid; fitted warm-ivory short rescue romper-dress, coral half-cape,
jade translucent protection modules; one pulse-injector baton; not a nurse costume.
Iris: tall elegant observer; long deep-plum hair; dominant cold-white split long coat over a short ink body layer;
one near-body-height non-firearm observation lance with prism core and distance rings; no firearm anatomy.
Noah: tallest powerful guardian; navy bob with amber underlight; fitted tailored protective jacket, feminine waist,
short lower silhouette and one tall door-like barrier shield; strength from physique and posture, not bulky armor.

Keep different body types, hemlines, poses, footwear and equipment. Preserve attractive adult feminine fashion and
character-specific skin exposure. Avoid Western semi-realism, painterly/3D rendering, child/chibi anatomy, same-face
cloning, repeated black tactical bodysuits, military realism, copied motifs, text, UI, logos and watermarks.
```

## v002 lower-body coverage experiment

```text
Change only the lower-body garment construction to remove thigh straps and create different shorts, skort, cropped
trousers, coat legs and long trousers. Preserve faces, upper bodies, equipment and renderer unchanged.
```

Result: technically separated the lower-body structures, but the user preferred v001's exposed thighs and shorter
hemlines. v002 is retained as a rejected comparison only.

## v003 exposure-preserving cleanup history

```text
Use case: precise-object-edit
Asset type: Re:Camp five-character full-body fashion lineup refinement
Input images: Image 1 is the edit target and the user-preferred design direction.

Preserve the attractive exposed-thigh fashion direction of Image 1 exactly. Change only unnecessary decorative black
thigh straps, garters and loose harness bands: remove or integrate them cleanly into the shorts/skirt hems so the
exposed legs look cleaner and more premium. Do not add trousers, long skirts, opaque tights, leggings, stockings on
new legs, longer hems or additional fabric coverage.

Luna remains in very short high-waisted scout shorts with the mint asymmetric hip panel and both athletic thighs
visible. Miyu remains in a short asymmetric lilac work skort with both thighs visible. Coco remains in the short
warm-ivory rescue romper-dress with both healthy curvy thighs visible. Iris remains in the black mini-dress under the
dominant white split coat with both long legs visible. Noah remains in a fitted high-cut short lower garment with a
strong exposed-thigh silhouette; do not replace it with trousers.

Preserve every face, expression, hairstyle, body shape, breast/waist/hip proportion, pose, neckline, crop-top area,
outer garment, color, footwear, hand, weapon, equipment count, drone, cape, coat, shield, background, framing,
camera, lighting, linework and cel-render finish unchanged. Exactly five adult women; no text, UI, logo, watermark,
extra people or altered anatomy. Avoid reducing skin exposure, conservative redesign, pants, long skirts, added
leggings, Western semi-realism, painterly texture and 3D rendering.
```

## v004 height and body-type refinement base

```text
Use case: identity-preserve
Asset type: Re:Camp five-character full-body fashion lineup proportion refinement
Input images: Image 1 is the edit target and current user-preferred exposed-thigh design.

Change only the relative standing height, adult body-type proportions and neutral stance. Preserve every outfit,
hemline, neckline, exposed thigh, bare leg, skin-exposure area, face, expression, hairstyle, color, accessory, weapon,
equipment count, drone, cape, coat, shield, footwear, background, camera, lighting, linework and cel-render finish.

Keep all feet on one baseline and the same head display scale. Required height order: Miyu < Luna < Coco < Iris <
Noah. Miyu is the shortest petite lean adult with a relaxed technician slouch. Luna is slightly taller and slim
athletic with a light forward weight shift. Coco is medium-tall with healthy soft curves and an open rescue-captain
stance. Iris is tall, long-limbed and upright. Noah is clearly tallest with stronger shoulders, powerful thighs,
defined feminine waist and a planted guardian stance.

Keep mature 2D anime proportions around 6.8–7.4 heads and preserve the short hemlines and visible thighs exactly.
Do not add trousers, longer skirts, leggings, stockings, armor or fabric. Exactly five adult women and the existing
signature equipment counts; no text, labels, measurement marks, UI, logo, watermark, extra people or cropped feet.
Avoid same-height bodies, identical hourglass bodies, childlike petite anatomy, masculine Noah, reduced exposure,
conservative redesign, Western semi-realism, painterly texture and 3D rendering.
```

## v005 Miyu skirt-removal experiment

```text
Use case: precise-object-edit
Asset type: Re:Camp five-character full-body fashion lineup refinement
Input images: Image 1 is the edit target.

Change only Miyu, the second woman from the left, below the waist. Remove her entire pale-lilac wrap-skirt/skort
cloth panel and the long purple cable hanging from her waist to the floor. Replace the skirt portion with very short,
fitted, high-waisted technician shorts in warm graphite gray, with a clean smoky-lilac waistband and small
electric-cyan seam accents. The shorts are fashionable near-future work shorts, not underwear and not black military
tactical shorts. Keep both thighs fully exposed. Use no skirt flap, hanging cloth, thigh straps, garters, holsters or
loose cable. Retain one tiny integrated waist tool module if needed.

Preserve Miyu's face, sleepy expression, asymmetric bob, adult petite body, height, pose, crop top, jacket,
one-sleeve asymmetry, control gauntlet, hands, legs, footwear and exactly two drones. Preserve Luna, Coco, Iris and
Noah completely unchanged. Preserve the height order, composition, background, camera, lighting, linework, cel
shading and shared anime-gacha rendering. Exactly five adult women; no pants, leggings, long fabric, new skirt,
extra drones, extra limbs, text, UI, logo or watermark.
```

Result: 미유의 순수 테크 쇼츠 실험은 유효했지만 최신 사용자 선택에서 미유의 짧은 비대칭 랩 패널을
복원하고 루나의 치마형 힙 패널을 제거하기로 정정했다. v005는 비교 이력이다.

## v006 Luna/Miyu panel-redistribution edit

```text
Use case: precise-object-edit
Asset type: Re:Camp five-character full-body fashion calibration lineup
Input image: Image 1 is the edit target.

Change only the lower-body cloth-panel design of Luna, the far-left woman, and Miyu, the second woman from the left.
Remove Luna's entire mint asymmetric hanging hip/skirt panel while keeping very short high-waisted scout shorts and
both thighs visible. Restore a compact short smoky-lilac asymmetric wrap panel over Miyu's graphite tech shorts,
attached at one hip and ending high on the upper thigh. Keep Miyu's shorts visible and do not restore her floor cable.

Preserve all five faces, hair, bodies, height order, poses, upper garments, footwear, equipment, exactly two drones,
lighting, background, composition and cel-rendering. Do not alter Coco, Iris or Noah. No long cloth, pants, leggings,
thigh straps, garters, extra objects, text, UI, logo or watermark.
```

Result: 패널 배분은 맞지만 루나의 차콜 쇼츠가 밝은 크림색으로 바뀌어 v007에서 단일 재질 보정했다.

## v007 active Luna shorts-material correction

```text
Use case: precise-object-edit
Asset type: Re:Camp five-character full-body fashion calibration lineup
Input image: Image 1 is the edit target.

Change only Luna's shorts. Replace the near-white fabric with very short fitted high-waisted warm-charcoal technical
utility shorts that match her inner top, retaining narrow cream trim and tiny mint-cyan seams. Keep Luna free of any
skirt, wrap panel, apron panel, loincloth, hip flap or hanging fabric and keep both thighs visible.

Preserve everything else: Luna's identity, upper outfit and equipment; Miyu's short smoky-lilac asymmetric wrap panel
over visible graphite shorts with no long cable; Coco, Iris and Noah; exactly two drones; all faces, height order,
bodies, equipment, composition, crop, background, lighting, linework and cel-rendering. No new cloth, longer hem,
pants, leggings, straps, extra objects, text, UI, labels, logos, signatures or watermarks.
```
