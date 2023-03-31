function varargout = gui1(varargin)
% GUI1 MATLAB code for gui1.fig
%      GUI1, by itself, creates a new GUI1 or raises the existing
%      singleton*.
%
%      H = GUI1 returns the handle to a new GUI1 or the handle to
%      the existing singleton*.
%
%      GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI1.M with the given input arguments.
%
%      GUI1('Property','Value',...) creates a new GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui1

% Last Modified by GUIDE v2.5 29-Mar-2023 00:38:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui1_OpeningFcn, ...
                   'gui_OutputFcn',  @gui1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

%Saludito
%fprintf('Ready to connect! :D \n');


% --- Executes just before gui1 is made visible.
function gui1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui1 (see VARARGIN)

%Variables thetas GLOBALES en posición 0
[theta1, theta2, theta3] = setGlobal_thetas(0,1,0);
%Para asignar valores o leer su valor se necesita: setGlobal_thetax y getGlobal_thetax 
%La x siendo el numero de theta que se busca modificar 
% Disclaimer ----- se puede usar global normal y puro
%global device;

% Choose default command line output for gui1
handles.output = hObject;
%-------------------------------------posibles cosas de setup
set(handles.text1,'string','0');
set(handles.text2,'string','0');
set(handles.text3,'string','0');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Tomando el valor del boton
%Tomando el valor del boton
valor_connect = get(handles.togglebutton1,'value');

if valor_connect == 1
    %Generando la conexion al arduino
    %connect_ar = arduino('COM5'); %Checar el puerto al que se conecta el arduino
    %Mandando la informacion a la variable global para poder tener una
    %comunicacion serial desde todas las funciones de theta de la GUI
    %device = serialport("COM5",9600); %---Si esto no jala, habra que generar la conexion en cada slider
    set(handles.togglebutton1,'BackgroundColor','green');
    set(handles.togglebutton1,'string','CONNECTED');
    set(handles.togglebutton1,'BackgroundColor','green');
    fprintf('Connected \n');  
else
    %delete(instrfind({'Port'},{'COM5'}));
    %clear device %---Si esto no jala, habra que apagar la conexion  luego de generarla en cada slider
    set(handles.togglebutton1,'BackgroundColor','red');
    set(handles.togglebutton1,'string','DISCONNECTED');
    fprintf('Disconnected \n');
    pause(1);
    %Restableciendo el color del boton -- maybe crashee
    set(handles.togglebutton1,'BackgroundColor',[0.929 0.694 0.125]);
    set(handles.togglebutton1,'string','CONNECT');
    fprintf('Ready to connect :)\n');

end



% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text

%        str2double(get(hObject,'String')) returns contents of edit2 as a double
%------------NOTA: Aqui no se manda el dato porque 
% -------------lo mandas al presionar MOVE, entonces la instruccion
%---------------de mandarlo va ahi
%setGlobal_theta1( str2double(get(hObject,'String')));
temp2 = str2double(get(hObject,'String'));
%limite superior
limit2 = 180.0;
if temp2 > limit2 %checar limite inferior
    %mensaje de error
    setGlobal_theta2(limit2); %Aqui debemos decidir si lo mantenemos en 180 o solo mandamos error
else
    setGlobal_theta2(temp2);
end
%r = getGlobal_theta2

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'string','HOLI');
end



% --- Executes on button press in pushbutton10. ------ MOVE button
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

device=serialport("COM5",9600); 
%----------------Comunicacion con Arduino---------------
%reads until it gets the new line character 
configureTerminator(device,"LF") 
disp("Reading Starting Message from Arduino") 
while device.NumBytesAvailable ~= 0 
    disp(readline(device)) 
end 
pause(1.0) 
%----------------------------------------------------ESCRIBE----
theta_array=strcat("<",int2str(getGlobal_theta1),",",int2str(getGlobal_theta2),",",int2str(getGlobal_theta3),">")
writeline(device,theta_array) 
pause(1.0) 
%reads until it gets the new line character 
configureTerminator(device,"LF") 
disp("Reading Message from Arduino") 
while device.NumBytesAvailable ~= 0 
    disp(readline(device)) 
end 
pause(1.0)
%-------------------------------------------
clear device

