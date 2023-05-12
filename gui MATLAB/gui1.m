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

% Last Modified by GUIDE v2.5 05-May-2023 18:11:03

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

%-------------------------------------Datos iniciales
%Variables thetas GLOBALES en posición 0
[theta1, theta2, theta3] = setGlobal_thetas(0,0,0);
%Compensacion en punto
setGlobal_theta3(getGlobal_theta3-90);

%Funcion pa resolver el DH de nuestro robot
[T, MatrizParcial,MatrizInterm] = GENDGM([0 0 0],[0 88.1 153.59],[pi/2 -pi -pi/2],[25.5 0 0],[0 0 0],[getGlobal_theta1*pi/180 getGlobal_theta2*pi/180 getGlobal_theta3*pi/180]) 
MatrizInterm = round(MatrizInterm) %se redondea porque else no se ve identico al real
T_1=MatrizInterm(:,:,1); %Junta 1
T_2=MatrizInterm(:,:,2); %Junta 2
T_3=MatrizInterm(:,:,3); %Junta 3
%Separacion de coordenadas a graficar
X = [0 T_1(1,4) T_2(1,4) T_3(1,4)]
Y = [0 T_1(2,4) T_2(2,4) T_3(2,4)]
Z = [0 T_1(3,4) T_2(3,4) T_3(3,4)]
%figure %Pa debuggear
plot3(X,Y,Z,'-o','Color',[0.5 0 0.8]);
xlabel('x')
ylabel('y')
zlabel('z')
grid on

%Posiciones iniciales con thetas = 0
set(handles.text1,'string',round(T(13)));
set(handles.text2,'string',round(T(14)));
set(handles.text3,'string',round(T(15)));
pause(1.0)

% device=serialport("COM5",9600); 
% pause(1.0) 
% theta_array=strcat("<",int2str(getGlobal_theta1),",",int2str(getGlobal_theta2),",",int2str(getGlobal_theta3),">")
% writeline(device,theta_array) 
% pause(1.0) 
% clear device

%Para asignar valores o leer su valor se necesita: setGlobal_thetax y getGlobal_thetax 
%La x siendo el numero de theta que se busca modificar 

% Choose default command line output for gui1
handles.output = hObject;

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
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in togglebutton1. ----Limpiar eventualmente
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
temp2 = str2double(get(hObject,'String'))
%limite superior
limit2 = 90.0;
if temp2 > limit2 %checar limite inferior
    %mensaje de error
    setGlobal_theta2(limit2); %Aqui debemos decidir si lo mantenemos en 180 o solo mandamos error
else
    setGlobal_theta2(temp2);
end
%Para cambiar graficamente el slider
set(handles.slider2,'Value',getGlobal_theta2/limit2);
%r = getGlobal_theta2
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'string','HOLI');
end



% --- Executes on button press in pushbutton10. ------ MOVE button
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
device=serialport("COM5",9600); 
pause(1.0) 
%-----------------------ESCRIBE------------------
% le sumamos 90 al theta 3 porque en la formula de cada edit se lo restamos
% para que salga bien el DH

theta_array=strcat("<",int2str(getGlobal_theta1),",",int2str(getGlobal_theta2),",",int2str(getGlobal_theta3+90),">")
writeline(device,theta_array) 
pause(2.0) 
clear device

