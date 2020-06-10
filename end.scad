/* end.scad - controls at the left end of octave.scad
 * William de Beaumont
 * 2020-06-09
 */

/* TODO:
 - print most of enclosure on its left side
 - print part around buttons and screws separately, upside down
  - extend it all the way down towards the buttons and screw holes
  - make a lip around its edge so it holds down the rest of the top
 - recess the corresponding lip in the rest of the top so the two parts of the top are flush
  - must take care to leave room for sus pedal jack
 - print button extensions horizontally, with triangular cross-section to prevent rotation
  - make user ends of arrow buttons triangular too, pointing out from the center
  - make clear button end rectangular
 # extend holes for sus pedal jack and USB receptacle out towards the right to enable assembly
 # add upside-down shelves along PCB edges
 ? add ribs around inside top corners
 # remove most of bottom side (esp. around screw holes); use glued-on cardboard instead
 ? add skewer hole corresponding to the front one on octave (will it fit under teensy?)
 # taper top and left sides towards back, where teensy is
  # left side taper must be 45° to be printable
 - pitch bend knob torsion spring
  # two slots in knob opposite finger notch, to loop wire through
  - wire wraps around center post at least once
  - wire makes 90° bend to right on other side of knob, so knob can push wire into enclosure
  - two holes in left side of enclosure, near top, to poke other ends of wire through
*/

include <common.scad>;

//
// locations and sizes of PCB features
//

// reference point is top left corner of PCB; Y is inverted from KiCAD
// x->width, y->height, z->thickness

// the board itself
pcb_width = 1.62*25.4;
pcb_height = 3.23*25.4;

// Teensy 4.0
teensy_min_x = 0.87*25.4;
teensy_min_y = -0.35*25.4;
teensy_min_z = 0.1*25.4; // ???
teensy_width = 0.7*25.4;
teensy_height = 1.4*25.4;
teensy_thickness = pcb_thickness; // ???
// guessing based on pictures
teensy_led_x = teensy_min_x + 0.5*25.4;
teensy_led_y = teensy_min_y + 0.13*25.4;
teensy_led_radius = 0.1*25.4/2;

// USB receptacle on Teensy 4.0
// (mostly guesswork from generic USB diagram I googled)
usb_width = 7.5;
usb_height = 2.75+3.35;
usb_thickness = 2.5;
// guessing it's centered on Teensy
usb_min_x = teensy_min_x + (teensy_width - usb_width)/2;
usb_max_y = teensy_min_y + teensy_height + 1.3;
usb_min_z = teensy_min_z + teensy_thickness;

// connector to keys
j5_x = pcb_width;
j5_min_y = -1.62*25.4;
j5_height = 0.5*25.4;
j5_thickness = 0.1*25.4;
j5_min_z = -(pcb_thickness+j5_thickness);

// screws
screw1_x = 1.12*25.4;
screw1_y = -1.35*25.4;
screw2_x = 0.67*25.4;
screw2_y = -2.9*25.4;

// buttons
button_radius = 3.51/2;
button_thickness = 5;
// button centers:
//    x1  x2  x3
// y1     sw1
// y2     sw2
// y3 sw3     sw7
// y4     sw6
// y5 sw4
// y6     sw5
button_x1 = 0.24*25.4;
button_x2 = 0.7*25.4;
button_x3 = 1.15*25.4;
button_y1 = -1.24*25.4;
button_y2 = -1.59*25.4;
button_y3 = -1.84*25.4;
button_y4 = -2.1*25.4;
button_y5 = -2.28*25.4;
button_y6 = -2.47*25.4;

// potentiometers
pot_shaft_radius = 6/2;
pot_shaft_max_x = 0.005*25.4;
pot_shaft_length = 20-8; // quoted as 8mm, but that includes pot body
pot_shaft_min_x = pot_shaft_max_x - pot_shaft_length;
pot_flat_length = 7;
pot_flat_depth = 6-4.5; // how far in from where the circumference would be otherwise
pot1_shaft_y = -1.35*25.4;
pot2_shaft_y = -2.9*25.4;
pot_shaft_z = 0.394*25.4;
pot_base_width = 9.7; // along edge of pcb

// sustain pedal jack
sus_radius = 0.1875*25.4;
sus_x = 1.2730*25.4;
sus_y = -pcb_height;
sus_z = 0.492*25.4;

// max height above pcb of any component (sustain pedal jack)
top_component_thickness = 0.708*25.4;
// ditto for components on bottom (J5)
//bottom_component_thickness = 0.1*25.4; //unused

//
// other parameters
//

knob_radius = 15;
knob_width = pot_shaft_length - (wall_thickness+2*(gap+sliding_deduction));
knob_min_x = pot_shaft_min_x;
// use thicker outer wall for knobs so that the gap doesn't show much
knob_wall_thickness = 5;
finger_radius = 5;
finger_depth = 2;

