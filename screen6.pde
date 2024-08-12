void screen6() {

  //second screen for different settings
  //fill(171);
  stroke(screensLineStroke);
  strokeWeight(screensLineStrokeWeight);
  rect((31*width)/70, (3*height)/7,(3*width)/10,(2*height)/7);
  pg6.beginDraw();
  //pg6.background(rightWheelgraph);
  pg6.background(255,255,255);
  
  

  
 
  pg6.endDraw();
  image(pg6,(31*width)/70, (3*height)/7,(3*width)/10,(2*height)/7);
}
