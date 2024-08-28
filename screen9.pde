void screen9(PGraphics pg) {

  //second screen for different settings
  //fill(171);
  stroke(screensLineStroke);
  strokeWeight(screensLineStrokeWeight);
  rect(26*width/35,0,(9*width)/35, height);
  
  
  rect(26*width/35,0,(9*width)/35, height/3);
  rect(26*width/35,height/3,(9*width)/35,height/3);
  rect(26*width/35,(2*height)/3,(9*width)/35,height/3);
  
  
  pg.beginDraw();
  pg.background(255,255,255);
  
  //pg.rect(-width/12.19,mouseY,width/15, height/17.65); 
  
  pg.translate(width/4.95,-height/5.06);
  dataDisplacement(pg,"Блок 1",w1.useful,w2.useful);
  pg.translate(-width/4.95,height/5.06);
  
  pg.translate(width/4.95,height/7.13);
  dataDisplacement(pg,"Блок 2",w3.useful,w4.useful);
  pg.translate(-width/4.95,-height/7.13);
  
   
  pg.translate(width/4.95,height/2.08);
  dataDisplacement(pg,"Блок 3",w5.useful,w6.useful);
  pg.translate(-width/4.95,-height/2.08);
  

  pg.endDraw();
  image(pg,26*width/35,0,(9*width)/35, height);
}