%Aplicar los angulos en la funcion pa resolver DH
set(handles.text1,'string','Resultado X');
%pause(1);
set(handles.text2,'string','Resultado Y');
set(handles.text3,'string','Resultado Z');


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
temp3 = str2double(get(hObject,'String'));
%limite superior
limit3 = 180.0;
if temp3 > limit3 %checar limite inferior
    %mensaje de error
    setGlobal_theta3(limit3); %Aqui debemos decidir si lo mantenemos en 180 o solo mandamos error
else
    setGlobal_theta3(temp3);
end
%r = getGlobal_theta3


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1(see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
temp1 = str2double(get(hObject,'String'));
%limite superior
limit1 = 180.0;
if temp1 > limit1 %checar limite inferior
    %mensaje de error
    setGlobal_theta1(limit1); %Aqui debemos decidir si lo mantenemos en 180 o solo mandamos error
else
    setGlobal_theta1(temp1);
end
%r = getGlobal_theta1


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider1_val=get(hObject,'Value');
a=slider1_val*300;
setGlobal_theta1(a);

%start the serial communication 
device=serialport("COM5",9600); 
%-----------------MANDA DATO---------------
%reads until it gets the new line character 
configureTerminator(device,"LF") 
disp("Reading Starting Message from Arduino") 
while device.NumBytesAvailable ~= 0 
    disp(readline(device)) 
end 
pause(1)
%--------------------------------ESCRIBE
theta_array=strcat("<",int2str(getGlobal_theta1),",",int2str(getGlobal_theta2),",",int2str(getGlobal_theta3),">")
pause(1.0);
%-------------Manda thetas_array
writeline(device,theta_array) 
%----------------------------------LEE
%reads until it gets the new line character 
configureTerminator(device,"LF") 
disp("Reading Message from Arduino") 
while device.NumBytesAvailable ~= 0 
    disp(readline(device)) 
end 
pause(1.0) 
%-------------------------------------------
%Terminando conexion 
clear device

%Aplicar el la funcion pa resolver DH
set(handles.text1,'string','Resultado X');



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider2_val=get(hObject,'Value');
b=slider2_val*300;
%Limite superior- 180
%Limite inferior- 0
setGlobal_theta2(b);

%start the serial communication 
device=serialport("COM5",9600);
%-----------------COMUNICACION CON ARDUNIO---------------
%reads until it gets the new line character 
configureTerminator(device,"LF") 
disp("Reading Starting Message from Arduino") 
while device.NumBytesAvailable ~= 0 
    disp(readline(device)) 
end 
pause(1.0)
%--------------escribe
theta_array=strcat("<",int2str(getGlobal_theta1),",",int2str(getGlobal_theta2),",",int2str(getGlobal_theta3),">");
%Manda array_theta a Arduino
writeline(device,theta_array) 
%reads until it gets the new line character 
configureTerminator(device,"LF") 
disp("Reading Message from Arduino") 
while device.NumBytesAvailable ~= 0 
    disp(readline(device)) 
end 
pause(1.0) 
%-------------------------------------------
%Terminando comunicación
clear device

%Aplicar el la funcion pa resolver DH
set(handles.text2,'string','Resultado Y');

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider3_val=get(hObject,'Value');
c=slider3_val*180;
%Limite superior- 180
%Limite inferior- 0
setGlobal_theta3(c);
%---------------------------MANDAR EL DATO-----------------------
%Aplicar el la funcion pa resolver DH
set(handles.text3,'string','Resultado Z');

%start the serial communication 
device=serialport("COM5",9600);
%-----------------LEE INFO INICIAL DEL ARDUINO---------------
%reads until it gets the new line character 
configureTerminator(device,"LF") 
disp("Reading Starting Message from Arduino") 
while device.NumBytesAvailable ~= 0 
    disp(readline(device)) 
end 
pause(1.0) 
theta_array=strcat("<",int2str(getGlobal_theta1),",",int2str(getGlobal_theta2),",",int2str(getGlobal_theta3),">")
%------------------Manda array_theta
writeline(device,theta_array) 
%Vuelve a leer
%reads until it gets the new line character 
configureTerminator(device,"LF") 
disp("Reading Message from Arduino") 
while device.NumBytesAvailable ~= 0 
    disp(readline(device)) 
end 
pause(1.0) 
%-------------------------------------------
%Terminando la conexion
clear device

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
