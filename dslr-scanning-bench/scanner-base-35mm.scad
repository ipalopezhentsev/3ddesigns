//scanner plate base

ver="1.0";

dist_btw_hole_centers_horiz = 165;
dist_btw_hole_centers_vert = 100;
hole_center_to_edge_horiz = 25;
hole_center_to_edge_vert = 40;
thumbwheel_diameter = 20;
hole_diameter = 14;
expected_holder_height = 45;
//width/height of film window
fw = 40;
fh = 28;

//height of scanner base
z=3;

//gap
g=0.001;

w = dist_btw_hole_centers_horiz + 2 * hole_center_to_edge_horiz;
h = dist_btw_hole_centers_vert + 2 * hole_center_to_edge_vert;

assert(expected_holder_height < dist_btw_hole_centers_vert - thumbwheel_diameter, 
    "Film holder won't pass between thumbwheels");
assert(fh < dist_btw_hole_centers_vert - thumbwheel_diameter,
    "Film won't pass between thumbwheels");
assert(thumbwheel_diameter > hole_diameter, "Thumbwheel won't clamp the plate");

echo(str("width=", w, ", height=", h));

module hole() {
    cylinder(h=z+g, r1=hole_diameter/2,
        r2=hole_diameter/2, center=false);
}

translate([0,0,0]) difference() {
    cube([w,h,z]);
    translate([w/2,h/2,z/2]) cube([fw,fh,z+g], center=true);
    translate([hole_center_to_edge_horiz, hole_center_to_edge_vert]) hole();
    translate([w - hole_center_to_edge_horiz, hole_center_to_edge_vert]) hole();
    translate([hole_center_to_edge_horiz, h - hole_center_to_edge_vert]) hole();
    translate([w - hole_center_to_edge_horiz, h - hole_center_to_edge_vert]) hole();
    translate([w/2,10,0]) mirror([1,0,0]) linear_extrude(z/3)
        text(ver, valign="center", halign="center", size=5);
};