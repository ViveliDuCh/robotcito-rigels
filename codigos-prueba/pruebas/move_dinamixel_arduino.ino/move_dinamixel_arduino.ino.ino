#include <DynamixelSerial1.h> 

#define ID 2 //CHANGE THIS VALUE TO YOUR SERVO ID; Use 254 to talk to any servo, every servo should have its own specific ID though. 

#define FREQ 1000000 // The baud rate to communicate with the servo,  

                  // typically (9600,19200,57600,115200,200000,500000,1000000) 

                  // If the servo does not move, you need to try with different values.  

const byte numChars = 32; 

char receivedChars[numChars]; 

char tempChars[numChars];        // temporary array for use when parsing 

 

// variables to hold the parsed data 

int theta1 = 0; 

int theta2 = 0; 

int theta3 = 0; 

 

 

boolean newData = false; 

 

void setup(){ 

  /** Configure Serial communication with the PC **/ 

   Serial.begin(9600); 

   Serial.println("This program expects 3 integers."); 

   Serial.println("Enter data in this style <100, 200, 300> for <theta1, theta2, theta3>"); 

   Serial.println(); 

  /** Configure and make an initial test of the servos **/ 

    pinMode(LED_BUILTIN, OUTPUT); //To make the arduino led blink 

    Dynamixel.begin(FREQ,2);  // Initialize the servo at FREQ bps and Pin Control 2 

    Dynamixel.ledStatus(ID,ON); //  Turns the LED on the back of the servomotor ON 

    digitalWrite(LED_BUILTIN, HIGH);   // Make the arduino led blink 

    //Test the servos at the beginning 

    Dynamixel.move(ID,307);  // Move the Servo(ID), to 90°= 306.9 

    delay(2000); 

    Dynamixel.move(ID,0);  // Move the Servo(ID), to 0° = 0 

    Dynamixel.ledStatus(ID,OFF); //  Turns the LED on the back of the servomotor OFF 

    digitalWrite(LED_BUILTIN, LOW);   // Make the arduino led blink 

    delay(2000); 

} 

 

void loop(){ 

  recvWithStartEndMarkers(); 

    if (newData == true) { 

        strcpy(tempChars, receivedChars); 

            // this temporary copy is necessary to protect the original data 

            //   because strtok() used in parseData() replaces the commas with \0 

        parseData(); 

        showParsedData(); 

        moveServo(theta1); 

        newData = false; 

    } 

} 

 

//============ 

 

void recvWithStartEndMarkers() { 

    static boolean recvInProgress = false; 

    static byte ndx = 0; 

    char startMarker = '<'; 

    char endMarker = '>'; 

    char rc; 

 

    while (Serial.available() > 0 && newData == false) { 

        rc = Serial.read(); 

 

        if (recvInProgress == true) { 

            if (rc != endMarker) { 

                receivedChars[ndx] = rc; 

                ndx++; 

                if (ndx >= numChars) { 

                    ndx = numChars - 1; 

                } 

            } 

            else { 

                receivedChars[ndx] = '\0'; // terminate the string 

                recvInProgress = false; 

                ndx = 0; 

                newData = true; 

            } 

        } 

 

        else if (rc == startMarker) { 

            recvInProgress = true; 

        } 

    } 

} 

 

//============ 

 

void parseData() {      // split the data into its parts 

 

    char * strtokIndx; // this is used by strtok() as an index 

 

    strtokIndx = strtok(tempChars,",");      // get the first part - theta1 as integer 

    theta1 = atoi(strtokIndx);  // copy it to the theta1 variable 

  

    strtokIndx = strtok(NULL, ","); // this continues where the previous call left off 

    theta2 = atoi(strtokIndx);     // convert this part to theta2 integer 

 

    strtokIndx = strtok(NULL, ","); 

    theta3 = atoi(strtokIndx);     // convert this part to theta3 

 

} 

 

//============ 

 

void showParsedData() { 

    Serial.print("theta1: "); 

    Serial.println(theta1); 

    Serial.print("theta2: "); 

    Serial.println(theta2); 

    Serial.print("theta3: "); 

    Serial.println(theta3); 

} 

 

void moveServo(int angle) { 

  //Angle must be a value between 0 and 1023 (0°-300°) 

  Dynamixel.move(ID,angle);  // Move the Servo(ID), to 0° = 0 

} 
