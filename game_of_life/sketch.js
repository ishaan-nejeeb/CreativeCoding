//capturer

let vidLength = 600;
let canvas;
var startMillis;

//Variable setup

let grid;
let cols;
let rows;
let resolution = 5;


//Canvas setup

function setup() {
  frameRate(60);
  let cnvs = createCanvas(900, 900);
	cnvs.parent('animationCanvas');
  canvas = cnvs.canvas;


	cols = width/resolution;
	rows = height/resolution;
	grid = make2DArray(cols, rows);
	for (let i = 0; i < cols; i++){
		for (let j = 0; j < rows; j++){
			grid[i][j] = floor(random(2));
		}
	}

  //capturer.start();
}

//Main draw function
function draw() {
  //capture
  // if(startMillis == null){
  //   startMillis - millis();
  // }
  // let duration = 120000;
  // let elapsed = millis() - startMillis;
  // let t = map(elapsed,0,duration,0,1);
  //
  // if(t>1){
  //   //noLoop();
  //   console.log('finished recording');
  //   capturer.stop();
  //   capturer.save();
  // }
  //capture


	background('#081826');

	render();

	let next = make2DArray(cols,rows);

	for (let i = 0; i < cols; i++){
		for (let j = 0; j < rows; j++){
			let state = grid [i][j];

			let neighbors = countNeighbors(grid ,i,j);

			if (state == 0 && neighbors == 3) {
			 next[i][j] = 1;
		 } else if (state == 1 && (neighbors < 2 || neighbors > 3)) {
			 next[i][j] = 0;
		 } else {
			 next[i][j] = state;
		 }
		}
	}
grid = next;


  if (frameCount < vidLength){
    capturer.capture(canvas);
  }else if(frameCount == vidLength){
    capturer.stop();
    capturer.save();
  }

  // capturer.capture(canvas);
}

//Function to make 2D arary
function make2DArray(col, row){
	let arr = new Array(col);
	for (let i = 0; i < arr.length; i++){
		arr[i] = new Array(row);
	}
	return arr;
}

//Render the game of life
function render(){
	for (let i = 0; i < cols; i++){
		for (let j = 0; j < rows; j++){
			let x = i*resolution;
			let y = j*resolution;
			if (grid[i][j] == 1){
				fill('#30F2F2');
				stroke(0);
				rect(x,y,resolution-1,resolution-1);
			}//else{
				// fill('#17AEBF');
				// rect(x,y,resolution-1,resolution-1);
			//}
		}
	}
}

//Count number of activev neighbours
function countNeighbors(grid,i,j){
	let sum = 0;
	for (let x = -1; x <= 1; x++) {
		for (let y = -1; y <= 1; y++) {
			sum += grid[(x+i+cols)%cols][(y+j+rows)%rows];
		}
	}
	sum -= grid[i][j];
	return sum;
}

function mousePressed(){
  capturer.start();
}
