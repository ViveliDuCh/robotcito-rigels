// This program will try to communicate with the servo at different baudrates  

// It will reset the servo to the default configuration baudrate=1000000, ID=1. and make it move  

// Be patient it can take a while; you will know when it is finished  

// when the Arduino LED 13 is turned on. If the LED is turned on and the servo does not move 

// then you have a problem!! 

 

#include <DynamixelSerial1.h>  

long BaudRates[] = {1000000,500000,400000,250000,230400, 

200000,115200,74880,57600,57143,57142,38400,19231,19200,9600}; 

  

void setup(){ 

  pinMode(13,OUTPUT); 

  //We assume that some of the baudrates will work in which case  

  // The servo will be reset to baudrate=1000000 and ID=1  

  for ( int i = 0; i <= 254;i++ ){ 

    Dynamixel.begin(BaudRates[i],2); // Init communication 

    Dynamixel.reset(254); //Changes Baudrate to  1000000 ( 1Mbps ) 

    Dynamixel.end(); 

  } 

  Dynamixel.begin(1000000,2); // Testing. 

} 

 

void loop(){ 

  // Be patient it can take a while; you will know when it is finished  

  // when the Arduino LED 13 is turned on. 

  digitalWrite(13,ON); 

  //Make the servo move from 0 to 300° 

  // If the change was successful the servo will move.  

  digitalWrite(13,ON); 

  Dynamixel.move(2,0);  // Move the Servo 0 GRADOS

  delay(1000); 

  Dynamixel.move(2,255);  // Move the Servo 100 - con regla de 3
  

  delay(1000); 
  
  Dynamixel.move(2,512);  // Move the Servo 

  delay(1000); 
  
  Dynamixel.move(2,1023);  // Move the Servo 

  delay(1000); 

}  

 
