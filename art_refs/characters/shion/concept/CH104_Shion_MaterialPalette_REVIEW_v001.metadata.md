# CH104 Shion Material Palette REVIEW v001 - Metadata

| Field | Value |
|---|---|
| Asset | `CH104_Shion_MaterialPalette_REVIEW_v001.png` |
| Scope | CH104 color roles, material separation, and low-saturation value REVIEW board |
| Primary source | `CH104_Shion_CharacterSheet_REVIEW_v001.png` |
| Equipment source | `CH104_Shion_EquipmentSheet_REVIEW_v001.png` |
| Roster source | `art_refs/characters/roster/current/CH101-105_Roster_FaceDiversity_WIP_v003.png` |
| Source commit | `418ef96` - `art: refine current roster gate A visuals` |
| Backlog | `ART-1307` |
| Generated | 2026-08-11 |
| Tool | Built-in Codex `image_gen.imagegen` |
| Status | `WIP / REVIEW / Gate A pending` |
| Human approval | Pending; shader slots and measured values remain Gate B work |
| Runtime use | Not permitted; 2D production review evidence only |

## Palette lock

- `Porcelain Ivory`: matte jacket-dress, sleeves, and boot ground.
- `Deep Indigo`: hair shadow masses, geometric outfit panels, grips, and primary value anchor.
- `Hot Magenta`: restrained hair-tip light, edge accents, and controlled prism activation only.
- `Smoke Gray`: low-sheen trim and secondary utility surfaces.
- `Translucent Prism`: lavender-ivory faceted fan and map-core material with crisp edges, not mirror chrome.
- `Muted Warm Gold`: small hardware, frame edges, buckles, and the single map-ring frame.
- `Natural Pale Skin`: soft satin response with no extreme tinting.

## Material direction

- Hair: smooth controlled highlights, non-metallic, grouped into large readable masses.
- Skin: soft satin response.
- Ivory and indigo outfit: mostly matte fabric with limited trim sheen.
- Hardware and ring frame: restrained low-to-medium metal response; small-area accent only.
- Prism fan and map core: translucent faceted surface with controlled lavender/ivory highlights.
- Activation: a narrow hot-magenta edge cue; no full-screen glow or floating symbol field.

## Proposed Gate B material slots

```text
MAT_ShionTategami_Face
MAT_ShionTategami_Hair
MAT_ShionTategami_Skin
MAT_ShionTategami_Outfit
MAT_ShionTategami_Equipment
MAT_ShionTategami_PrismEmission
```

These are planning categories only. Final slot count, shader values, texture sizes, emission budget, and Android measurements remain separate Gate B work.

## Boundary

The grayscale character panel is a value-hierarchy check, not a gameplay state or runtime material. This REVIEW asset does not authorize Unity import, Runtime replacement, 3D Blockout, or Gate B approval.
