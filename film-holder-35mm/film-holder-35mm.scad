//film holder for 35mm film used with anti-Newton glass

//film height
film_height = 35; //35mm film - (34.976 ± 0.025 mm - so max is 35.001) 

//width of frame
fw=36;

//height of frame
fh=24;

//width of post between frames
p=2;//nikon f100 creates spacing of 2mm

//width of margin near top and bottom of the frame
mh=18;

//height of holder base
h1=3;

//height of 'lips' that hold anti-Newton glass
h2=1.9; //my glass has height 2mm, I want holder to rest on glass, not on plastic, because glass is smoother

//gap between copies so openscad understands they form one piece
g=0.001;

//number of frames
n = 6;

//width of left and right borders
mw = 15;

//anti-Newton glass height
//angh = 32.8; //real is 33 (ordered 34!)
angh = film_height; //otherwise film won't fit!
//we need glass 270x35

total_base_height = fh+2*mh;
full_frame_width=fw+p-g;
full_base_width=full_frame_width*n+2*mw;

echo("width=", full_base_width);

module frame() {
    difference() {
        cube([fw+p,total_base_height, h1], center=true);
        cube([fw, fh, h1+g*2], center=true);
    }
}

module base_main() {
    for (i=[0:1:n-1]) {
        translate([full_frame_width*i,0,0]) 
            frame();
    }
}

module base_side() {
    cube([mw,total_base_height,h1], center=true);
}

module base() {
    //main base
    translate([mw+0.5*(fw+p)-g,0,0]) base_main();
    //left margin
    translate([mw/2,0,0]) base_side();
    //right margin
    translate([1.5*mw+full_frame_width*n-g,0,0]) base_side();
}

module lip(lip_height) {
    cube([full_base_width, lip_height,h2]);
}

module lips() {
    //stopper so that glass doesn't move
    cube([mw/2,total_base_height,h2]);
    //lips
    lip_height = (total_base_height-angh)/2;
    lip(lip_height);
    translate([0,angh+lip_height,0]) lip(lip_height);
}

translate([0,total_base_height/2,h1/2]) base();
translate([0,0,h1-g]) lips();
