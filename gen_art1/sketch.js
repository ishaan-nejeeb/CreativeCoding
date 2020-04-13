let w = [];
const num = 170;

var palette = [];

function setup() {
	frameRate(20);
	let cnvs = createCanvas(900, 900);
	cnvs.parent('animationCanvas');
	background(30,30,40);

	//palette[0] = color(154, 202, 62);
	palette[0] = color(151, 71, 140);
  palette[1] = color(212, 42, 41);
	palette[2] = color(252, 50, 100);
	palette[3] = color(74, 184, 219);
	palette[4] = color(255, 140, 231);
	//palette[6] = color(193, 115, 15);

	for (let x = 0; x < num; x++){
		let ranCol = floor(random(palette.length));
		w[x] = new Walker(palette[ranCol]);
	}
}

function draw() {
for (let x = 0; x < num; x++){
		w[x].update();
		w[x].display();
	}
	background(30,30,40,15);
	//console.log(w);

	//let ranCol = floor(random(palette.length));
	//console.log(palette[ranCol]);
}
