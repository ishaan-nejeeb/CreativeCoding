public class FlowField{
    PVector[] vectors;
    int cols, rows;
    float xinc = 0.05;
    float yinc = 0.05;
    float zoff = 0;
    float angle;
    float[] perlinNoise;
    int scl;

    FlowField(int res){
        scl = res;
        cols = floor(width/res) + 1;
        rows = floor(height/res) + 1;
        vectors = new PVector[cols*rows];
        perlinNoise = new float[cols*rows];
    }

    void update(){
        float yoff = 0;
        for (int y = 0; y < rows; y++) {
            float xoff = 0;
            for (int x = 0; x < cols; x++) {
                float tempNoise = noise(xoff, yoff, zoff);
                angle = tempNoise * TWO_PI * 4;
                PVector v =PVector.fromAngle(angle);
                //v.setMag(v.mag() * 1);
                //v.setMag(1);
                int index = x + y * cols;
                vectors[index] = v;
                perlinNoise[index] = tempNoise;

                xoff += xinc;  
            }
            yoff += yinc;
        }
        //zoff += 0.004;
    }

    void display(){
        for (int y = 0; y < rows; y++) {
            for (int x = 0; x < cols; x++) {
                int index = x + y * cols;
                PVector v = vectors[index];

                stroke(0);
                strokeWeight(0);
                pushMatrix();
                translate(x * scl, y * scl);
                //fill(map(angle,0,2*TWO_PI,0,255));
                //rect(0, 0, scl, scl);
                rotate(v.heading());
                //line(0, 0, map(perlinNoise[index], min(perlinNoise), max(perlinNoise), 0, scl), 0);
                line(0, 0, v.mag() * 50, 0);
                popMatrix();
            }
        }
    }
}