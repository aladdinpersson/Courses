% MyChebyshevMWE1 Minimal working example for MyChebyshev function

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen
%   2018-11-14 Skeleton extracted from working code

% PROGRAMMING by Aladdin Persson
%   2018-11-17 Initial programming

% clear variables for the sake of uneccessary bugs
clear all; close all; clc

% Set number of polynomials
n = 6;

% Set number of sample points
m = 1000;

% Define sample points
x = linspace(-1,1,m);

% Generate function values
y = MyChebyshev(n, x);

% Plot all graphs with one command
plot(x,y)

% Adjust axis to make room for legend
ylim([-1.5,2.5])

% Construct and display legend
str=[];
for i=0:n-1
    str=[str strcat("n=",string(i))];
end

% Add legend
legend(str);
