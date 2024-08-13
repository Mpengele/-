void screen2(PGraphics pg) {

  //second screen for different settings
  //fill(0);
  stroke(screensLineStroke);
  strokeWeight(screensLineStrokeWeight);
  rect(width/7,0, (3*width)/5, height/7); 
  pg.beginDraw();
  //pg2.background(title);
  pg.background(255,255,255);
  
  //pg2.fill(textColor);
  //pg2.textFont(f3);
  //pg2.textSize(width/40);
  //pg2.text("ОРИЕНТАЦИЯ КОЛЕС В РЕАЛЬНОМ ВРЕМЕНИ", width/35.71,height/13.24, 0);
  
  //pg2.textFont(f3);
  //pg2.textSize(width/55);
  //pg2.text("(Real-time WHEELS ORIENTATION)", width/6.36, height/7.73, 0);

  
  //logo
   //pg.image(logo,width/5.71,width/500,width/2.85,width/10); //add image
   pg.image(logo,width/7.89,-height/103,width/2.85,width/10); //add image
   println (mouseX,mouseY);
 
  

  
  pg.endDraw();
  image(pg, width/7,0, (3*width)/5, height/7);
}
