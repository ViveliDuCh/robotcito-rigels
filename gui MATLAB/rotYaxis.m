function [R] = rotYaxis(angulo)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
a=cos(angulo);
b=sin(angulo);
R=[ a  0  b 0;
    0  1  0 0;
   -b  0  a 0;
    0  0  0 1];
end