[T, MatrizParcial,MatrizInterm] = GENDGM([0 0 0],[0 88.1 153.59],[pi/2 -pi -pi/2],[25.5 0 0],[0 0 0],[getGlobal_theta1*pi/180 getGlobal_theta2*pi/180 getGlobal_theta3*pi/180]) 
MatrizInterm = round(MatrizInterm) %se redondea porque else no se ve identico al real
T_1=MatrizInterm(:,:,1); %Junta 1
T_2=MatrizInterm(:,:,2); %Junta 2
T_3=MatrizInterm(:,:,3); %Junta 3
%Separacion de coordenadas a graficar
X = [0 T_1(1,4) T_2(1,4) T_3(1,4)]
Y = [0 T_1(2,4) T_2(2,4) T_3(2,4)]
Z = [0 T_1(3,4) T_2(3,4) T_3(3,4)]
%figure %Pa debuggear
plot3(X,Y,Z,'-o','Color',[0.5 0 0.8]);
xlabel('x')
ylabel('y')
zlabel('z')
grid on
%Posiciones iniciales con thetas = 0
set(handles.text1,'string',round(T(13)));
set(handles.text2,'string',round(T(14)));
set(handles.text3,'string',round(T(15)));
pause(1.0)
% Update handles structure
guidata(hObject, handles);

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
temp3 = str2double(get(hObject,'String')) %puede ser 0 - 180
%Al DH llegarian de -90 a 90

%limite superior
limit3 = 180.0; 
%Grafica slider - tiene que interpretarse con el rango 0-180
set(handles.slider3,'Value',temp3/limit3);

if temp3 > limit3 %checar limite inferior
    %mensaje de error
    setGlobal_theta3(limit3-90); %Aqui debemos decidir si lo mantenemos en 180 o solo mandamos error
else
    setGlobal_theta3(temp3-90);
end
%Para cambiar graficamente el slider
%set(handles.slider3,'Value',getGlobal_theta3/limit3);
%r = getGlobal_theta3
% Update handles structure
guidata(hObject, handles);


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
temp1 = str2double(get(hObject,'String'))
%limite superior
limit1 = 180.0;
if temp1 > limit1 %checar limite inferior
    %mensaje de error
    setGlobal_theta1(limit1); %Aqui debemos decidir si lo mantenemos en 180 o solo mandamos error
else
    setGlobal_theta1(temp1);
end
%Para cambiar graficamente el slider
set(handles.slider1,'Value',getGlobal_theta1/limit1);
% Update handles structure
guidata(hObject, handles);


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
%Es relativo porque cada que se cambia el valor desde las cajitas de texto, se modifica el valor actual del slider
temp1=slider1_val*180
limit1 = 180.0; %limite superior
%Approach uno pa limitar, aunque es suficiente con multiplicar la verdad
if temp1 > limit1 %checar limite inferior
    %mensaje de error
    setGlobal_theta1(limit1); %Aqui debemos decidir si lo mantenemos en 180 o solo mandamos error
else
    setGlobal_theta1(temp1);
end
%Actualiza graficamente el cuadro de texto de theta1
set(handles.edit1,'string',getGlobal_theta1);
%--------------------Start the serial communication 
device=serialport("COM5",9600); 
pause(1.0) 
%--------------------------MANDA DATO------------------
theta_array=strcat("<",int2str(getGlobal_theta1),",",int2str(getGlobal_theta2),",",int2str(getGlobal_theta3),">")
pause(1.0);
%-------------Manda thetas_array
writeline(device,theta_array) 
pause(2.0) 
%Terminando conexion 
clear device

