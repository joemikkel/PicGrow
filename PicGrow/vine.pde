class Vine{
  PGraphics growSpace;
  int xPos, yPos;
  int vineColor;
  int stuckCount;
  PImage bgImg;
  
  int HiDeltaX, LoDeltaX;    //these control the range of random motion of the particle
  int HiDeltaY, LoDeltaY;    //in the x and y dimension
  
  boolean isVertical = false;
  
  Vine(PGraphics growSpace, int x, int y, PImage bgImg){
    this.growSpace = growSpace;
    xPos = x;
    yPos = y;
    this.bgImg = bgImg;
    this.vineColor = bgImg.get(xPos, yPos);
    stuckCount = 0;
    if(random(-1, 1) > 0)
      isVertical = true;
      
    HiDeltaX = int(random(2, 5));
    LoDeltaX = int(random(-5, -2));
    
    HiDeltaY = int(random(2, 5));
    LoDeltaY = int(random(-5, -2));
  }
    
  boolean isSimilarColor(int otherColor){
    float redDiff = abs(red(vineColor) - red(otherColor));
    float blueDiff = abs(blue(vineColor) - blue(otherColor));
    float greenDiff = abs(green(vineColor) - blue(otherColor));
    float totalDiff = redDiff + blueDiff + greenDiff;
    if((redDiff + blueDiff + greenDiff)/3 > 80)
      return false;
    else
      return true;  
  }

  void drawVine(){
    int xTarget, yTarget;
    
    xTarget = xPos + int(random(LoDeltaX, HiDeltaX));
    yTarget = yPos + int(random(LoDeltaY, HiDeltaY));
    
    if(alpha(growSpace.get(xTarget, yTarget)) == 255){
      stuckCount++;
      return;
    }
    else{
      stuckCount--;
    }
    
    if(yTarget >= img.height || yTarget <= 0 || 
       xTarget >= img.width || xTarget <= 0)
      stuckCount = 100;
    
    if(isSimilarColor(bgImg.get(xTarget, yTarget))){
      
      growSpace.stroke(vineColor, 5);
      growSpace.strokeWeight(10);
      growSpace.line(xPos, yPos, xTarget, yTarget);
      
      growSpace.stroke(vineColor, 1);
      growSpace.strokeWeight(5);
      growSpace.line(xPos, yPos, xTarget, yTarget);

      growSpace.stroke(vineColor);
      growSpace.strokeWeight(1);
      growSpace.line(xPos, yPos, xTarget, yTarget);
      
      xPos = xTarget;
      yPos = yTarget;
    }
  }
}
