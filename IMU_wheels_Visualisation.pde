//com library
import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

// **************************************** LIBRARY ***************************************
//*****************************************************************************************

// button library
import controlP5.*;
ControlP5 cp5;

// ************************* defining COM PORT AND BUTTONS ********************************
//*****************************************************************************************

Serial myPort;
String portName = "COM11";
int baudRate = 115200;
char lineEnding = '\n';

//***************** Com Port byte processing  variables ***********************************
//*****************************************************************************************
int startByteCount, stopByteCount = 0;
boolean startRecordData, stopRecordData = false;
byte startByte3, startByte2, startByte1, startByte0 = 0;
byte stopByte3, stopByte2, stopByte1, stopByte0 = 0;
byte recByte =0;
byte[] tempData = new byte[244];
byte[] data = new byte[tempData.length-8];

float[] flaotData =  {0.0};


WheelVar w1 = new WheelVar();
WheelVar w2 = new WheelVar();
WheelVar w3 = new WheelVar();
WheelVar w4 = new WheelVar();
WheelVar w5 = new WheelVar();
WheelVar w6 = new WheelVar();

//**************************** second wheel variables ***************************************
//*******************************************************************************************

//int id2               = 0;
//float batLev2         = 0.0;
//float temp2           = 0.0;
//float dOmega2         = 0.0;
//float freq2           = 0.0;
//float[] roll2         = new float[17];
//float[] pitch2        = new float[17];
//float[] yaw2          = new float[17];

//float[] droll2         = new float[16];
//float[] dpitch2        = new float[16];
//float[] dyaw2          = new float[16];

//float meanRoll2       =0.0;
//float meanPitch2      =0.0;
//float meanYaw2        =0.0;

//float dphi2           =0.0;
//float dtheta2         =0.0;
//float dpsi2           =0.0;

//float w2_old2         =0.0;
//float w2_old1         =0.0;
//float w2_old0         =0.0;
//Boolean turnStab2     =true;
//float w2_2              =0.0;

//float speed3DSim2     =0.0;
//int speedRate2        =0;
//Boolean Isrunning2     = true;

//**************************** Data global variables ****************************************
//*******************************************************************************************

float angleRotSim =0.0;
int[] stepSpeedvalue  = {0, 1, 2, 3, 4, 5};



//variables for Data position in the screen 7
float widthWheelData =0.0;
float heightWheelData =0.0;
float dtWidth = 0.0;
float dtheight= 0.0;
float widthPosX = 0.0;
float heightPosY = 0.0;
float widthItem = 0.0;
float heightItem = 0.0;


//variables  connected with button

boolean saveData = false; // activating the saving file state
int saveStop = 0; // stop saving data if true


// ***************************** defining different parts in the window *********************
//*******************************************************************************************
PGraphics pg1; // screen 1   ->  buttons
PGraphics pg2; // screen 2   -> title
PGraphics pg3; // screen 3   ->  left wheel block1
PGraphics pg4; // screen 4   ->  right wheel block1
PGraphics pg5; // screen 5   ->  left wheel block2
PGraphics pg6; // screen 6   ->  right wheel block2
PGraphics pg7; // screen 7   ->  left wheel block3
PGraphics pg8; // screen 8   ->  right wheel block4
PGraphics pg9; // screen 9   ->  real data for sensors

// ******************************* set weight  and color variables *************************
//******************************************************************************************

float screensLineStrokeWeight = 0.5;
float AngleSimLeft = 1;
float AngleSimRight = 1;

// angle in degree
float verticalTilt = 10;

//Data variables
float rollLeft, pitchLeft, yawLeft, frecLeft=0.0;
float roll360Left, pitch360Left, yaw360Left = 0;
float lastRollLeft, lastPitchLeft, lastYawLeft =0;
float minRollLeft, minPitchLeft, minYawLeft, maxRollLeft, maxPitchLeft, maxYawLeft =0;
float numberOfRotationLeft, numberOfRotationLeftPlus, numberOfRotationLeftMinus = 0;
boolean rollSensIndicatorLeft, pitchSensIndicatorLeft, yawSensIndicatorLeft = false;
float tempLeft = 0.0;
float tempRight = 0.0;

float rollRight, pitchRight, yawRight, frecRight= 0;
float roll360Right, pitch360Right, yaw360Right = 0;
float lastRollRight, lastPitchRight, lastYawRight =0;
float minRollRight, minPitchRight, minYawRight, maxRollRight, maxPitchRight, maxYawRight =0;
float numberOfRotationRight, numberOfRotationRightPlus, numberOfRotationRightMinus = 0;
boolean rollSensIndicatorRight, pitchSensIndicatorRight, yawSensIndicatorRight = false;

