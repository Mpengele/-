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
byte startByte3,startByte2,startByte1,startByte0 = 0;
byte stopByte3,stopByte2,stopByte1,stopByte0 = 0;
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
int[] stepSpeedvalue  = {0,1,2,3,4,5};



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
color greenColor = color(152,190,100);

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


PFont f1, f2, f3, f1t,f2t,f3t, f1a,f2a,f1g,f2g;


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
  if(subFolfder == "bg5" || subFolfder == "bg6" ){
    screensLineStroke = color(255);
  } else if (subFolfder == "bg7"){
    screensLineStrokeWeight = 1;
 
  }else if(subFolfder == "bg8"){
    screensLineStrokeWeight = 1.2;
  }
  
  
  
  // *************************  set the COM PORT **************************************
  //***********************************************************************************
  
  // List all the available serial ports
  printArray(Serial.list());
  portName = Serial.list()[4];
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
  pg3 = createGraphics((3*width)/10,(2*height)/7,P3D);   // screen 3   ->  left block1
  pg4 = createGraphics((3*width)/10,(2*height)/7,P3D);   // screen 4   ->  right block1
  pg5 = createGraphics((3*width)/10,(2*height)/7,P3D);   // screen 5   ->  left block2
  pg6 = createGraphics((3*width)/10,(2*height)/7,P3D);   // screen 6   ->  right block2
  pg7 = createGraphics((3*width)/10,(2*height)/7,P3D);   // screen 7   ->  left block3
  pg8 = createGraphics((3*width)/10,(2*height)/7,P3D);   // screen 8   ->  right block3
  pg9 = createGraphics(9*width/35, height);              // screen 9   ->  real data for sensors
  
  
 //******************** Screen images background *******************
  //*****************************************************************
  
  screen1  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_01.png");
  screen1.resize(width/7, height);
  
  screen2  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_02.png");
  screen2.resize((3*width)/5, height/7);
  
  screen3  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_03.png");
  screen3.resize((302*width)/1000,(602*height)/2100);
  
  screen4  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_03.png");
  screen4.resize((302*width)/1000,(602*height)/2100);
  
  screen5  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_03.png");
  screen5.resize(3*width/10, 100*height/341);
  
  screen6  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_04.png");
  screen6.resize((302*width)/1000,(602*height)/2100);
  
  screen7  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_04.png");
  screen7.resize((302*width)/1000,(602*height)/2100);
  
  screen8  =  loadImage("/logoImages/"+subFolfder+"/_01_bg_04.png");
  screen8.resize((302*width)/1000,(602*height)/2100);
 
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
   if(angleRotSim >= 360){angleRotSim =0;}
   
  //********** Defining differents screens *************
  //****************************************************
  
  screen1();
  screen2(pg2);
  screen3(pg3);
  //screen4(pg4);
  //screen5(pg5);
  //screen6(pg6);
  //screen7(pg7);
  //screen8(pg8);
  screen9(pg9);
  
  
  
  
//************************DATA PACK , UPDATE AND PRINT *************************************
//******************************************************************************************

  flaotData = treatData(tempData,data);
  
  if ((flaotData[0] == 1) && (flaotData[0] == 1)){w1.packData(flaotData);}
  else if ((flaotData[0] == 1) && (flaotData[0] == 2)){w2.packData(flaotData);}
  else if ((flaotData[0] == 2) && (flaotData[0] == 1)){w3.packData(flaotData);}
  else if ((flaotData[0] == 2) && (flaotData[0] == 2)){w4.packData(flaotData);}
  else if ((flaotData[0] == 3) && (flaotData[0] == 1)){w5.packData(flaotData);}
  else if ((flaotData[0] == 3) && (flaotData[0] == 2)){w5.packData(flaotData);}
 
  //printData();
  
  
//// *************** Value  calca *************************** 
//meanRoll1   = meanAngle(roll1);
//meanPitch1  = meanAngle(pitch1);
//meanYaw1    = meanAngle(yaw1);

//droll1         = dAngleArray(roll1);
//dpitch1        = dAngleArray(pitch1); 
//dyaw1          = dAngleArray(yaw1);

