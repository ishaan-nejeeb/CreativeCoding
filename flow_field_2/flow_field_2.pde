import processing.svg.*;



int drawLength = 150;
float noiseScale = 0.05;
int resolution = 20;
int strokeLength = 40;
int layers = 8;
float zInc = 0.001;
float zNoiseScale = 0;


int frame;
int l;


void setup() {
    size(1000, 1000);
    background(255);
    load();
    colorMode(HSB, 360, 100, 100);

}


void draw() {
    //for (int l = 0; l < layers; ++l) {
        if (l > layers) {
        return;
        }
        
        frame = 0;
        zNoiseScale = 0;

        while (frame <= drawLength) {
            int count = int(map(frame, 0, drawLength, 2, 80));

            for (int i = 0; i < count; ++i) {
                int x = int(random(width));
                int y = int(random(height));

                int resX = floor(x / resolution);;
                int resY = floor(y / resolution);;

                int index = (resY * width / resolution) + resX;

                //stroke(280, 100, 14, 5);

                int sw = int(map(frame, 0, drawLength, 10, 5));
                strokeWeight(sw);

                push();
                translate(x, y);

                float n = noise(resX * noiseScale, resY * noiseScale, zNoiseScale);
                rotate(radians(map(n, 0, 1, -180, 180)));

                stroke(setColor(n), int(random(90, 100)), int(random(5, 35)), 50);

                float lengthVariation = random(0.5, 1.75);
                line(0, 0, strokeLength * lengthVariation, 0);

                //stroke(random(255), random(255), random(255), random(100));
                strokeWeight(sw * 0.8);
                line(0, -sw * 0.15, strokeLength * lengthVariation, -sw * 0.15);
                pop();
            }

            frame++;
            zNoiseScale += zInc;
        }

        l++;
        
        

    //}
   //frame = 0;
}

void load() {
    //background(255);

    frame = 0;
    l = 0;
    zNoiseScale = 0;

}

int setColor(float n){

    return int(map(n, 0, 1, 100, 330));

}