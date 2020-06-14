FlowField flowfield;
ArrayList<Particle> particles;

//boolean debug = true;

void setup() {
  size(800, 800);
  
  flowfield = new FlowField(20);
  flowfield.update();

//   particles = new ArrayList<Particle>();
//   for (int i = 0; i < 1000; i++) {
//     PVector start = new PVector(random(width), random(height));
//     particles.add(new Particle(start, random(2, 8)));
//   }
  background(0);
}

void draw() {
  flowfield.update();
  
  //if (debug)
  flowfield.display();
  
//   for (Particle p : particles) {
//     p.follow(flowfield);
//     p.run();
//   }
}