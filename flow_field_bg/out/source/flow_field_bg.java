import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class flow_field_bg extends PApplet {

FlowField flowfield;
Dipole pole;
ArrayList<Particle> particles;
PVector l;

//boolean debug = true;

public void setup() {
  

  l = new PVector(400, 400);
  
  flowfield = new FlowField(20);
  flowfield.update();

  pole = new Dipole(l, 20);
  pole.update();

//   particles = new ArrayList<Particle>();
//   for (int i = 0; i < 1000; i++) {
//     PVector start = new PVector(random(width), random(height));
//     particles.add(new Particle(start, random(2, 8)));
//   }

  background(0);

//   ellipse(400, 400, 10, 10);


//   for (int y = 0; y < flowfield.rows; y++) {
//             for (int x = 0; x < flowfield.cols; x++) {
//                 int index = x + y * flowfield.cols;
//                 PVector v = flowfield.vectors[index];

//                 float dist = v.dist(pole);
//                 float force = 900 / (dist * dist);
//                 ///PVector ab = PVector.sub(pole, v);
//                 float ang = PVector.angleBetween(v, pole);
//                 PVector temp = PVector.fromAngle(ang);
//                 temp.normalize();
//                 temp.mult(force);
//                 v.add(temp);

//                 stroke(255);
//                 strokeWeight(1);
//                 pushMatrix();
//                 translate(x * flowfield.scl, y * flowfield.scl);
//                 //fill(map(angle,0,2*TWO_PI,0,255));
//                 //rect(0, 0, scl, scl);
//                 rotate(v.heading());
//                 line(0, 0, flowfield.scl, 0);
//                 popMatrix();
//             }
//         }
}


  //flowfield.display();


public void draw() {
  //flowfield.update();
  
  //if (debug)
  //flowfield.display();
  pole.display();
  
//   for (Particle p : particles) {
//     p.follow(flowfield);
//     p.run();
//   }
}
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

    public void update(){
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

    public void display(){

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
public class FlowField{
    PVector[] vectors;
    int cols, rows;
    float xinc = 0.05f;
    float yinc = 0.05f;
    float zoff = 0;
    float angle;
    int scl;

    FlowField(int res){
        scl = res;
        cols = floor(width/res) + 1;
        rows = floor(height/res) + 1;
        vectors = new PVector[cols*rows];
    }

    public void update(){
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

    public void display(){
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
public class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector previousPos;
  float maxSpeed;
   
  Particle(PVector start, float maxspeed) {
    maxSpeed = maxspeed;
    pos = start;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    previousPos = pos.copy();
  }
  public void run() {
    update();
    edges();
    show();
  }
  public void update() {
    pos.add(vel);
    vel.limit(maxSpeed);
    vel.add(acc);
    acc.mult(0);
  }
  public void applyForce(PVector force) {
    acc.add(force); 
  }
  public void show() {
    stroke(255, 5);
    strokeWeight(1);
    line(pos.x, pos.y, previousPos.x, previousPos.y);
    //point(pos.x, pos.y);
    updatePreviousPos();
  }
  public void edges() {
    if (pos.x > width) {
      pos.x = 0;
      updatePreviousPos();
    }
    if (pos.x < 0) {
      pos.x = width;    
      updatePreviousPos();
    }
    if (pos.y > height) {
      pos.y = 0;
      updatePreviousPos();
    }
    if (pos.y < 0) {
      pos.y = height;
      updatePreviousPos();
    }
  }
  public void updatePreviousPos() {
    this.previousPos.x = pos.x;
    this.previousPos.y = pos.y;
  }
  public void follow(FlowField flowfield) {
    int x = floor(pos.x / flowfield.scl);
    int y = floor(pos.y / flowfield.scl);
    int index = x + y * flowfield.cols;
    
    PVector force = flowfield.vectors[index];
    applyForce(force);
  }
}
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "flow_field_bg" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
