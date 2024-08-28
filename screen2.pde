void screen2(PGraphics pg) {

  //second screen for different settings
  //fill(0);
  stroke(screensLineStroke);
  strokeWeight(screensLineStrokeWeight);
  rect(width/7,0, (3*width)/5, height/7); 
  pg.beginDraw();
  //pg2.background(title);
  pg.background(255,255,255);
  
  //logo
   pg.image(logo,width/7.89,-height/103,width/2.85,width/10); //add image
 
 
  pg.endDraw();
  image(pg, width/7,0, (3*width)/5, height/7);
}
