class Registration{
 PVector pt1;
 PVector pt2;
 color boxColor = 100; 
 int boxAlpha; //defualts to light color if flash is turned off
 int boxAlphaLight = 70;
 int boxAlphaDark = 130;
 int flashSpeed = 15;
 boolean dragging = false;
 boolean boxFlashOn = false;
 boolean isFlashLight = true;
 
 Registration(){
   pt1 = new PVector();
   pt2 = new PVector();
   boxAlpha = boxAlphaLight;
 }
 
 void calcBox(int mx, int my){
   setRegPoint(2, mx, my);
 }
 
 void setRegPoint(int regPoint, int mx, int my){
   if(regPoint == 1) pt1.set(mx, my);
   else{
     pt2.set(mx, my); 
     println("the second point was set to "+mx+", "+my);
   }
 }
 
 //turns boxFlashing on and off
 void boxFlash(boolean desiredState){
   boxFlashOn = desiredState;
 }
 
 void clearPts(){
  pt1.set(0,0); 
  pt2.set(0,0); 
 }
 
 void displayBox(){
   if(boxFlashOn && frameCount % flashSpeed == 0) toggleFlashState();
   fill(boxColor, boxAlpha);
   noStroke();
   rect(pt1.x, pt1.y, pt2.x-pt1.x, pt2.y-pt1.y);
 }
 
 void toggleFlashState(){
   if(isFlashLight){
     boxAlpha = boxAlphaDark;
     isFlashLight = false;
   }
   else{
     boxAlpha = boxAlphaLight;
     isFlashLight = true;
   }
 }
}