int lightRight = 0;
int lightLeft =0;



//stabilise the 3d motion

float stabXLeft = 0.0;
float stabYLeft = 0.0;
float stabZLeft = 0.0;

float stabXRight = 0.0;
float stabYRight = 0.0;
float stabZRight = 0.0;

float stabRollLeft= 0.0;
float stabPitchLeft = 0.0;
float stabYawLeft = 0.0;

float stabRollRight= 0.0;
float stabPitchRight = 0.0;
float stabYawRight = 0.0;

float lastValueRollLeft= 0.0;
float lastValuePitchLeft = 0.0;
float lastValueYawLeft = 0.0;

float lastValueRollRight= 0.0;
float lastValuePitchRight = 0.0;
float lastValueYawRight = 0.0;



//color and weight
int colorRange = 200;
color screenColor=color(245);
color screenSeparation=color(0);
//color textColor=color(0,255,255,245);
color textColor=color(0);
color buttonColor  = color(50, 55, 100, colorRange);
color buttonMouseOverColor = color(0, 100, 0, colorRange);
color buttonClickedColor = color(100, 0, 0, colorRange);
color shape3D = color(50, 55, 100, 250);
color ac_red = color(100, 0, 0, colorRange);
color screensLineStroke = color (0);
color orangeColor = color(204, 102, 0);
color greenColor = color(152, 190, 100);

// ******************************* set screen imagimes  *************************************
//******************************************************************************************

PImage logo;
PImage screen1;  //buttons
PImage screen2;  //title;
PImage screen3;  //left  block1
PImage screen4;  //right  block1
PImage screen5;  //left  block2
PImage screen6;  //right  block2
PImage screen7;  //left block3;
PImage screen8;  //right block3
PImage screen9;  //realTimeData;

PImage fillBW;
PImage fillBlack;
PImage fillWhite;

// ******************************* set buttons  ********************************************
//******************************************************************************************

Button startButton;
Button stopButton;
Button saveButton;
Button stopSaving;
Button sendData;
Button sendAngles;
Button resetButton;

ScrollableList sl;
CheckBox chck;
Textfield txt;

float buttonInterline = 0;

// ******************* background images subfolder setting**********************************
//******************************************************************************************

String subFolfder = "bg8";

// ************************* text font and size  *******************************************
//******************************************************************************************


PFont f1, f2, f3, f1t, f2t, f3t, f1a, f2a, f1g, f2g;


