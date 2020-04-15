clear all; close all; clc

% x1 = antal gram av havregrynsgröt
% x2 = antal gram av kyckling
% x3 = antal gram av standardmjölk
% x4 = antal gram av körsbärspaj
% x5 = antal gram av fläsk och bönor

% min x1 + x2 + x3 + x4 + x5

% subject to (392/100)x1+(205/100)x2 + .... >= 2000
% subject to (14/100)x1 + ... >= 55
% 

f = [1,1,1,1,1];
A = [-392,-205,-67,-247,-100;
      -14, -32, -3, -2, -5;
      -7,-12,-120,-13,-31];
A = A .* (1/100);
b = [-2000,-55,-800];

lb = [0,0,0,0,0];
ub = [inf,inf,inf,inf,inf];


[x,fval] = linprog(f,A,b,[],[],lb,ub)
x


