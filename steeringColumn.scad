thickness = 5;
bladeL = 100;
bladeW = 120;
pipeR = 51/2;

module peg() {
  difference() {
    cube([thickness*3, thickness*3, thickness]);
    translate([thickness, thickness, 0])
    cube([thickness, thickness, thickness]);
  }
}

module mountingPegs() {
  for(i=[0:3]) {
    translate([0, i*thickness*7, 0])
    peg();
  }
}

module blade(r) {
  difference() {
    union() {
      cube([bladeL, bladeW, thickness]);
      translate([bladeL, 0, 0])
      mountingPegs();
      translate([-thickness*3, 0, 0])
      mountingPegs();
    }
    translate([bladeL/2, bladeW/2, 0])
    cylinder(r=pipeR-r, h=thickness);
  }
}

module columnFins() {
  for(i=[0:3]) {
    translate([0, 0, i*20])
    if (i == 0 || i == 3) {
      blade(1);
    } else {
      blade(0);
    }
  }
}
