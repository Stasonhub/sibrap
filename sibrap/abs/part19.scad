module halfcube(a,orient,center) {
	translate(center==true?-a/2:0) {
		if (orient=="x")
			polyhedron (points = [[a[0],0,a[2]], [0,0,a[2]], [0,a[1],0], [0,0,0], [a[0],0,0], [a[0],a[1],0]], triangles = [[1,3,2], [4,0,5], [3,1,4], [1,2,5], [1,0,4], [0,1,5],  [5,2,4], [4,2,3]]);
		if (orient=="y")
			polyhedron (points = [[0,a[1],a[2]], [0,0,a[2]], [0,a[1],0], [0,0,0], [a[0],0,0], [a[0],a[1],0]], triangles = [[1,3,2], [1,2,0], [3,1,4], [0,2,5], [1,5,4], [1,0,5],  [5,2,4], [4,2,3]]);
		if (orient=="z")
			polyhedron (points = [[0,a[1],a[2]], [0,0,a[2]], [0,a[1],0], [0,0,0], [a[0],0,0], [a[0],0,a[2]]], triangles = [[1,3,2], [1,2,0], [3,1,4], [0,2,5], [1,5,4], [1,0,5],  [5,2,4], [4,2,3]]);
	}
}
//include <halfcube.scad>
x=42;
y=15.5;
z=10;
z0=7;

d1=23.5;
d2=8;
d3=4;
d4=9;
d5=3;
x1=18.5;
h1=9;
h2=12;
z1=7;

d6=6.5;
hh=6.5;
// freecad positioning
//translate([18.5,8,60.5])rotate([180,90,0])
mirror([1,0,0])
union(){
difference(){
	// main part
	cube([x,y,z]);
	translate([0,-1,z-1])cube([x,y/2,z]);
	translate([x-4.5,-1,z1])cube([d4,y+2,d4]);
	translate([x-4.5,-1,z1])rotate([0,40,0])cube([d4,y+2,d4]);

	// bearing
	translate([x1,y/2+h1/2,z0])rotate([90,0,0])cylinder(h1,r=d1/2,$fn=50);
	translate([x1,y/2,d1/2+z0])cube([d1,h1,d1],true);
	translate([x1,y/2+h2/2,z0])rotate([90,0,0])cylinder(h2,r=d2/2,$fn=50);
	translate([x1,y/2,d2/2+z0])cube([d2,h2,d2],true);

	// top slot
	translate([-1,-1,z-4])cube([x1-9,y+2,5]);
	translate([3,y/2,-1])cylinder(z+2,r=d3/2,$fn=20);

	// bottom round cut
	translate([x-4.5,-1,z1])rotate([-90,0,0])cylinder(y+2,r=d5/2,$fn=20);
	translate([x+1,-1,-1])rotate([0,-90,0])halfcube([7.6,y+2-hh,6.3],"y");

	translate([x-4.5,-1,z1])rotate([0,40,0])cube([d4,y+2,d4]);
	translate([x+1,y-hh,-1])rotate([0,-90,0])halfcube([11.9,hh+1,6],"y");
}

// bottom round thing
difference(){
	union(){
		translate([x-4.5,0,z1])rotate([-90,0,0])cylinder(y-hh,r=d4/2,$fn=50);
		translate([x-4.5,0,z1])rotate([-90,0,0])cylinder(y,r=d6/2,$fn=50);
	}
	translate([x-4.5,-1,z1])rotate([-90,0,0])cylinder(y+2,r=d5/2,$fn=20);
}
}
