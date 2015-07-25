$fn=40;

x=8;
y=30;
z=18;

// difference between details
delta=0.05;

difference() {
	cube([x,y,z]);
	translate([x,y/2,-1])cylinder(r=4+delta,h=z+2);
	translate([-1,y/2-8,z/2])rotate([0,90,0])cylinder(r=2.5+delta,h=x+2);
	translate([-1,y/2+8,z/2])rotate([0,90,0])cylinder(r=2.5+delta,h=x+2);
}
