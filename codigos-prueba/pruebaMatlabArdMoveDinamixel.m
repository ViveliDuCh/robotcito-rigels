disp("starting serial communication") 

%start the serial communication 

device=serialport("COM5",9600); 

 
theta1_deg=180 %theta 1 is given in degrees it must be between 0° and 300°  

 

theta1_dyn = theta1_deg*1023/300; %In dynamixel a value of 300° is equal to 1023 

pause(1.0) %waits a little bit to ensure serial port is ready 

 

%reads until it gets the new line character 

configureTerminator(device,"LF") 

disp("Reading Starting Message from Arduino") 

while device.NumBytesAvailable ~= 0 

    disp(readline(device)) 

end 

pause(1.0) 

 

%write the string of data to the Arduino 

theta_array=strcat("<",int2str(theta1_dyn),",0,0>") 

pause(1.0) 

writeline(device,theta_array) 

%reads until it gets the new line character 

configureTerminator(device,"LF") 

disp("Reading Message from Arduino") 

while device.NumBytesAvailable ~= 0 

    disp(readline(device)) 

end 

pause(1.0) 
 
  

%Clear the device variable to close the serial port  

disp("finished") 

clear device 