void setup() {

  //Screen Size settings
  //size(1000, 618, P3D);
  //size(1250, 772, P3D);
  size(1500, 927, P3D);
  //size(1555, 961, P3D);
  //fullScreen(P2D, SPAN);

  surface.setTitle("Real_time WHEELS ORIENTATION"); // set window title

  //***********variables on positionning ********************
  //*********************************************************

  //buttonInterline = height/9.8;
  buttonInterline = height/11;

  // declaring a button objet
  cp5 = new ControlP5(this);

  //smooth (4);
  if (subFolfder == "bg5" || subFolfder == "bg6" ) {
    screensLineStroke = color(255);
  } else if (subFolfder == "bg7") {
    screensLineStrokeWeight = 1;
  } else if (subFolfder == "bg8") {
    screensLineStrokeWeight = 1.2;
  }



  // *************************  set the COM PORT **************************************
  //***********************************************************************************

  // List all the available serial ports
  printArray(Serial.list());
  portName = Serial.list()[0];
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, portName, baudRate);


  //  //defining different screens with rect()
  //rect(0,0,width/7, height);                                              // screen 1   ->  buttons
  //rect(width/7,0, (3*width)/5, height/7);                                 // screen 2   ->  title
  //rect(width/7,height/7,(3*width)/10,(2*height)/7);                       // screen 3   ->  left block1
  //rect((31*width)/70,height/7,(3*width)/10,(2*height)/7);                 // screen 4   ->  right block1
  //rect(width/7,(3*height)/7,(3*width)/10,(2*height)/7);                   // screen 5   ->  left block2
  //rect((31*width)/70, (3*height)/7,(3*width)/10,(2*height)/7);            // screen 6   ->  right block2
  //rect(width/7, (5*height)/7,(3*width)/10,(2*height)/7);                  // screen 7   ->  left block3
  //rect((31*width)/70,(5*height)/7,(3*width)/10,(2*height)/7);             // screen 8   ->  right block3
  //rect(26*width/35,0,(9*width)/35, height);                               // screen 9   ->  real data for sensors


  //defining different screens
  pg1 = createGraphics(width/7, height);                 // screen 1   ->  buttons
  pg2 = createGraphics((3*width)/5, height/7);           // screen 2   ->  title
  pg3 = createGraphics((3*width)/10, (2*height)/7, P3D);   // screen 3   ->  left block1
  pg4 = createGraphics((3*width)/10, (2*height)/7, P3D);   // screen 4   ->  right block1
  pg5 = createGraphics((3*width)/10, (2*height)/7, P3D);   // screen 5   ->  left block2
  pg6 = createGraphics((3*width)/10, (2*height)/7, P3D);   // screen 6   ->  right block2
  pg7 = createGraphics((3*width)/10, (2*height)/7, P3D);   // screen 7   ->  left block3
  pg8 = createGraphics((3*width)/10, (2*height)/7, P3D);   // screen 8   ->  right block3
  pg9 = createGraphics(9*width/35, height);              // screen 9   ->  real data for sensors


  //******************** Screen images background *******************
  //*****************************************************************

  screen1  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_01.png");
  screen1.resize(width/7, height);

  screen2  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_02.png");
  screen2.resize((3*width)/5, height/7);

  screen3  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_03.png");
  screen3.resize((302*width)/1000, (602*height)/2100);

  screen4  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_03.png");
  screen4.resize((302*width)/1000, (602*height)/2100);

  screen5  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_03.png");
  screen5.resize(3*width/10, 100*height/341);

  screen6  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_04.png");
  screen6.resize((302*width)/1000, (602*height)/2100);

  screen7  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_04.png");
  screen7.resize((302*width)/1000, (602*height)/2100);

  screen8  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_04.png");
  screen8.resize((302*width)/1000, (602*height)/2100);

  screen9  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_07.png");
  screen9.resize(9*width/35, height);

  fillBlack = loadImage("/logoImages/black.jpg");
  fillWhite = loadImage("/logoImages/white.jpg");
  fillBW = loadImage("/logoImages/black_white.jpg");


  logo = loadImage("/logoImages/neis_detal.png");




  //******************* define font ********************
  //****************************************************
  // if you want to find  installed in processing
  //String[] fontList = PFont.list();
  //printArray(fontList);

  // define fonts
  f1 = createFont("Cambria", width/33.33, true);
  f2 = createFont("Cambria", width/66.66, true);
  f3 = createFont("Cambria Bold", width/66.66, true);

  f1t = createFont("Times New Roman", width/33.33, true);
  f2t = createFont("Times New Roman", width/66.66, true);
  f3t = createFont("Times New Roman Bold", width/66.66, true);

  f1g = createFont("Georgia", width/33.33, true);
  f2g = createFont("Georgia", width/66.66, true);

  f1a = createFont("Arial", width/33.33, true);
  f2a = createFont("Arial", width/66.66, true);

  //*********** calling butrtons function **************
  //****************************************************
  drawWidgets();
}


void draw() {

  background(51);

  angleRotSim++;
  if (angleRotSim >= 360) {
    angleRotSim =0;
  }

  //********** Defining differents screens *************
  //****************************************************

  screen1();
  screen2(pg2);
  screen3(pg3);
  screen4(pg4);
  screen5(pg5);
  screen6(pg6);
  screen7(pg7);
  screen8(pg8);
  screen9(pg9);




  //************************DATA PACK , UPDATE AND PRINT *************************************
  //******************************************************************************************

  flaotData = treatData(tempData, data);


  if ((flaotData[0] == 1) && (flaotData[1] == 1)) {
    w1.packData(flaotData);
    //w1.printData();
  } else if ((flaotData[0] == 1) && (flaotData[1] == 2)) {
    w2.packData(flaotData);
    //w2.printData();
  } else if ((flaotData[0] == 2) && (flaotData[1] == 1)) {
    w3.packData(flaotData);
    //w3.printData();
  } else if ((flaotData[0] == 2) && (flaotData[1] == 2)) {
    w4.packData(flaotData);
    //w4.printData();
  } else if ((flaotData[0] == 3) && (flaotData[1] == 1)) {
    w5.packData(flaotData);
    //w5.printData();
  } else if ((flaotData[0] == 3) && (flaotData[1] == 2)) {
    w6.packData(flaotData);
    //w6.printData();
  }

  //println("flaotData[0]     :   "+flaotData[0]+"               flaotData[1]     :     " +flaotData[1] );
}