shelf_width = 1.5; // not wide enough to interfere with solder joints around pcb edges

//
// non-printed parts
//

module pcb() {
    translate([0,0,-pcb_thickness/2])
  import("end-pcb/piano-keyboard-end-pcb.stl");
  // teensy
    translate([teensy_min_x, teensy_min_y, teensy_min_z])
  cube([teensy_width, teensy_height, teensy_thickness]);
  // usb
    translate([usb_min_x, usb_max_y - usb_height, usb_min_z])
  cube([usb_width, usb_height, usb_thickness]);
}

//
// enclosure
//

module enclosure() {
  difference() {
    electronics_height = pcb_height + teensy_height + teensy_min_y;
    electronics_thickness = top_component_thickness + support_base_height;
    electronics_min_z = -support_base_height;
    // main body
      translate([-(gap+wall_thickness), -(pcb_height+gap+wall_thickness), electronics_min_z-epsilon])
    cube([pcb_width+gap+wall_thickness, electronics_height+2*(gap+wall_thickness), electronics_thickness+gap+wall_thickness+epsilon]);
    // main hollow
      translate([-gap, -(pcb_height+gap), electronics_min_z-gap])
    cube([pcb_width+gap+epsilon, pcb_height+2*gap, electronics_thickness+2*gap]);
    // teensy hollow
      translate([teensy_min_x-gap, teensy_min_y, electronics_min_z-gap])
    cube([pcb_width-teensy_min_x+gap+epsilon, teensy_height+gap, -electronics_min_z+usb_min_z+usb_thickness+2*gap]);
    hole_thickness = wall_thickness+2*epsilon;
    // top left bevel
      translate([teensy_min_x-(gap+wall_thickness),teensy_min_y+teensy_height+gap+wall_thickness,0])
      rotate([0,0,-45])
      translate([-50,0,0])
    cube([100,100,100], center=true);
    // top...top? bevel
      translate([0,teensy_min_y+teensy_height+gap+wall_thickness,usb_min_z+usb_thickness+gap+wall_thickness])
      rotate([-27.1,0,0]) // manually tuned so edges line up
      translate([0,0,50])
    cube([100,100,100], center=true);
    // hole for usb receptacle
      translate([usb_min_x-gap, usb_max_y-hole_thickness+epsilon, usb_min_z-gap])
    cube([usb_width+2*gap /*extend for assemblability*/+50, hole_thickness, usb_thickness+2*gap]);
    // hole for led (light pipe?)
      translate([teensy_led_x, teensy_led_y, top_component_thickness+gap-epsilon])
    cylinder(r=teensy_led_radius, h=hole_thickness);
    // hole for sustain pedal jack
      translate([sus_x, sus_y-gap+epsilon, sus_z])
      rotate([90,0,0])
    cylinder(r=sus_radius+gap, h=hole_thickness);
    // ...extend for assemblability
      translate([sus_x, sus_y-(gap+wall_thickness+epsilon), sus_z-(sus_radius+gap)])
    cube([50, hole_thickness, 2*(sus_radius+gap)]);
    // holes for pots
      translate([epsilon-gap, pot1_shaft_y, pot_shaft_z])
      rotate([0,-90,0])
    cylinder(r=pot_shaft_radius+gap+sliding_deduction, h=hole_thickness);
      translate([epsilon-gap, pot2_shaft_y, pot_shaft_z])
      rotate([0,-90,0])
    cylinder(r=pot_shaft_radius+gap+sliding_deduction, h=hole_thickness);
    // holes for button stalks
      translate([0, 0, top_component_thickness+gap-epsilon])
    union() {
	translate([button_x2, button_y1, 0])
      cylinder(r=button_radius, h=hole_thickness);
	translate([button_x2, button_y2, 0])
      cylinder(r=button_radius, h=hole_thickness);
	translate([button_x1, button_y3, 0])
      cylinder(r=button_radius, h=hole_thickness);
	translate([button_x3, button_y3, 0])
      cylinder(r=button_radius, h=hole_thickness);
	translate([button_x2, button_y4, 0])
      cylinder(r=button_radius, h=hole_thickness);
	translate([button_x1, button_y5, 0])
      cylinder(r=button_radius, h=hole_thickness);
	translate([button_x2, button_y6, 0])
      cylinder(r=button_radius, h=hole_thickness);
    }
  }
  // shelves around edge of pcb
  // ..bottom
  // ....under pcb
    translate([-(gap+epsilon), -(pcb_height+gap+epsilon), -support_base_height])
  cube([pcb_width+gap+epsilon, shelf_width+epsilon, support_base_height-(pcb_thickness+gap)]);
  // ....over pcb
    translate([-(gap+epsilon), -(pcb_height+gap+epsilon), gap])
  cube([pcb_width+gap+epsilon, shelf_width+epsilon, shelf_width]);
  // ..left
  // ....under pcb
    translate([-(gap+epsilon), -pcb_height, -support_base_height])
  cube([shelf_width+epsilon, pcb_height, support_base_height-(pcb_thickness+gap)]);
  // ....over pcb (with cutouts for pots)
  difference() {
      translate([-(gap+epsilon), -pcb_height, gap])
    cube([shelf_width+epsilon, pcb_height, shelf_width]);
    // pot cutouts
      translate([0,pot1_shaft_y,0])
    cube([100,pot_base_width+2*gap,100], center=true);
      translate([0,pot2_shaft_y,0])
    cube([100,pot_base_width+2*gap,100], center=true);
  }
  // ..top
  // ....under pcb and teensy, with top left bevel
  difference() {
      translate([-(gap+epsilon), -shelf_width+gap+epsilon, -support_base_height])
    cube([pcb_width+gap+epsilon, shelf_width+teensy_min_y+teensy_height+epsilon, support_base_height-(pcb_thickness+gap)]);
    // top left bevel
      translate([teensy_min_x-(gap+wall_thickness),teensy_min_y+teensy_height+gap+wall_thickness,0])
      rotate([0,0,-45])
      translate([-50,0,0])
    cube([100,100,100], center=true);
  }
  // ....over pcb
    translate([-(gap+epsilon), -shelf_width+gap+epsilon, gap])
  cube([teensy_min_x+epsilon, shelf_width+epsilon, shelf_width]);
  // TODO? shelves around teensy (I don't know its position as accurately, nor how wide its shelves should be)
}

