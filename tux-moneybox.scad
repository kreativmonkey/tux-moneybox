// Tux-Spardose
// Forked from runeman.org/3d/tux
// Modified by Kreativmonkey 04.2018
// 
// Licence: GPLv3



/////////////////////////////////////////////////////////////////////////
////////////////// VARIABLES ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

///// Render
// lock
// tux
// moneybox minimum hight 200mm
// dev
renderer = "moneybox";

// Dimention in mm
// For moneybox the minimal hight is:
// euro = 150mm
// dollar = 170mm
// sterling = 190mm
hight=200;
wall=5;

// currency for the coinhole
// Options:
// - euro
// - dollar
// - pfund (without Ten Pounds)
currency="euro";

// Numb of Fragments
// Set $fn to ~100 for rendering the print objekt
$fn=50;

//////////////////////////////////////////////////////////////////////////
////////////////// RENDERS ///////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

if (renderer == "lock") {
    translate([0,0, hight*0.06]) rotate([180,0,0]) lock(hight);
}

if (renderer == "tux") {
    difference(){
        tux(hight);   
    }
}

if ( renderer == "moneybox") {
    difference(){
        tux(hight, true);
        
        cutLock(hight);
        coinhole(hight, currency);
    }
}

if (renderer == "dev"){
    difference(){
            
        tux(hight, true);
        
        cutLock(hight);
        coinhole(hight, currency);
        
        translate([-hight/2, 0, 0]) cube(hight);

    }
    
}

////////////////////////////////////////////////////////////////////////
/////////////////// MODULES ////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

module lock(size){
    translate([0,0,size*0.05]) cube([size*0.4, size*0.05, size*0.02], center=true);
    difference(){
        union(){
            // body
            translate([0, 0, size*0.01]) cylinder(r=size*0.18, h=size*0.05);
            // bottom
            cylinder(r1=size*0.21, r2=size*0.18 , h=size*0.015);
        }
        cylinder(r1=size*0.16, r2=size*0.14 , h=size*0.02);
    }
    translate([0,0,size*0.022/2]) cube([size*0.322, size*0.032, size*0.022], center=true);
}

module coinhole(size, currency = "euro") {
    // Dimension Dollar "Half Dollar": r=30.61mm h=2.15mm 
    // Dimension Euro "2 Euro": r=25.75mm h=2.2mm
    // Dimension Sterling "Ten pounds": r=65mm h=2.5mm
    
    if( currency == "euro" ) {
        if(size < 170) echo("The minimal hight is 150mm");
        translate([0,size*0.05,size*0.95]) rotate([0,0,90]) cube([3, 30, size*0.3], center=true);
        translate([0, 0, size*0.60]) cylinder(d=35, h=size*0.18);
    }
    
    if( currency == "dollar" ) {
        if(size < 170) echo("The minimal hight is 170mm");
        translate([0,size*0.05,size*0.95]) rotate([0,0,90]) cube([3, 35, size*0.3], center=true);
        translate([0, 0, size*0.60]) cylinder(d=40, h=size*0.18);
    }
    
    if( currency == "sterling" ) {
        if(size < 190) echo("The minimal hight is 190mm");
        translate([0,size*0.05,size*0.95]) rotate([0,0,90]) cube([4, 43, size*0.3], center=true);
        translate([0, 0, size*0.60]) cylinder(d=45, h=size*0.18);
    }
    
    
 
}

module cutLock(size){
    translate([0,0,size*0.04]) cylinder(r=size*0.21, h=size*0.022);
    // Verschluss mit aussparungen.
    lock(size*1.01);
    translate([0, 0, size*0.02]) cube([size*0.06, size*0.41, size*0.07], center=true);
    translate([0, 0, size*0.04]) cube([size*0.41, size*0.06, size*0.006], center=true);
    cylinder(r=size*0.18, h=size*0.025);
}

module tux(size, inside = false){
    difference(){
        union(){
            arm(size, "right");
            arm(size, "left");
            foot(size, "right");
            foot(size, "left");
        }
        if( inside == true ){ 
            body(size, wall);
            arm(size, "right", wall);
            arm(size, "left", wall);
            foot(size, "right", wall);
            foot(size, "left", wall);
        }    
        translate([0,0,-size*0.7]) cube([size*1.4,size*1.4,size*1.4], center=true);

    }
    difference(){
            union(){
                body(size);
                head(size);
            }
            if( inside == true ){
                body(size, wall+5);
                head(size, wall+5);
            }
            translate([0,0,-size*0.7]) cube([size*1.4,size*1.4,size*1.4], center=true);
        }
        
    // Botton
    resize(newsize=[size*0.5,size*0.5,0])
        cylinder(r2=size*0.14, r1=size*0.13, h=size*0.06);
}

module head(size, wthikness = 0){
    
