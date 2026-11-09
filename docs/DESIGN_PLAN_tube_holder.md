# Design plan — Silicone tube drying holder (wall comb)

Brief version 1.0 confirmed on 2026-09-26 by the requester (one click). Single Low-load part: stages 1–5 run in one pass.

| # | Sub-task | Output | Load | Gate — what the user does |
|---|---|---|---|---|
| 1 | Shared values, helpers, tools | common.scad, helpers.scad, tools/ | Low | — |
| 2 | Model: comb (swept rounded band + slab), wall plate, root cove, screw holes; `part` selector holder / test_slot | tube_holder.scad, preview | Medium | — |
| 3 | Verification (§10): sweep, check_stl (2 passes, sections), render set, flatten --verify | tools/sweep_report, img/ | Low | — |
| 4 | Delivery package (§11): STLs (holder_1, holder_2, test_slot), README, DATASHEET, STATUS, zip | zip | Low | prints test slot, then the combs |
| 5 | Feedback after the print (§2.2), revision | confirmed-values table, v1.1 | Low | reports which tubes hold, photos |

Rules: building ahead of a physical result is allowed, releasing is not — the wedge hold is "not confirmed" until the test slot has been tried with the real tubes.
