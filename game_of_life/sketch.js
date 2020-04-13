 let grid;
let cols;
let rows;
let resolution = 10;

function setup() {
	createCanvas(1000,1000);
	cols = width/resolution;
	rows = height/resolution;
	grid = make2DArray(cols, rows);
	for (let i = 0; i < cols; i++){
		for (let j = 0; j < rows; j++){
			grid[i][j] = floor(random(2));
		}
	}

}

function draw() {
	background(0);

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

}

function make2DArray(col, row){
	let arr = new Array(col);
	for (let i = 0; i < arr.length; i++){
		arr[i] = new Array(row);
	}
	return arr;
}

function render(){
	for (let i = 0; i < cols; i++){
		for (let j = 0; j < rows; j++){
			let x = i*resolution;
			let y = j*resolution;
			if (grid[i][j] == 1){
				fill(255);
				stroke(0);
				rect(x,y,resolution-1,resolution-1);
			}//else{
			// 	fill(0);
			// 	rect(x,y,resolution-1,resolution-1);
			// }
		}
	}
}

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