   if( wthikness == 0){
   difference(){
        union(){
            // HEAD
            translate([0,size*0.01,size*0.82])
            rotate([size*0.30,0,0])
            resize(newsize=[size*0.36-wthikness,size*0.34-wthikness,size*0.34-wthikness])
            sphere(size*0.16-wthikness);
        }
            
        // Eyeholes 
        translate([-size*0.07,-size*0.19+wthikness,size*0.85]) rotate([80,-5,-10]) resize(newsize=[size*0.1, size*0.15, size*0.12]) cylinder(r=size*0.12, h=size*0.01, center=true);
        translate([size*0.07,-size*0.19+wthikness,size*0.85]) rotate([80,5,10]) resize(newsize=[size*0.1, size*0.15, size*0.12]) cylinder(r=size*0.12, h=size*0.01, center=true); 
        translate([0,-size*0.155+wthikness,size*0.85]) rotate([-10,0,0]) resize(newsize=[size*0.15, size*0.02,size*0.15])sphere(size*0.02);
    }
    } else {
      difference(){
        union(){
            // HEAD
            translate([0,size*0.01,size*0.82])
            rotate([size*0.30,0,0])
            resize(newsize=[size*0.36-wthikness,size*0.34-wthikness,size*0.34-wthikness])
            sphere(size*0.16-wthikness);
        }
        
        translate([0,-size*0.135,size*0.85]) rotate([-10,0,0]) cube([size*0.25, size*0.05, size*0.25], center=true);
    
      }  
    }
    
    
    // Pupills
    translate([size*0.05,-size*0.13,size*0.83])
    rotate([0,7,0])
    resize(newsize=[size*0.075-wthikness, size*0.044-wthikness, size*0.1-wthikness])
    sphere(3);
    
    translate([-size*0.05,-size*0.13,size*0.83])
    rotate([0,-7,0])
    resize(newsize=[size*0.075-wthikness, size*0.044-wthikness, size*0.1-wthikness])
    sphere(3);
    
    // beak
    if(wthikness ==0){
        hull(){
            // tip
            translate([0,-size*0.22,size*0.74])
            resize(newsize=[size*0.11-wthikness,size*0.15-wthikness,size*0.044-wthikness])
            sphere(size*0.02);
            //chin
            translate([0,-size*0.05,size*0.73])
            resize(newsize=[size*0.25-wthikness,size*0.03-wthikness,size*0.22-wthikness])
            sphere(size*0.02);
            //nose
            translate([0,-size*0.10,size*0.77])
            rotate([5,0,0])
            resize(newsize=[size*0.01-wthikness,size*0.22-wthikness,size*0.044-wthikness])
            sphere(size*0.02);
        }
    }
}

// BODY
module body(size, wthikness = 0){    
    // body
    difference(){
        hull(){
            translate([0,0,size*0.15])
            resize(newsize=[size*0.60-wthikness,size*0.52-wthikness,size*0.60-wthikness])
            sphere((size*0.60+wthikness)/2, center=true);
            //neck
            translate([0,size*0.015,size*0.60])
            sphere(size*0.17-wthikness/2);
            //back top
            translate([0,size*0.11,size*0.52])
            rotate([size*0.20,0,0])
            resize(newsize=[size*0.34-wthikness,size*0.22-wthikness,size*0.40-wthikness])
            sphere(2);
            //back bottom
            translate([0,size*0.22,size*0.30])
            rotate([size*0.10,0,0])
            resize(newsize=[size*0.22-wthikness,size*0.11-wthikness,size*0.44-wthikness])
            sphere(size*0.02);
        }
        translate([0,0,-size*0.35+wthikness])
            cube([size*1.40-wthikness,size*1.40-wthikness,size*0.70-wthikness], center=true);
    }
        
    //tail
    if( wthikness == 0){
        translate([0,size*0.24,size*0.09])
            sphere(size*0.09);    
    }    
}

// ARMS
module arm(size, side, wthikness = 0){    
    if(side == "right"){
        hull(){
            translate([-size*0.21,0,size*0.45])
            rotate([-20,110,0])
            resize(newsize=[size*0.30-wthikness,size*0.22-wthikness,size*0.15-wthikness])
            sphere(2);
            translate([-size*0.19,-size*0.15,size*0.30])
            rotate([60,70,100])
            resize(newsize=[size*0.22-wthikness,size*0.30-wthikness,size*0.10-wthikness])
            sphere(2);
        }
    }

    if(side == "left"){
        // left arm
            hull(){
                translate([size*0.21,0,size*0.45])
                rotate([20,70,0])
                resize(newsize=[size*0.30-wthikness,size*0.22-wthikness,size*0.15-wthikness])
                sphere(2);
                translate([size*0.27,-size*0.22,size*0.30])
                rotate([80,20,30])
                resize(newsize=[size*0.15-wthikness,size*0.25-wthikness,size*0.10-wthikness])
                sphere(2);
            }
    }
}

// FOOT
module foot(size, side="none", wthikness = 0){
   
    if(side == "right"){
        translate([-size*0.20,-size*0.25,size*0.074]) rotate([85,30,140]) complete();
    }
    // left foot
    if(side == "left"){
        translate([size*0.20,-size*0.25,size*0.074]) rotate([85,-30,220]) complete();
    }
    
    if(side == "none"){
        complete();
    }
    
    module complete(){
    
        hull(){
            union(){
                translate([0,-1.8,size*0.074])
                sphere(size*0.074-wthikness);
            }
            finger();
        }
        rotate([0,0,30]) finger();
        rotate([0,0,-30]) finger();
    }
    
    module finger(){
        hull(){
            resize(newsize=[size*0.15-wthikness,size*0.15-wthikness,size*0.074-wthikness])
            sphere(2);
            translate([0,size*0.20,0])
            resize(newsize=[size*0.18-wthikness,size*0.22-wthikness,size*0.074-wthikness])
            sphere(2);
        }
    }
}
