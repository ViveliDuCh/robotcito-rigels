function [R] = transZaxis(distancia)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    b=distancia;
    R=[1 0 0 0;
       0 1 0 0;
       0 0 1 b;
       0 0 0 1];
end

