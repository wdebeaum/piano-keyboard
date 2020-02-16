/* piano-keyboard.scad - piano keyboard with dimensions copied from my midi keyboard
 * William de Beaumont
 * 2020-02-16
 */

/* TODO:
# no more skewers (lots of assumptions broken by them)
# move bpin forward so the U no longer sticks out the back
# make base broader for more key wiggle stability
 # also make it broader in plated form (what went wrong?)
? print base in 2 sections per octave so it'll fit on printer
? make groove in underside of key to accept bobby pin
*/

/* problems found after trying to print:
- narrower support walls mean more ooze; bpin doesn't fit
- longer support walls mean more curl-up
- larger base means harder to separate from tape bed
*/

// measurements taken from my optimus md-1150
octave = 162.5;
white_width = 21.8;
white_gap = octave / 7 - white_width; // suspiciously close to sqrt(2)
black_width = 11; // but slightly narrower at the top
black_top_width = 9.8; // ?
white_depth = 134;
black_min_depth = 77; // at top
black_max_depth = 84; // at bottom, next to top of white key
white_travel = 16.9 - 6.1; // at max end of white key
// measured
//black_travel = 12 - 5.6; // ? at max end of black key (but tilted)
// calculated with the assumption that the travel angle is the same for b&w
black_travel = white_travel * black_max_depth / white_depth;
// height of black key above white key, with neither depressed
black_min_height = 8; // at min end of key, toward fulcrum
black_max_height = 12; // at max end of key
corner_radius = 1.5; // ? approx (maybe less for top of black keys)
// ^^^ doesn't apply to cutouts in white keys for black keys

// measurements from paper transfer
c_stem_width = 13;
d_stem_width = 14;
e_stem_width = 12.75;
f_stem_width = 12.1;
g_stem_width = 12.15;
a_stem_width = 12.15;
b_stem_width = 12.1;

black_gap =
  (octave - 
    ( // add up everything but the black gaps
      c_stem_width +
      d_stem_width +
      e_stem_width +
      f_stem_width +
      g_stem_width +
      a_stem_width +
      b_stem_width +
      5*black_width +
      2*white_gap
    )
  ) / 10;

c_x = 0;
c_sharp_x = c_x + c_stem_width + black_gap;
d_x = c_sharp_x + black_width + black_gap;
d_sharp_x = d_x + d_stem_width + black_gap;
e_x = d_sharp_x + black_width + black_gap;
f_x = e_x + e_stem_width + white_gap;
f_sharp_x = f_x + f_stem_width + black_gap;
g_x = f_sharp_x + black_width + black_gap;
g_sharp_x = g_x + g_stem_width + black_gap;
a_x = g_sharp_x + black_width + black_gap;
a_sharp_x = a_x + a_stem_width + black_gap;
b_x = a_sharp_x + black_width + black_gap;

/* bobby pin measurements
	o  ends
	|
	| o
max	|/	min length
length	|\
	|/  m
	|\
	| |
	| |
	 U

	 u
*/
bpin_width = 1.6;
bpin_thickness = 0.7;
bpin_end_thickness = 1.7; // max
bpin_u_radius = 3.8 / 2;
bpin_max_length = 50;
bpin_min_length = 46;
bpin_u_m = 17.5;
bpin_m_length = bpin_min_length - bpin_u_m;
bpin_m_pitch = 22 / 4;

bpin_angle = 8.75; // after unbending

// end measurements

wall_thickness = 1;
white_thickness = 2*corner_radius;
gap = 0.3;
thin_wall_deduction = 0.2;/* for imperfect printing */
sliding_deduction = 0.3;
support_gap = gap + thin_wall_deduction + sliding_deduction;
epsilon = 0.01;

pad_thickness = 25.4 / 4; // 1/4"

hinge_radius = 2*wall_thickness;
hinge_height = wall_thickness + 0.5/*for imperfect printing*/;

key_back_width = black_width;
key_back_depth = hinge_radius + wall_thickness + support_gap + wall_thickness;
white_back_height = white_travel + white_thickness;
black_back_height = white_back_height + black_min_height;

hollow_width = key_back_width - 2*wall_thickness;
hollow_height = white_travel;
support_width = hollow_width - 2*support_gap;
support_depth = 60;
support_back_depth = 3*wall_thickness;

$fn=24;

module bpin() {
    translate([0,-(bpin_min_length - bpin_u_radius),-bpin_u_radius])
  cube([bpin_width, bpin_min_length - bpin_u_radius, bpin_thickness]);
    rotate([-bpin_angle,0,0])
    translate([0,-(bpin_max_length - bpin_u_radius),bpin_u_radius - bpin_thickness])
  cube([bpin_width, bpin_max_length - bpin_u_radius, bpin_thickness]);
    rotate([0,90,0])
  cylinder(r = bpin_u_radius, h = bpin_width);
}

