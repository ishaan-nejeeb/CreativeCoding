class Walker {
  constructor(x, y, clr){
    this.clr = clr;
    // this.noiseX = random(10)-50;
    // this.noiseY = random(100)-50;
    this.noiseX = x;
    this.noiseY = x;
    this.noiseXIncrement = 0.007;
    this.noiseYIncrement = 0.01;
    this.x = noise(this.noiseX);
    this.y = noise(this.noiseY);
    this.x = map(this.x, 0, 1, 0, width);
    this.y = map(this.y, 0, 1, 0, height);
    // this.x;
    // this.y;
    this.pos = createVector(this.x,this.y);
    // this.pos;
    this.prev = this.pos.copy();
    //this.prev;

  }

  display(){
    strokeWeight(1);
    stroke(255);
    stroke(this.clr);
    // let constrainX=constrain(this.pos.x,0,500);
    // let constrainY=constrain(this.pos.y,0,500);
    //console.log(constrainX);
    //console.log(constrainY);

    //point(this.pos.x,this.pos.y);
    //console.log(this.pos.x);
    beginShape();
    vertex(this.prev.x,this.prev.y);
    vertex(this.pos.x,this.pos.y);
    endShape();
    this.prev.set(this.pos);
  }

  update(){
    this.Xnoise = noise(this.noiseX);
    this.Ynoise = noise(this.noiseY);
    this.Xnoise = map(this.Xnoise, 0, 1, 0, width);
    this.Ynoise = map(this.Ynoise, 0, 1, 0, height);
    this.step= createVector(this.Xnoise,this.Ynoise);


    this.pos=this.step;
    //this.pos.add(this.step);
    //console.log(this.pos);

    if(this.pos.x<0){
      this.pos.x=width;
    }else if(this.pos.x>width){
      this.pos.x=0;
    }else if(this.pos.y<0){
      this.pos.y=height;
    }else if(this.pos.y>height){
      this.pos.x=0;
    }else{

    }

    this.noiseX+=this.noiseXIncrement;
    this.noiseY+=this.noiseYIncrement;


  }
}
