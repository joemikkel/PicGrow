class Vine{
  PGraphics growSpace;
  int xPos, yPos;
  int vineColor;
  int stuckCount;
  PImage bgImg;
  
  //TESTING STUFF
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
  }
    
  boolean isSimilarColor(int otherColor){
    //println("Red Vine : " + red(vineColor));
    //println("Red BG : " + red(otherColor));
    float redDiff = abs(red(vineColor) - red(otherColor));
    float blueDiff = abs(blue(vineColor) - blue(otherColor));
    float greenDiff = abs(green(vineColor) - blue(otherColor));
    float totalDiff = redDiff + blueDiff + greenDiff;
    //println("COLOR DIFFERENCE : " + totalDiff);
    if((redDiff + blueDiff + greenDiff)/3 > 80)
      return false;
    else
      return true;
      
  }

  void drawVine(){
    int xTarget, yTarget;
    
    /*
    if(!isVertical){
      xTarget = xPos + int(random(-100, 100));
      yTarget = yPos + int(random(-2, 2));
    }
    else{
      xTarget = xPos + int(random(-2, 2));
      yTarget = yPos + int(random(-100, 100));
    }
    */
    
    xTarget = xPos + int(random(-2, 2));
    yTarget = yPos + int(random(-2, 5));
    
    if(growSpace.get(xTarget, yTarget) != color(0,0,0,0)){
      stuckCount++;
      //println("StuckCount : " + stuckCount);
      return;
    }
    
    stuckCount = 0;
    
    
    if(yTarget >= img.height || yTarget <= 0 || 
       xTarget >= img.width || xTarget <= 0)
      stuckCount = 100;
    
    
    
    
    if(isSimilarColor(bgImg.get(xTarget, yTarget))){
      //println("FOUND SIMILAR COLOR!");
      xPos = xTarget;
      yPos = yTarget;
      growSpace.set(xPos, yPos, vineColor);
    }
  }
}
