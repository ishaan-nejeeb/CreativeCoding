import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.svg.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class flow_field_2 extends PApplet {





int drawLength = 150;
float noiseScale = 0.05f;
int resolution = 20;
int strokeLength = 40;
int layers = 8;
float zInc = 0.001f;
float zNoiseScale = 0;


int frame;
int l;


public void setup() {
    
    background(255);
    load();
    colorMode(HSB, 360, 100, 100);

}


public void draw() {
    //for (int l = 0; l < layers; ++l) {
        if (l > layers) {
        return;
        }
        
        frame = 0;
        zNoiseScale = 0;

        while (frame <= drawLength) {
            int count = PApplet.parseInt(map(frame, 0, drawLength, 2, 80));

            for (int i = 0; i < count; ++i) {
                int x = PApplet.parseInt(random(width));
                int y = PApplet.parseInt(random(height));

                int resX = floor(x / resolution);;
                int resY = floor(y / resolution);;

                int index = (resY * width / resolution) + resX;

                //stroke(280, 100, 14, 5);

                int sw = PApplet.parseInt(map(frame, 0, drawLength, 10, 5));
                strokeWeight(sw);

                push();
                translate(x, y);

                float n = noise(resX * noiseScale, resY * noiseScale, zNoiseScale);
                rotate(radians(map(n, 0, 1, -180, 180)));

                stroke(setColor(n), PApplet.parseInt(random(90, 100)), PApplet.parseInt(random(5, 35)), 50);

                float lengthVariation = random(0.5f, 1.75f);
                line(0, 0, strokeLength * lengthVariation, 0);

                //stroke(random(255), random(255), random(255), random(100));
                strokeWeight(sw * 0.8f);
                line(0, -sw * 0.15f, strokeLength * lengthVariation, -sw * 0.15f);
                pop();
            }

            frame++;
            zNoiseScale += zInc;
        }

        l++;
        
        

    //}
   //frame = 0;
}

public void load() {
    //background(255);

    frame = 0;
    l = 0;
    zNoiseScale = 0;

}

public int setColor(float n){

    return PApplet.parseInt(map(n, 0, 1, 100, 330));

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
