# CH101-CH105 Current Roster - Gate B Preflight REVIEW v001

> Date: 2026-08-12
> Branch: `art/current-roster-gate-a-ch102`
> Source commit: `418ef96` - `art: refine current roster gate A visuals`
> Status: `REVIEW / FIVE-CHARACTER GATE B PREFLIGHT ASSEMBLED`
> Gate B: `NOT APPROVED`
> 3D/Unity proof: `NOT TESTED`
> Backlog: `ART-0112`, character-level `ART-1104~ART-1108`, `ART-1204~ART-1208`, `ART-1304~ART-1308`, `ART-1404~ART-1408`

This is the current five-character Gate B preparation index. It connects the approved 2D production sheets, current-generation support evidence, translation contracts, per-character preflight records, and common 3D budget. It is a documentation and handoff package only; it does not claim Blender, FBX, Unity, Android, or Runtime evidence.

## 1. Source and package lock

| Character | Approved 2D source | Gate B preflight | Handoff / translation contract | Current state |
|---|---|---|---|---|
| CH101 Rin | `art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_APPROVED_v001.png` | `art_source/manifests/CH101_Rin_GateB_Preflight_REVIEW_v001.md` | `CH101_Rin_Production_Handoff_REVIEW_v001.md` | `2D APPROVED / Gate B conditional` |
| CH102 Mao | `art_refs/characters/mao/concept/CH102_Mao_CharacterSheet_APPROVED_v001.png` | `art_source/manifests/CH102_Mao_GateB_Preflight_REVIEW_v001.md` | `CH102_Mao_Production_Handoff_REVIEW_v001.md` + translation contract | `2D APPROVED / Gate B conditional` |
| CH103 Nozomi | `art_refs/characters/nozomi/concept/CH103_Nozomi_CharacterSheet_APPROVED_v001.png` | `art_source/manifests/CH103_Nozomi_GateB_Preflight_REVIEW_v001.md` | StateReference + translation contract | `2D APPROVED / Gate B conditional` |
| CH104 Shion | `art_refs/characters/shion/concept/CH104_Shion_CharacterSheet_APPROVED_v001.png` | `art_source/manifests/CH104_Shion_GateB_Preflight_REVIEW_v001.md` | `CH104_Shion_Production_Handoff_REVIEW_v001.md` + translation contract | `2D APPROVED / Gate B conditional` |
| CH105 Akari | `art_refs/characters/akari/concept/CH105_Akari_CharacterSheet_APPROVED_v001.png` | `art_source/manifests/CH105_Akari_GateB_Preflight_REVIEW_v001.md` | `CH105_Akari_Production_Handoff_REVIEW_v001.md` + translation contract | `2D APPROVED / Gate B conditional` |

All five identities are anchored to the morning roster source. The 5-person 2D cross-roster decision is `PASS`, but that decision does not approve 3D or Runtime use.

## 2. Common Gate B matrix

| Gate B item | Five-character documentation state | Actual missing proof |
|---|---|---|
| `CHA-B01` Turnaround consistency | `READY FOR GATE B REVIEW` for CH101~CH105 | 3D proportion/blockout cross-check for each character |
| `CHA-B02` Equipment structure and sockets | `READY FOR GATE B REVIEW` | measured socket transforms, hand clearance, and collider probes |
| `CHA-B03` Keep/enlarge/simplify/remove | `READY FOR GATE B REVIEW` | technical implementation proof |
| `CHA-B04` 5~6H adult readability and Humanoid | `CONDITIONAL` | common Humanoid blockout and pose captures |
| `CHA-B05` Joint/outfit/equipment collision | `NOT TESTED` | shoulder, elbow, wrist, hip, knee, and equipment pose blockouts |
| `CHA-B06` Material-slot separation | `READY FOR GATE B REVIEW / CONDITIONAL` | imported slot proof, shader references, and missing-slot checks |
| `CHA-B07` Camera/hand/foot/equipment clearance | `CONDITIONAL` | fixed orthographic quarter-view captures |
| `CHA-B08` Physics and penetration budget | `READY FOR GATE B REVIEW` policy | runtime penetration, overdraw, and performance probes |
| `CHA-B09` Signature motion and equipment state | `NOT TESTED` | Idle/Attack/Skill/Victory motion thumbnails or clips |
| `CHA-B10` Polygon/texture/bone/BlendShape/LOD/shader budget | `CONDITIONAL` | measured Android and Editor proof |

## 3. Common proof contract

Use `docs/05_art_concept/CHARACTER_3D_SPEC.md` as the starting contract for all five characters:

- LOD0 body `<=18,000` triangles; representative equipment addition `<=2,000`.
- LOD1/LOD2 body targets `<=10,000` / `<=5,000`; equipment `<=1,200` / `<=600`.
- Texture atlas `2048²` max for LOD0, `1024²` for LOD1, `512²` for LOD2.
- Material slots `<=6` for LOD0/LOD1 and `<=4` for LOD2.
- Deform bones `<=55`, helper bones/drivers `<=8`, Face BlendShapes `<=8` at LOD0/LOD1.
- Cloth/Cable Physics `0` for the first proof; use controlled transforms, Trail/Ribbon, shader, or bounded VFX cues.
- Common root axis `+Z` forward, `+Y` up, scale `(1,1,1)`, in-place animation, Root Motion default `false`.

These are proof budgets, not measured Android performance results. Final model, rig, material, prefab, animation, and Runtime approval remain separate.

## 4. Character-specific first-proof focus

| Character | First proof must preserve | First proof must avoid |
|---|---|---|
| CH101 Rin | high ponytail, white/black split, single saber, one cyan signal ribbon | ribbon cloth, multiple saber/ribbon systems, face occlusion |
| CH102 Mao | silver-lavender hair, black/purple maker read, one folding bow | independent bow rings, free string/cable physics, hand intersection |
| CH103 Nozomi | coral braid, ivory/coral rescue read, orb baton, few large veil panels | opaque shield, many cloth panels, translucent overdraw |
| CH104 Shion | indigo vertical read, prism fan, one map ring, restrained cue | second ring, orbit simulation, floating beam geometry |
| CH105 Akari | black/teal hair, grounded protector read, paired gauntlets, one anchor ring | second ring, giant shield, cable physics, full armor redesign |

## 5. Required evidence sequence

1. Confirm the approved 2D source and versioned identity package for the character.
2. Create temporary Blockout-only geometry under `Assets/_ReCamp/Art/Blockout/` when the 3D environment is available.
3. Validate root/axis/scale, common Humanoid mapping, sockets, material slots, LODs, and no-physics policy.
4. Capture Front/Side/Back, quarter-view, A/B/C state, joint-intersection, and representative equipment evidence for each character.
5. Add motion thumbnails or clips for the character's signature equipment states.
6. Record actual triangle/material/bone/BlendShape/texture/overdraw/Android measurements.
7. Re-run `CHA-B01~B10`, request human Gate B approval, and only then prepare Unity import/Runtime work.

## 6. Current blockers and boundary

- Blender executable is not available in the current workspace session.
- Unity proof is blocked by the missing Unity license in CI and no local Unity project environment is available here.
- AndroidPlayer/SDK/NDK/OpenJDK and a test device are not available for measured proof.
- No file in this package authorizes Blender/FBX export, 3D Blockout, Unity import, Runtime roster replacement, Android proof, or release use.

The next actionable technical step is environment setup or a user-provided 3D proof artifact. Until then, this package is the complete documentation-side Gate B handoff for CH101~CH105.
