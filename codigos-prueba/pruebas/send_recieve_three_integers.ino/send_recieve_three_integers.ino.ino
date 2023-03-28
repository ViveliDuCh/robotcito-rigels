// serial receive three integers - Receive with start (<)- and end-markers (>) combined with parsing 

const byte numChars = 32; 
char receivedChars[numChars]; 
char tempChars[numChars];        // temporary array for use when parsing 
 

// variables to hold the parsed data 
int theta1 = 0; 
int theta2 = 0; 
int theta3 = 0; 

 
 boolean newData = false; 
 //============ 
 
void setup() { 
//-------------------------NOTA: Los Serial.println() son para mandar info a matlab que está conectado al puerto COM3
    Serial.begin(9600); 
    Serial.println("This program expects 3 integers."); //ESTO ES SUFICIENTE PA MANDAR INFO A MATLAB
    Serial.println("Enter data in this style <100, 200, 300> for <theta1, theta2, theta3>"); 
    Serial.println(); 

} 

 

//============ 

 

void loop() { 

    recvWithStartEndMarkers(); 
    if (newData == true) { 
        strcpy(tempChars, receivedChars); 
            // this temporary copy is necessary to protect the original data 
            //   because strtok() used in parseData() replaces the commas with \0 
        parseData(); 
        showParsedData(); 
        newData = false; 

    } 

} 

 

//============ 

 
//Lee los datos del puerto, tomando como referencia los < >
void recvWithStartEndMarkers() { 

    static boolean recvInProgress = false; 
    static byte ndx = 0; 
    char startMarker = '<'; 
    char endMarker = '>'; 
    char rc; 
 
    while (Serial.available() > 0 && newData == false) { 
        rc = Serial.read(); //Lee del puerto serial si hay datos 

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

 
//Aqui solo saca los ints del string que los tiene
//usando como referencia las comas
//Saca substr y los convierte a enteros

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


//Imprime los datos ya parseados
void showParsedData() { 

    Serial.print("theta1: "); 
    Serial.println(theta1); 
    Serial.print("theta2: "); 
    Serial.println(theta2); 
    Serial.print("theta3: "); 
    Serial.println(theta3); 

}
