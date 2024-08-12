void screen8() {

  //second screen for different settings
  //fill(171);
  stroke(screensLineStroke);
  strokeWeight(screensLineStrokeWeight);
  rect((31*width)/70,(5*height)/7,(3*width)/10,(2*height)/7);
  pg8.beginDraw();

  pg8.background(255,255,255);
  
  

  
 
  pg8.endDraw();
  image(pg8,(31*width)/70,(5*height)/7,(3*width)/10,(2*height)/7);
}
