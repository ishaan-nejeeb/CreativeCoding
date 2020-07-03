const flock = [];

function setup() {
    createCanvas(800, 800);

    for (let i = 0; i < 100; i++) {
        flock.push(new Boid());
    }
    background(0);
}

function draw() {
    background(0);

    for (let boid of flock) {
        boid.flock(flock);
        boid.update();
        boid.show();
    }
}
