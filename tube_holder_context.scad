// tube_holder_context.scad — context-of-use renders (illustration only, never exported)
// OpenSCAD 2021.01 or newer. Uses the modules of tube_holder.scad without running its build.
include <common.scad>
include <helpers.scad>
use <tube_holder.scad>

/* [Scene] */
scene = "installed";   // [installed, exploded, section]
explode = 40;          // [0:5:100] separation between the comb and the wall in the exploded view
section_axis = "y";    // [x, y, z]
section_at = 21;       // [-100:1:300] position of the section plane (print frame, mm) - 21 = mid-thickness of the shelf: shows the pockets from above

/* [Stand-ins — illustration only] */
wall_w = 420;          // [100:10:800] wall width (two combs side by side)
wall_h = 300;          // [100:10:600]
wall_t = 20;           // [10:5:50]
tube_l = 160;          // [50:10:400] visible tube length in the render
comb_gap = 6;          // [0:1:40] gap between the two combs

assert($preview, "tube_holder_context.scad is for preview renders only — export the part from tube_holder.scad");

// Values of the part (the same defaults as tube_holder.scad; the scene only positions stand-ins)
c_W = 180; c_plate_t = 6; c_bottom = 12; c_top = 30; c_x0 = 8; c_side_w = 22; c_pitch = 30; c_n = 5;
c_plate_h = 60; c_bar = 12; c_slot_l = 41.88;
c_pocket_d = [10, 8, 6, 4]; c_pocket_len = [13, 11, 9, 7];
function c_y_pocket(k) = c_bar + c_slot_l - ([for (j = [0 : k]) c_pocket_len[j]] * [for (j = [0 : k]) 1]) + c_pocket_len[k] / 2;

module part_module() { comb_body(); }

// print frame -> in-use frame: plate vertical, shelf pointing to the viewer (-Y), tubes hanging down (-Z)
module in_use() { rotate([90, 0, 0]) children(); }

module wall_standin() { color("wheat") translate([-wall_w / 2 + c_W + comb_gap / 2, 0, -wall_h / 2 + c_plate_h / 2]) cube([wall_w, wall_t, wall_h]); }

module tubes_standin(dx = 0) {
    for (i = [0 : c_n - 1]) {
        k = [1, 3, 0, 2, 1][i]; d = c_pocket_d[k];                 // one tube size per slot, in its own pocket
        x = dx + c_x0 + c_side_w + i * c_pitch;
        y = -(c_plate_t + c_y_pocket(k));
        color("lightblue") translate([x, y, c_top - 15 - tube_l]) cylinder(d = d, h = tube_l);
    }
}

module scene_installed() {
    color("white") render() in_use() part_module();
    color("white") render() translate([c_W + comb_gap, 0, 0]) in_use() part_module();
    wall_standin();
    tubes_standin(0);
    tubes_standin(c_W + comb_gap);
}
module scene_exploded() {
    color("white") render() in_use() part_module();
    translate([0, explode, 0]) wall_standin();
    translate([0, -explode, 0]) tubes_standin(0);
}
module scene_section() {
    cutter = section_axis == "x" ? [section_at, -1000, -1000] : section_axis == "y" ? [-1000, section_at, -1000] : [-1000, -1000, section_at];
    color("white") render() difference() { part_module(); translate(cutter) cube(2000); }
}

if (scene == "installed") scene_installed();
else if (scene == "exploded") scene_exploded();
else if (scene == "section") scene_section();
