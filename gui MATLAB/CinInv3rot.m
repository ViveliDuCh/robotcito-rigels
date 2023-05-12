clc
close all

syms q1 q2 q3 real;
syms L1 L2 L3 real;
syms D1 real;
pi = sym(pi);
L = [L1 L2 L3];
q = [q1 q2 q3];
sigma = [0 0 0]'; %0R 1P
a = [0 L(2) L(3)]';
alpha = [pi/2 0 0]';
d = [D1 0 0]';
theta =  [q(1) q(2) q(3)]';
[T, trans] = GENDGM(sigma, a, alpha, d, theta, q);
T = simplify(T)

syms SX SY SZ PX real
syms NX NY NZ PY real
syms AX AY AZ PZ real

U = [SX NX AX PX; SY NY AY PY; SZ NZ AZ PZ; 0 0 0 1];

T01 = trans(:,:,1)
T12 = trans(:,:,2)
T23 = trans(:,:,3)

simplify(inv(T01)*U)
simplify(T12*T23)