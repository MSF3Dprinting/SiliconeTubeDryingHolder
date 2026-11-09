// @name: Silicone tube drying holder
// @description: Wall comb with stair slots (a pocket per tube size, 4-10 mm) that lets washed silicone tubes hang straight down to drain and dry.
// @category: Hospital
// @credit: MSF 3D Printing for All
/* ===== DESIGN SUMMARY =====
 * Part / purpose:    Wall-mounted comb for a sterilisation room. Washed silicone tubes are pushed sideways into
 *                    open-front stair slots and hang straight down to drain and dry. Each slot opens toward the
 *                    room in four pockets, one per tube size (4 / 6 / 8 / 10 mm): a pocket is a little narrower
 *                    than its tube (6 % at the top face, 13 % at the bottom face) and the step behind it is a
 *                    hard stop, so the grip is set by the pocket, not by how hard the tube is pushed. Two
 *                    identical combs of 5 slots side by side = 10 tubes.
 * Version:           2.0 2026-09-27   Designer: MSF 3D Printing for All  (1.0 wedge, 1.1 V-slot: rejected)
 * Critical part:     yes (new part in the hospital environment) -> draft for review, Biomed + IPC sign-off
 * Material:          PETG (white/natural/light) | PLA light | ASA light (advisor)  - light colour is an IPC rule
 * Environment:       room temperature; dripping water; wiped with Surfanios, bleach 1:10 or IPA
 * Loads:             5 wet tubes < 1 m (about 0.6 kg) hanging; design load 2 kg per comb, test 4 kg on the front edge
 * Print orientation: wall plate flat on the bed, shelf standing up, slots pointing up; supports: none; brim: no
 * Mating hardware:   screw_n x wood screws d screw_d (default 2 x d4 mm) with wall plugs, countersunk
 * Fits used:         none between printed parts; screw hole = screw_d + screw_clr + hole_clr (loose, plug aligns)
 * Interfaces:        tube outside diameters 4 / 6 / 8 / 10 mm (4, 8 measured by the requester; 6 and 10 chosen by
 *                    him); pocket widths at the top face 3.8 / 5.6 / 7.5 / 9.4 mm, at the bottom face 3.5 / 5.2 /
 *                    7.0 / 8.7 mm; contact height 18 mm; tubes hang 15-50 mm off the wall depending on size
 * Unverified values: tube wall thickness (sets the grip) - confirmed on the test slot with the real tubes
 * Flags:             disinfection needed; holds cleaned items before sterilisation (IPC advisor)
 * Deviations:        the test_slot part is the coupon (the pockets themselves are the steps)
 * Verified:          see stl/EXPORT_LOG.txt and tools/sweep_report_*.txt (OpenSCAD 2025.07 Manifold; 2021.01 language level)
 * Not verified:      physical print, grip on the real tubes, 4 kg load test
 * Approval:          Biomed + IPC advisor
 * ========================== */

include <common.scad>
include <helpers.scad>

/* [Part] */
part = "holder";     // [holder:Comb with wall plate, test_slot:Test slot - print this first]

/* [Main dimensions] */
slot_n = 5;          // [1:1:8] slots (tubes) per comb
slot_pitch = 30;     // [20:1:50] distance between tube centres (mm) - leave air between the biggest tubes
pocket_1 = 10;       // [3:0.5:16] tube outside diameter for the first pocket, at the mouth (the biggest tube)
pocket_2 = 8;        // [3:0.5:16] ... second pocket
pocket_3 = 6;        // [3:0.5:16] ... third pocket
pocket_4 = 4;        // [2:0.5:16] ... fourth pocket, nearest the wall (the smallest tube)
squeeze_top = 6;     // [2:1:12] pocket narrower than its tube at the top face, in % of the tube diameter
squeeze_bottom = 13; // [4:1:20] ... at the bottom face, in % (a slipping tube settles tighter, then stops)
pocket_extra = 3;    // [2:0.5:6] pocket length = tube diameter + this (mm)
shelf_t = 18;        // [12:1:26] shelf thickness = height of the pocket walls that grip the tube
bar_w = 12;          // [8:1:25] solid shelf between the slot end and the wall plate - keeps tubes off the wall
side_w = 22;         // [14:1:40] from the outer tube centre to the side edge of the shelf

