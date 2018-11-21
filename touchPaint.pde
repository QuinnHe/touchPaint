PGraphics pg;
PImage photo, pg2;
PImage frame;
ArrayList<Particle>particles=new ArrayList<Particle>();
float particlesN=1;

import oscP5.*;

OscP5 oscP5;
float messageX=-width;
float messageY=-height;

void setup() {
  //size(1280, 800);
  fullScreen();
  oscP5 = new OscP5(this, 1234);
  photo = loadImage("thekiss.png");
  frame = loadImage("frame.png");
  pg2=loadImage("mask.jpg");
  pg=createGraphics(1280, 800);
  pg.beginDraw();
  pg.background(0);
  pg.endDraw();
  //background(255);
  for (int i=0; i<particlesN; i++) {
    particles.add(new Particle());
  }
}

void draw() {
  background(0);
  //pushStyle();
  //fill(0);
  //rect(0, 0, width, height);
  //popStyle();
  pg.beginDraw();
  //pg.pushStyle();
  //pg.fill(0,10);
  //pg.rect(0,0,width,height);
  //pg.popStyle();
  for (int i=0; i<particles.size(); i++) {
    Particle p=particles.get(i);
    p.setupPos(messageX, messageY);
    p.rise();
    //p.swing();
    p.update();
    p.checkEdge();
    p.display();
  }
  //for (int j=particles.size()-1; j>0; j--) {
  //  Particle p=particles.get(j);
  //  if (p.checkDeath()) {
  //    particles.remove(j);
  //    particles.add(new Particle());
  //  }
  //}
  checkFinish();
  pg.endDraw();


  photo.mask(pg);
  image(photo, 0, 0);
  //image(frame, 0, 0);
}
void checkFinish() {
  int count=0;
  for (int j=0; j<height; j++) {
    for (int i=0; i<width; i++) {
      int index=i+j*width;
      if (pg.pixels[index]!=color(0)) {
        count++;
      }
    }
  }
  if (count>=width*height*0.8) {
    reset();
  }
}

void reset() {
  pg.pushStyle();
  pg.fill(0);
  pg.rect(0,0,width,height);
  pg.popStyle();
}

void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  //print("### received an osc message.");
  //print(" addrpattern: "+theOscMessage.addrPattern());
  //print(" message: "+theOscMessage.get(0).floatValue());
  //println(" typetag: "+theOscMessage.typetag());
  
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    if (theOscMessage.checkTypetag("f")) {
      float f = theOscMessage.get(0).floatValue();
      messageX = f;
      println(messageX);
    }
  }
  
  //float tempX=theOscMessage.get(0).floatValue();
  //float tempY=theOscMessage.get(1).floatValue();
  //messageX=map(tempX, 0, 640, 0, width);
  //messageY=map(tempY, 0, 480, 0, height);
}