import processing.video.*;
Capture video;
ColorTracking cTrack;
Registration reg;
ConversionHandler conHand;

void setup(){
  String[] cameras = video.list();
  video = new Capture(this, cameras[15]);
  cTrack = new ColorTracking(video);
  reg = new Registration();
  conHand = new ConversionHandler();
  size(displayWidth, displayHeight);
  smooth();
  reg.boxFlash(true);
}

void draw(){
  background(255);
  cTrack.track();
  if(cTrack.foundColor() && cTrack.videoDisplaying) cTrack.displayPointer();
  if(reg.dragging) reg.calcBox(mouseX, mouseY);
  if(cTrack.videoDisplaying) reg.displayBox();
  conHand.calcTrackValues(width, height);
  if(conHand.isInsideRegBox(cTrack.closestX, cTrack.closestY)){
    fill(170);
    int s = 40;
    ellipse(conHand.trackValConverted.x, conHand.trackValConverted.y, s, s);
  }
}

void mousePressed() {
  if(mouseButton == RIGHT){
    // Save color where the mouse is clicked in trackColor variable
    cTrack.pickColor(mouseX, mouseY);
  }
  else if(cTrack.videoDisplaying){
    reg.clearPts();
    reg.setRegPoint(1, mouseX, mouseY);
    reg.dragging = true;
  }
}

void mouseReleased(){
  if(cTrack.videoDisplaying){
    reg.dragging = false;
  }
}

void keyPressed(){
  //if alt key
  if(keyCode == 18){
    cTrack.toggleVideoDisplay();
  }
}
