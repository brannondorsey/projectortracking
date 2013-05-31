import processing.video.*;
import java.awt.AWTException;
import java.awt.Robot;

Robot robot;
Capture video;
ColorTracking cTrack;
Registration reg;
ConversionHandler conHand;

void setup(){
  size(640, 480);
  smooth();
  String[] cameras = video.list();
  video = new Capture(this, cameras[15]);
  cTrack = new ColorTracking(video);
  reg = new Registration();
  conHand = new ConversionHandler();
  try { 
    robot = new Robot();
  } 
  catch (AWTException e) {
    e.printStackTrace();
  }
  reg.boxFlash(true);
}

void draw(){
  background(255);
  cTrack.track();
  if(cTrack.foundColor() && cTrack.videoDisplaying) cTrack.displayPointer();
  if(reg.dragging) reg.calcBox(mouseX, mouseY);
  if(cTrack.videoDisplaying) reg.displayBox();
  conHand.calcTrackValues(displayWidth, displayHeight);
  if(conHand.isInsideRegBox(cTrack.closestX, cTrack.closestY) &&
     !cTrack.videoDisplaying){
    fill(170);
    int s = 40;
    ellipse(conHand.trackValConverted.x, conHand.trackValConverted.y, s, s);
    robot.mouseMove(int(conHand.trackValConverted.x), int(conHand.trackValConverted.y));
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
