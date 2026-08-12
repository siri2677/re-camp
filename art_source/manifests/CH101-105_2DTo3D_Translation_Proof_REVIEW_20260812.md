# CH101-CH105 Current Roster - 2D-to-3D Translation Proof REVIEW

> Date: 2026-08-12
> Branch: `art/current-roster-gate-a-ch102`
> Backlog: `ART-0112`, with character-level `ART-1008`, `ART-1108`, `ART-1208`, `ART-1308`, `ART-1408`
> Source commit: `418ef96` - `art: refine current roster gate A visuals`
> Status: `REVIEW / DOCUMENTATION PROOF ASSEMBLED`
> Gate B: `NOT APPROVED`
> 3D/Unity proof: `NOT TESTED`

The documentation-side next-step index is `art_source/manifests/CH101-105_GateB_Preflight_REVIEW_20260812.md`. It does not change the Gate B or 3D/Unity boundary below.

This document audits the five current-generation 2D-to-3D translation contracts as one review package. It proves that the planned reduction rules, common proportion targets, equipment policies, material proposals, state boundaries, and missing technical evidence are recorded consistently.

It is not a Blender/FBX, mesh, rig, shader, animation, Unity, Android, or Runtime proof. It does not authorize 3D implementation.

## 1. Source and contract map

| Character | 2D source package | Translation contract | Current 2D state |
|---|---|---|---|
| CH101 Rin | `art_source/manifests/CH101_Rin_Production_Handoff_REVIEW_v001.md` | `art_source/manifests/CH101_Rin_Production_Handoff_REVIEW_v001.md` section 4 | `2D APPROVED / Gate B preparation` |
| CH102 Mao | `art_refs/characters/mao/CH102_Mao_ART-1101-1108_REVIEW_Package.md` | `art_source/manifests/CH102_Mao_2DTo3D_Translation_REVIEW_v001.md` | `2D APPROVED / Gate B not approved` |
| CH103 Nozomi | `art_source/manifests/CH103_Nozomi_StateReference_v001.md` | `art_source/manifests/CH103_Nozomi_2DTo3D_Translation_REVIEW_v001.md` | `2D APPROVED / Gate B not approved` |
| CH104 Shion | `art_source/manifests/CH104_Shion_StateReference_v001.md` | `art_source/manifests/CH104_Shion_2DTo3D_Translation_REVIEW_v001.md` | `2D APPROVED / Gate B not approved` |
| CH105 Akari | `art_source/manifests/CH105_Akari_GateA_Review_v001.md` | `art_source/manifests/CH105_Akari_2DTo3D_Translation_REVIEW_v001.md` | `2D APPROVED / Gate B not approved` |

Common technical contract: `docs/05_art_concept/CHARACTER_3D_SPEC.md`.
Common Gate B checklist: `docs/05_art_concept/ART_REVIEW_CHECKLIST.md`, items `CHA-B01` through `CHA-B10`.

## 2. Common proportion and proof boundary

| Character | Current 2D target | Planned 3D target | Current evidence | Missing technical proof |
|---|---:|---:|---|---|
| CH101 Rin | `6.9-7.1H` | `5.3-5.4H` | Approved sheet, handoff, Gate B preflight | proportion blockout, Humanoid proof, pose captures |
| CH102 Mao | `6.8-7.0H` | `5.2-5.3H` | Approved sheet and translation contract | proportion blockout, socket/collider proof, Android measurements |
| CH103 Nozomi | `7.0-7.2H` | `5.5-5.6H` | Approved sheet and translation contract | proportion blockout, veil/baton socket proof, Android measurements |
| CH104 Shion | `7.1-7.3H` | `5.6-5.7H` | Approved sheet and translation contract | proportion blockout, fan/ring socket proof, Android measurements |
| CH105 Akari | `7.2-7.4H` | `5.7-5.8H` | Approved 2D sheet and translation contract | proportion blockout, gauntlet/ring socket proof |

The targets are planning values from the Canonical Baseline and character contracts. They are not measured 3D results.

## 3. Character translation matrix

