# CH102 Mao Material Palette REVIEW v001 - Metadata

| Field | Value |
|---|---|
| Asset | `CH102_Mao_MaterialPalette_REVIEW_v001.png` |
| Scope | CH102 2D color tokens, material roles, bow active cue, and readability support |
| Backlog | `ART-1107` |
| Generated | 2026-08-11 |
| Tool | Built-in Codex `image_gen.imagegen` |
| Source reference | Approved CH102 character sheet and CH102 bow equipment sheet REVIEW v001 |
| Source commit | `418ef96` - `art: refine current roster gate A visuals` |
| Status | `REVIEW / 2D SHEET PACKAGE SUPPORT` |
| Human approval | Not separately approved; Gate A unified package is approved |
| Runtime use | Not permitted; palette review evidence only |

## Review color tokens

These are visual starting tokens for the 2D package, not final shader values:

| Role | Review token | Material direction |
|---|---|---|
| Hair | `#C8C1DF` | silver-lavender satin hair with soft highlight bands |
| Skin | `#F2D4C6` | pale warm anime skin with restrained cel shadow |
| Outfit black | `#1D1B27` | matte technical fabric / rubber-like trim |
| Outfit purple | `#6C3BC4` | saturated coated fabric or panel with controlled sheen |
| Bow metal | `#2A2B36` | dark graphite machined metal |
| Hardware gold | `#B58A40` | small restrained metal accent only |
| Active purple | `#A36BFF` | limited bow state cue / emission, not a full-screen effect |

## Included evidence

- Six material tiles: hair, skin, black fabric, purple coated panel, graphite bow metal, and active purple cue.
- Cropped examples tied to the approved outfit and bow direction.
- Material separation intended for the proposed `Face`, `Hair`, `Skin`, `Outfit`, `BowMetal`, and `BowPurple` slots.

## Open review points

- Confirm exact shader values, texture treatment, slot count, and Android overdraw during Gate B.
- Confirm low-saturation readability against the existing CH102 silhouette evidence.
- This image is not a Unity material asset or a standalone Gate B approval.
