/* piano-keyboard.scad - piano keyboard with dimensions copied from my midi keyboard
 * William de Beaumont
 * 2017-02-04
 */

/* TODO
 * - abandon back with pennies or springs
 *  - instead put a y-axis hole in back, to put in a long bolt (~4cm?) with 1 or
 *    2 nuts at the back end (or 1 nut and a bunch of washers)
 *  - nuts must be narrower than black_width
 *  - need to keep *some* of the back, so that there's a flat part to balance
 *    on in the key up position. no need for the current back hole, though
 *   - or just make the bolt hole close to the bottom so the nut hits the ground
 * - make support only wall_thickness around hinge, with no back part (tall
 *   single walls delaminate easily, and the back would be in the way of the
 *   bolt)
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
black_travel = 12 - 5.6; // ? at max end of black key (but tilted)
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

// end measurements

wall_thickness = 1;
white_thickness = 2*corner_radius;
gap = 0.3;
thin_wall_deduction = 0.2;/* for imperfect printing */
epsilon = 0.01;

key_back_width = black_width;
//key_back_depth = 19 + wall_thickness + 2*gap; // enough to fit a penny around the X axis
key_back_depth = 15;
support_back_depth = 20;
white_back_height = white_travel + white_thickness;
black_back_height = white_back_height + black_min_height;

hinge_radius = corner_radius;
hinge_height = (white_gap - gap)/2 + 0.25/*for imperfect printing*/;

spring_thickness = 0.5; // 1 layer
spring_radius = 3.7; // slightly smaller than would fit without stretching
spring_width = key_back_width - 2*(wall_thickness + gap);

spring_gap_height = 2;
spring_gap_width = spring_width + 2*(gap-epsilon);

$fn=24;

