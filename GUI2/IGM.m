function [S1,S2,S3,S4] = IGM(PX,PY,PZ)
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
Z1A = PX*cos(q1A)+PY*sin(q1A);
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


S1 = [q1A q2A q3A]
S2 = [q1A q2AP q3AP]
S3 = [q1B q2B q3B]
S4 = [q1B q2BP q3BP]

end