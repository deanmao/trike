forkL = 450;
forkW = 76;
thickness = 5;

wheelR = 300;
forkSpacing = 55;
axleR = 5;
screwR = 3;

module rodCavity() {
  rotate([0, 90, 0])
  cylinder(r=25, h=100);
}

module screwMountCavity(x,y,h) {
  translate([0, 0, -20]) {
    cylinder(r=screwR, h=h);
    translate([x, 0, 0])
    cylinder(r=screwR, h=h);
    translate([0, y, 0])
    cylinder(r=screwR, h=h);
    translate([x, y, 0])
    cylinder(r=screwR, h=h);
  }
}

module wheelCavity() {
  cylinder(r=wheelR, h=25, $fn=60);
  translate([0, 0, -50])
  cylinder(r=axleR, h=125, $fn=60);
}

module fork() {
//  difference() {
  cube([forkL, forkW, thickness]);
  translate([0, 0, forkSpacing])
  cube([forkL, forkW, thickness]);

  translate([forkL-(forkW/2), forkW/2, 10])
  wheelCavity();

  translate([0, forkW/2, 25+thickness])
  rodCavity();

  translate([20, (forkW - 20) / 2, 0])
  screwMountCavity(50, 20, 100);
// }
}

fork();