module white_key(left_cutout, right_cutout) {
    translate([-left_cutout,0,0])
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
    difference() {
      cube([key_back_width, key_back_depth, white_back_height]);
        translate([wall_thickness, -epsilon, wall_thickness])
      cube([key_back_width - 2*wall_thickness, key_back_depth - wall_thickness + epsilon, white_back_height - wall_thickness + epsilon]);
    }
    // hinge
      translate([left_cutout,0,0])
    intersection() {
	rotate([0,90,0])
      rotate_extrude(convexity=2, $fn=12) {
	polygon(points=[
	  [0, -hinge_height],
	  [hinge_radius, 0],
	  [hinge_radius, white_width-left_cutout-right_cutout],
	  [0, white_width-left_cutout-right_cutout+hinge_height],
	]);
      }
      union() {
	  translate([-(hinge_height+epsilon),0,0])
	cube([white_width+2*hinge_height+2*epsilon, hinge_radius+epsilon, hinge_radius+epsilon]);
	  rotate([-atan2(white_travel, white_depth),0,0])
	  translate([-(hinge_height+epsilon),-hinge_radius,0])
	cube([white_width+2*hinge_height+2*epsilon, hinge_radius+epsilon, hinge_radius+epsilon]);
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
    // back holes
      translate([wall_thickness, -epsilon, wall_thickness])
    cube([key_back_width - 2*wall_thickness, key_back_depth - wall_thickness + epsilon, black_back_height - wall_thickness + epsilon]);
      translate([wall_thickness+epsilon, key_back_depth-(wall_thickness+epsilon), white_travel + white_thickness])
    cube([spring_gap_width, wall_thickness + 2*epsilon, spring_gap_height]);
  }
  // hinge
  intersection() {
      rotate([0,90,0])
    rotate_extrude(convexity=2, $fn=12) {
      polygon(points=[
	[0, -hinge_height],
	[hinge_radius, 0],
	[hinge_radius, black_width],
	[0, black_width+hinge_height],
      ]);
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

module spring() {
  difference() {
    cylinder(r=spring_radius, h=spring_width);
      translate([0,0,-epsilon])
    cylinder(r=spring_radius-spring_thickness, h=spring_width + 2*epsilon);
      translate([0, -(spring_radius+epsilon), -epsilon])
    cube([spring_radius+epsilon, spring_radius+epsilon, spring_width + 2*epsilon]);
  }
    translate([-epsilon,-(2*spring_radius-spring_thickness), 0])
  difference() {
    cylinder(r=spring_radius, h=spring_width);
      translate([0,0,-epsilon])
    cylinder(r=spring_radius-spring_thickness, h=spring_width + 2*epsilon);
      translate([-(spring_radius+epsilon), 0, -epsilon])
    cube([spring_radius+epsilon, spring_radius+epsilon, spring_width + 2*epsilon]);
  }
}

module spring_assembled() {
    translate([spring_width,support_back_depth,spring_radius + spring_gap_height - 2*gap])
    rotate([-60,0,0])
    rotate([0,-90,0])
  spring();
}

module springs_assembled() {
  translate([(c_x+c_sharp_x-spring_width-black_gap)/2,0,0]) spring_assembled();
  translate([(c_sharp_x+d_x-spring_width-black_gap)/2,0,0]) spring_assembled();
  translate([(d_x+d_sharp_x-spring_width-black_gap)/2,0,0]) spring_assembled();
  translate([(d_sharp_x+e_x-spring_width-black_gap)/2,0,0]) spring_assembled();
  translate([(e_x+f_x      -spring_width-white_gap)/2,0,0]) spring_assembled();
  translate([(f_x+f_sharp_x-spring_width-black_gap)/2,0,0]) spring_assembled();
  translate([(f_sharp_x+g_x-spring_width-black_gap)/2,0,0]) spring_assembled();
  translate([(g_x+g_sharp_x-spring_width-black_gap)/2,0,0]) spring_assembled();
  translate([(g_sharp_x+a_x-spring_width-black_gap)/2,0,0]) spring_assembled();
  translate([(a_x+a_sharp_x-spring_width-black_gap)/2,0,0]) spring_assembled();
  translate([(a_sharp_x+b_x-spring_width-black_gap)/2,0,0]) spring_assembled();
  translate([(b_x+octave   -spring_width-white_gap)/2,0,0]) spring_assembled();
}

black_wall_thickness = black_gap - 2*(gap+thin_wall_deduction);
white_wall_thickness = white_gap - 2*(gap+thin_wall_deduction);

module support_wall(thickness) {
  difference() {
    union() {
        translate([0,0,-(wall_thickness + gap)])
      cube([thickness, support_back_depth + gap + thin_wall_deduction, white_travel + white_thickness + wall_thickness + gap]);
        rotate([0,90,0])
      cylinder(r=white_travel + white_thickness, h=thickness);
    }
      translate([-epsilon,0,0])
      rotate([0,90,0])
    cylinder(r=hinge_radius, h=thickness+2*epsilon);
      translate([-epsilon, -(white_travel + white_thickness + epsilon), -(white_travel + white_thickness + wall_thickness + gap)+epsilon])
    cube([thickness+2*epsilon, 2*(white_travel + white_thickness + epsilon), white_travel + white_thickness]);
  }
}

// key support with holes for hinges
// two versions: one with two B-C separators, and one with only one, at the high end
module support(include_first_wall) {
  // bottom
    translate([
      (include_first_wall ? -white_gap : 0),
      -(white_travel + white_thickness),
      -(wall_thickness + gap)
    ])
  cube([
    octave + (include_first_wall ? white_gap : 0),
    support_back_depth + white_travel + white_thickness + wall_thickness + gap,
    wall_thickness + gap
  ]);
  // back
  difference() {
      translate([
	(include_first_wall ? -white_gap : 0),
	support_back_depth + gap + thin_wall_deduction,
	-gap
      ])
    cube([
      octave + (include_first_wall ? white_gap : 0),
      wall_thickness - thin_wall_deduction,
      white_travel + white_thickness + gap
    ]);
    // spring gaps
      translate([(c_x+c_sharp_x-spring_width-black_gap)/2-gap,
		support_back_depth+gap, epsilon])
    cube([spring_gap_width, wall_thickness + 2*epsilon, spring_gap_height]);
      translate([(c_sharp_x+d_x-spring_width-black_gap)/2-gap,
		support_back_depth+gap, epsilon])
    cube([spring_gap_width, wall_thickness + 2*epsilon, spring_gap_height]);
      translate([(d_x+d_sharp_x-spring_width-black_gap)/2-gap,
		support_back_depth+gap, epsilon])
    cube([spring_gap_width, wall_thickness + 2*epsilon, spring_gap_height]);
      translate([(d_sharp_x+e_x-spring_width-black_gap)/2-gap,
		support_back_depth+gap, epsilon])
    cube([spring_gap_width, wall_thickness + 2*epsilon, spring_gap_height]);
      translate([(e_x+f_x      -spring_width-white_gap)/2-gap,
		support_back_depth+gap, epsilon])
    cube([spring_gap_width, wall_thickness + 2*epsilon, spring_gap_height]);
      translate([(f_x+f_sharp_x-spring_width-black_gap)/2-gap,
		support_back_depth+gap, epsilon])
    cube([spring_gap_width, wall_thickness + 2*epsilon, spring_gap_height]);
      translate([(f_sharp_x+g_x-spring_width-black_gap)/2-gap,
		support_back_depth+gap, epsilon])
    cube([spring_gap_width, wall_thickness + 2*epsilon, spring_gap_height]);
      translate([(g_x+g_sharp_x-spring_width-black_gap)/2-gap,
		support_back_depth+gap, epsilon])
    cube([spring_gap_width, wall_thickness + 2*epsilon, spring_gap_height]);
      translate([(g_sharp_x+a_x-spring_width-black_gap)/2-gap,
		support_back_depth+gap, epsilon])
    cube([spring_gap_width, wall_thickness + 2*epsilon, spring_gap_height]);
      translate([(a_x+a_sharp_x-spring_width-black_gap)/2-gap,
		support_back_depth+gap, epsilon])
    cube([spring_gap_width, wall_thickness + 2*epsilon, spring_gap_height]);
      translate([(a_sharp_x+b_x-spring_width-black_gap)/2-gap,
		support_back_depth+gap, epsilon])
    cube([spring_gap_width, wall_thickness + 2*epsilon, spring_gap_height]);
      translate([(b_x+octave   -spring_width-white_gap)/2-gap,
		support_back_depth+gap, epsilon])
    cube([spring_gap_width, wall_thickness + 2*epsilon, spring_gap_height]);
  }
  // between keys
  if (include_first_wall) {
      translate([c_x-white_gap+gap, 0, 0])
    support_wall(white_wall_thickness);
  }
    translate([c_sharp_x-black_gap+gap, 0, 0])
  support_wall(black_wall_thickness);
    translate([d_x-black_gap+gap, 0, 0])
  support_wall(black_wall_thickness);
    translate([d_sharp_x-black_gap+gap, 0, 0])
  support_wall(black_wall_thickness);
    translate([e_x-black_gap+gap, 0, 0])
  support_wall(black_wall_thickness);
    translate([f_x-white_gap+gap, 0, 0])
  support_wall(white_wall_thickness);
    translate([f_sharp_x-black_gap+gap, 0, 0])
  support_wall(black_wall_thickness);
    translate([g_x-black_gap+gap, 0, 0])
  support_wall(black_wall_thickness);
    translate([g_sharp_x-black_gap+gap, 0, 0])
  support_wall(black_wall_thickness);
    translate([a_x-black_gap+gap, 0, 0])
  support_wall(black_wall_thickness);
    translate([a_sharp_x-black_gap+gap, 0, 0])
  support_wall(black_wall_thickness);
    translate([b_x-black_gap+gap, 0, 0])
  support_wall(black_wall_thickness);
    translate([octave-white_gap+gap, 0, 0])
  support_wall(white_wall_thickness);
}

module assembled() {
  octave();
  support(true);
    translate([octave, 0, 0])
  support(false);
  springs_assembled();
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
//plated_keys();
//support(true);
//support(false);
//spring();

//
// fit test
//

  rotate([0,0,40])
union() {
  // plated C key
    translate([0,0,white_travel + white_thickness])
    rotate([0,180,0])
  white_key(0, white_width - c_stem_width);
  // // plated C# key
  //   translate([0,0,black_min_height + white_travel + white_thickness])
  //   rotate([0,180,0])
  //   rotate([(atan2(black_max_height-black_min_height, black_min_depth) /* fudge factor? */+5*epsilon),0,0])
  // black_key();
  // plated support for C(#) key only
    translate([0,-20,0])
  intersection() {
      translate([5 /*20*/,-80,-epsilon])
    cube([20,60,30]);
      translate([10, -50, wall_thickness + gap])
    support(true);
  }
    translate([20,-20,0])
  spring();
}
