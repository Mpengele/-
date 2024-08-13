void screen8(PGraphics pg) {

  //second screen for different settings
  //fill(171);
  stroke(screensLineStroke);
  strokeWeight(screensLineStrokeWeight);
  rect((31*width)/70,(5*height)/7,(3*width)/10,(2*height)/7);
  pg.beginDraw();

  pg.background(255,255,255);
  
  //********************* Red or  bleu sphere  to show  the  motion *********************
  //*************************************************************************************
 pg.translate(width/4.33, height/6.96);    
 
 if (Isrunning1 && turnStab1){
    pg.noStroke();
    pg.fill(0,255,0);
    pg.sphere(15);
    lightLeft = 0; 
  } 
   else {  
    pg.noStroke();
    pg.fill(255,0,0);
    pg.sphere(15);

  }
  pg.translate( -width/4.33,-height/6.96);
   

  pg.translate(width/500,-height/4.68);
  tempIndicator(pg,temp1);
  pg.translate(-width/500,height/4.68);
 
    
  // *************************** 3D 0bject ****************************************
  //*******************************************************************************
  pg.stroke(0);
  pg.strokeWeight(2);
  //Moving the screeen on the center
  pg.translate( width/6.72, height/7.24, -width/10);
  
  //text
  pg.fill(textColor);
  pg.textFont(f2);
  pg.textSize(width/45.45);
  pg.text("Правое Колесо Блок 3", -width/10.06, height/4.35);
 
  
  // Rotate the object
  
  pg.rotateX(radians(180)); //This is the physical axis x
  pg.rotateY(radians(90)); //This is the physical axis y
  if(turnStab1){
  pg.rotateZ(radians(speedRate1*speed3DSim1)); // this the phisical axis z
  }

  pg.fill(shape3D);
  //pg3.box(width/5, height/15.45, width/5);
  drawCylinder(pg,fillBW,36,height/6.18,width/21.42);
  

  
 
  pg.endDraw();
  image(pg,(31*width)/70,(5*height)/7,(3*width)/10,(2*height)/7);
}
