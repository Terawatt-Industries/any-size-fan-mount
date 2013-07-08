include <MCAD/nuts_and_bolts.scad>

$fn=100;

//fan_ctc = 105; //  uncomment for 120mm fan
//fan_ctc = 71.5; //       ""         for 80mm fan
fan_ctc = 50; //          ""         for 60mm fan
//fan_ctc = 32; //            ""         for 40mm fan

mounting_screw = 5; // choose M3 = 3, M4 = 4, M5 = 5
mounting_pos = 0.75; // choose   -1 = left,   0 = center,   1=right
					// fractional sizes between 0 and +/- 1 accepted!

height = 6;
thickness = 7.5;

fan_mount();

module fan_mount(fan_ctc = fan_ctc, mounting_screw = mounting_screw, mounting_pos = mounting_pos, height = height, thickness = thickness) {
	assign(offset = mounting_pos * (fan_ctc/2 - 4 - 15/2 - 3)) {
	difference(){
		union(){
			translate([offset,-10,0]) cube([15,20,height],center=true);
			bracket(fan_ctc, thickness, height);
			translate([-15/2+0.3+offset,-4+0.6,0]) fillet(4,height);
			translate([15/2-0.3+offset,-4+0.6,0]) rotate([0,0,90]) fillet(4,height);
		}
		if (mounting_screw == 3){
			translate([offset,-20/2-mounting_screw/2,0.5])
			rotate([180,0,0]) boltHole(mounting_screw,units="MM",length=30,tolerance=0.25);
		}
		else if (mounting_screw == 4){
			translate([offset,-20/2-mounting_screw/2,0.5])
			rotate([180,0,0]) boltHole(mounting_screw,units="MM",length=30,tolerance=0.25);
		}
		else if (mounting_screw == 5){
			translate([offset,-20/2-mounting_screw/2,0])
			rotate([180,0,0]) boltHole(mounting_screw,units="MM",length=30,tolerance=0.25);
		}
	translate([offset,-20/2-mounting_screw/2,0])
		cylinder(r=mounting_screw/2+0.25,h=100,center=true);
	}
	}
}

module bracket(fan_ctc = fan_ctc, thickness = thickness, height = height){
difference(){
union(){
cube([fan_ctc+4,thickness,height],center=true);
translate([fan_ctc/2,0,height/2]) rotate([90,0,0]) cylinder(r=4,h=thickness,center=true);
translate([-fan_ctc/2,0,height/2]) rotate([90,0,0]) cylinder(r=4,h=thickness,center=true);
translate([-fan_ctc/2+2.85,0,height/2-0.2]) rotate([0,0,90]) rotate([0,90,0]) fillet(4,thickness);
translate([fan_ctc/2-2.85,0,height/2-0.2]) rotate([0,0,-90]) rotate([0,90,0]) fillet(4,thickness);
}
translate([fan_ctc/2,-0.5,height/2]) rotate([-90,0,0]) boltHole(4,units="MM",length=30,tolerance=0.25);
translate([fan_ctc/2,0,height/2]) rotate([90,0,0]) cylinder(r=2+0.25,h=100,center=true);
translate([-fan_ctc/2,-0.5,height/2]) rotate([-90,0,0]) boltHole(4,units="MM",length=30,tolerance=0.25);
translate([-fan_ctc/2,0,height/2]) rotate([90,0,0]) cylinder(r=2+0.25,h=100,center=true);
}}

module fillet(rad,height){
translate([-2*sqrt(rad),-2*sqrt(rad),0])
difference(){
translate([0,0,-height/2]) cube([rad-0.2,rad-0.2,height]);
cylinder(h=height+1,r=rad,center=true);
}}