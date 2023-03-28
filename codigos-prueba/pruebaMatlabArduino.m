%Comunicacion serial al puerto COM3 con 9600 bauds
%device=serialport("COM4",9600); 

%Para cerrar la comunicación solo tienes que destruir la variable 
%que la inició
%clear device


%Tendremos un caracter como *line feed que es con el que 
%sabremos que ya acabó de mandarse la información 
%en la comunicación serial de "device"
%configureTeminator(device,"LF");

%-----------------------INICIO DEL SCRIPT---------------
disp("starting serial communication") 
%start the serial communication 
device=serialport("COM4",9600); %Si no pones bien el puerto, llora
pause(1.0) %waits a little bit to ensure serial port is ready 

%-------------NOTA: NO puedes abrir el Serial Monitor del Arduino IDE
%mientras corres este programa porque intentará usar la misma líea de
%comunicación.
%Esta línea solo puede ser usada por un dispositivo (O Matlab O arduino) a
%la vez.
 

%reads until it gets the new line character 
configureTerminator(device,"LF") 
disp("Reading Starting Message from Arduino") 

while device.NumBytesAvailable ~= 0 
    disp(readline(device)) 
end 
pause(1.0) 

 
%--------------NOTA: Para mandar datos es writeline() usando el device que se conecta al
%puerto COM3
%write the string of data to the Arduino - Manda datos
writeline(device,"<500,1000,0>") 
pause(1.0) 
writeline(device,"<26,26,29>") 
pause(1.0) 

%Luego de mandar los datos, espera a respuesta**
%reads until it gets the new line character 
disp("Reading Message from Arduino") 
while device.NumBytesAvailable ~= 0 
    disp(readline(device)) 
end 
pause(1.0) 

 

%Clear the device variable to close the serial port  

disp("finished") 
clear device 