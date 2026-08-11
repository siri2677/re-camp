# CH103 Nozomi Equipment Sheet REVIEW v001 — Metadata

| Field | Value |
|---|---|
| Asset | `CH103_Nozomi_EquipmentSheet_REVIEW_v001.png` |
| Scope | CH103 representative equipment structure, activation, socket, and simplification support |
| Source | `CH103_Nozomi_CharacterSheet_APPROVED_v001.png`; `CH103_Nozomi_Silhouette_ON_OFF_WIP_A_v001.png` |
| Roster source | `art_refs/characters/roster/current/CH101-105_Roster_FaceDiversity_WIP_v003.png` |
| Source commit | `418ef96` |
| Backlog | `ART-1206` |
| Generated | 2026-08-11 |
| Tool | Built-in Codex `image_gen.imagegen` |
| Status | `REVIEW / 2D EQUIPMENT SUPPORT` |
| Human approval | Pending; socket transforms and Gate B proof remain open |
| Runtime use | Not permitted; production review evidence only |

## Included evidence

- Left zone: turquoise-orb resonance baton, full view and side/profile view.
- Center zone: emergency veil panel system in folded, partial, and full deployment reads.
- Right zone: on-character placement reference for baton hand position and veil roots.

All equipment remains tied to the approved Nozomi identity and A/B/C state package. The baton is one representative object; the emergency veil is one controlled group of large translucent panels.

## 2D-to-3D handoff notes

### Keep

- Baton orb, slim shaft, grip, connector rings, and end cap.
- Veil's broad curved panel silhouette, faceted aqua material, restrained coral edge accents, and small hinge/edge frames.
- A/B/C activation progression: lowered/folded, raised/partial, and full protection.

### Enlarge or clarify

- Baton orb and grip for hand clearance and readable scale.
- Veil panel root, edge frame, and upper-back/waist attachment areas.

### Simplify or remove

- Micro-fasteners, duplicate hinge layers, hidden internal braces, and independent floating parts.
- Cloth simulation, free-hanging cable physics, and opaque-shield geometry.

## Proposed attachment references

These are Gate B proposals, not imported assets or final transforms:

```text
CHR_KanadeNozomi
  VisualRoot
    GEO_Body_LOD0
    GEO_Hair_LOD0
    GEO_Outfit_LOD0
    Socket_Equipment_R
      PRP_Nozomi_ResonanceBaton
        Socket_BatonGrip
        Socket_BatonOrb
    Socket_VeilRoot_L
    Socket_VeilRoot_R
    Socket_VeilWaist_L
    Socket_VeilWaist_R
```

Final socket transforms, collider policy, shader/VFX values, and runtime state transitions remain Gate B work.
