<<<<<<< HEAD
function [Salida, S_label,allSol] = IGM(PX,PY,PZ)
=======
function [S1,S2,S3,S4] = IGM(PX,PY,PZ)
>>>>>>> 0287c397ab8541cc9eb47860c7e880a02bd4a7bc
L1 = 25.5;
L2 = 88.1;
L3 = 153.59;

% TYPE 3, CASE 2
q1A= atan2(PY,PX);
q1B = atan2(PY,PX)+pi;

% TYPE 8
X = L2;
Y = L3;

% Primera combinacion de Q1A Y Q3 Y Q2
<<<<<<< HEAD
Z1A = PX*cos(q1A)+PY*sin(q1A); 
=======
Z1A = PX*cos(q1A)+PY*sin(q1A);
>>>>>>> 0287c397ab8541cc9eb47860c7e880a02bd4a7bc
Z2 = PZ-L1;

C3A = (Z1A^2 + Z2^2 - X^2 - Y^2)/(2*X*Y);
S3A = sqrt(1-C3A^2);
q3A = atan2(S3A, C3A);
q3AP = atan2(-S3A, C3A);

%Obtencion de q2A con q3A
B1q3A = X+Y*cos(q3A); 
B2q3A = Y*sin(q3A);
S2q3A = (B1q3A*Z2 + B2q3A*Z1A)/(B1q3A^2 + B2q3A^2);
C2q3A = (B1q3A*Z1A - B2q3A*Z2)/(B1q3A^2 + B2q3A^2);
q2A = atan2(S2q3A, C2q3A); %-----------------------------q2
%Obtencion de q2AP con q3AP
B1q3AP = X+Y*cos(q3AP); 
B2q3AP = Y*sin(q3AP);
S2q3AP = (B1q3AP*Z2 + B2q3AP*Z1A)/(B1q3AP^2 + B2q3AP^2);
C2q3AP= (B1q3AP*Z1A - B2q3AP*Z2)/(B1q3AP^2 + B2q3AP^2);
q2AP = atan2(S2q3AP, C2q3AP);%---------------------------q2

% Segunda ombinacion de Q1B Y Q3 Y Q2
Z1B = PX*cos(q1B)+PY*sin(q1B);
Z2 = PZ-L1;

C3B = (Z1B^2 + Z2^2 - X^2 - Y^2)/(2*X*Y);
S3B = sqrt(1-C3B^2);
q3B = atan2(S3B, C3B);
q3BP = atan2(-S3B, C3B);

%Obtencion de q2B con q3B
B1q3B = X+Y*cos(q3B);
B2q3B = Y*sin(q3B);
S2q3B = (B1q3B*Z2 + B2q3B*Z1B)/(B1q3B^2 + B2q3B^2);
C2q3B = (B1q3B*Z1B - B2q3B*Z2)/(B1q3B^2 + B2q3B^2);
q2B = atan2(S2q3B, C2q3B); %----------------------------q2
%Obtencion de q2BP con q3BP
B1q3BP = X+Y*cos(q3BP); 
B2q3BP = Y*sin(q3BP);
S2q3BP = (B1q3BP*Z2 + B2q3BP*Z1B)/(B1q3BP^2 + B2q3BP^2);
C2q3BP = (B1q3BP*Z1B - B2q3BP*Z2)/(B1q3BP^2 + B2q3BP^2);
q2BP = atan2(S2q3BP, C2q3BP);%--------------------------q2

<<<<<<< HEAD
S(:,:,1) = [q1A q2A q3A]
S(:,:,2) = [q1A q2AP q3AP]
S(:,:,3) = [q1B q2B q3B]
S(:,:,4) = [q1B q2BP q3BP]

x = length(S);
j = 0;
i = 0;
for j = 1:x
    Sp = S(:,:,j);
    for i = 1:3
        if(Sp(i)<0)
            Sp(i)=Sp(i)+(2*pi);
        end
    end
    S(:,:,j) = Sp;
end

allSol = S;

j_salida=2;
q1_limit = pi;
q2_limit = pi;
q3_limit = pi;
S_label = ["Seleccione"]; %default

Salida(:,:,1) = [0 0 0]; %Si no matchea con ninguna, vuelve a home
for j = 1:x
    Sp = S(:,:,j);
    %Casos en que se sale de los rangos
    if(Sp(1)<0 || Sp(1)>q1_limit)
        continue %se sale de esta vuelta del loop sin checar nada m[as
    end
    if(Sp(2)<0 || Sp(2)>q2_limit)
        continue %se sale de esta vuelta del loop sin checar nada m[as
    end
    if(Sp(3)<0 || (Sp(3)+pi/2)>q3_limit)
        continue %se sale de esta vuelta del loop sin checar nada m[as
    end
    %Es +1 para que se salte los 0 del label "Selecciona"
    Salida(:,:,j_salida) = Sp; %Los que sí cumplen
    j_salida = j_salida +1;    

    %Esto es para facilitar cosas en la GUI 
    if(j == 1)
        S_label = [S_label "Solución 1"];
    elseif(j == 2)
        S_label = [S_label "Solución 2"];
    elseif(j == 3)
        S_label = [S_label "Solución 3"];
    elseif(j == 4)
        S_label = [S_label "Solución 4"];
    end
end

S1deg = rad2deg([q1A q2A q3A])
S2deg = rad2deg([q1A q2AP q3AP])
S3deg = rad2deg([q1B q2B q3B])
S4deg = rad2deg([q1B q2BP q3BP])


sigma = [0 0 0]; %0R 1P
a =     [0 L2 L3];
alpha = [pi/2 -pi -pi/2];
d =     [L1 0 0];
q =     S(:,:,2);
theta = [q(1) q(2) q(3)];
T = GENDGM(sigma,a,alpha,d,theta,q)

=======

S1 = [q1A q2A q3A]
S2 = [q1A q2AP q3AP]
S3 = [q1B q2B q3B]
S4 = [q1B q2BP q3BP]
>>>>>>> 0287c397ab8541cc9eb47860c7e880a02bd4a7bc

end