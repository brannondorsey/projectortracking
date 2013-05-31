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
  size(640, 480);
  smooth();
  reg.boxFlash(true);
}

void draw(){
  cTrack.track();
  if(cTrack.foundColor()) cTrack.displayPointer();
  if(reg.dragging) reg.calcBox(mouseX, mouseY);
  reg.displayBox();
  conHand.calcTrackValues(width, height);
  if(conHand.isInsideRegBox(cTrack.closestX, cTrack.closestY)){
    fill(255, 0, 0);
    ellipse(conHand.trackValConverted.x, conHand.trackValConverted.y, 15, 15);
  }
}

void mousePressed() {
  if(mouseButton == RIGHT){
    // Save color where the mouse is clicked in trackColor variable
    cTrack.pickColor(mouseX, mouseY);
  }
  else{
    reg.clearPts();
    reg.setRegPoint(1, mouseX, mouseY);
    reg.dragging = true;
  }
}

void mouseReleased(){
  reg.dragging = false;
}
