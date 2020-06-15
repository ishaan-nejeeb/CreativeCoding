FlowField flowfield;
Dipole pole;
ArrayList<Particle> particles;
PVector l;

//boolean debug = true;

void setup() {
  size(800, 800);

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


void draw() {
  //flowfield.update();
  
  //if (debug)
  //flowfield.display();
  pole.display();
  
//   for (Particle p : particles) {
//     p.follow(flowfield);
//     p.run();
//   }
}