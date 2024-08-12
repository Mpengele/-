void screen9() {

  //second screen for different settings
  //fill(171);
  stroke(screensLineStroke);
  strokeWeight(screensLineStrokeWeight);
  rect(26*width/35,0,(9*width)/35, height);
  pg9.beginDraw();
  pg9.translate( width/2, height/4, 0);
  //pg9.background(realTimeData);
  pg9.background(255,255,255);
  
  
  //pg9.strokeWeight(strokeWeightsize);
  //pg9.strokeWeight(1);
  pg9.textFont(f3);
  pg9. textSize(width/66.66);
  pg9.fill(textColor);

  //offset used for two wheels to adjuste position oif text on the screen 7
  dtWidth = width/16.66;
  dtheight = 0.85*height/15.45;
  
  //Data zone diplay
  //offset used for left wheel to adjuste position oif text on the screen 7 
  widthWheelData = width/100;
  heightWheelData = height/9.5;
  widthPosX = width/100;
  heightPosY = height/30.9;
  dtWidth =  width/12;
  dtheight= height/11;
  widthItem =  width/13.33;
  heightItem = height/13.73;


// title in data screen
  pg9.fill(textColor);
  pg9.textFont(f3);
  pg9. textSize(width/66.66);

  
  pg9.fill(0);
  pg9.text("ЛЕВОЕ КОЛЕСО",widthPosX+dtWidth,2.5*heightPosY,widthItem,heightItem);
  pg9.text("ПРАВОЕ КОЛЕСО",widthPosX+2*dtWidth,2.5*heightPosY,widthItem,heightItem);  

  pg9.text("Угловая скорость", widthPosX, 0.85*(heightPosY+2*dtheight), widthItem, heightItem);
  if(turnStab1){  pg9.text(int(w1),widthPosX+1.2*dtWidth,0.85*(heightPosY+2*1.25*dtheight));}
  else{ pg7.text(int(0),widthPosX+1.2*dtWidth,0.85*(heightPosY+2*1.25*dtheight));}
  if(turnStab2){ pg9.text(int(w2),widthPosX+2*1.1*dtWidth,0.85*(heightPosY+2*1.25*dtheight));}
  else{pg7.text(int(0),widthPosX+2*1.1*dtWidth,0.85*(heightPosY+2*1.25*dtheight));}

  pg9.text("T° [град]", widthPosX,  0.88*(heightPosY+3*dtheight), widthItem, heightItem);
  pg9.text(int(temp1),widthPosX+1.2*dtWidth,0.95*(heightPosY+3*dtheight));
  pg9.text(int(temp2),widthPosX+2*1.1*dtWidth,0.95*(heightPosY+3*dtheight));
  
  pg9.text("Напряжение [В]", widthPosX,  0.82*(heightPosY+4*dtheight), widthItem, heightItem);
  pg9.text(batLev1,widthPosX+1.2*dtWidth,0.9*(heightPosY+4*dtheight));
  pg9.text(batLev2,widthPosX+2*1.1*dtWidth,0.9*(heightPosY+4*dtheight));
  

  
  pg9.fill(0);
  pg9.text("Биение колес", widthPosX,  heightPosY+1.2*4*dtheight, widthItem, heightItem);
  pg9.text(int(-rollLeft),widthPosX+1.2*dtWidth,heightPosY+4*1.3*dtheight);
  pg9.text(int(rollRight),widthPosX+2*1.1*dtWidth,heightPosY+4*1.3*dtheight);
  
  pg9.textFont(f2);
  pg9.text("Min", widthPosX,heightPosY+5*1.2*dtheight);
  pg9.text(int(minRollLeft),widthPosX+1.2*dtWidth,heightPosY+5*1.2*dtheight);
  pg9.text(int(minRollRight),widthPosX+2*1.1*dtWidth,heightPosY+5*1.2*dtheight);
 
  pg9.text("Max", widthPosX,heightPosY+6*1.12*dtheight);
  pg9.text(int(-maxRollLeft),widthPosX+1.2*dtWidth,heightPosY+6*1.12*dtheight);
  pg9.text(int(maxRollRight),widthPosX+2*1.1*dtWidth,heightPosY+6*1.12*dtheight);
  
  
  
 
  //rect(width/1.187,mouseY,width/8, height/17.65); // the place for the botton
  //println(mouseX,mouseY);
  
  

  pg9.endDraw();
  image(pg9,26*width/35,0,(9*width)/35, height);
}
