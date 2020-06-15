include <octave.scad>;
include <end.scad>;

module assembled() {
  assembled_octave();
  /* too much for OpenSCAD to handle
    translate([octave,0,0])
  assembled_octave();*/
    translate([-(pcb_width+support_gap),-(support_depth - key_back_depth)+skewer_hole_radius+5*wall_thickness-skewer_y/*-support_gap*/,-support_gap])
  assembled_end();
}

// To view, comment out assembled_end() in end.scad and assembled_octave() in
// octave.scad, then uncomment the following:
//assembled();
