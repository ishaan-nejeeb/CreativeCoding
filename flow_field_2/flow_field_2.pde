int drawLength = 250;
float noiseScale = 0.05;
int resolution = 20;
int strokeLength = 40;
int layers = 1;


int frame;


void setup() {
    size(1000, 1000);
    background(255);
    load();

}


void draw() {
    for (int l = 0; l < layers; ++l) {

    frame = 0;

        if (frame > drawLength) {
        return;
    }

    int count = int(map(frame, 0, drawLength, 2, 80));

    for (int i = 0; i < count; ++i) {
        int x = int(random(width / resolution));
        int y = int(random(height / resolution));

        int index = (y * width / resolution) + x;

        stroke(0,5);

        int sw = int(map(frame, 0, drawLength, 25, 0));
        strokeWeight(sw);

        push();
        translate(x * resolution, y * resolution);

        float n = noise(x * noiseScale, y * noiseScale);
        rotate(radians(map(n, 0, 1, -180, 180)));

        float lengthVariation = random(0.5, 1.75);
        line(0, 0, strokeLength * lengthVariation, 0);

        //stroke(random(255), random(255), random(255), random(100));
        strokeWeight(sw * 0.8);
        line(0, -sw * 0.15, strokeLength * lengthVariation, -sw * 0.15);
        pop();
    }

    frame++;
    }
}

void load() {
    //background(255);

    frame = 0;

}