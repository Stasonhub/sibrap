include <config.scad>

//x=43;
//y=36;
z=23;

// отверстия под болты М3
d1=3.2;
d2=23;
// диаметр гнезда под подшипник
d22=22.3;
d3=12;
d4=9.7;
d5=5;
d6=12.5;

//x0=5.5;
x00=6.5;
y0=4;
//y00=4;
x1=24.5;
y1=20;
z1=z-6.25;

y2=15.5;
z2=13;
y22=15.5;
z22=13;
y3=3;
z3=6.3;

y4=4;
y5=9;
z4=2.5;
x5=24.5;
y6=5;
x6=14;
z6=5;

module nut() {
	translate([0,0,8.75])rotate([90,0,90])cylinder(z6,r=7/2,$fn=6);
}
module hole() {
	translate([0,0,8.75])rotate([90,0,90])cylinder(5,r=d1/2,$fn=20);
}

module head_part02(bowden=false) {
// freecad positioning
//translate([15.5,13,17.5])rotate([-90,-90,180])
mirror([1,0,0])
union() {
difference() {
    x=bowden?46.5:43;
    y=bowden?39.5:36;
    x0=bowden?9:5.5;
    y00=bowden?4.5:4;

	// main part
	cube([x,y,z]);

	// horizontal section
	//translate([-1,-1,1])cube([x+2,y+2,z]);

	// bolts
	translate([x0,y00,-1])cylinder(z+2,r=d1/2,$fn=20);
	translate([x0,y-y0,-1])cylinder(z+2,r=d1/2,$fn=20);
	translate([x-x00,y-y0,-1])cylinder(z+2,r=d1/2,$fn=20);

	// hobbed bolt
	//translate([x1,y1,-1])cylinder(z+2,r=5.8/2,$fn=50);
	//translate([x1,y1,-1])cylinder(z+2,r=4,$fn=50);

	// bearings
	translate([x1,y1,-1])cylinder(z+2,r=d3/2,$fn=50);
// поднимаем подшипник на 1 мм для плотной посадки в каретку экструдера
	translate([x1,y1,z1+1])cylinder(7,r=d22/2,$fn=50);
	translate([x1-d3/2,y1-8,z1-7.8])cube([d3,8,9]);
	translate([x1,y1,-1])cylinder(8.5,r=d22/2,$fn=50);

	// part19 slot
	translate([-1,-1,5])cube([x+2,y4+1,z-4]);
	translate([x0,-1,5])cube([x/2-x0,8,z-4]);
	translate([x0,y00,5])cylinder(z-4,r=d4/2,$fn=50);

	// part19 bearing
	translate([x5,y6,5])cylinder(z-4,r=d2/2+0.4,$fn=50);
	translate([x5,y6,7])cylinder(13,r=4,$fn=50);
	translate([x5,y6,10])cylinder(7,r=11,$fn=50);

	// part19 nut
	translate([x-4.5,y2-7,z2])rotate([-90,0,0])cylinder(y3,r=z3/2,$fn=6);
	translate([x-6,y2-7,z2-z3/2+0.25])cube([7,y3,z3-0.5]);
	translate([x-3,y4-1,z2])rotate([-90,0,0])cylinder(y5,r=d1/2,$fn=20);

	// profile slot
	translate([-1,-1,z-z4])cube([19,y+2,z4+1]);

	// ABS plastic 3mm
	//translate([-1,y2,z2])rotate([0,90,0])cylinder(x+2,r=3/2,$fn=20);
	translate([x1,y2,z2])rotate([0,90,0])cylinder(x-x1+1,r=d5/2,$fn=20);
	translate([-1,y22,z22])rotate([0,90,0])cylinder(x1+1,r=d5/2,$fn=20);

	// Отверстие под термобарьер с резьбой. Выдвигаем на 0.7 мм чтобы был зазор между радиатором и соплом
    if (bowden) {
        translate([4-0.01,y22,13])bowden();
    } else {
        translate([41,y22,13])mirror([1,0,0])bowden();
        translate([-1-0.7,y22,z22])rotate([0,90,0])cylinder(x6,r=d6/2,$fn=50);

        // hotend nuts
        for(i=[0:2])translate([-1,y22,z2])rotate([120*i+60,0,0])nut();
        for(i=[0:2])translate([2,y22,z2])rotate([120*i+60,0,0])hole();
	//translate([-1,y22-13.5,z-z4+1])rotate([0,90,0])cube([7.15,8,z6-.2]);

        translate([-6,0,14.34]) cube([10,10,10]);
        translate([-1,21.3,14.34]) cube([5,3.5,10]);
    }
}

// bearing cap & support
difference() {
	union() {
		translate([x1,y1,0.5])cylinder(8.5,r=d2/2+1.5,$fn=50);
		translate([12.5,6.9,0.5])cube([24,5,8.5]);
	}
	translate([x1,y1,7.9])cylinder(15,r=d3/2,$fn=50);
	translate([x1,y1,-1])cylinder(8.5,r=d22/2,$fn=50);
	translate([0.5,y1-d22/4,0.5])cube([14.5,d22/2,10]);
	translate([12,2,0.5])cube([25,5,9]);
	translate([-1,y22,z22])rotate([0,90,0])cylinder(x6,r=d6/2,$fn=50);
	translate([x5,y6,7])cylinder(13,r=4,$fn=50);
}
}
}

module bowden() {
    // расстояние от стенок до гайки
    DELTA = 0.3;
    // гайка М4
    // высота
    h=m4_hole[0];
    // макс. диаметр
    d=m4_hole[1];
    // между стенками (размер ключа)
    k=m4_hole[2];
    
    translate([-4,-2,0])cube([7.5,4,11]);
    translate([0,-k/2,0])cube([h,k,11]);
    rotate([0,90,0])cylinder(r=d/2,h=h,$fn=6);
}

head_part02(false);
