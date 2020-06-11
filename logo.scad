module logo() {
  $fn = 90;
  union() {
    // W
    translate([18,5,0]) sphere(0.5);
      translate([18,10,0])
      rotate([0,0,180])
    rotate_extrude(angle=90) {
      translate([5,0,0]) circle(r=0.5);
    }
    translate([13,10,0]) sphere(0.5);
      translate([11,10,0])
      rotate([0,0,180])
    rotate_extrude(angle=180) {
      translate([2,0,0]) circle(r=0.5);
    }
    // C
    translate([4,15,0]) sphere(0.5);
      translate([4,10,0])
      rotate([0,0,-90])
    rotate_extrude(angle=180) {
      translate([5,0,0]) circle(r=0.5);
    }
    translate([4,5,0]) sphere(0.5);
    // d
    translate([10,1,0]) sphere(0.5);
      translate([10,10,0])
      rotate([0,0,180])
    rotate_extrude(angle=90) {
      translate([9,0,0]) circle(r=0.5);
    }
      translate([4,10,0])
    rotate_extrude() {
      translate([3,0,0]) circle(r=0.5);
    }
  }
}