module bpin_hole() {
  intersection() {
    // NOTE: could have used bpin_max_length instead of support_depth, but would have made disassembly hard
      translate([0, -support_depth, -(bpin_u_radius + gap)])
    cube([bpin_width + 2*gap, support_depth, black_back_height]);
      rotate([-bpin_angle,0,0])
      translate([-epsilon, -support_depth, bpin_u_radius+gap-black_back_height])
    cube([bpin_width + 2*gap + 2*epsilon, support_depth, black_back_height]);
  }
    rotate([0,90,0])
  cylinder(r = bpin_u_radius + gap, h = bpin_width + 2*gap);
}

module white_key(left_cutout, right_cutout) {
    translate([-left_cutout,0,0])
  union() {
    difference() {
      union() {
	// front
	difference() {
	  intersection() {
	    minkowski() {
		translate([corner_radius,-(white_depth-corner_radius),0])
	      cube([white_width-2*corner_radius, white_depth-corner_radius, white_travel + white_thickness -corner_radius]);
	      sphere(r=corner_radius);
	    }
	      translate([-epsilon,-(white_depth+epsilon),0])
	    cube([white_width+2*epsilon, white_depth+epsilon, white_travel + white_thickness +epsilon]);
	    // the "10" in the following I think should be:
	    // white_thickness*white_travel/sqrt(white_depth*white_depth+white_travel*white_travel)
	    // but obviously I made a mistake because that still cuts into the front
	      rotate([-atan2(white_travel, white_depth),0,0])
	      translate([0,-white_depth-10,0])
	    cube([white_width+2*epsilon, white_depth + 10, white_travel + white_thickness]);
	  }
	  if (left_cutout > 0) {
	      translate([-epsilon, epsilon-(black_max_depth + black_gap), -epsilon])
	    cube([left_cutout + epsilon, black_max_depth + black_gap, white_travel + white_thickness + 2*epsilon]);
	  }
	  if (right_cutout > 0) {
	      translate([white_width - right_cutout, epsilon-(black_max_depth + black_gap), -epsilon])
	    cube([right_cutout + epsilon, black_max_depth + black_gap, white_travel + white_thickness + 2*epsilon]);
	  }
	}
	// back
	  translate([left_cutout + (white_width - left_cutout - right_cutout - key_back_width) / 2, 0, 0])
	cube([key_back_width, key_back_depth, white_back_height]);
      }
      // hollow
	translate([left_cutout + (white_width - left_cutout - right_cutout - hollow_width)/2,-(black_max_depth-corner_radius),-epsilon])
      cube([hollow_width, black_max_depth+key_back_depth-(corner_radius + wall_thickness), hollow_height]);
    }
    // hinge
      translate([left_cutout + (white_width - left_cutout - right_cutout - hollow_width)/2,0,0])
    intersection() {
      union() {
	  translate([-epsilon,0,0])
	  rotate([0,90,0])
	cylinder(r1=hinge_radius, r2=0, h=hinge_height);
	  translate([hollow_width+epsilon,0,0])
	  rotate([0,-90,0])
	cylinder(r1=hinge_radius, r2=0, h=hinge_height);
      }
      union() {
	  translate([-2*epsilon,0,0])
	cube([hollow_width+4*epsilon, hinge_radius+epsilon, hinge_radius+epsilon]);
	  rotate([-atan2(white_travel, white_depth),0,0])
	  translate([-2*epsilon,-hinge_radius,0])
	cube([hollow_width+4*epsilon, hinge_radius+epsilon, hinge_radius+epsilon]);
      }
    }
  }
}