//
// mod/pitch pot knob
//

module knob() {
  difference() {
    union() {
      // outer body
      difference() {
	cylinder(r=knob_radius, h=knob_width);
	  translate([0,0,wall_thickness])
	cylinder(r=knob_radius-knob_wall_thickness, h=knob_width-wall_thickness+epsilon);
	// finger notch
	  translate([-(knob_radius+finger_radius-finger_depth), 0, -epsilon])
	cylinder(r=finger_radius, h=knob_width+2*epsilon);
	// anchor for torson spring for pitch bend knob
	// bottom hole
	  translate([
	    knob_radius - (knob_wall_thickness+1),
	    -(wire_radius+gap),
	    (knob_width - (wall_thickness + 4*(wire_radius+gap)))/2
	  ])
	cube([
	  knob_wall_thickness+1/*fudge for curvature*/,
	  2*(wire_radius+gap),
	  2*(wire_radius+gap)
	]);
	// top hole
	  translate([
	    knob_radius - (knob_wall_thickness+1),
	    -(wire_radius+gap),
	    (knob_width + wall_thickness)/2
	  ])
	cube([
	  knob_wall_thickness+1/*fudge for curvature*/,
	  2*(wire_radius+gap),
	  2*(wire_radius+gap)
	]);
	// outer trench
	  translate([
	    knob_radius - 2*(wire_radius+gap),
	    -(wire_radius+gap),
	    (knob_width - (wall_thickness+4*(wire_radius+gap)))/2
	  ])
	cube([
	  2*(wire_radius+gap)+epsilon,
	  2*(wire_radius+gap),
	  wall_thickness+4*(wire_radius+gap)
	]);
      }
      // inner post
      cylinder(r=pot_shaft_radius+gap+wall_thickness, h=knob_width);
    }
    // shaft hole
      translate([0,0,-epsilon])
    difference() {
      cylinder(r=pot_shaft_radius+gap, h=knob_width+2*epsilon);
      // flat
	rotate([0,0,-90])
        translate([
	  -(pot_shaft_radius+gap+epsilon),
	  pot_shaft_radius+gap-pot_flat_depth,
	  -2*epsilon
	])
      cube([
        2*(pot_shaft_radius+gap+epsilon),
        2*(pot_shaft_radius+gap+epsilon),
        pot_flat_length - gap + 2*epsilon
      ]);
    }
  }
}

%pcb();
  %translate([screw1_x,screw1_y,-(pcb_thickness+gap)])
  rotate([180,0,0])
screw();
  %translate([screw2_x,screw2_y,-(pcb_thickness+gap)])
  rotate([180,0,0])
screw();
enclosure();
  translate([pot_shaft_min_x, pot1_shaft_y, pot_shaft_z])
  rotate([0,90,0])
knob();
  translate([pot_shaft_min_x, pot2_shaft_y, pot_shaft_z])
  rotate([0,90,0])
knob();
