function [R] = rotZaxis(angulo)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
a=cos(angulo);
b=sin(angulo);
R=[a -b  0 0;
   b  a  0 0;
   0  0  1 0;
   0  0  0 1];
end

