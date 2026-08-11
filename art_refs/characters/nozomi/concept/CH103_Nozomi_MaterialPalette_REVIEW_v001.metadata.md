# CH103 Nozomi Material Palette REVIEW v001 — Metadata

| Field | Value |
|---|---|
| Asset | `CH103_Nozomi_MaterialPalette_REVIEW_v001.png` |
| Scope | CH103 color palette, material separation, and low-saturation value support |
| Source | `CH103_Nozomi_CharacterSheet_APPROVED_v001.png`; `CH103_Nozomi_EquipmentSheet_REVIEW_v001.png` |
| Roster source | `art_refs/characters/roster/current/CH101-105_Roster_FaceDiversity_WIP_v003.png` |
| Source commit | `418ef96` |
| Backlog | `ART-1207` |
| Generated | 2026-08-11 |
| Tool | Built-in Codex `image_gen.imagegen` |
| Status | `REVIEW / 2D COLOR-MATERIAL SUPPORT` |
| Human approval | Pending; shader slots and measured values remain Gate B work |
| Runtime use | Not permitted; production review evidence only |

## Palette lock

- Coral-red and coral-pink: jacket accents, hair/eye family, and emergency-veil edge accents.
- Cream-rose to coral: hair gradient family; no unrelated hair color.
- Milk ivory: high-neck base, wrap jacket ground, and boots.
- Restrained black: utility shorts and tool blocks only.
- Aqua mint: translucent emergency veil panels.
- Turquoise: resonance baton shaft and orb energy.
- Warm gold/brass: small hardware, connector rings, buckles, and panel frames.
- Natural skin tones: adult face and body; no extreme tinting.

## Material direction

- Hair: smooth controlled highlights, not metallic.
- Skin: soft satin response.
- Ivory/coral clothing: mostly matte fabric with limited trim sheen.
- Utility blocks: low-spec matte black.
- Baton: glossy turquoise orb with restrained glow; metallic connector hardware and controlled shaft sheen.
- Veil: translucent faceted aqua material with visible edge highlights and restrained coral patterning.

## Proposed Gate B material slots

The visual review categories above are consolidated into the common six-slot starting budget:

```text
MAT_KanadeNozomi_Face
MAT_KanadeNozomi_Hair
MAT_KanadeNozomi_Skin
MAT_KanadeNozomi_Outfit
MAT_KanadeNozomi_Equipment
MAT_KanadeNozomi_VeilEmission
```

`MAT_KanadeNozomi_Outfit` carries ivory/coral/black utility masks; `MAT_KanadeNozomi_Equipment` carries baton and warm hardware; `MAT_KanadeNozomi_VeilEmission` carries the translucent aqua veil and its controlled glow. These are planning proposals only. Final slot count, shader values, texture sizes, emission, and Android measurements remain Gate B work.