//dphi1           =  dAngleArrayMean(droll1);
//dtheta1         =  dAngleArrayMean(dpitch1);
//dpsi1           =  dAngleArrayMean(dyaw1)-0.013882357;

//meanRoll2   = meanAngle(roll2);
//meanPitch2  = meanAngle(pitch2);
//meanYaw2    = meanAngle(yaw2);


//droll2         = dAngleArray(roll2);
//dpitch2        = dAngleArray(pitch2); 
//dyaw2          = dAngleArray(yaw2);

//dphi2           =  dAngleArrayMean(roll2 );
//dtheta2         =  dAngleArrayMean(dpitch2);
//dpsi2           =  dAngleArrayMean(dyaw2)-0.013176469;


//meanW2


  
  
//************************ 3D Rotation Simulation decision *********************************
//******************************************************************************************  
  




//w1_old2  = w1_old1  ;
//w1_old1  = w1_old0;
//w1_old0  =  w1 ;
//if( (w1_old2 != 0) && (w1_old1 != 0) && (w1_old0!= 0) ){ turnStab1 = true;} else{turnStab1 = false;}

//w2_old2  =  w2_old1;  
//w2_old1  =  w2_old0;
//w2_old0  =  w2;
//if( (w2_old2 != 0) && (w2_old1 != 0) && (w2_old0!= 0) ){ turnStab2 = true;} else{turnStab2 = false;}


//if (abs(dpsi1*freq1)<5){
//    w1  = 0.0;
//    speed3DSim1  =stepSpeedvalue[0]; 
//    Isrunning1 = false;
//  }
//  else{
//    w1  = dpsi1*freq1;        // value  to print on the  screen for  the  angular  rate
//    speed3DSim1 = angleRotSim;
//    Isrunning1 = true;
//  }
    
//if (abs(dpsi2*freq2)<5){
//    w2  = 0.0; 
//    speed3DSim2  =stepSpeedvalue[0];
//    Isrunning2 = false;
//  }
//else{
//    w2  = dpsi2*freq2;
//    speed3DSim2 = angleRotSim;
//    Isrunning2 = true;
//  }

//// rotation rate  adjustment

//if (w1 <5 ){ speedRate1 = stepSpeedvalue[0];}
//else if((w1 >=5) && (w1 < 10)){speedRate1 = stepSpeedvalue[1];} 
//else if((w1 >= 10) && (w1 < 180)){speedRate1 = stepSpeedvalue[2];} 
//else if((w1 >= 180) && (w1 <360)){speedRate1 = stepSpeedvalue[3];} 
//else {speedRate1 = stepSpeedvalue[4];}


//if (w2 <5 ){ speedRate2 = stepSpeedvalue[0];}
//else if((w2 >=5) && (w2 < 10)){speedRate2 = stepSpeedvalue[1];} 
//else if((w2 >= 10) && (w2 < 180)){speedRate2 = stepSpeedvalue[2];} 
//else if((w2 >= 180)&& (w2 <360)){speedRate2 = stepSpeedvalue[3];} 
//else {speedRate2 = stepSpeedvalue[4];}






//println();
//println("dpsi1  : "+ dpsi1 + "   w1   : "+w1);
//println("dpsi2  : "+dpsi2 + "    w2   : "+w2);
////println(dyaw1);
//println();
 

}


// Read data from the Serial Port
void serialEvent (Serial myPort) {
  
   // reads the data from the Serial Port up to the character '.' and puts it into the String variable .
  byte[] inBuffer = new byte[4];
  inBuffer = myPort.readBytes();
  //myPort.readBytes(inBuffer);
  
  //println(hex(inBuffer[0]));
  
  
   if (startRecordData ){
     tempData[startByteCount] = inBuffer[0];
     startByteCount++;
   }

  startByte3 = startByte2;  
  startByte2 = startByte1;  
  startByte1 = startByte0;
  startByte0 = inBuffer[0];
  
  if( (startByte3 == 0x2B) && (startByte2 == 0x2B) && (startByte1 == 0x4D) && (startByte0 == 0x23) ){
    
     startByte3 = 0x00;     
     startByte2 = 0x00;     
     startByte1 = 0x00;     
     startByte0 = 0x00;
     
     if(stopRecordData){startByteCount = 0;}
   
     startRecordData = true;
     stopRecordData = false;
   }

  stopByte3 = stopByte2;  
  stopByte2 = stopByte1;  
  stopByte1 = stopByte0;  
  stopByte0 = inBuffer[0];
  
  if( (stopByte3 ==0x0D) && (stopByte2 == 0x0A) && (stopByte1 == 0x00) && (stopByte0 == 0x00) ){

     stopByte3 = 0x00;     stopByte2 = 0x00;     stopByte1 = 0x00;     stopByte0 = 0x00;
     
     stopByteCount =1;
     
     startRecordData = false;
     stopRecordData = true;
  }
  
}