/* [Interface / edges] */
edge_r = 1.5;        // [0.8:0.1:3] rounding of every shelf edge on the top and bottom face (the tube slides over these)
step_r = 0.4;        // [0.2:0.1:1] rounding of the pocket corners and step tips (a step is only about 1 mm deep)
tip_r = 4;           // [2:0.5:8] rounding of the finger tips seen from above
corner_r = 4.5;      // [3:0.5:10] rounding of the outer shelf corners seen from above
root_r = 6;          // [2:1:12] cove (fillet) all round where the shelf meets the wall plate

/* [Wall plate] */
plate_t = 6;         // [4:0.5:10] wall plate thickness
plate_above = 30;    // [16:1:60] plate above the shelf - the screws go here
plate_below = 12;    // [8:1:40] plate below the shelf
plate_corner_r = 6;  // [3:1:12] corner radius of the wall plate
screw_n = 2;         // [2:1:3] number of wall screws
screw_d = 4;         // [3:0.5:6] wall screw diameter (kit: d4-5 mm screws with plugs)
screw_head_d = 8;    // [5:0.5:12] screw head diameter - sets the countersink
screw_clr = 0.5;     // [0:0.1:1.5] extra clearance on the screw hole diameter
screw_edge = 14;     // [8:1:30] screw centre measured from the top edge of the plate
screw_spacing = 120; // [30:5:180] distance between the outer screws (reduced automatically on a narrow plate)

/* [Preview] */
show_ghosts = true;  // show the wall and sample tubes in the preview (never exported)

/* [Hidden] */
$fa = 2; $fs = 0.3; $fn = $preview ? 32 : 96;

// ===== Derived values =====
n        = part == "test_slot" ? 1 : slot_n;
p_above  = part == "test_slot" ? 10 : plate_above;
p_below  = part == "test_slot" ? 8 : plate_below;
n_scr    = part == "test_slot" ? 0 : screw_n;
pocket_d = [pocket_1, pocket_2, pocket_3, pocket_4]; // the four pockets, mouth to wall
np       = len(pocket_d);                            // pockets per slot
function w_top(k) = pocket_d[k] * (1 - squeeze_top / 100);     // pocket width at the top face (in use)
function w_bot(k) = pocket_d[k] * (1 - squeeze_bottom / 100);  // ... at the bottom face
function p_len(k) = pocket_d[k] + pocket_extra;                 // pocket length along the slot
s_draft  = (1 - squeeze_bottom / 100) / (1 - squeeze_top / 100);   // width ratio bottom / top (the draft)
slot_l   = [for (k = [0 : np - 1]) p_len(k)] * [for (k = [0 : np - 1]) 1] + w_top(np - 1) / 2;   // sum of pocket lengths + round end
function y_step(k) = bar_w + slot_l - ([for (j = [0 : k]) p_len(j)] * [for (j = [0 : k]) 1]);   // step at the end of pocket k
shelf_w  = (n - 1) * slot_pitch + 2 * side_w;       // shelf width (X)
W        = shelf_w + 2 * (root_r + 2);              // plate width: room for the side coves + 2 mm
plate_h  = p_below + shelf_t + p_above;             // plate height (Y in print = vertical in use)
D        = bar_w + slot_l;                          // shelf depth from the plate face (Z in print)
ov       = edge_r + 1.5;                            // how far the shelf reaches into the plate (its rounded back edge stays buried)
n_fil    = $preview ? 4 : 8;                        // slices per edge rounding (0.19 mm steps at full resolution)
x0       = (W - shelf_w) / 2;                       // shelf offset on the plate (X)
y_sh     = p_below + shelf_t / 2;                   // shelf centre line on the plate (Y)
screw_y  = plate_h - screw_edge;
spacing  = min(screw_spacing, W - screw_head_d - 2 * bolt_wall);   // adapts to a narrow plate (few slots)
hole_d   = screw_d + screw_clr;                     // + hole_clr inside vertical_hole()
sink_h   = (screw_head_d + 0.4 - hole_d - hole_clr) / 2;   // 90 deg countersink depth
finger_w = slot_pitch - w_top(0);                   // finger width at the top face, at the mouth
outer_w  = side_w - w_top(0) / 2;                   // outer finger width at the mouth
echo(str("NOTE: pockets (top / bottom face width, mm): ", [for (k = [0 : np - 1]) [round(w_top(k) * 10) / 10, round(w_bot(k) * 10) / 10]],
         "; slot length ", slot_l, " mm; shelf depth ", D, " mm"));

