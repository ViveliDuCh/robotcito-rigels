close all
clc
clear all
%Tamaño de Juntas
L1 = 25.5;
L2 = 88.1;
L3 = 153.59;

t = 1;    % Variable de tiempo
r = 30;   % Radio de Espiral
dz = 1.5;   %Delta Z que afecta el cambio de distancia en z

% Coordenadas Iniciales
Px = r + 100;
Py = 50;
Pz = 200;

device=serialport("COM4",9600);

for c = 0:pi/6:12*pi  % Increase the range of c for a larger spiral
    clf
    t = t + 1;

    % Update coordinates along the spiral
    Px = (r*cos(c)) + 100;      % X coordinate of the spiral
    Py = (r*sin(c)) + 50;       % Y coordinate of the spiral
    Pz = Pz - dz;               % Decrease Z coordinate of the spiral

    X(t) = Px;   % Variable to store the X coordinate
    Y(t) = Py;   % Variable to store the Y coordinate
    Z(t) = Pz;   % Variable to store the Z coordinate


    % Retrieve the first angle Q1
    q1 = atan2(Py, Px)

    Z1 = Px*cos(q1) + Py*sin(q1);
    Z2 = Pz - L1;

    % Retrieve the second angle Q3
    C3 = (Z1^2 + Z2^2 - L2^2 - L3^2) / (2 * L2 * L3);
    S3 = sqrt(1 - C3^2);
    q3 = atan2(S3, C3)

    % Retrieve the third angle Q2
    B1 = L2 + L3 * C3;
    B2 = L3 * S3;

    S2 = (B1 * Z2 + B2 * Z1) / (B1^2 + B2^2);
    C2 = (B1 * Z1 - B2 * Z2) / (B1^2 + B2^2);
    q2 = atan2(S2, C2)

    % DH Parameters
    sigma = [0; 0; 0];
    a = [0; L2; L3];
    alpha = [pi/2; -pi; -pi/2];
    d = [L1; 0; 0];
    q = [q1; q2; q3];
    theta = [q(1); q(2); q(3)-pi/2];

    T = eye(4);
    % Inicializacion de variables temporales
    px_ant = 0;
    py_ant = 0;
    pz_ant = 0;

    i = length(a);
    

    % Code
    plot3(X(2:t),Y(2:t),Z(2:t))
    hold on
  

    for j = 1:i

        if sigma(j) == 0
            A = rotZaxis(q(j)) * transZaxis(d(j)) * rotXaxis(alpha(j)) * transXaxis(a(j));

        elseif sigma(j) == 1
            A = rotZaxis(theta(j)) * transZaxis(q(j)) * rotXaxis(alpha(j)) * transXaxis(a(j));

        end
    
        M = T;
        % Matriz parcial es 0T1-1T2-2T3
        MatrizParcial = A;
        MatrizParcial = double(MatrizParcial);
        T = M*MatrizParcial;

        Px = T(1,4);
        Py = T(2,4); 
        Pz = T(3,4);

 %Plot de juntas
        line([px_ant,Px],[py_ant,Py],[pz_ant,Pz],'marker','*','color',[rand rand rand],'linewidth',2) %%ROBOT
        view(3)
        hold on
        axis equal;
        xlabel('eje x');
        ylabel('eje y');
        zlabel('eje z');
        px_ant = Px;
        py_ant = Py;
        pz_ant = Pz;

        D(:,:,j) = T;
    end

    plot3(X(2:t),Y(2:t),Z(2:t)) %%Plot de Trazo
    pause(2.0)
    hold on
    xlim([0 150]);
    ylim([0 150]);
    zlim([0 150]);
    axis equal
    %pause(0.5)
    q11 = rad2deg(q1);
    q22 = rad2deg(q2);
    q33 = rad2deg(q3);

    theta_array=strcat("<",int2str(q11),",",int2str(q22),",",int2str(q33+90),">")
    writeline(device,theta_array) 
    %pause(2.0)





end
Vp = [Px;Py;Pz]
clear device