// Read data from the Serial Port
void serialEvent (Serial myPort) {

  // reads the data from the Serial Port up to the character '.' and puts it into the String variable .
  byte[] inBuffer = new byte[4];
  inBuffer = myPort.readBytes();
  //myPort.readBytes(inBuffer);

  //println(hex(inBuffer[0]));


  if (startRecordData ) {
    tempData[startByteCount] = inBuffer[0];
    startByteCount++;
  }

  startByte3 = startByte2;
  startByte2 = startByte1;
  startByte1 = startByte0;
  startByte0 = inBuffer[0];

  if ( (startByte3 == 0x2B) && (startByte2 == 0x2B) && (startByte1 == 0x4D) && (startByte0 == 0x23) ) {

    startByte3 = 0x00;
    startByte2 = 0x00;
    startByte1 = 0x00;
    startByte0 = 0x00;

    if (stopRecordData) {
      startByteCount = 0;
    }

    startRecordData = true;
    stopRecordData = false;
  }

  stopByte3 = stopByte2;
  stopByte2 = stopByte1;
  stopByte1 = stopByte0;
  stopByte0 = inBuffer[0];

  if ( (stopByte3 ==0x0D) && (stopByte2 == 0x0A) && (stopByte1 == 0x00) && (stopByte0 == 0x00) ) {

    stopByte3 = 0x00;
    stopByte2 = 0x00;
    stopByte1 = 0x00;
    stopByte0 = 0x00;

    stopByteCount =1;

    startRecordData = false;
    stopRecordData = true;
  }
}




//************************************* wheels class ***************************************
//******************************************************************************************
class WheelVar {

  float block;
  float espID;
  float bat;
  float temp;
  float pression;  // in bars /1000
  float x;
  float w              =0.0;
  float freq;
  float[] roll         = new float[17];
  float[] pitch        = new float[17];
  float[] yaw          = new float[17];

  float [] useful      = new float[4];

  float speed3DSim     =0.0;
  int speedRate        =0;
  Boolean Isrunning     = false;
  Boolean turnStab      =true;

  void packData( float[] array ) {

    block                 = int(array[0]);
    espID                 = int(array[1]);
    bat                   = array[2];
    temp                  = array[3];
    pression              = array[4];
    x                     = array[5];
    w                     = array[6];
    freq                  = array[7];

    int wordStartcout   = 8;

    for (int i = 0; i<17; i++) {

      roll[i]         =  array[wordStartcout];
      pitch[i]        =  array[wordStartcout+1];
      yaw[i]          =  array[wordStartcout+2];

      wordStartcout+=3;
    }
    for (int j =0; j<4; j++) {
      useful[0]= bat;
      useful[1]= w;
      useful[2]= temp;
      useful[3]= pression;
    }
    speed3DSim     =0.0;
    speedRate        =0;
    if (abs(w) !=0) {
      Isrunning     = true;
    } else {
      Isrunning     = false;
    }
    turnStab      =true;
  }

  void printData() {

    if (espID ==1) {
      println(block);
      println(espID);
      println(bat);
      println(temp);
      println(pression);
      println(x);
      println(w);
      println(freq);
      for (int i = 0; i<17; i++) {
        print(roll[i] + "  ");
      }
      println();
      for (int i = 0; i<17; i++) {
        print(pitch[i]+ "  ");
      }
      println();
      for (int i = 0; i<17; i++) {
        print(yaw[i] + "  ");
      }
      println();
      println();
    } else if (espID ==1) {

      print("                                        ");
      println(block);
      print("                                        ");
      println(espID);
      print("                                        ");
      println(bat);
      print("                                        ");
      println(temp);
      print("                                        ");
      println(pression);
      print("                                        ");
      println(x);
      print("                                        ");
      println(w);
      print("                                        ");
      println(freq);
      print("                                        ");
      for (int i = 0; i<17; i++) {
        print(roll[i] + "  ");
      }
      println();
      print("                                        ");
      for (int i = 0; i<17; i++) {
        print(pitch[i]+ "  ");
      }
      println();
      print("                                        ");
      for (int i = 0; i<17; i++) {
        print(yaw[i] + "  ");
      }
      println();
    }
  }
}
