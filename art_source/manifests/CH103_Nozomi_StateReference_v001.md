# CH103 Kanade Nozomi - State Reference Manifest v001

> Backlog: `ART-1201`, `ART-1202`, `ART-1203`, `ART-1209`
> Status: `APPROVED / 2D production sheet / Gate B pending`
> Primary visual source: `art_refs/characters/roster/current/CH101-105_Roster_FaceDiversity_WIP_v003.png`
> Source commit: `418ef96` - `art: refine current roster gate A visuals`
> WIP board: `art_refs/characters/nozomi/concept/CH103_Nozomi_GateA_Candidates_WIP_v001.png`
> Face support: `art_refs/characters/nozomi/concept/CH103_Nozomi_Face128_WIP_A_v001.png`
> Silhouette support: `art_refs/characters/nozomi/concept/CH103_Nozomi_Silhouette_ON_OFF_WIP_A_v001.png`
> Unified sheet review: `art_refs/characters/nozomi/concept/CH103_Nozomi_CharacterSheet_REVIEW_v001.png`
> Approved sheet: `art_refs/characters/nozomi/concept/CH103_Nozomi_CharacterSheet_APPROVED_v001.png`
> Turnaround review: `art_refs/characters/nozomi/concept/CH103_Nozomi_Turnaround_REVIEW_v001.png`
> Expression review: `art_refs/characters/nozomi/concept/CH103_Nozomi_ExpressionSheet_REVIEW_v001.png`
> Equipment review: `art_refs/characters/nozomi/concept/CH103_Nozomi_EquipmentSheet_REVIEW_v001.png`

This manifest defines the approved CH103 A/B/C board as one usable character state package. It follows the same package logic used for the approved CH102 sheet: A is the neutral anchor, while B/C are controlled equipment and action-state references.

## Shared identity lock

- Third figure from the left in the morning roster is the only visual source for this WIP package.
- Face, cream-rose/coral hair, thin side braid, adult healthy body read, ivory/coral outfit, aqua-mint veil, and turquoise-orb baton are shared across A/B/C.
- No state may introduce a new costume, body type, or unrelated weapon.

## State map

| State | Use | Emergency veil read |
|---|---|---|
| `A` Neutral | idle, profile, roster, neutral reference | folded/quiet |
| `B` Ready | response preparation and transition | partially opened |
| `C` Full Protection | protection/utility presentation | large curved panels opened |

## Production rules

1. Use A as the neutral face/hair/body anchor.
2. Use B/C as the same character's veil deployment and action references.
3. Keep Face128, turnaround, expression, palette, and 2D-to-3D evidence consistent across all states.
4. Treat the baton as one representative equipment object and the veil as one controlled panel system.
5. The approved 2D sheet does not authorize Unity import, Runtime replacement, or 3D Blockout.
6. Use the neutral turnaround for construction checks; use the approved A/B/C sheet for deployed veil states.
7. Expression references must preserve the shared identity across A/B/C and remain separate from runtime deformation proof.
8. Equipment detail must keep one baton object and one controlled veil panel system; proposed sockets remain Gate B inputs only.

## Approval and supporting evidence

- Final Gate A 2D production-sheet approval was recorded by the user on 2026-08-11 in `CH103_Nozomi_Production_Sheet_Approval_20260811.md`.
- Face128 board: three state-linked close-ups of the same face and hair identity; approved as current 2D input.
- ON/OFF/LOW-SAT board: deployed veil, core outfit, and value-check states; approved as current 2D input.
