class Boid {
    constructor() {
        this.position = createVector(random(width), random(height));
        this.velocity = p5.Vector.random2D();
        this.velocity.setMag(random(2, 5));
        this.accelecration = createVector();
        this.maxForce = 1;
    }

    align = (boids) => {
        let perceptionRadius = 50;
        let steering = createVector();
        let total = 0;
        for (let other of boids) {
            let d = p5.Vector.dist(this.position, other.position);
            if (other != this && d < perceptionRadius) {
                steering.add(other.velocity);
                total++;
            }
        }
        if (total > 0) {
            steering.div(total);
            steering.sub(this.velocity);
            steering.limit(this.maxForce);
        }
        return steering;
    };

    flock = (boids) => {
        let alignment = this.align(boids);
        this.accelecration = alignment;
    };

    update = () => {
        this.position.add(this.velocity);
        this.velocity.add(this.accelecration);
    };

    show = () => {
        strokeWeight(15);
        stroke(255);
        point(this.position.x, this.position.y);
    };
}
