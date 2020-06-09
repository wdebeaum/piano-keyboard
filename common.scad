/* common.scad - shared between octave.scad and end.scad
 * William de Beaumont
 * 2020-06-09
 */

//
// parameters that depend on printer capabilities
//

// height of a single layer of extrusion
layer_height = 0.4;
// how thick should walls be, in general?
wall_thickness = 1;
// size of gap between parts that are meant to fit together but not slide easily
gap = 0.3;
// additional gap for thin walls that tend to ooze and become thicker than
// designed
thin_wall_deduction = 0.2;
// additional gap for parts that are meant to slide easily past each other
sliding_deduction = 0.3;
// how much small vertical holes shrink (additional radius to compensate)
small_v_hole_shrinkage = 0.25;

// small value used to avoid coinciding surfaces for CSG operations
epsilon = 0.01;

// use many facets for cylinders
$fn=24;

//
// measurements of non-printed parts
//

// skewer measurements

skewer_radius = 3 / 2; // 3mm diameter skewers

// M3 screw measurements

/*   |    | head radius
      _________  ____
     /         \ head height
     |_________| ____
        <   >     ^
	<   >     threads height
	<___>    _V__
       |  | threads radius
*/

screw_threads_radius = 3/2;
screw_threads_height = 6;
screw_head_radius = 5/2;
screw_head_height = 2;

// electronics measurements

pcb_thickness = 1.6;

// 22 AWG wire
wire_radius = 0.644/2;

//
// common computed values
//

skewer_hole_radius = skewer_radius + gap + sliding_deduction;

support_hole_ir = screw_threads_radius + small_v_hole_shrinkage; // NOTE: no gap so threads bite
support_hole_or = support_hole_ir + wall_thickness;

//
// common parts
//

// screws for affixing the PCB to the support/enclosure, for viewing assembly
module screw() {
  cylinder(r=screw_head_radius, h=screw_head_height);
    translate([0,0,-6])
  cylinder(r=screw_threads_radius, h=screw_threads_height);
}
