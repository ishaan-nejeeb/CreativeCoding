public class Dipole{
    PVector location;
    PVector[] vectors;
    int scl;
    int cols, rows;


    Dipole(PVector loc, int res){
        location = loc;
        scl = res;
        cols = floor(width/res) + 1;
        rows = floor(height/res) + 1;
        vectors = new PVector[cols*rows];

    }

    void update(){
        for (int y = 0; y < rows; y++) {
            for (int x = 0; x < cols; x++) {
                int index = x + y * cols;
                PVector t = new PVector(1, 0);

                PVector temp = new PVector(x * scl + scl / 2, y * scl + scl / 2);
                float dist = PVector.dist(location, temp);
                float force = 3600 / (dist * dist);
                PVector ab = new PVector(location.x - (x * scl + scl / 2), location.y - (y * scl + scl / 2));
                ab.normalize();
                ab.mult(force);
                ab.add(t);
                float ang = PVector.angleBetween(temp, location);
                PVector v = PVector.fromAngle(ang);
                v.mult(force);
                
                vectors[index] = ab;
    
            }
        }
    }

    void display(){

        ellipse(location.x - scl / 2, location.y - scl / 2, scl, scl);

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