//************************************* wheels class ***************************************
//******************************************************************************************
class WheelVar{
  
  float block;
  float espID;
  float bat;
  float temp;
  float pression;  // in bars /1000
  float x;
  float w              =1.0;
  float freq;
  float[] roll         = new float[17];
  float[] pitch        = new float[17]; 
  float[] yaw          = new float[17];
  
 
  float speed3DSim     =0.0;
  int speedRate        =0;
  Boolean Isrunning     = true;
  Boolean turnStab      =true;
  
 void packData( float[] array ){
    
  block                 = int(array[0]*1000);
  espID                 = int(array[1]*1000);
  bat                   = array[3];
  temp                  = array[4];
  pression              = array[5];
  x                     = array[6];
  w                     = array[7];
  freq                  = array[8];  

  int wordStartcout   = 9;
  
  for(int i = 0; i<16; i++){
  
     roll[i]         =  array[wordStartcout];
     pitch[i]        =  array[wordStartcout+1];
     yaw[i]          =  array[wordStartcout+2];
  
    wordStartcout+=3;
    } 
     speed3DSim     =0.0;
     speedRate        =0;
     Isrunning     = true;
     turnStab      =true;
  }

void printData(){
  
  if (espID ==1){
    println(block);
    println(espID);
    println(bat);
    println(temp);
    println(pression);
    println(x);
    println(w);
    println(freq);
    for(int i = 0; i<18; i++){ print(roll[i] + "  ");}
    println();
    for(int i = 0; i<18; i++){ print(pitch[i]+ "  ");}
    println();
    for(int i = 0; i<18; i++){ print(yaw[i] + "  ");}
    println();
    println();
  
  }else if (espID ==1){
  
    print("                                        "); println(block);
    print("                                        "); println(espID);
    print("                                        "); println(bat);
    print("                                        "); println(temp);
    print("                                        "); println(pression);
    print("                                        "); println(x);
    print("                                        "); println(w);
    print("                                        "); println(freq);
    print("                                        ");
    for(int i = 0; i<18; i++){ print(roll[i] + "  ");}
    println();
    print("                                        ");
    for(int i = 0; i<18; i++){ print(pitch[i]+ "  ");}
    println();
    print("                                        ");
    for(int i = 0; i<18; i++){ print(yaw[i] + "  ");}
    println();
  
      }

    }
    
  void tempInd(PGraphics pg){
  
     pg.stroke (buttonColor);
     pg.strokeWeight(width/500);
    
     pg.fill (buttonColor);
      //pg.fill (227,227,227);
     pg.smooth();
    
     //build thermostat
     pg.rectMode(CORNER);
     
     pg.rect (width/19.23, width/3.58, width/66.66, -width/8.06,width/50);
     pg.ellipse (width/16.66, width/3.7, width/40, width/50);
    
     //build quicksilver reservoir
      if (temp <= 30){ 
        pg.stroke (100,200,0);
        pg.fill(100, 200,0);
      } else if (temp <=60){
        pg.stroke (0,255,0);
        pg.fill(0, 255,0);
      } else
      {
          pg.stroke (255,0,0);
          pg.fill(255, 0, 0);
      }
     pg.ellipse (width/16.66, width/3.7, width/100, width/100);
    
     //quicksilver
     if (temp <=  0){
           pg.rect(width/16.94, width/3.73, width/500, 0,width/50);
     }else {
            pg.rect(width/16.94, width/3.73, width/500, -temp,width/50);
     }
  }
}
