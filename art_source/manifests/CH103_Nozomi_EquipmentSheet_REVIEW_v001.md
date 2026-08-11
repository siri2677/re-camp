# CH103 Kanade Nozomi - Equipment Sheet Review Manifest v001

> Backlog: `ART-1206`
> Status: `REVIEW / 2D EQUIPMENT SUPPORT`
> Primary visual source: `art_refs/characters/nozomi/concept/CH103_Nozomi_CharacterSheet_APPROVED_v001.png`
> Deployment support: `art_refs/characters/nozomi/concept/CH103_Nozomi_Silhouette_ON_OFF_WIP_A_v001.png`
> Roster source commit: `418ef96`

This manifest records the representative equipment package for the approved CH103 identity: one turquoise-orb resonance baton and one controlled emergency-veil panel system.

## Asset

```text
art_refs/characters/nozomi/concept/CH103_Nozomi_EquipmentSheet_REVIEW_v001.png
art_refs/characters/nozomi/concept/CH103_Nozomi_EquipmentSheet_REVIEW_v001.metadata.md
art_refs/characters/nozomi/concept/CH103_Nozomi_EquipmentSheet_REVIEW_v001.review.md
```

## State contract

| State | Baton | Emergency veil |
|---|---|---|
| `A Neutral` | lowered at side | folded/quiet stack |
| `B Ready` | raised/active | one curved panel partially open |
| `C Full Protection` | active presentation | broad curved panels opened |

## Gate B preparation locks

- Keep one baton root and one controlled veil group; do not split into unrelated weapons or many independent cloth objects.
- Proposed sockets are `Socket_Equipment_R`, `Socket_BatonGrip`, `Socket_BatonOrb`, `Socket_VeilRoot_L`, `Socket_VeilRoot_R`, `Socket_VeilWaist_L`, and `Socket_VeilWaist_R`.
- Verify socket transforms, collider policy, material slots, shader/VFX direction, and state transitions during Gate B.
- This 2D review does not authorize Blender/FBX export, 3D Blockout, Unity import, or Runtime roster replacement.