module black_key() {
  /* no-radius version
    translate([0,0,white_travel + white_thickness])
  polyhedron(
    points=[
      // at top of white keys
      [		 0,			0, 0],
      [black_width,			0, 0],
      [		 0,	-black_max_depth,  0],
      [black_width,	-black_max_depth,  0],
      // at top of black key
      [(black_width - black_top_width)/2,
       0,
       black_min_height],
      [black_width - (black_width - black_top_width)/2,
       0,
       black_min_height],
      [(black_width - black_top_width)/2,
       -black_min_depth,
       black_max_height],
      [black_width - (black_width - black_top_width)/2,
       -black_min_depth,
       black_max_height]
    ],
    faces=[
      [0,2,3,1], // bottom
      [4,5,7,6], // top
      [0,4,6,2], // left
      [1,3,7,5], // right
      [0,1,5,4], // back
      [2,6,7,3], // front
    ],
    convexity=2
  );*/
  // radius version
  difference() {
    union() {
      // bottom (under top of white keys)
	translate([0, -(black_max_depth-corner_radius), 0])
      cube([black_width, black_max_depth-corner_radius, white_travel + white_thickness]);
	translate([corner_radius, -black_max_depth, 0])
      cube([black_width - 2*corner_radius, corner_radius, white_travel + white_thickness]);
	translate([corner_radius, -(black_max_depth-corner_radius), 0])
      cylinder(r=corner_radius, h=white_travel + white_thickness);
	translate([black_width - corner_radius, -(black_max_depth-corner_radius), 0])
      cylinder(r=corner_radius, h=white_travel + white_thickness);
      // back
      cube([key_back_width, key_back_depth, black_back_height]);
      // top (over top of white keys)
      minkowski() {
	  translate([0,0,white_travel + white_thickness])
	polyhedron(
	  points=[
	    // at top of white keys
	    [corner_radius,				0,		0],
	    [black_width-corner_radius,			0,		0],
	    [corner_radius,	-black_max_depth+corner_radius,		0],
	    [black_width-corner_radius,-black_max_depth+corner_radius,	0],
	    // at top of black key
	    [(black_width - black_top_width)/2+corner_radius,
	     0,
	     black_min_height-corner_radius],
	    [black_width - (black_width - black_top_width)/2 - corner_radius,
	     0,
	     black_min_height-corner_radius],
	    [(black_width - black_top_width)/2+corner_radius,
	     -black_min_depth+corner_radius,
	     black_max_height-corner_radius],
	    [black_width - (black_width - black_top_width)/2 - corner_radius,
	     -black_min_depth+corner_radius,
	     black_max_height-corner_radius]
	  ],
	  faces=[
	    [0,2,3,1], // bottom
	    [4,5,7,6], // top
	    [0,4,6,2], // left
	    [1,3,7,5], // right
	    [0,1,5,4], // back
	    [2,6,7,3], // front
	  ],
	  convexity=2
	);
	sphere(r=corner_radius);
      }
    }
    // bottom angle
      rotate([-atan2(black_travel, black_max_depth),0,0])
      translate([-epsilon,-black_max_depth-10, -white_travel])
    cube([black_width+2*epsilon, black_max_depth + 10, white_travel]);
    // top angle
      translate([0,0, white_travel + white_thickness + black_min_height + epsilon])
      rotate([-(atan2(black_max_height-black_min_height, black_min_depth) /* fudge factor? */+5*epsilon),0,0])
      translate([-epsilon,-black_max_depth, 0])
    cube([black_width+2*epsilon, key_back_depth + black_max_depth + 10, white_travel]);
    // hollow
      translate([(black_width - hollow_width)/2,-(black_max_depth-corner_radius),-epsilon])
    cube([hollow_width, black_max_depth+key_back_depth-(corner_radius + wall_thickness), hollow_height]);
  }
  // hinge
  intersection() {
    union() {
	translate([(black_width - hollow_width)/2-epsilon,0,0])
	rotate([0,90,0])
      cylinder(r1=hinge_radius, r2=0, h=hinge_height);
	translate([black_width-((black_width - hollow_width)/2-epsilon),0,0])
	rotate([0,-90,0])
      cylinder(r1=hinge_radius, r2=0, h=hinge_height);
    }
    union() {
	translate([-(hinge_height+epsilon),0,0])
      cube([black_width+2*hinge_height+2*epsilon, hinge_radius+epsilon, hinge_radius+epsilon]);
	rotate([-atan2(black_travel, black_max_depth),0,0])
	translate([-(hinge_height+epsilon),-hinge_radius,0])
      cube([black_width+2*hinge_height+2*epsilon, hinge_radius+epsilon, hinge_radius+epsilon]);
    }
  }
}

module octave_white_keys() {
  translate([c_x,0,0]) white_key(0, white_width - c_stem_width);
    translate([d_x,0,0])
  white_key(
    d_x - (white_width + white_gap),
    2*white_width + white_gap - (d_sharp_x - black_gap)
  );
    translate([e_x,0,0])
  white_key(
    e_x - 2*(white_width + white_gap),
    0
  );
    translate([f_x,0,0])
  white_key(
    0,
    4*white_width + 3*white_gap - (f_sharp_x - black_gap)
  );
    translate([g_x,0,0])
  white_key(
    g_x - 4*(white_width + white_gap),
    5*white_width + 4*white_gap - (g_sharp_x - black_gap)
  );
    translate([a_x,0,0])
  white_key(
    a_x - 5*(white_width + white_gap),
    6*white_width + 5*white_gap - (a_sharp_x - black_gap)
  );
    translate([b_x,0,0])
  white_key(
    b_x - 6*(white_width + white_gap),
    0
  );
}

module octave_black_keys() {
  translate([c_sharp_x,0,0]) black_key();
  translate([d_sharp_x,0,0]) black_key();
  translate([f_sharp_x,0,0]) black_key();
  translate([g_sharp_x,0,0]) black_key();
  translate([a_sharp_x,0,0]) black_key();
}

module octave() {
  octave_white_keys();
  octave_black_keys();
}

