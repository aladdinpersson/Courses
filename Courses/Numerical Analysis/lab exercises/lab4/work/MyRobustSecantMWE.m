clear all; close all; clc

x = linspace(-5,5);
% Define the function
f=@(x) x.^2 + x - 6;

plot(x,f(x))


