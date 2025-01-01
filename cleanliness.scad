/*
 * Clean / Dirty sign for dishwasher
 *
 * Copyright (C) 2024-2025 Matthias Neeracher <microtherion@gmail.com>
 */

$fn = $preview ? 32 : 64;

// Width of handle [mm]
handle_width	   = 10; // [10:30:5]

// Depth of handle [mm]
handle_depth       = 17; // [5:50:.5]

// Height of handle [mm]
handle_height	   = 18; // [5:50:.5]

// Height of ridge [mm]
handle_ridge       =  3; // [0:10:1]

// Width of sign [mm]
sign_width         = 70; // [20:100:5]

// Height of sign [mm]
sign_height        = 35; // [10:100:5]

// Element thickness [mm]
thickness          =  3; // [1:5:.5]

// Front text
front_text         = "Clean";

// Back text
back_text          = "Dirty";

// Text size
text_size          = 18; // [7:80:1]

// Text position
text_pos           = 0.6; // [0.2:0.8:0.1]

// Slope [deg]
slope              = 30; // [0:75:5]

half_thickness     = thickness*0.5;
text_thickness     = 0.5+half_thickness;

module handle() {
    hw = 0.5*handle_width;
    hd = 0.5*handle_depth+half_thickness;
    hh = handle_height+thickness;
    rh = handle_ridge+thickness;
    hull() {
        translate([-hw, -hd, half_thickness]) sphere(d=thickness);
        translate([ hw, -hd, half_thickness]) sphere(d=thickness);
        translate([ hw,  hd, half_thickness]) sphere(d=thickness);
        translate([-hw,  hd, half_thickness]) sphere(d=thickness);
    }
    hull() {
        translate([-hw,  hd, half_thickness]) sphere(d=thickness);
        translate([-hw,  hd, hh])             sphere(d=thickness);
        translate([ hw,  hd, hh])             sphere(d=thickness);
        translate([ hw,  hd, half_thickness]) sphere(d=thickness);
    }
    hull() {
        translate([-hw,  hd, hh])             sphere(d=thickness);
        translate([ hw,  hd, hh])             sphere(d=thickness);
        translate([-hw,   0, hh])             sphere(d=thickness);
        translate([ hw,   0, hh])             sphere(d=thickness);
    }
    hull() {
        translate([-hw, -hd, half_thickness]) sphere(d=thickness);
        translate([-hw, -hd, rh])             sphere(d=thickness);
        translate([ hw, -hd, rh])             sphere(d=thickness);
        translate([ hw, -hd, half_thickness]) sphere(d=thickness);
    }
}

module sign() {
    hw = 0.5*handle_width;
    sw = 0.5*sign_width;
    sh = sign_height*cos(slope);
    sd = sign_height*sin(slope);
    hull() {
        translate([-sw,   0, half_thickness])      sphere(d=thickness);
        translate([ sw,   0, half_thickness])      sphere(d=thickness);
        translate([-sw,  sd, half_thickness+sh]) sphere(d=thickness);
        translate([ sw,  sd, half_thickness+sh]) sphere(d=thickness);
        translate([-sw, -sd, half_thickness+sh]) sphere(d=thickness);
        translate([ sw, -sd, half_thickness+sh]) sphere(d=thickness);
    }
    translate([0, -text_pos*sd, text_pos*sh]) rotate([90-slope, 180, 0]) linear_extrude(text_thickness) text(front_text, font="Helvetica;style=bold", size=text_size, halign="center", valign="center");
    translate([0,  text_pos*sd, text_pos*sh]) rotate([90-slope, 180, 180]) linear_extrude(text_thickness) text(back_text, font="Helvetica;style=bold", size=text_size, halign="center", valign="center");
}

module cleanliness() {
    handle();
    translate([0, 0, handle_height+half_thickness]) sign();
}

cleanliness();