// ===== Input validation =====
for (k = [0 : np - 2]) assert(pocket_d[k] > pocket_d[k + 1] + 0.5, "pocket_d must go from the biggest tube (mouth) to the smallest (wall), each at least 0.5 mm smaller");
assert(squeeze_bottom > squeeze_top, "squeeze_bottom must be larger than squeeze_top (the pocket narrows toward the bottom face)");
assert(w_bot(np - 1) >= 1.6, "The smallest pocket is narrower than 1.6 mm at the bottom - a wipe cannot reach it; bigger tube or less squeeze");
assert(finger_w >= 2 * tip_r + 2, str("Fingers too thin for tip_r: widen slot_pitch (need ", 2 * tip_r + 2 + w_top(0), " mm)"));
assert(outer_w >= tip_r + corner_r + 2, str("Outer finger too thin: increase side_w to at least ", w_top(0) / 2 + tip_r + corner_r + 2, " mm"));
assert(corner_r >= edge_r + 1, "corner_r must be at least edge_r + 1");
assert(shelf_t >= 2 * edge_r + 6, "shelf_t too thin: the pocket walls need at least 6 mm of straight height between the edge roundings");
for (k = [0 : np - 2]) assert(2 * step_r <= (w_top(k) - w_top(k + 1)) / 2 - 0.05, str("step_r too big for the step between the ", pocket_d[k], " and ", pocket_d[k + 1], " mm pockets (", (w_top(k) - w_top(k + 1)) / 2, " mm deep): smaller step_r or bigger size steps"));
assert(bar_w >= root_r + 2 - 0.001, "bar_w must be at least root_r + 2 so the cove stays clear of the slot ends");
assert(p_below >= root_r + 1.5 - 0.001, "plate_below must be at least root_r + 1.5 mm");
assert(plate_t >= ov + chamfer_top + 0.3 - 0.001, str("plate_t must be at least ", ov + chamfer_top + 0.3, " mm so the buried back edge of the shelf stays inside it"));
assert(plate_t >= sink_h + 1.5 - 0.001, "plate_t too thin for the countersink: thicker plate or smaller screw_head_d");
assert(n_scr == 0 || screw_y - screw_head_d / 2 - 1 >= p_below + shelf_t + root_r - 0.001, "Screws too close to the shelf: increase plate_above or reduce screw_edge");
if (n_scr > 0 && spacing < screw_spacing - 0.001) echo(str("NOTE: screw_spacing reduced to ", spacing, " mm to fit the plate width ", W, " mm"));
assert(n_scr == 0 || screw_edge >= screw_head_d / 2 + bolt_wall - 0.001, "screw_edge too small: the countersink breaks the top edge");
assert(W <= max_part[0] + 0.001 && plate_h <= max_part[1] && plate_t + D <= max_part[2], "Part larger than 200 mm: fewer slots or a smaller pitch");

// ===== Modules =====
function _nl(d) = [-d[1], d[0]];          // left normal of a direction

