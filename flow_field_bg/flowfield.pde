public class FlowField{
    PVector[] vectors;
    int cols, rows;
    float xinc = 0.05;
    float yinc = 0.05;
    float zoff = 0;
    float angle;
    int scl;

    FlowField(int res){
        scl = res;
        cols = floor(width/res) + 1;
        rows = floor(height/res) + 1;
        vectors = new PVector[cols*rows];
    }

    void update(){
        float yoff = 0;
        for (int y = 0; y < rows; y++) {
            float xoff = 0;
            for (int x = 0; x < cols; x++) {
                angle = noise(xoff, yoff, zoff) * TWO_PI * 4;
                PVector v =PVector.fromAngle(angle);
                v.setMag(1);
                int index = x + y * cols;
                vectors[index] = v;

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

                stroke(255);
                strokeWeight(1);
                pushMatrix();
                translate(x * scl, y * scl);
                //fill(map(angle,0,2*TWO_PI,0,255));
                //rect(0, 0, scl, scl);
                rotate(v.heading());
                line(0, 0, scl, 0);
                popMatrix();
            }
        }
    }
}