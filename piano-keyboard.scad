/* piano-keyboard.scad - piano keyboard with dimensions copied from my midi keyboard
 * William de Beaumont
 * 2020-05-03
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

// echo centers of key stems in inches for PCB layout
echo(
c=(c_x +c_sharp_x )/(2*25.4),
cs=(c_sharp_x +d_x )/(2*25.4),
d=(d_x +d_sharp_x )/(2*25.4),
ds=(d_sharp_x +e_x )/(2*25.4),
e=(e_x +f_x )/(2*25.4),
f=(f_x +f_sharp_x )/(2*25.4),
fs=(f_sharp_x +g_x )/(2*25.4),
g=(g_x +g_sharp_x )/(2*25.4),
gs=(g_sharp_x +a_x )/(2*25.4),
a=(a_x +a_sharp_x )/(2*25.4),
as=(a_sharp_x +b_x )/(2*25.4),
b=(b_x +octave)/(2*25.4)
);

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
bpin_u_radius = 5 / 2; // measured when unaltered: 3.8 / 2;
bpin_max_length = 50;
bpin_min_length = 46;
bpin_u_m = 17.5;
bpin_m_length = bpin_min_length - bpin_u_m;
bpin_m_pitch = 22 / 4;

bpin_angle = 7.4; // after unbending

// skewer measurements

skewer_radius = 3 / 2; // 3mm diameter skewers

// electronics measurements

pcb_thickness = 1.6;
// this is what the TI datasheet says:
//chip_thickness = 2*2.54; // 2/10 inch
// this is what I measured (includes wide part of pins extending below plastic)
chip_thickness = (5/32) * 25.4; // 5/32 inch
// half of the 7/100 inch I shaved off the left side of the PCB to account for
// forgetting about the fact that the gap between keys is on the right side of
// the keys only when doing the above echo to get key stem centers in inches
pcb_x_fudge = - (7/2) * 0.254;

// mounting hole centers
//             inches
pcb_hole_1_x = 0.30	*25.4;
pcb_hole_1_y =-0.60	*25.4;
pcb_hole_2_x = 1.95	*25.4;
pcb_hole_2_y =-1.05	*25.4;
pcb_hole_3_x = 4.05	*25.4;
pcb_hole_3_y =-0.60	*25.4;
pcb_hole_4_x = 5.75	*25.4;
pcb_hole_4_y =-1.05	*25.4;

pcb_hole_radius = 3.2 / 2;

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
support_base_height = pcb_thickness + chip_thickness;
support_width = hollow_width - 2*support_gap;
support_depth = 50;
support_back_depth = 3*wall_thickness;

pcb_peg_radius = pcb_hole_radius - (gap + sliding_deduction);

skewer_hole_radius = skewer_radius + gap + sliding_deduction;

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
      translate([0, -support_depth, -(bpin_u_radius + support_gap)])
    cube([bpin_width + 2*support_gap, support_depth, black_back_height]);
      rotate([-bpin_angle,0,0])
      translate([-epsilon, -support_depth, bpin_u_radius+support_gap-black_back_height])
    cube([bpin_width + 2*support_gap + 2*epsilon, support_depth, black_back_height]);
  }
    rotate([0,90,0])
  cylinder(r = bpin_u_radius + support_gap, h = bpin_width + 2*support_gap);
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
        (support_width - (bpin_width + 2*support_gap)) / 2,
	0,
	bpin_u_radius - support_gap
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

module pcb_peg() {
    translate([pcb_x_fudge, - (support_depth - key_back_depth + support_gap), -(support_base_height + support_gap)])
  union() {
    cylinder(r=pcb_peg_radius, h=support_base_height);
    cylinder(r=pcb_peg_radius + wall_thickness, h=support_base_height - (pcb_thickness + gap));
  }
}

module switch_pad_clearance() {
    translate([
      -0.05*25.4,
      -0.31*25.4 - (support_depth - key_back_depth + support_gap),
      -0.1*25.4 - (support_gap + pcb_thickness)])
  cube([0.1*25.4, 0.3*25.4, 0.1*25.4]);
}

// key support with holes for hinges
module support() {
  // bottom
    translate([0, -(support_depth - key_back_depth), -(support_base_height + support_gap)])
  difference() {
    cube([octave-gap, support_depth, support_base_height]);
    // front pitchwise skewer hole
      translate([-epsilon, skewer_hole_radius+5*wall_thickness, skewer_hole_radius+wall_thickness/2-epsilon])
      rotate([0,90,0])
    union() {
      cylinder(r=skewer_hole_radius, h=octave+2*epsilon);
        translate([-sqrt(2)*skewer_hole_radius/2, 0, octave/2+epsilon])
	rotate([0,0,45])
      cube([skewer_hole_radius, skewer_hole_radius, octave+2*epsilon], center=true);
    }
    // back pitchwise skewer hole
      translate([-epsilon, support_depth - (skewer_hole_radius+5*wall_thickness), skewer_hole_radius+wall_thickness/2-epsilon])
      rotate([0,90,0])
    union() {
      cylinder(r=skewer_hole_radius, h=octave+2*epsilon);
        translate([-sqrt(2)*skewer_hole_radius/2, 0, octave/2+epsilon])
	rotate([0,0,45])
      cube([skewer_hole_radius, skewer_hole_radius, octave+2*epsilon], center=true);
    }
    // bottom crosshatches to mitigate curl
    // pitchwise crosshatch
      translate([-epsilon, support_depth / 2, 0])
      rotate([0,90,0])
    cylinder(r=support_base_height-wall_thickness, h=octave+2*epsilon, $fn=4);
    // perpendicular crosshatches
    // FIXME x positioned by hand
    for(
         //x=[25,61.5,111.1,136] // for r=skewer_hole_radius
         x=[25,64.5,114,133] // for r=support_base_height-wall_thickness
       ) {
	translate([x, -epsilon, 0])
	rotate([-90,0,0])
      cylinder(r=support_base_height-wall_thickness, h=support_depth+2*epsilon, $fn=4);
    }
  }
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
  // pcb pegs
  difference() {
    union() {
      translate([pcb_hole_1_x, pcb_hole_1_y, 0]) pcb_peg();
      difference() {
	  translate([0, 0, -(support_base_height + support_gap)])
	linear_extrude(height=support_base_height - (pcb_thickness + gap)) {
	  polygon(points=[
	    [0, -(support_depth - key_back_depth - epsilon)],
	    [2*(pcb_hole_1_x+pcb_x_fudge), - (support_depth - key_back_depth - epsilon)],
	    [pcb_hole_1_x + pcb_x_fudge + pcb_peg_radius + wall_thickness,
	     pcb_hole_1_y - (support_depth - key_back_depth + support_gap)],
	    [pcb_hole_1_x + pcb_x_fudge - (pcb_peg_radius + wall_thickness),
	     pcb_hole_1_y - (support_depth - key_back_depth + support_gap)]
	  ]);
	}
	  translate([(c_x + c_sharp_x)/2 + pcb_x_fudge, 0, 0])
	switch_pad_clearance();
      }
      translate([pcb_hole_2_x, pcb_hole_2_y, 0]) pcb_peg();
      difference() {
	  translate([0, 0, -(support_base_height + support_gap)])
	linear_extrude(height=support_base_height - (pcb_thickness + gap)) {
	  polygon(points=[
	    [pcb_hole_2_x + pcb_x_fudge - black_width,
	     -(support_depth - key_back_depth - epsilon)],
	    [pcb_hole_2_x + pcb_x_fudge + black_width,
	     -(support_depth - key_back_depth - epsilon)],
	    [pcb_hole_2_x + pcb_x_fudge + pcb_peg_radius + wall_thickness,
	     pcb_hole_2_y - (support_depth - key_back_depth + support_gap)],
	    [pcb_hole_2_x + pcb_x_fudge - (pcb_peg_radius + wall_thickness),
	     pcb_hole_2_y - (support_depth - key_back_depth + support_gap)]
	  ]);
	}
	  translate([(d_sharp_x + e_x)/2 + pcb_x_fudge, 0, 0])
	switch_pad_clearance();
      }
      translate([pcb_hole_3_x, pcb_hole_3_y, 0]) pcb_peg();
      difference() {
	  translate([0, 0, -(support_base_height + support_gap)])
	linear_extrude(height=support_base_height - (pcb_thickness + gap)) {
	  polygon(points=[
	    [pcb_hole_3_x + pcb_x_fudge - black_width*2/3,
	     -(support_depth - key_back_depth - epsilon)],
	    [pcb_hole_3_x + pcb_x_fudge + black_width*2/3,
	     -(support_depth - key_back_depth - epsilon)],
	    [pcb_hole_3_x + pcb_x_fudge + pcb_peg_radius + wall_thickness,
	     pcb_hole_3_y - (support_depth - key_back_depth + support_gap)],
	    [pcb_hole_3_x + pcb_x_fudge - (pcb_peg_radius + wall_thickness),
	     pcb_hole_3_y - (support_depth - key_back_depth + support_gap)]
	  ]);
	}
	  translate([(g_x + g_sharp_x)/2 + pcb_x_fudge, 0, 0])
	switch_pad_clearance();
      }
      translate([pcb_hole_4_x, pcb_hole_4_y, 0]) pcb_peg();
      difference() {
	  translate([0, 0, -(support_base_height + support_gap)])
	linear_extrude(height=support_base_height - (pcb_thickness + gap)) {
	  polygon(points=[
	    [pcb_hole_4_x + pcb_x_fudge - black_width*2/3,
	     -(support_depth - key_back_depth - epsilon)],
	    [pcb_hole_4_x + pcb_x_fudge + black_width*2/3,
	     -(support_depth - key_back_depth - epsilon)],
	    [pcb_hole_4_x + pcb_x_fudge + pcb_peg_radius + wall_thickness,
	     pcb_hole_4_y - (support_depth - key_back_depth + support_gap)],
	    [pcb_hole_4_x + pcb_x_fudge - (pcb_peg_radius + wall_thickness),
	     pcb_hole_4_y - (support_depth - key_back_depth + support_gap)]
	  ]);
	}
	  translate([(a_sharp_x + b_x)/2 + pcb_x_fudge, 0, 0])
	switch_pad_clearance();
      }
    }
    // pitchwise crosshatch
      translate([
        octave/2,
	-(support_depth - key_back_depth +
	  support_base_height-(wall_thickness + pcb_thickness + gap)),
	-(support_base_height + support_gap)])
      rotate([0,90,0])
      rotate([0,0,45])
    cube([sqrt(2)*(support_base_height-(wall_thickness + pcb_thickness + gap)),
          sqrt(2)*(support_base_height-(wall_thickness + pcb_thickness + gap)),
	  octave+2*epsilon],
	 center=true);
  }
}

module support_low_half() {
  intersection() {
    support();
      translate([-epsilon, -(300 - key_back_depth - epsilon), -(support_base_height + support_gap + epsilon)])
    cube([f_sharp_x - gap + epsilon, 300,300]);
  }
}

module support_high_half() {
  intersection() {
    support();
      translate([f_sharp_x, -(300 - key_back_depth - epsilon), -(support_base_height + support_gap + epsilon)])
    cube([octave - f_sharp_x - gap + epsilon, 300,300]);
  }
}

module assembled() {
  octave();
  //support();
  support_low_half();
  support_high_half();
    %translate([-25.4 + pcb_x_fudge, 25.4 - (support_depth - key_back_depth + support_gap), -0.8 - support_gap])
  import("piano-keyboard-pcb/piano-keyboard-pcb-v2.stl");
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
//  cube([6,70,30]);
//}
//octave();
//plated_keys();
//support();

//
// fit tests
//

//  translate([-50,-50, support_base_height + support_gap])
//support_high_half();

//// plated A key
//  translate([0,0,white_travel + white_thickness])
//  rotate([0,180,0])
//white_key(
//  a_x - 5*(white_width + white_gap),
//  6*white_width + 5*white_gap - (a_sharp_x - black_gap)
//);

//// plated C key
//  translate([0,0,white_travel + white_thickness])
//  rotate([0,180,0])
//white_key(0, white_width - c_stem_width);

//// plated D key
//  translate([0,0,white_travel + white_thickness])
//  rotate([0,180,0])
//white_key(
//  d_x - (white_width + white_gap),
//  2*white_width + white_gap - (d_sharp_x - black_gap)
//);
//// plated E key
//  translate([45,key_back_depth-white_depth,white_travel + white_thickness])
//  rotate([0,0,180])
//  rotate([0,180,0])
//white_key(
//  e_x - 2*(white_width + white_gap),
//  0
//);

//// plated F key
//  translate([60,0,white_travel + white_thickness])
//  rotate([0,180,0])
//white_key(
//  0,
//  4*white_width + 3*white_gap - (f_sharp_x - black_gap)
//);
//// plated G key
//  translate([0,key_back_depth-white_depth,white_travel + white_thickness])
//  rotate([0,0,180])
//  rotate([0,180,0])
//white_key(
//  g_x - 4*(white_width + white_gap),
//  5*white_width + 4*white_gap - (g_sharp_x - black_gap)
//);

//// plated A key
//  translate([0,0,white_travel + white_thickness])
//  rotate([0,180,0])
//white_key(
//  a_x - 5*(white_width + white_gap),
//  6*white_width + 5*white_gap - (a_sharp_x - black_gap)
//);
//// plated B key
//  translate([45,key_back_depth-white_depth,white_travel + white_thickness])
//  rotate([0,0,180])
//  rotate([0,180,0])
//white_key(
//  b_x - 6*(white_width + white_gap),
//  0
//);

  translate([0,0,black_min_height + white_travel + white_thickness])
  rotate([0,180,0])
  rotate([(atan2(black_max_height-black_min_height, black_min_depth) /* fudge factor? */+5*epsilon),0,0])
union() {
  black_key();
    translate([30,0,0])
  black_key();
    translate([60,0,0])
  black_key();
}
