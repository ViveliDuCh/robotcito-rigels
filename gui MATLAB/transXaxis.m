function [R] = transXaxis(distancia)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
b=distancia;
    R=[1 0 0 b;
       0 1 0 0;
       0 0 1 0;
       0 0 0 1];
end

