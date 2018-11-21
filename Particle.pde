class Particle {
  PVector pos, vel, acc;
  float clr;
  float size, sizeE;
  float amp;
  float mass, density, volume;
  float opacity;
  float speed;
  float freq;
  Boolean death;
  Particle() {
    this.pos=new PVector(width/2, height/2);
    this.vel=new PVector();
    this.acc=new PVector();
    this.size=random(1,3);
    //this.size=random(5, 10);
    this.sizeE=this.size*random(5);
    this.mass=this.size*1000;
    this.density=random(0.1);
    this.volume=this.mass/this.density;
    this.amp=0.1;
    this.opacity=random(200, 255);
    this.speed=random(0.1);
    this.freq=random(0.05, 0.06);
    this.death=false;
    this.clr=120;
  }
  void update() {
    //this.size=map(this.pos.y, height, 0, random(2), 0);
    this.speed-=random(0.0001, 0.0002);
    this.clr+=random(-14.5, 15);
    this.freq*=1.00001;
    //this.opacity-=0.1;
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }
  void applyForce(PVector force) {
    PVector f=force.div(this.mass).mult(0.0003);
    this.acc.add(f);
  }
  void setupPos(float messageX, float messageY) {
    if (messageX == 1.0) {
      this.pos.x-=1.0;
    }else{
      this.pos.x+=1.0;
    }
    //this.pos.y=messageY;
    //this.pos.x=mouseX;
    //this.pos.y=mouseY;
  }
  void rise() {
    float densityAir=1;
    float g=9.8;
    PVector f=new PVector(0, -densityAir*this.volume*g).mult(this.speed);
    applyForce(f);
  }
  void swing() {
    this.amp+=0.5;
    this.pos.x+=sin(frameCount*this.freq)*this.amp*random(0.008, 0.009)+noise(this.pos.x, this.pos.y)*random(-100, 100)*0.05;
  }
  void display() {
    pg.pushMatrix();
    pg.translate(this.pos.x, this.pos.y);
    //pg.noFill();
    pg.fill(this.clr, random(100, 200));
    pg.noStroke();
    //pg.stroke(this.clr);
    pg.ellipse(0, 0, this.size, this.size);
    pg.rect(0, 0, this.size, this.size);
    pg.pushStyle();
    pg.noFill();
    pg.stroke(this.clr);
    pg.strokeWeight(random(0.01));
    //pg.pushMatrix();
    pg.rotate(frameCount);
    pg.line(0, 0, random(150), random(150));
    pg.strokeWeight(random(0.01));
    //pg.ellipse(0, 0, this.size*100, this.size*30);
    //pg.ellipse(0, 0, this.size*random(100), this.size*random(30));
    //pg.popMatrix();
    pg.popStyle();
    //pg.textSize(this.sizeE*random(1));
    //pg.fill(this.clr, this.opacity);
    //pg.text("Satoshi", random(-150, 150), random(-150, 150));
    pg.pushStyle();
    pg.fill(this.clr, this.opacity);
    //pg.stroke(this.clr);
    pg.noStroke();
    pg.ellipse(random(-150, 150), random(-150, 150), this.sizeE, this.sizeE*random(1));
    pg.popStyle();
    pg.popMatrix();
  }
  void checkEdge(){
    if (this.opacity<0 || this.pos.y<0 || this.pos.y>height) {
      this.pos.y=height;
    }
  }
  Boolean checkDeath() {
    if (this.opacity<0 || this.pos.y<0 || this.pos.y>0) {
      this.death=true;
    }
    return this.death;
  }
}