%Funcion pa resolver el DH de nuestro robot
%Comento lo siguiente por si me equivoco copypasteando algo - BACKUP del DH
%[T] = GENDGM([0 0 0],[0 88.1 153.59],[pi/2 -pi -pi/2],[25.5 0 0],[0 0 0],[getGlobal_theta1*pi/180 getGlobal_theta2*pi/180 getGlobal_theta3*pi/180])
[T, MatrizParcial,MatrizInterm] = GENDGM([0 0 0],[0 88.1 153.59],[pi/2 -pi -pi/2],[25.5 0 0],[0 0 0],[getGlobal_theta1*pi/180 getGlobal_theta2*pi/180 getGlobal_theta3*pi/180]) 
MatrizInterm = round(MatrizInterm) %se redondea porque else no se ve identico al real
T_1=MatrizInterm(:,:,1); %Junta 1
T_2=MatrizInterm(:,:,2); %Junta 2
T_3=MatrizInterm(:,:,3); %Junta 3
%Separacion de coordenadas a graficar
X = [0 T_1(1,4) T_2(1,4) T_3(1,4)]
Y = [0 T_1(2,4) T_2(2,4) T_3(2,4)]
Z = [0 T_1(3,4) T_2(3,4) T_3(3,4)]
%figure %Pa debuggear
plot3(X,Y,Z,'-o','Color',[0.5 0 0.8]);
xlabel('x')
ylabel('y')
zlabel('z')
grid on
%Resultado coordenada X
%en la posición 13 de la matriz T4x4 vista como un arreglo lineal
set(handles.text1,'string',round(T(13)));
pause(1.0)
% Update handles structure
guidata(hObject, handles);



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
slider2_val=get(hObject,'Value')
%fprintf("slider 2 val: %i", slider2_val);
b=slider2_val*90;
%Limite superior- 90
%Limite inferior- 0
setGlobal_theta2(b);
%Actualiza graficamente el cuadro de texto de theta2
set(handles.edit2,'string',getGlobal_theta2);
%start the serial communication 
device=serialport("COM5",9600);
pause(1.0)
%-----------------Escribe------------------
theta_array=strcat("<",int2str(getGlobal_theta1),",",int2str(getGlobal_theta2),",",int2str(getGlobal_theta3),">");
%Manda array_theta a Arduino
writeline(device,theta_array) 
pause(2.0)
%Terminando comunicación
clear device

[T, MatrizParcial,MatrizInterm] = GENDGM([0 0 0],[0 88.1 153.59],[pi/2 -pi -pi/2],[25.5 0 0],[0 0 0],[getGlobal_theta1*pi/180 getGlobal_theta2*pi/180 getGlobal_theta3*pi/180]) 
MatrizInterm = round(MatrizInterm) %se redondea porque else no se ve identico al real
T_1=MatrizInterm(:,:,1); %Junta 1
T_2=MatrizInterm(:,:,2); %Junta 2
T_3=MatrizInterm(:,:,3); %Junta 3
%Separacion de coordenadas a graficar
X = [0 T_1(1,4) T_2(1,4) T_3(1,4)]
Y = [0 T_1(2,4) T_2(2,4) T_3(2,4)]
Z = [0 T_1(3,4) T_2(3,4) T_3(3,4)]
%figure %Pa debuggear
plot3(X,Y,Z,'-o','Color',[0.5 0 0.8]);
xlabel('x')
ylabel('y')
zlabel('z')
grid on
%Resultado coordenada Y
%en la posición 14 de la matriz T4x4 vista como un arreglo lineal
set(handles.text2,'string',round(T(14)));
pause(1.0)
% Update handles structure
guidata(hObject, handles);


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
slider3_val=get(hObject,'Value')
c=(slider3_val*180)-90; %Limite superior- 180
%Actualiza graficamente el cuadro de texto de theta1
set(handles.edit3,'string',getGlobal_theta3);

setGlobal_theta3(c);
%---------------------------MANDAR EL DATO-----------------------
%start the serial communication 
device=serialport("COM5",9600); 
pause(1.0) 
%--------------------------MANDA DATO------------------
theta_array=strcat("<",int2str(getGlobal_theta1),",",int2str(getGlobal_theta2),",",int2str(getGlobal_theta3),">")
pause(1.0);
%-------------Manda thetas_array
writeline(device,theta_array) 
pause(1.0) 
%Terminando conexion 
clear device

%Funcion pa resolver el DH de nuestro robot
[T] = GENDGM([0 0 0],[0 88.1 153.59],[pi/2 -pi -pi/2],[25.5 0 0],[0 0 0],[getGlobal_theta1*pi/180 getGlobal_theta2*pi/180 getGlobal_theta3*pi/180])
%Resultado coordenada Z
%en la posición 15 de la matriz T4x4 vista como un arreglo lineal
set(handles.text3,'string',round(T(15)));
pause(1.0)
% Update handles structure
guidata(hObject, handles); %Para actualizar la estructura de datos de los handles

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
