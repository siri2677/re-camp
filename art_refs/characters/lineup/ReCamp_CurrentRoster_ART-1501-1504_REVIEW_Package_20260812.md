# Re:Camp Current Roster CH101-CH105 - ART-1501-1504 Review Package

> Date: 2026-08-12
> Branch: `art/current-roster-gate-a-ch102`
> Roster source commit: `418ef96` - `art: refine current roster gate A visuals`
> Package state: `REVIEW / HUMAN 5-PERSON VERDICT PENDING`
> `APPROVED`: `NOT GRANTED` for the five-person cross-roster decision

This is the current-generation cross-review package for the five figures in the morning roster. It uses the source-faithful CH101-CH105 evidence and does not replace any individual character approval record.

## 1. Source lock and exclusion

| Item | Current decision evidence |
|---|---|
| Controlling visual source | `art_refs/characters/roster/current/CH101-105_Roster_FaceDiversity_WIP_v003.png` |
| Source evidence commit | `418ef96` |
| Current roster proxy | `art_refs/characters/roster/current/CH101-105_Roster_GateA_Evidence_WIP_v001.png` |
| Individual package manifests | `art_source/manifests/CH101_Rin_Production_Sheet_Approval_20260811.md`, `CH102_Mao_Production_Sheet_Approval_20260811.md`, `CH103_Nozomi_Production_Sheet_Approval_20260811.md`, `CH104_Shion_Production_Sheet_Approval_20260812.md`, `CH105_Akari_GateA_Review_v001.md` |
| Excluded historical package | `art_refs/characters/lineup/ReCamp_ART-1501-1504_REVIEW_Package.md` and its 2026-08-07 Luna/Miyu/Coco/Iris/Noah imagery |
| IP similarity review | `art_refs/characters/lineup/ReCamp_CurrentRoster_ART-1503_IPReview_REVIEW_20260812.md` |
| Final comparison sheet | `art_refs/characters/lineup/ReCamp_CurrentRoster_ART-1504_FinalComparison_REVIEW_20260812.png` plus `.metadata.md` and `.review.md` |
| Human decision record | `art_source/manifests/CH101-105_CurrentRoster_CrossReview_Decision_20260812.md` |
| 2D-to-3D proof audit | `art_source/manifests/CH101-105_2DTo3D_Translation_Proof_REVIEW_20260812.md` |

The excluded package is retained for history only. It is not evidence for the current CH101-CH105 roster and must not be used for character selection, 3D handoff, or Unity migration.

## 2. Current evidence set

| Review lane | Current evidence | State |
|---|---|---|
| Morning source fidelity | `CH101-105_Roster_FaceDiversity_WIP_v003.png` | `LOCKED FOR REVIEW` |
| Face identity, equipment-OFF silhouette, low-saturation proxy | `CH101-105_Roster_GateA_Evidence_WIP_v001.png` | `CONDITIONAL / HUMAN REVIEW` |
| CH101 Rin | Approved 2D sheet plus supporting Face128, silhouette, expression, equipment, and material evidence | `INDIVIDUAL 2D APPROVED` |
| CH102 Mao | Approved 2D sheet plus supporting Face128, silhouette, expression, equipment, and material evidence | `INDIVIDUAL 2D APPROVED` |
| CH103 Nozomi | Approved 2D sheet plus supporting Face128, silhouette, expression, equipment, and material evidence | `INDIVIDUAL 2D APPROVED` |
| CH104 Shion | Approved 2D sheet plus supporting Face128, silhouette, expression, equipment, and material evidence | `INDIVIDUAL 2D APPROVED` |
| CH105 Akari | Complete REVIEW package and separate Gate A request; no approved sibling | `GATE A PENDING` |

The individual approval labels above do not grant a five-person cross-roster approval. The five-person verdict remains open until the current evidence is reviewed together.

## 3. Current identity matrix

| Character | Morning-roster identity anchor | Palette and silhouette separation | Equipment hook | Current Gate A state |
|---|---|---|---|---|
| CH101 Rin | black hair with cyan inner/back hair; bright cyan eyes; athletic runner read | white/cyan over black; short diagonal and ribbon motion | one saber and one signal ribbon | `APPROVED / 2D SHEET` |
| CH102 Mao | long silver-lavender hair; violet eyes; controlled maker read | purple/black layered vertical mass; bow geometry | one large mechanical bow | `APPROVED / 2D SHEET` |
| CH103 Nozomi | coral braided hair; warm coral eyes; soft rescue/protection read | ivory/coral with broad translucent veil mass | one orb staff and controlled veil | `APPROVED / 2D SHEET` |
| CH104 Shion | deep indigo hair with magenta tips; narrow indigo eyes; tall precision read | ivory/indigo long vertical structure | one prism fan and one map ring | `APPROVED / 2D SHEET` |
| CH105 Akari | black hair with teal inner/back hair; mature amber eyes; broad grounded protector read | black/forest-green utility mass with copper-gold hardware | heavy gauntlet pair, one anchor ring, restrained cable line | `REVIEW / GATE A PENDING` |

## 4. ART-1501 and ART-1502 review lanes

### ART-1501 - current five-person identity and candidate consistency

Review the five current figures together for face family separation, adult-feminine proportion, role hook, palette family, equipment mass, and A/B/C identity continuity. The controlling question is whether each figure is recognizable as a separate character while still belonging to one project style.

Current result: `REVIEW READY / 5-PERSON HUMAN VERDICT PENDING`.

### ART-1502 - same-scale face, silhouette, and low-saturation read

Use the current roster proxy together with each character's Face128 and silhouette evidence. The roster proxy is a review aid, not a runtime export. The review must confirm that the five faces, equipment-OFF silhouettes, and value blocks remain readable at the same scale.

Current result: `REVIEW READY / SAME-SCALE HUMAN VERDICT PENDING`.

## 5. Human review checklist

1. Does the source image show the correct current CH101, CH102, CH103, CH104, and CH105 identities in that order?
2. Does each character remain distinct by face, hair, body read, role, palette, silhouette, and equipment hook?
3. Do the A/B/C states in the individual packages read as states of one character rather than alternate character choices?
4. At the same scale, are face identity, equipment-OFF silhouette, and low-saturation value blocks sufficiently separated?
5. Is the CH105 package acceptable for the separate Gate A decision described in `CH105_Akari_GateA_Review_Request_20260812.md`?
6. Should the current five-person cross-review be recorded as `PASS`, `CONDITIONAL`, or `REVISION REQUIRED`?

## 6. ART-1503 - originality review boundary

The repository-level IP similarity precheck is documented separately in `ReCamp_CurrentRoster_ART-1503_IPReview_REVIEW_20260812.md`. It records the current identity combinations and review questions, but formal external search, trademark review, copyright review, and legal clearance have not been performed.

## 7. Decision boundary

This package does not authorize Blender/FBX, 3D Blockout, rigging, animation, shader proof, Unity import, Runtime roster replacement, Android proof, or release use.

Until CH105 receives a separate human Gate A decision and the five-person review is recorded, keep `ART-1501`, `ART-1502`, and `ART-1504` in review and do not migrate the current roster into Runtime.

## 8. Next action

1. Human-review this current CH101-CH105 package against the morning source image.
2. Record the five-person cross-review result in `art_source/manifests/CH101-105_CurrentRoster_CrossReview_Decision_20260812.md` without changing the source image.
3. Complete the separate CH105 Gate A decision; if approved, create a separately named APPROVED sibling and approval record.
4. Only after those decisions, revise or promote the comparison record and prepare any later Gate B preflight.
