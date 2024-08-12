void screen2() {

  //second screen for different settings
  //fill(0);
  stroke(screensLineStroke);
  strokeWeight(screensLineStrokeWeight);
  rect(width/7,0, (3*width)/5, height/7); 
  pg2.beginDraw();
  //pg2.background(title);
  pg2.background(255,255,255);
  
  //pg2.fill(textColor);
  //pg2.textFont(f3);
  //pg2.textSize(width/40);
  //pg2.text("ОРИЕНТАЦИЯ КОЛЕС В РЕАЛЬНОМ ВРЕМЕНИ", width/35.71,height/13.24, 0);
  
  //pg2.textFont(f3);
  //pg2.textSize(width/55);
  //pg2.text("(Real-time WHEELS ORIENTATION)", width/6.36, height/7.73, 0);

  
  //logo
   pg2.image(logo,width/5.71,width/500,width/2.85,width/10); //add image
   //pg2.image(logo,width/5.71,width/500,width/2.85,width/10); //add image
  

  
  pg2.endDraw();
  image(pg2, width/7,0, (3*width)/5, height/7);
}
