function [R] = rotXaxis(angulo)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
a=cos(angulo);
b=sin(angulo);
R=[1  0   0 0;
   0  a  -b 0;
   0  b   a 0;
   0  0   0 1];
end

