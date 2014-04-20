use <steeringColumn.scad>;

thickness = 5;
axleR = 3;

module body() {
  seatPegs();
  difference() {
    translate([-35, 58.8, 0])
    linear_extrude(height = thickness) import_dxf(file = "center-spline.dxf");
    pegs2(5);
  }
}


module sideBody() {
  linear_extrude(height = thickness) import_dxf(file = "outer-middle-spine.dxf");
  seatPegs();
}

module side() {
  linear_extrude(height = thickness) import_dxf(file = "outer-spine.dxf");
  seatPegs();
}

module seatPegs() {
  for(i=[0:5]) {
    translate([thickness * i * 6, 120, 0])
    cube([thickness*3, thickness, thickness]);
  }
}

module frame(showColumn, a, b, c, d, e, f) {
  difference() {
    union() {
      if (a) {
        side();
      }
      if (b) {
        translate([0, 0, 100])
        sideBody();
      }
      if (c) {
        translate([0, 0, 200])
        body();
      }
      if (d) {
        translate([0, 0, 300])
        body();
      }
      if (e) {
        translate([0, 0, 400])
        sideBody();
      }
      if (f) {
        translate([0, 0, 500])
        side();
      }
    }

    // slats
    for(i=[0:1]) {
      slat1(150+(i*70));
    }
    for(i=[0:2]) {
      slat2(310+(i*70));
    }
    for(i=[0:1]) {
      slat3(450+(i*70));
    }

    // axle
    translate([70, 70, -50])
    rotate([0, 0, 90])
    cylinder(r=axleR, h=600);
    translate([70, 15, -50])
    rotate([0, 0, 90])
    cylinder(r=axleR, h=600);

  }
  if (showColumn) {
    // steering column
    translate([520, 350, 300+thickness])
    rotate([45, 90, 0])
    columnFins();
  }
}

module slat1(x) {
  translate([x, 50, -50])
  rotate([0, 0, 45])
  cube([thickness, 40, 600]);
}

module slat2(x) {
  translate([x, 50, 50])
  rotate([0, 0, 45])
  cube([thickness, 40, 400]);
}

module slat3(x) {
  translate([x, 200, 150])
  rotate([0, 0, 45])
  cube([thickness, 40, 200]);
}

module mountingPegs2() {
  for(i=[0:3]) {
    translate([0, i*thickness*7, 0])
    cube([thickness*3, thickness*3, thickness]);
  }
}

module columnFins2() {
  for(i=[0:3]) {
    translate([0, 0, i*20])
    mountingPegs2();
  }
}

module pegs2(h) {
  translate([520, 350, h+thickness])
  rotate([45, 90, 0])
  columnFins2();
}

module one() {
  projection() {
    frame(false, 1, 0, 0, 0, 0, 0);
    translate([0, 150, 0])
    frame(false, 0, 1, 0, 0, 0, 0);
  }
}
module two() {
  projection() {
    frame(false, 0, 0, 1, 0, 0, 0);
  }
}

module crossbar() {
  projection() {
    difference() {
      cube([540, 40, 5]);
      for(i=[0:5]) {
        translate([i * 100+20, 0, 0])
        cube([thickness, 10, 50]);
      }
    }
  }
}

module crossbars() {
  for(i=[0:6]) {
    translate([0, 45*i, 0])
    crossbar();
  }
}


