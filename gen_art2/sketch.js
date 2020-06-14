//capturer

let vidLength = 600;
//let frameTillNow;
let canvas;
//var startMillis;

//Variables

let w = [];
const num = 600;
const xOffset = 1.5;
const yOffset = 20;

var palette = [];

function setup() {
	frameRate(30);
	let cnvs = createCanvas(900, 900);
	cnvs.parent('animationCanvas');
	background(30,30,40);
	canvas = cnvs.canvas;

	//palette[0] = color(154, 202, 62);
	palette[0] = color(151, 71, 140);
  palette[1] = color(212, 42, 41);
	palette[2] = color(252, 50, 100);
	palette[3] = color(74, 184, 219);
	palette[4] = color(255, 140, 231);
	palette[5] = color(193, 115, 15);
	// palette[0] = color(151, 71, 140);
  // palette[1] = color(212, 42, 41);
	// palette[2] = color(252, 50, 100);
	// palette[3] = color(74, 184, 219);
	// palette[4] = color(255, 140, 231);
	// palette[5] = color(193, 115, 15);

	// for (let x = 0; x < num; x++){
	// 	let ranCol = floor(random(palette.length));
	// 	w[x] = new Walker(palette[ranCol]);
	// 	w[x].update();
	// }

	for(let x = 0; x < palette.length; x++){
		let posX = random(width);
		let posY = random(height);
		for(let y = 0; y < (num/(palette.length)); y++){
			w[((x*(num/palette.length))+y)] = new Walker(posX+(random(xOffset)-(xOffset/2)), posY+(random(yOffset)-(yOffset/2)), palette[x]);
			w[((x*(num/palette.length))+y)].update();
		}
	}

	capturer.start();
}

function draw() {
for (let x = 0; x < num; x++){
		w[x].update();
		w[x].display();
	}
	background(30,30,40,5);
	//console.log(w);

	//let ranCol = floor(random(palette.length));
	//console.log(palette[ranCol]);
	//capturer
	if (frameCount < vidLength){
    capturer.capture(canvas);
  }else if(frameCount == vidLength){
    capturer.stop();
    capturer.save();
  }
}
