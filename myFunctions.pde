
// define a cylinder
void drawCylinder(PGraphics pg,PImage img,int sides, float r, float h)
    {
        float angle = 360 / sides;
        float halfHeight = h / 2;

        // draw top of the tube
        //pg.noStroke();
        //pg.noFill();
        pg.beginShape();
        pg.texture(img);
        for (int i = 0; i < sides; i++) {
            float x = cos( radians( i * angle ) ) * r;
            float y = sin( radians( i * angle ) ) * r;
            
            pg.vertex( x, y, -halfHeight,255,255);
        }
        pg.endShape(CLOSE);

        // draw bottom of the tube
        //pg.noStroke();
        //pg.noFill();
        pg.beginShape();
        pg.texture(img);
        for (int i = 0; i < sides; i++) {
            float x = cos( radians( i * angle ) ) * r;
            float y = sin( radians( i * angle ) ) * r;
            pg.vertex( x, y, halfHeight,255,255);
        }
        pg.endShape(CLOSE);

        // draw sides
        //pg.noStroke();
        //pg.noFill();
        pg.beginShape(TRIANGLE_STRIP);
        pg.texture(img);
        for (int i = 0; i < sides + 1; i++) {
            float x = cos( radians( i * angle ) ) * r;
            float y = sin( radians( i * angle ) ) * r;
            pg.vertex( x, y, halfHeight,0,255);
            pg.vertex( x, y, -halfHeight,255,0);    
        }
        pg.endShape(CLOSE);
    
    }
    
    
    
    // min and Max functions
float maxValue(float oldParameter, float value) {
  if (oldParameter<value) {
    oldParameter = value;
  }
  return oldParameter;
}
float minValue(float oldParameter, float value) {
  if (oldParameter>value) {
    oldParameter = value;
  }
  return oldParameter;
}

void tempIndicator(PGraphics pg, float temp){

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



float[] treatData (byte[] dataSrc, byte[] dataDst){

  
  // delete for scr array  8 bytes :: 4 bytes >> startBytes and  4 bytes >> stopBytes
  byte[] tempDa = new byte[dataDst.length];
  for(int i = 0; i < (dataSrc.length-8); i++){
    tempDa[i] = dataSrc[i];
  }
  
  
  // swap the  orders or every series  of  4 bytes
  int wordByte = 4;

  for (int i = 0; i < dataDst.length; i+=wordByte){
    //the  for loop replace 4 oparations on top
    for(int j = 0 ; j < wordByte ; j++){
      dataDst[i+j]   = tempDa[i+(wordByte-(j+1))];
        }
    }    
    
   
  //assign 4 bytes to int  Values of  int = dataDst.length /4
    println();
    int countValues = 0;
    int[] values = new int[int(dataDst.length/4)];
    
    
    for (int bytePack = 0; bytePack< dataDst.length; bytePack+=wordByte){
   
        long temp =((0xFF & dataDst[bytePack])<<24) | ((0xFF & dataDst[bytePack+1])<<16) | ((0xFF & dataDst[bytePack+2])<<8)  | (0xFF & dataDst[bytePack+3]);
        values[countValues]  = (int)(temp & 0x0FFFFFFFFL);
       
        //print("  ");
        //print(hex(values[countValues]));
         
         countValues++;  
     } 
     //println();
     
   float[] floatData = new float[dataDst.length/4];
   for( int intTrans = 0 ; intTrans < floatData.length; intTrans++){
     
       floatData[intTrans] = (values[intTrans]/1000.0);
     }
    
  
   /* 
   // diaplay data in decimal
  for(int dec = 0; dec < floatData.length; dec++){
    
     //print(" ");
     print(floatData[dec]+"  ");
  }
   println();
   */
   
   
   /*
 
   
   
  // diaplay data in hex
  //int space = 0;
  for(int h = 0;  h < dataDst.length;  h++){
    if ((h%4)  == 0 ){
      print("  ");
      }
    print(hex( dataDst[ h]));
    
  }
   println();
    */  
     
  return floatData;
}

void packArrayToVariables(float[] array ){
  
  if(array[0] ==0.001){
    
  id1                 = int(array[0]*1000); 
  batLev1             = array[1];
  temp1               = array[2];
  freq1               = array[3];
  
  
  int wordStartcout   = 4;
  
  for(int i = 0; i<18; i++){
  
     roll1[i]         =  array[wordStartcout];
     pitch1[i]        =  array[wordStartcout+1];
     yaw1[i]          =  array[wordStartcout+2];
   
    
    wordStartcout+=3;
  } 
  
  
  }
  else if(array[0] ==0.002){
  
    id2                 = int(array[0]*1000); 
    batLev2             = array[1];
    temp2               = array[2];
    freq2               = array[3];
    
    
    int wordStartcout   = 4;
    
    for(int i = 0; i<18; i++){
      
       roll2[i]         =  array[wordStartcout];
       pitch2[i]        =  array[wordStartcout+1];
       yaw2[i]          =  array[wordStartcout+2];
     
      wordStartcout+=3;
     

  }
}
}


//**************** horizontal presentation of  Data *************************************
void printData(){

 
println(id1);
println(batLev1);
println(temp1);
println(freq1);
for(int i = 0; i<18; i++){ print(roll1[i] + "  ");}
println();
for(int i = 0; i<18; i++){ print(pitch1[i]+ "  ");}
println();
for(int i = 0; i<18; i++){ print(yaw1[i] + "  ");}
println();
println();



print("                                        "); println(id2);
print("                                        "); println(batLev2);
print("                                        "); println(temp2);
print("                                        "); println(freq2);
print("                                        ");
for(int i = 0; i<18; i++){ print(roll2[i] + "  ");}
println();
print("                                        ");
for(int i = 0; i<18; i++){ print(pitch2[i]+ "  ");}
println();
print("                                        ");
for(int i = 0; i<18; i++){ print(yaw2[i] + "  ");}
println();

}


/*

//**************** Vertical presentation of  Data *************************************
void printData(){

println(id1);
println(batLev1);
println(temp1);
println(freq1);
for(int i = 0; i<18; i++){
  
  println(roll1[i] + "  "+pitch1[i]+"  "+ yaw1[i]);
  
}

print("                        ");println(id2);
print("                        ");println(batLev2);
print("                        ");println(temp2);
print("                        ");println(freq2);
for(int i = 0; i<18; i++){ 
    print("                       ");  println(roll2[i] + "  "+pitch2[i]+"  "+ yaw2[i]);
}

}

*/


float meanAngle(float[] array){
  float mean = 0;
  int len = array.length;
  for (int i =0; i<len; i++){
     mean+=abs(array[i]);
  }
  mean/=len;
  return mean;
}



float[] dAngleArray(float[] array){
 
  int len = array.length;
  float[] dAngle = new float[len-1];
  
  for (int i =0; i<(len-1); i++){
     
    dAngle[i] = abs(array[i+1])-abs(array[i]);

  }

 return dAngle;
}

float dAngleArrayMean(float[] array){
  float mean = 0;
  int len = array.length;
  for (int i =0; i<len; i++){
     mean+=abs(array[i]);
  }
  mean/=len;
  return mean;
}