module support_wall(x, next_x, next_gap) {
    translate([(x + next_x - next_gap - support_width)/2,0,0])
  difference() {
      rotate([atan2(white_travel, white_depth),0,0])
    union() {
      // curved top corner
      intersection() {
	  rotate([0,90,0])
	cylinder(r=hollow_height-support_gap, h=support_width+2*epsilon, $fn=72);
	  translate([0, -epsilon, -(support_gap + support_back_depth * white_travel / white_depth + epsilon)])
	cube([support_width, support_back_depth, hollow_height + support_back_depth * white_travel / white_depth + epsilon]);
      }
      // bulk
        translate([0, -support_depth, -support_gap])
      cube([support_width, support_depth, hollow_height]);
    }
    // bottom
      translate([-epsilon, -(support_depth - (support_back_depth + epsilon)), -(hollow_height + support_gap + epsilon)])
    cube([support_width+2*epsilon, support_depth+2*epsilon, hollow_height]);
    // front
      translate([-epsilon, -(hollow_height + support_depth - key_back_depth), -hollow_height])
    cube([support_width+2*epsilon, hollow_height, 2*hollow_height]);
    // hinge pits
      translate([-epsilon,0,0])
      rotate([0,90,0])
    cylinder(r1=hinge_radius + gap, r2=0, h=hinge_height + gap+epsilon);
      translate([support_width+epsilon,0,0])
      rotate([0,-90,0])
    cylinder(r1=hinge_radius + gap, r2=0, h=hinge_height + gap+epsilon);
    // bobby pin slot
      translate([
        (support_width - (bpin_width + 2*gap)) / 2,
	0,
	bpin_u_radius - gap
      ])
    bpin_hole();
  }
  /* DEBUG: bpin ghost
  %translate([(x + next_x - next_gap - support_width)/2,0,0])
      translate([
        (support_width - bpin_width)/2,
	0,
	bpin_u_radius - gap
      ])
  bpin();*/
}

// key support with holes for hinges
module support() {
  // bottom
    translate([0, -(support_depth - key_back_depth), -(wall_thickness + support_gap)])
  cube([octave, support_depth, wall_thickness]);
  // walls inside keys
  support_wall(c_x, c_sharp_x, black_gap);
  support_wall(c_sharp_x, d_x, black_gap);
  support_wall(d_x, d_sharp_x, black_gap);
  support_wall(d_sharp_x, e_x, black_gap);
  support_wall(e_x, f_x, white_gap);
  support_wall(f_x, f_sharp_x, black_gap);
  support_wall(f_sharp_x, g_x, black_gap);
  support_wall(g_x, g_sharp_x, black_gap);
  support_wall(g_sharp_x, a_x, black_gap);
  support_wall(a_x, a_sharp_x, black_gap);
  support_wall(a_sharp_x, b_x, black_gap);
  support_wall(b_x, octave, white_gap);
}

module assembled() {
  octave();
  support();
}

module plated_white_keys() {
    translate([0,0,white_travel + white_thickness])
    rotate([0,180,0])
  octave_white_keys();
}

module plated_black_keys() {
    translate([0,0,black_min_height + white_travel + white_thickness])
    rotate([0,180,0])
    rotate([(atan2(black_max_height-black_min_height, black_min_depth) /* fudge factor? */+5*epsilon),0,0])
  octave_black_keys();
}

module plated_keys() {
  plated_white_keys();
  plated_black_keys();
}

//assembled();
//difference() { // cutaway
//  assembled();
//    translate([0,-60,1])
//  cube([7,70,30]);
//}
//octave();
//plated_keys();
//support();

//
// fit test
//

//  rotate([0,0,40])
union() {
  // // plated C key
  //   translate([0,0,white_travel + white_thickness])
  //   rotate([0,180,0])
  // white_key(0, white_width - c_stem_width);
  // // plated C# key
  //   translate([0,0,black_min_height + white_travel + white_thickness])
  //   rotate([0,180,0])
  //   rotate([(atan2(black_max_height-black_min_height, black_min_depth) /* fudge factor? */+5*epsilon),0,0])
  // black_key();
  // // plated D key
  //   translate([0,0,white_travel + white_thickness])
  //   rotate([0,180,0])
  // white_key(
  //   d_x - (white_width + white_gap),
  //   2*white_width + white_gap - (d_sharp_x - black_gap)
  // );
  // // plated E key
  //   translate([0,0,white_travel + white_thickness])
  //   rotate([0,180,0])
  // white_key(
  //   e_x - 2*(white_width + white_gap),
  //   0
  // );
  // plated support for C-E keys only
    translate([10,-20,0])
  intersection() {
      translate([5,-120,-epsilon])
    cube([75,100,30]);
      translate([10, -50, wall_thickness + support_gap])
    support();
  }
}
