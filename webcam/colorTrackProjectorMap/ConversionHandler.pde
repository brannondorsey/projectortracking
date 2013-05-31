class ConversionHandler{
 //class to handle data translation between color tracking and registration box to generate useable values
 PVector trackValConverted;
 ConversionHandler(){
   trackValConverted = new PVector();
 }
 
 boolean isInsideRegBox(int colorTrackX, int colorTrackY){
  if(colorTrackX > reg.pt1.x &&
     colorTrackX < reg.pt2.x &&
     colorTrackY > reg.pt1.y &&
     colorTrackY < reg.pt2.y) return true;
  else return false; 
 }
 
 void calcTrackValues(int toWidth, int toHeight){
   if(isInsideRegBox(cTrack.closestX, cTrack.closestY)){
     int x = int(map(cTrack.closestX, reg.pt1.x, reg.pt2.x, 0, toWidth));
     int y = int(map(cTrack.closestY, reg.pt1.y, reg.pt2.y, 0, toHeight));
     trackValConverted.set(x, y);
     //println("the trackpoint is INSIDE of the registration box");
   }
   //else println("the trackpoint is OUTSIDE of the registration box");
 }
}
