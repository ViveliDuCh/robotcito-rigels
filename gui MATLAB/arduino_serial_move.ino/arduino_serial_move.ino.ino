#include <DynamixelSerial1.h> 

//PARA QUE ESTO FUNCIONE SE LE TUVO QUE HABER CAMBIADO EL ID AL MOTOR PREVIAMENTE CON EL PROGRAMA DE SETUP
#define ID_theta1 1 //CHANGE THIS VALUE TO YOUR SERVO ID; Use 254 to talk to any servo, every servo should have its own specific ID though.
#define ID_theta2 2
#define ID_theta3 3 
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

int Theta1F = 0; 
int Theta2F = 0; 
int Theta3F = 0; 
 


boolean newData = false; 
boolean checker = true;

 

void setup(){ 

  /** Configure Serial communication with the PC **/ 
  Serial.begin(9600); 
  //-------------------------Revisar el pin de control---------------------------
  Dynamixel.begin(FREQ,2);  // Initialize the servo at FREQ bps and Pin Control 2 
  //---------Test pa ver si funcionan los motores-----------------------------------
} 

 

void loop(){ 
  recvWithStartEndMarkers(); // Recibimos la info, los thetas
    if (newData == true) { 
        strcpy(tempChars, receivedChars); 
            // this temporary copy is necessary to protect the original data 
            //   because strtok() used in parseData() replaces the commas with \0 
        parseData(); 
        //Pa moverlos independientemente
        //--posible cambio moveServo(theta1); moveServo(theta2); moveServo(theta3);
        moveServo(theta1, theta2, theta3);
        delay(1000); 
        showParsedData(); //debug1 - Recepcion de datos/grados correctos
        delay(1000);
        showPositionData(); //debug2 - Conversion de posiciones
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
    // Recibimos la info, los thetas
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
void showPositionData() { 
    Serial.print("theta1: "); 
    Serial.println(Theta1F); 
    Serial.print("theta2: "); 
    Serial.println(Theta2F); 
    Serial.print("theta3: "); 
    Serial.println(Theta3F); 
} 

void moveServo(int angle1, int angle2, int angle3) { 
  //Angle must be a value between 0 and 1023 (0°-300°)
  //Cambio de grados a posiciones:
  Theta1F = map(theta1,0,180,1023,400); //Rango de 0 a 180
  Theta2F = map(theta2,0,90,400,695); //Rango de 0 a 90
  Theta3F = map(theta3,0,180,590,280); //Rango de 0 a 180
  Dynamixel.move(ID_theta1,Theta1F);  // Move the Servo(ID), to 0° = 0 
  Dynamixel.move(ID_theta2,Theta2F);  // Move the Servo(ID), to 0° = 0 
  Dynamixel.move(ID_theta3,Theta3F);  // Move the Servo(ID), to 0° = 0 
} 
