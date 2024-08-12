void screen1() {

  //second screen for different settings
  //fill(0);
  stroke(screensLineStroke);
  strokeWeight(screensLineStrokeWeight);
  rect(0,0,width/7, height);
  pg1.beginDraw();
  //pg1.background(buttons);
  pg1.background(255,255,255);




  
 
  pg1.endDraw();
  image(pg1, 0,0,width/7, height);
}

void drawWidgets() {


    //Scrollable List
  String clist[]={"COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9", "COM10", "COM11", "COM12", "COM13", "COM14", "COM15", "COM16", "COM17", "COM18", "COM19"};
  sl=cp5.addScrollableList("COM")
    .setPosition(width/37, height/3.98)
    .setSize(int (width/11.76), int(height/17.65))
    .addItems(clist)
    .setBarHeight(int(height/20.6))
    .setItemHeight(int(height/20.6))
    .setColorBackground(buttonColor)
    .setColorActive(buttonColor)
    .setFont(f2)
    .close();
  // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST

  sl.getCaptionLabel().getStyle().marginLeft = int(width/82);
  sl.getCaptionLabel().getStyle().marginTop = int(height/88.2);


  // Button
  startButton =cp5.addButton("START")
    .setValue(1)
    .setPosition(width/37, height/3.98+buttonInterline)
    .setSize(int (width/11.76), int(height/17.65))
    .setFont(f2)
    .setColorBackground( buttonColor ) //default color
    .setColorForeground( buttonMouseOverColor ) // mouse-over
    .setColorActive( color(0, 150, 0 ) ); //button pressed

  stopButton =cp5.addButton("STOP")
    .setValue(2)
    .setPosition(width/37, height/3.98+2*buttonInterline)
    .setSize(int (width/11.76), int(height/17.65))
    .setFont(f2)
    .setColorBackground( buttonColor ) //default color
    .setColorForeground( buttonMouseOverColor ) // mouse-over
    .setColorActive(buttonClickedColor ); //button pressed
  println(mouseY);


  resetButton =cp5.addButton("RESET1")
    .setValue(7)
    //.setPosition(width/37, height/3.98+5*buttonInterline) // position in the screen 1
    .setPosition(width/1.187, height/2.53)  // position in the screen 7
    .setSize(int (width/8), int(height/17.65))  //size of the botton in the screen 7
    .setFont(f2)
    .setColorBackground( buttonColor ) //default color
    .setColorForeground( buttonMouseOverColor ) // mouse-over
    .setColorActive( buttonClickedColor); //button pressed
   
    
  resetButton =cp5.addButton("RESET2")
    .setValue(7)
    .setPosition(width/1.187, height/1.47)  // position in the screen 7
    .setSize(int (width/8), int(height/17.65))  //size of the botton in the screen 7
    .setFont(f2)
    .setColorBackground( buttonColor ) //default color
    .setColorForeground( buttonMouseOverColor ) // mouse-over
    .setColorActive( buttonClickedColor); //button pressed
 

}

public void START(int theValue) {
  println("a button was clicked: "+theValue);
  myPort.write('X');
}
public void STOP(int theValue) {
  println("a button was clicked: "+theValue);
  myPort.write('O');
}
public void SAVE(int theValue) {
  println("a button was clicked: "+theValue);
  saveData = true;
}

public void RESET1(int theValue) {
  println("a button was clicked: "+theValue);
  
  //batLev1 = 0.0;
  //batLev2 = 0.0;
  //temp1 = 0.0; 
  //temp2 = 0.0;
  //dpsi1 = 0.0;
  //dpsi2 = 0.0;

 }
 public void RESET2(int theValue) {
  println("a button was clicked: "+theValue);
  

 }
 /*
  public void RESET3(int theValue) {
  println("a button was clicked: "+theValue);
 
  minPitchLeft =0;
  maxPitchLeft=0;
  
  minPitchRight =0;
  maxPitchRight=0;
 }
 
 
   /*
 public void EQUHOR(int theValue) {
 println("a button was clicked: "+theValue);
  
equalizerLeftRoll =0;
equalizerLeftPitch =0;
equalizerLeftYaw =0;

equalizerRightRoll =0;
equalizerRightPitch =0;
equalizerRightYaw =0;

  }
  

public void EQUVER(int theValue) {
  println("a button was clicked: "+theValue);
  
equalizerLeftRoll =0;
equalizerLeftPitch =0;
equalizerLeftYaw =0;

equalizerRightRoll =0;
equalizerRightPitch =0;
equalizerRightYaw =0;

//equalizerLeftRoll =-90+roll360Left;
//equalizerLeftPitch =0;
//equalizerLeftYaw =yaw360Left;

//equalizerRightRoll =-90+roll360Right;
//equalizerRightPitch =0;
//equalizerRightYaw =yaw360Right;

  }
  

public void BREAK(int theValue) {
  println("a button was clicked: "+theValue);
  saveStop = saveStop+1;
  saveData = false;
  println ("saveStop : " + saveStop);
  }
  */

void COM(int n) {
  print("ScrollableList event :  ");
  println(n, cp5.get(ScrollableList.class, "COM").getItem(n).get("name"));
  //portName  = "COM"+ (n+1);
  //myPort = new Serial(this, portName, baudRate); // starts the serial communication
  //println("the selected port name is : " +portName);
}
