class Walker {
  constructor(clr){
    this.clr = clr;
    this.x = random(width);
    this.y = random(height);
    this.pos = createVector(this.x,this.y);
    this.prev = this.pos.copy();
  }

  display(){
    strokeWeight(1);
    stroke(255);
    stroke(this.clr);
    let constrainX=constrain(this.pos.x,0,500);
    let constrainY=constrain(this.pos.y,0,500);
    //console.log(constrainX);
    //console.log(constrainY);

    //point(this.pos.x,this.pos.y);
    if((this.prev.x>=0&&this.pos.x==width)||
    (this.prev.x<=width&&this.pos.x==0)||
    (this.prev.y>=+0&&this.pos.y==height)||
    (this.prev.y<=height&&this.pos.y==0)){
      point(this.pos.x, this.pos.y);
    }else{
      line(this.prev.x, this.prev.y, this.pos.x, this.pos.y);
    }
    this.prev.set(this.pos);
  }

  update(){
    this.step = createVector(floor(random(3)-1),floor(random(3)-1));
    //console.log(this.step);
    this.step = this.step.mult(30);
    //console.log(this.step);
    //this.step.sub(1,1);
    //console.log(this.step);
    //this.step.x=floor(this.step.x);
    //this.step.y=floor(this.step.y);
    //console.log(this.step);

    this.pos.add(this.step);
    //console.log(this.pos);

    if(this.pos.x<0){
      this.pos.x=width;
    }else if(this.pos.x>width){
      this.pos.x=0;
    }else if(this.pos.y<0){
      this.pos.y=height;
    }else if(this.pos.y>height){
      this.pos.x=0;
    }


  }
}
