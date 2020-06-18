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

public class flow_field_2 extends PApplet {

int drawLength = 250;
float noiseScale = 0.05f;
int resolution = 20;
int strokeLength = 40;
int layers = 1;


int frame;


public void setup() {
    
    background(255);
    load();

}


public void draw() {
    for (int l = 0; l < layers; ++l) {

    frame = 0;

        if (frame > drawLength) {
        return;
    }

    int count = PApplet.parseInt(map(frame, 0, drawLength, 2, 80));

    for (int i = 0; i < count; ++i) {
        int x = PApplet.parseInt(random(width / resolution));
        int y = PApplet.parseInt(random(height / resolution));

        int index = (y * width / resolution) + x;

        stroke(0,5);

        int sw = PApplet.parseInt(map(frame, 0, drawLength, 25, 0));
        strokeWeight(sw);

        push();
        translate(x * resolution, y * resolution);

        float n = noise(x * noiseScale, y * noiseScale);
        rotate(radians(map(n, 0, 1, -180, 180)));

        float lengthVariation = random(0.5f, 1.75f);
        line(0, 0, strokeLength * lengthVariation, 0);

        //stroke(random(255), random(255), random(255), random(100));
        strokeWeight(sw * 0.8f);
        line(0, -sw * 0.15f, strokeLength * lengthVariation, -sw * 0.15f);
        pop();
    }

    frame++;
    }
}

public void load() {
    //background(255);

    frame = 0;

}
  public void settings() {  size(1000, 1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "flow_field_2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
