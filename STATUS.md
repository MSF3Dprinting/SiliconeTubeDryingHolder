# STATUS — Silicone tube drying holder (wall comb)   (one page; update at the end of every conversation)

**Version:** 2.0 · **Stage:** 4 of 5 (delivery package done; v2.0 = stair slots, the requester's proposal) · **Next step:** print the test slot, try the real tubes (4, 8, 12 mm, with and without connector), then print the two combs; report back with the result and photos.

## Stages
| Stage | Status | Date | Note |
|---|---|---|---|
| 1 Shared values, helpers, tools | done | 2026-09-26 | common.scad, helpers.scad, tools/ from skill v1.3 |
| 2 Model | done | 2026-09-27 | v2.0: drafted core (pockets narrow 6 → 13 % through the thickness) + inset slice stacks for the edge rounding, cove ring, plate, countersunk screws; `part` = holder / test_slot |
| 3 Verification | done | 2026-09-27 | v2.0: sweep 39 PASS / 16 GUARD / 0 FAIL of 55, check_stl PASS two passes, T22 PASS, renders |
| 4 Delivery package | done | 2026-09-27 | tube_holder_v2.0.zip with STLs, README, DATASHEET, tools, brief, plan |
| 5 Feedback and revision | pending | | after the test slot and the first comb |

## Files
| File | Version | Purpose |
|---|---|---|
| tube_holder.scad | 2.0 | working file (include common.scad, helpers.scad) |
| tube_holder_customizer.scad | 2.0 | one-file Customizer version (verified identical) |
| tube_holder_context.scad | 2.0 | context scenes for the renders (never exported) |
| stl/tube_holder_holder_1_v2.0.stl, _2_ | 2.0 | the two combs, print position |
| stl/tube_holder_test_slot_v2.0.stl | 2.0 | one-slot test piece — print first |
| README.md, DATASHEET.md | 2.0 | user page and full record |
| docs/DESIGN_BRIEF_tube_holder.md, docs/DESIGN_PLAN_tube_holder.md | 2.0 / 1.0 | brief (confirmed by one click) and plan |
| tools/sweep_report_2026-09-27.txt, stl/EXPORT_LOG.txt | 2.0 | verification evidence |

## Confirmed by test print
| Value | Default | Confirmed | Source |
|---|---|---|---|
| Grip, 4 / 6 / 8 / 10 mm tubes stop at their step and stay | pockets 6 → 13 % narrower than the tube, 15 mm contact | | not confirmed — test slot (wall thickness unknown) |
| Screw hole Ø 4.7 for Ø 4 screws | screw_clr 0.5 | | not confirmed — first article |
| 4 kg load on the front edge | design 2 kg | | not confirmed — load test |

## Deviations from the brief (found while modelling — folded into the brief)
- v1.1: the friction wedge of v1.0 replaced by a V through the shelf thickness after the requester's feedback; shelf 12 mm.
- v2.0: the V replaced by stair slots (the requester's proposal: nothing inside the tube, no wedge on the big tubes); shelf 18 mm, plate 180 × 60 mm.
- No stepped tolerance coupon (nothing to step on a V hold); the test_slot part is the coupon.
- v1.0's root cove was modelled inside the plate (invisible); v1.1 corrects it — the cove is now in front of the plate.

## Warnings and decisions on record
- Critical item (§4.2): draft for review, Biomed + IPC sign-off before use. §4.3 flags: disinfection needed; contact with cleaned items before sterilisation.

## Open issues
- Exporter note: tools/openscad-fast now drops zero-area mesh specks (tools/stl_clean.py) that the Manifold engine leaves where a swept run overlaps a tangent arc at some extreme parameter values (slot_w_top=8, slot_w_bottom=1.6); the main body was watertight in every such case; cause = the tangent overlap of fillet chords, not the geometry.
- Connector diameters D and E not measured — checked on the test slot instead.
- Readiness levels proposed (field 2, maker 4, user 3, technology 2, risk 3) — to be confirmed by the 3D printing advisor.
- Grip is friction with a bounded squeeze: thin-walled 8–10 mm tubes may slide out — decided on the test slot; the pocket sizes and the squeeze are parameters for a reprint.

