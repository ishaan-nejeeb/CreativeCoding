import processing.svg.*;
import processing.pdf.*;



int drawLength = 150;
float noiseScale = 0.03;
int resolution = 20;
int strokeLength = 25;
int layers = 8;
float zInc = 0.0000;
float zNoiseScale = 0;
PVector[] poles;
int numPoles = 10;

int frame = 0;
int l = 0;

//--------------------------------------------------
//colors
int minH = 359;
int maxH = 360;
int minS = 0;
int maxS = 1;
int minL = 0;
int maxL = 10;
//--------------------------------------------------
void mouseClicked() {
    saveFrame("19.png");
}

boolean record;


void setup() {
    size(1000, 1000);
    background(255);
    int prev = 0;
    //load();
    poles = new PVector[numPoles];
    for (int i = 0; i < numPoles; ++i) {
        int x, y, z;
        z = ((i % 2) == 1) ? 1 : -1;
        y = ((i % 2) == 1) ? prev + 10 : int(random(height));
        x = int(random(width));
        PVector temp = new PVector(x, y, z);
        poles[i] = temp;
        prev = int(poles[i].y);
    }

    //poles[0] = new PVector(500, 500, 1);
    //poles[1] = new PVector(500, 510, -1);
    //colorMode(HSB, 360, 100, 100);

    //beginRecord(SVG, "1.svg");
    //beginRecord(PDF, "1.pdf");
    

}


void draw() {

    // if (l == layers){
    //     beginRecord(SVG, "frame-####.svg");    
    // }

    if (l > layers) {
        //endRecord();
        return;
        //exit();colorMode(HSB, 360, 100, 100);
    }
    colorMode(HSB, 360, 100, 100);
    frame = 0;
    zNoiseScale = 0;

    while (frame <= drawLength) {
        int count = int(map(frame, 0, drawLength, 2, 80));

        for (int i = 0; i < count; ++i) {
            push();
            translate(50,50);
            int x = int(random(900));
            int y = int(random(900));

            int resX = floor(x / resolution);;
            int resY = floor(y / resolution);;

            int index = (resY * 900 / resolution) + resX;

            //stroke(280, 100, 14, 5);

            int sw = int(map(frame, 0, drawLength, 8, 6));
            strokeWeight(sw);

            push();
            translate(x, y);

            float n = noise(resX * noiseScale, resY * noiseScale, zNoiseScale);
            float totalAngle = dipole(n, x, y);
            rotate(radians(map(n, 0, 1, -180, 180)));
            //rotate(totalAngle);

            stroke(setColor(n), int(random(minS, maxS)), int(random(minL, maxL)), 255);

            float lengthVariation = random(0.8, 1.20);
            line(0, 0, strokeLength * lengthVariation, 0);

            //stroke(random(255), random(255), random(255), random(100));
            strokeWeight(sw * 0.8);
            line(0, -sw * 0.15, strokeLength * lengthVariation, -sw * 0.15);
            pop();
            pop();
        }

        frame++;
        zNoiseScale += zInc;
    }
    // if (l == layers) {
    //     endRecord();
    // }
    l++;
    
}

void load() {
    //background(255);

    frame = 0;
    l = 0;
    zNoiseScale = 0;

}

int setColor(float n){

    //return int(map(n, 0, 1, minH, maxH));
    int col =  int(map(n, 0, 1, minH, maxH));
    col = col > 360 ? col % 360 : col;
    return col;

}


float dipole(float noise, int x, int y){
    PVector loc = new PVector(x, y);
    PVector toPole = new PVector(0, 0);
    float distance;
    float force;
    PVector noiseForce;
    PVector totalForce = new PVector(0, 0);
    float minForce = 0.25;

    float angle1 = radians(map(noise, 0, 1, -180, 180));
    noiseForce = PVector.fromAngle(angle1);
    noiseForce.setMag(noise);

    totalForce.add(noiseForce);

    for (int i = 0; i < numPoles; i++) {
        toPole.x = 0;
        toPole.y = 0;

        distance = PVector.dist(loc, poles[i]);
        force = 62500 / (distance * distance);

        if (force < minForce) {
            force = 0;
            toPole.mult(0);
        }
        if (force != 0) {
            //force = map(force, minForce, 3600, 0, 1);   
            if (poles[i].z == 1){
                toPole = PVector.sub(poles[i], loc);
            } else {
                toPole = PVector.sub(loc, poles[i]);
            }
            
            toPole.setMag(force); 
            //toPole.mult(poles[i].z);
        }

        

        totalForce.add(toPole);

    }

    //float finalAngle = totalForce.heading();//radians(map(totalForce.heading(), 0, numPoles + 1, -180, 180));
    //return finalAngle;     
    //print(totalForce.heading());
    return totalForce.heading();   
    //return toPole.heading();
}



// void keyPressed() {
//   if (key == 'q') {
//     endRecord();
//     exit();
//     //record = true;
//   }
// }