| Character | Keep / enlarge | Simplify / remove from first proof | Equipment and physics policy | Primary risk |
|---|---|---|---|---|
| CH101 Rin | face, high ponytail, white/black jacket split, boots, one saber, one cyan signal ribbon | micro hair, small buckles, ribbon lattice, multi-part physics | one weapon socket; one Ribbon Mesh/Trail; no Cloth/Cable physics | ribbon occlusion, saber hand clearance, overdraw |
| CH102 Mao | face, silver-lavender hair mass, asymmetric sleeve, large purple bow silhouette | loose strands, tiny fasteners, repeated bow micro-mechanics | one bow object with controlled deployment; no multi-part mechanical simulation | bow string/pivot intersection, long coat clipping |
| CH103 Nozomi | round face, coral braid, ivory/coral outfit, orb baton, large veil panels | micro strands, small print, duplicate trim, many veil pieces | one baton object; a small number of large veil panels with shader/VFX; no Cloth | veil occlusion, translucent overdraw, arm clearance |
| CH104 Shion | angular face, indigo/magenta hair mass, ivory/indigo vertical outfit, prism fan, one map ring | micro hair, tiny gold lines, internal prism detail, orbit simulation | one fan root and one ring; presentation state only; no orbit/cloth physics | fan/ring camera read, coat clipping, value collapse |
| CH105 Akari | mature face, black/teal hair boundary, shoulder/waist break, boots, gauntlets, one anchor ring | micro hair, tiny buckles, hidden mechanisms, loose cable links | paired gauntlet reads, one ring, one/two line segments; no Cloth/Cable physics | wrist/elbow/torso penetration, dark-value collapse, proportion cross-check |

The matrix preserves one representative equipment hook per character. It does not authorize adding alternate weapons or replacing the morning-roster identity.

## 4. Shared implementation budget carried forward

From `CHARACTER_3D_SPEC.md`, all five contracts carry the same first-proof limits:

- LOD0 body mesh `<=18,000` triangles; representative equipment addition `<=2,000` triangles.
- LOD1 and LOD2 targets remain `<=10,000` and `<=5,000` body triangles.
- Material slots target `<=6`; deform bones target `<=55`; helper bones/drivers target `<=8`.
- Face BlendShapes target `<=8` for LOD0/LOD1 and `0-4` for LOD2.
- Cloth/Cable physics remain `0`; use transforms, state drivers, shader, Trail, or controlled VFX cues.
- Orthographic quarter-view proof must confirm a three-second read for face, boots, and representative equipment.

These are proof budgets, not measured Android performance results.

## 5. CHA-B01 to CHA-B10 evidence audit

| Gate B item | Documentation evidence now assembled | Actual proof state |
|---|---|---|
| `CHA-B01` Turnaround consistency | Individual character sheets, turnaround references, and source locks | `CONDITIONAL / 3D proportion cross-check missing` |
| `CHA-B02` Equipment structure and sockets | Five translation tables, equipment sheets, state contracts, socket proposals | `CONDITIONAL / transform and collider proof missing` |
| `CHA-B03` Keep/enlarge/simplify/remove rules | CH101 handoff plus CH102-CH105 translation contracts | `READY FOR GATE B REVIEW / technical implementation missing` |
| `CHA-B04` 5-6H adult readability and Humanoid | Baseline targets and common 3D spec | `CONDITIONAL / blockout and Humanoid proof missing` |
| `CHA-B05` Joint and pose intersection | No 2D evidence can prove this | `NOT TESTED` |
| `CHA-B06` Material-slot separation | Individual palette sheets and common six-slot baseline | `CONDITIONAL / imported slot proof missing` |
| `CHA-B07` Camera, hand, foot, and equipment focus | Translation camera/socket rules and comparison sheets | `CONDITIONAL / quarter-view capture missing` |
| `CHA-B08` Physics and penetration budget | No-physics policies and simplification risks | `READY FOR GATE B REVIEW / runtime probe missing` |
| `CHA-B09` Signature motion and equipment state | Animation direction and A/B/C state contracts | `NOT TESTED / motion thumbnails or clips missing` |
| `CHA-B10` Polygon, texture, bone, BlendShape, LOD, shader budget | `CHARACTER_3D_SPEC.md` and character contracts | `CONDITIONAL / measured Android proof missing` |

## 6. Current decision

The 2D-to-3D translation documentation is `REVIEW READY` for later Gate B preparation. The following gates remain closed:

- CH105 2D Gate A and the five-person 2D cross-review decision are recorded; Gate B remains closed.
- Blender/FBX, 3D Blockout, common Humanoid, socket, collider, material import, animation, and shader proof.
- Unity import, Runtime roster replacement, Android readability/performance, and release use.

No character should be marked `Gate B APPROVED` from this document.

## 7. Next action

1. Keep the recorded five-person decision and CH105 2D approval linked to this documentation baseline.
2. Use `CH101-105_GateB_Preflight_REVIEW_20260812.md` as the five-character documentation handoff.
3. If the technical environment becomes available and the required Gate B approval is granted, open a separate character proof task and create actual CHA-B05/B07/B09 evidence.
4. Keep this document as the documentation baseline; update it only when a versioned contract or real technical proof changes.
