import java.util.*;
PImage img;
PGraphics growSpace;
ArrayList<Vine> vines;
boolean execute = false;

void setup(){
  frame.setResizable(true);
  vines = new ArrayList<Vine>();
  selectInput("Select a .jpg ",  "loadSourceImage");
  //while(img == null);
   
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
  
  frame.setSize(img.width, img.height);
  execute = true;
}

void draw(){

    
  if(!execute)
    return;
  
  if(vines.size() < 10000)
    for(int i = 0; i < 10000 - vines.size() / 2; i ++)
      vines.add(new Vine(growSpace, int(random(0, width)), int(random(0, height)), img));
  
  if(mousePressed)
    vines.add(new Vine(growSpace, mouseX, mouseY, img));
    
  //println("GOT HERE!");
  //image(img, 0, 0);
  processVines();
    growSpace.endDraw();

  image(growSpace, 0, 0);
}

void mousePressed(){
  
}

void processVines(){
  ListIterator<Vine> iter = vines.listIterator();
  while(iter.hasNext()){
    Vine nextVine = iter.next();
    nextVine.drawVine();
    //println("StuckCount : " + iter.next().stuckCount);
    
    if(nextVine.stuckCount > 50){
      //println("Removing Stuck Vine!");
      iter.remove();
      iter.add(new Vine(growSpace, int(random(0, width)), int(random(0, height)), img));
    }
  } 
}
