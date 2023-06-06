close all
clc
clear all

L1 = 25.5;
L2 = 88.1;
L3 = 153.59;
% Coordenadas del primer punto
P1x = -140;
P1y = 110;
P1z = 155;

% Coordenadas del segundo punto
P2x = 45;
P2y = 140; %88.1
P2z = 205; %179.09

m = (P2z-P1z)/(P2x-P1x)   % Slope in x direction
n = (P2z-P1z)/(P2y-P1y)  % Slope in y direction
b = P2z-m*P2x-n*P2y   % z-intercept

% coordenadas de x & y
x = linspace(-140,45, 5)
y = linspace(110,140, 5)

% Calcular coordenadas de z
z = m * x + n * y + b

% Grafica
% plot3(x, y, z, 'b-', 'LineWidth', 2);
% grid on;
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Trayectoria de la linea');
t = 1;
device=serialport("COM3",9600);

for i=1:1:5 
    clf
    t = t+1;
    
    Px = x(i);   %Xi coordinate of the line
    Py = y(i);   %Yi coordinate of the line
    Pz = z(i);   %Zi coordinate of the line
    
    X(t) = Px;             %Buffer para guardar coordenada X 
    Y(t) = Py;             %Buffer para guardar coordenada Y 
    Z(t) = Pz;             %Buffer para guardar coordenada Z 
    
    % Retrieve of the first angle Q1
    q1 = atan2(Py,Px);
    
    Z1 = Px*cos(q1)+Py*sin(q1);
    Z2 = Pz-L1;

    % Retrieve of the second angle Q3
    C3 = (Z1^2 + Z2^2 - L2^2 - L3^2)/(2*L2*L3);
    S3 = sqrt(1-C3^2);
    q3 = atan2(S3,C3);

   % Retrieve if the third angle Q2 
    B1 = L2 + L3*C3;
    B2 = L3*S3;

    S2 = (B1*Z2 + B2*Z1)/(B1^2 + B2^2);
    C2 = (B1*Z1 - B2*Z2)/(B1^2 + B2^2);
    q2 = atan2(S2,C2);
    

    % DH Parameters
    sigma = [0;0;0];
    a =     [0;L2;L3];
    alpha = [pi/2; -pi; -pi/2];
    d =     [L1;0;0];
    q =     [q1;q2;q3];
    theta = [q(1);q(2);q(3)];

    T = eye(4);

    px_ant = 0;
    py_ant = 0;
    pz_ant = 0;

    i = length(a);
    
    % Code
    for j = 1:i

        if sigma(j) == 0
            A = rotZaxis(q(j))*transZaxis(d(j))*rotXaxis(alpha(j))*transXaxis(a(j));
    
        elseif sigma(j) == 1
            A = rotZaxis(theta(j))*transZaxis(q(j))*rotXaxis(alpha(j))*transXaxis(a(j));

        end

        M = T;
        %Matriz parcial es 0T1-1T2-2T3
        MatrizParcial = A;
        MatrizParcial = double(MatrizParcial);
        T = M*MatrizParcial;
 
        px = T(1,4);
        py = T(2,4); 
        pz = T(3,4);

        %Robot Plot
        line([px_ant,px],[py_ant,py],[pz_ant,pz],'marker','*','color',[rand rand rand],'linewidth',2) % Estas son las plot de las juntas
        view(3)
        hold on
        axis equal;
        xlabel('eje x');
        ylabel('eje y');
        zlabel('eje z');
        px_ant = px;
        py_ant = py;
        pz_ant = pz;

    end

    grid on
    plot3(X(2:t),Y(2:t),Z(2:t))   %Esto es el plot de la línea
    pause(2.0)
    
    hold on
    xlim([0 150]);
    ylim([0 150]);
    zlim([0 150]);
    axis equal
    
    q11 = rad2deg(q1);
    q22 = rad2deg(q2);
    q33 = rad2deg(q3);
    
    theta_array=strcat("<",int2str(q11),",",int2str(q22),",",int2str(q33+90),">")
    writeline(device,theta_array) 
    
end
 
clear device

