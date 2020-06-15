public class FlowField{
    PVector[] vectors;
    int cols, rows;
    float xinc = 0.05;
    float yinc = 0.05;
    float zoff = 0;
    float angle;
    int[] hue;
    float[] perlinNoise;
    int scl;

    FlowField(int res){
        scl = res;
        cols = floor(width/res) + 1;
        rows = floor(height/res) + 1;
        vectors = new PVector[cols*rows];
        hue = new int[cols*rows];
        perlinNoise = new float[cols*rows];
    }

    void update(){
        float yoff = 0;
        for (int y = 0; y < rows; y++) {
            float xoff = 0;
            for (int x = 0; x < cols; x++) {
                int index = x + y * cols;
                perlinNoise[index] = noise(xoff, yoff, zoff);
                //int thue = int(map(perlinNoise, 0, 1, 0, 255));
                angle = perlinNoise[index] * TWO_PI * 4;
                PVector v =PVector.fromAngle(angle);
                v.setMag(1);
                
                vectors[index] = v;

                //hue[index] = thue;
                xoff += xinc;  
            }
            yoff += yinc;
        }
        //zoff += 0.004;
;
        for (int y = 0; y < rows; y++) {
            for (int x = 0; x < cols; x++) {
                int index = x + y * cols;
                int thue = int(map(perlinNoise[index], min(perlinNoise), max(perlinNoise), 0, 255));
                

                hue[index] = thue;
            }
        }
    }

    void display(){
        for (int y = 0; y < rows; y++) {
            for (int x = 0; x < cols; x++) {
                int index = x + y * cols;
                PVector v = vectors[index];


                colorMode(HSB, 255);
                //stroke(hue[index], 100, 100);
                fill(hue[index], 255, 255);
                strokeWeight(0);
                pushMatrix();
                translate(x * scl, y * scl);
                //fill(map(angle,0,2*TWO_PI,0,255));
                rect(0, 0, scl, scl);
                rotate(v.heading());
                stroke(0,0,0);
                line(0, 0, scl, 0);
                popMatrix();
            }
        }
    }
}