// Sweep a 2D profile (u = left of travel, v = Z) along a closed path of [[x, y], radius] vertices.
// Left turns get the profile mirrored (u toward the arc centre); a radius of 0 keeps a sharp corner (runs meet).
// The profile reads its width from $band_w,
// which is limited to r - 0.5 at left turns so it never crosses the revolve axis. Right turns keep the
// profile (u away from the centre). Straight runs overlap the arcs by EPS (boolean hygiene).
module sweep_band(pv, w = 0, back_y = undef) {   // back_y: runs lying on this y get $band_back = true (unused here)
    m = len(pv);
    for (i = [0 : m - 1]) {
        p0 = pv[(i - 1 + m) % m][0]; p1 = pv[i][0]; p2 = pv[(i + 1) % m][0]; p3 = pv[(i + 2) % m][0];
        r = pv[i][1]; r2 = pv[(i + 1) % m][1];
        d1 = _unit(p1 - p0); d2 = _unit(p2 - p1); d3 = _unit(p3 - p2);
        beta  = atan2(d1[0] * d2[1] - d1[1] * d2[0], d1[0] * d2[0] + d1[1] * d2[1]);
        beta2 = atan2(d2[0] * d3[1] - d2[1] * d3[0], d2[0] * d3[0] + d2[1] * d3[1]);
        tl  = r * tan(abs(beta) / 2);
        tl2 = r2 * tan(abs(beta2) / 2);
        P1 = p1 - tl * d1;                                    // arc start at this vertex
        c  = beta > 0 ? P1 + r * _nl(d1) : P1 - r * _nl(d1);   // arc centre
        a0 = beta > 0 ? _ang(P1 - c) : _ang(P1 - c) - abs(beta);
        $band_w = beta > 0 ? min(w, r - 0.5) : w;
        $band_back = false;
        if (r > 0.01 && abs(beta) > 0.01)
            translate(c) rotate([0, 0, a0]) rotate_extrude(angle = abs(beta))
                translate([r, 0]) if (beta > 0) mirror([1, 0]) children(); else children();
        P2 = p1 + tl * d2;                                    // arc end at this vertex
        Q1 = p2 - tl2 * d2;                                   // arc start at the next vertex
        L = norm(Q1 - P2);
        if (L > 0.001) {
            $band_w = w;
            $band_back = !is_undef(back_y) && P2[1] <= back_y + 0.01 && Q1[1] <= back_y + 0.01;
            translate([P2[0] - EPS * d2[0], P2[1] - EPS * d2[1], 0]) rotate([0, 0, _ang(d2)])
                rotate([90, 0, 90]) linear_extrude(L + 2 * EPS) children();
        }
    }
}

// Cove profile at the shelf root: u outward from the shelf surface, v from the plate face into the room
module cove2d() {                                    // reaches 1 mm into the shelf so it always overlaps the sliced edge rounding
    difference() {
        translate([-1, -0.2]) square([root_r + 1, root_r + 0.2]);
        translate([root_r, root_r]) circle(root_r, $fn = 48);
    }
}

function slot_x(i) = side_w + i * slot_pitch;
function _rev(v) = [for (i = [len(v) - 1 : -1 : 0]) v[i]];

// One slot seen from above, slot centre on x = 0, mouth toward +y (a void polygon with every corner rounded):
// the flare in front of the shelf rounds the finger tips, the pockets step down toward the wall, the end is round.
function pocket_pts_right() = concat(
    [[[w_top(0) / 2 + 30, D + 10], 0], [[w_top(0) / 2, D], tip_r]],
    [for (k = [0 : np - 2]) each [[[w_top(k) / 2, y_step(k)], step_r], [[w_top(k + 1) / 2, y_step(k)], step_r]]],
    [[[w_top(np - 1) / 2, bar_w], w_top(np - 1) / 2 - 0.01]]);
function slot_pts() = concat(pocket_pts_right(), [for (p = _rev(pocket_pts_right())) [[-p[0][0], p[0][1]], p[1]]]);
module slot2d() { rounded_poly(slot_pts(), fn = $preview ? 6 : 10); }

// Shelf outline seen from above: rectangle from inside the plate (y = -ov) to the front (y = D), front corners rounded
module rect2d() { rounded_poly([[[0, -ov], 0], [[shelf_w, -ov], 0], [[shelf_w, D], corner_r], [[0, D], corner_r]], fn = $preview ? 8 : 24); }

