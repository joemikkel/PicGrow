import java.util.*;
PImage img;
PGraphics growSpace;
ArrayList<Vine> vines;
boolean execute = false;

void setup(){
  frame.setResizable(true);
  vines = new ArrayList<Vine>();
  selectInput("Select a .jpg ",  "loadSourceImage");
} 

void loadSourceImage(File image){
  img = loadImage(image.getAbsolutePath());
  println(" IMAGE : " + img.width + "," + img.height);
  size(img.width, img.height);
  background(0);
  colorMode(RGB, 255, 255, 255, 255);
  
  img.loadPixels();
  growSpace = createGraphics(width, height);
  growSpace.beginDraw();
  growSpace.fill(0,0,0,0);
  
  frame.setSize(img.width + 18, img.height + 47);
  execute = true;
}

void draw(){

    
  if(!execute)
    return;
   
  if(vines.size() < 10)
    vines.add(new Vine(growSpace, int(random(0, width)), int(random(0, height)), img));
  
  if(mousePressed){
    for(int xBox = -5; xBox <= 5; xBox += 2)
      for(int yBox = -5; xBox < 5; xBox += 2)
        vines.add(new Vine(growSpace, mouseX + xBox , mouseY + yBox, img));
  }
  
  println(vines.size());
  processVines();
    growSpace.endDraw();
    
  image(growSpace, 0, 0);
}

void processVines(){
  ListIterator<Vine> iter = vines.listIterator();
  while(iter.hasNext()){
    Vine nextVine = iter.next();
    nextVine.drawVine();
    
    if(nextVine.stuckCount > 50){
      iter.remove();
    }
    
    if(nextVine.stuckCount < int(random(-75, -25))){
      iter.add(new Vine(growSpace, nextVine.xPos + int(random(-2, 2)), nextVine.yPos + int(random(-2, 2)), img));
      nextVine.stuckCount = 0;
    }
  } 
}
