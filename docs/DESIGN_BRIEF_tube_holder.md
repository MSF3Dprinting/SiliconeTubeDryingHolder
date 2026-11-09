# Design brief — Silicone tube drying holder (wall comb)

**Request:** sterilisation room, tube drying · 2026-09-27 · Brief version 2.0 (1.0 wedge and 1.1 V-slot rejected by the requester; 2.0 stair slots are his own proposal, sizes and squeeze chosen by him)
**Written against:** msf-3dp-design skill v1.3 · **Personal data:** none

## 1. Item
- Purpose: wall-mounted comb that lets washed silicone tubes (Ø 4–12 mm, most Ø 8 mm, with or without a rigid connector in the end) hang straight down to drain and dry — not folded over a hook.
- Area of use and users: sterilisation room (hospital, clean side); sterilisation staff.
- Criticality (§4): in scope; critical item by §4.2 (new part in the hospital environment) → draft for review, Biomed + IPC sign-off before use. §4.3 flags: disinfection needed; holds cleaned items before sterilisation.
- Existing designs and OEM parts: none directly usable (MSF UMS, Printables, Thingiverse: nothing for straight hanging of soft tubes; commercial racks use pegs, which fold the tube). New design.

## 2. Design assumptions
- Function: open-front stair slot per tube: four pockets from the mouth inward for 10 / 8 / 6 / 4 mm tubes, each 6 % narrower than its tube at the top face and 13 % at the bottom face of an 18 mm shelf, a hard step behind each pocket. The tube is pushed in until it stops and is held by friction with a bounded squeeze; nothing depends on the push (v1.0 friction wedge: tubes fell when not pushed; v1.1 V-slot: squeezed the big tubes — both rejected).
- Loads: 5 wet tubes < 1 m per comb ≈ 0.6 kg hanging; design load 2 kg per comb; test at 4 kg (2 × design load). Someone pulling a tube out: < 50 N at the front edge.
- Fit type: none (wedge on soft silicone; no printed–printed interface). Screws: loose clearance in the plate, the plug takes the alignment.
- Mating part varies: tube Ø 4 / 6 / 8 / 10 mm, one pocket each (parameters); wall thickness unknown — it sets the grip, confirmed on the test slot. Nothing enters the tube; the holder holds it from the outside only (requester's requirement).
- Mating hardware: 2 × Ø 4 mm screws with wall plugs per comb (parameter).
- Materials acceptable, in order: PETG white / natural / light colour (on the shelf) · PLA light colour (indoor, room temperature, wiping only) · ASA light colour (advisor to confirm). Never a dark filament.
- Environment: room temperature; water dripping from wet tubes; wiped with Surfanios, bleach 1:10 or IPA.
- Print orientation: lying on its back (wall plate on the bed, shelf standing up, slots pointing up). No support, no brim. All faces of the shelf, coves and countersinks point up or sideways.
- Layout assumptions: tubes are hung from their upper end; the wall is flat; two combs side by side give 10 places.

## 3. Shape and size
- Overall size per comb (print position, X × Y × Z): 180 × 60 × 60 mm.
- Features: wall plate 6 mm with 2 countersunk screw holes above the shelf; shelf 18 mm thick, 54 mm deep, 164 mm wide with 5 stair slots (pockets 9.4 / 7.5 / 5.6 / 3.8 mm at the top face, 13 % narrower at the bottom face, 13 / 11 / 9 / 7 mm long, pitch 30 mm), every edge rounded (R 1.5), pocket corners R 0.4, finger tips R 4; root cove R 6 all round; plate edges chamfered.
- Colour bands: none (disinfected item).

## 4. Parameters the user can change
| Parameter | Default | Range | What it changes |
|---|---|---|---|
| slot_n | 5 | 1–8 | slots per comb |
| slot_pitch | 30 | 20–50 | distance between tube centres |
| pocket_1…4, squeeze_top / squeeze_bottom | 10 / 8 / 6 / 4, 6 / 13 % | see file | the pockets = the tubes they hold and how firmly |
| shelf_t, edge_r, step_r, tip_r, bar_w, side_w | 18 / 1.5 / 0.4 / 4 / 12 / 22 | see file | contact height, edge rounding, solid margins |
| plate_t, plate_above, plate_below, root_r | 6 / 30 / 12 / 6 | see file | wall plate and root cove |
| screw_d, screw_head_d, screw_n, screw_spacing | 4 / 8 / 2 / 120 | see file | wall screws |

## 5. Changed from the request
| Request said | Reading taken / change made | Constraint that forced it |
|---|---|---|
| 10 tubes next to each other | 2 identical combs of 5, side by side | printer bed 250 × 210 mm; parts ≤ 200 mm (MSF); reprint of one comb possible |
| "extended end" | rigid connector in the tube end, not on every tube | user's answers; the slot works with and without it |
| (v1.0) tapered slot, tube wedged by friction | (v1.1) V-slot through the shelf thickness | requester: tubes fall when not squeezed in |
| (v1.1) V-slot | (v2.0) stair slot, a pocket per size with a hard stop | requester: the V squeezes the big tubes too much; nothing may enter the tube; he asked for the stair |

## 6. Defaults relied on (tagged (default) — please confirm)
- Slot pitch 30 mm; pockets for 10 / 8 / 6 / 4 mm with 6 → 13 % squeeze over an 18 mm shelf; tubes hang 15–50 mm off the wall (bar_w 12 + plate 6 + pocket position).
- Edge rounding R 1.5, pocket corners R 0.4; root cove R 6; plate 6 mm; countersunk Ø 4 screws, head Ø 8.

## 7. Flags and approval
- Advisor flags (§4.3): disinfection needed; contact with reprocessed medical items.
- Approval: Biomed + IPC advisor.

## 8. Failure consequence and test before use
- If it fails: tubes drop to the floor and must be re-cleaned; nothing heavy falls, no one is hurt, no patient exposure.
- Test before use: function (each tube size stops at its step, stays when let go — also wet, also under a two-finger pull — and pulls out forward), cleaning (wipe test, no residue traps), edges (deburred), load (4 kg on the front edge for 1 min, no cracks).

## 9. Open questions
- Connector diameters D and E (not measured) — confirm on the test slot with the real tubes.