// Shelf section at height z through the thickness (z = -t/2 top face in use, +t/2 bottom face): the pockets narrow
// linearly from the top face to the bottom face; `inset` pulls the whole outline in (used for the edge rounding).
function sc(z) = 1 + (s_draft - 1) * (z + shelf_t / 2) / shelf_t;
module shelf2d(z, inset = 0) {
    offset(r = -inset) difference() {
        rect2d();
        for (i = [0 : n - 1]) translate([slot_x(i), 0]) scale([sc(z), 1]) slot2d();
    }
}

// Shelf in its own frame: outline in XY (Y = depth from the plate face), thickness along Z (+Z = bottom face in use).
// Core with a true draft on every pocket, plus a stack of inset slices at each face for the edge rounding (radius edge_r).
module shelf_local() {
    t2 = shelf_t / 2; r = edge_r; hc = shelf_t - 2 * r;
    $fn = $preview ? 24 : 40;                                       // offset roundings in the slices
    difference() {
        translate([0, 0, -t2 + r - 0.01]) linear_extrude(hc + 0.02) rect2d();
        for (i = [0 : n - 1]) translate([slot_x(i), 0, -t2 + r - 0.02])
            linear_extrude(hc + 0.04, scale = [sc(t2 - r) / sc(-t2 + r), 1], slices = 1) scale([sc(-t2 + r), 1]) slot2d();
    }
    for (side = [-1, 1]) for (i = [0 : n_fil - 1]) {
        h0 = r * i / n_fil; h1 = r * (i + 1) / n_fil;                  // distance from the face
        inset = r - sqrt(r * r - (r - h0) * (r - h0));                  // circle: full inset at the face, 0 at depth r
        z0 = side < 0 ? -t2 + h0 : t2 - h1;
        translate([0, 0, z0]) linear_extrude(h1 - h0 + 0.01) shelf2d(side < 0 ? -t2 + h0 : t2 - h0, inset);
    }
}

// Cove ring around the shelf root: path = the rectangular root cross-section in the sweep frame, clockwise so the
// profile points outward; rotate(-90) sends the cove depth into the room
module cove_ring() {
    rotate([-90, 0, 0])
        sweep_band([[[0, -shelf_t / 2], edge_r], [[0, shelf_t / 2], edge_r],
                    [[shelf_w, shelf_t / 2], edge_r], [[shelf_w, -shelf_t / 2], edge_r]], root_r) cove2d();
}

function screw_x(k) = W / 2 + (n_scr < 2 ? 0 : (k / (n_scr - 1) - 0.5) * spacing);

module comb_body() {
    difference() {
        union() {
            translate([W / 2, plate_h / 2, 0])
                rounded_box([W, plate_h, plate_t], r = plate_corner_r, c_bot = chamfer_bottom, c_top = chamfer_top);
            translate([x0, y_sh, plate_t]) rotate([90, 0, 0]) { shelf_local(); cove_ring(); }
        }
        for (k = [0 : n_scr - 1]) if (n_scr > 0) translate([screw_x(k), screw_y, 0]) {
            vertical_hole(hole_d, plate_t);
            translate([0, 0, plate_t - sink_h])
                cylinder(d1 = hole_d + hole_clr, d2 = hole_d + hole_clr + 2 * (sink_h + 1), h = sink_h + 1);
        }
    }
}

// Sample tubes in their pockets (preview only): one size per slot, cycling through the pockets
module ghosts() {
    %color("wheat", 0.3) translate([-20, -20, -20]) cube([W + 40, plate_h + 40, 20]);
    for (i = [0 : n - 1]) {
        k = [1, 3, 0, 2, 1, 0, 3, 2][i % 8]; d = pocket_d[k];
        %color("lightblue", 0.4) translate([x0 + slot_x(i), y_sh, plate_t + y_step(k) + p_len(k) / 2])
            translate([0, 40, 0]) rotate([90, 0, 0]) cylinder(d = d, h = 100);
    }
}

// ===== Build =====
comb_body();
if ($preview && show_ghosts) ghosts();
