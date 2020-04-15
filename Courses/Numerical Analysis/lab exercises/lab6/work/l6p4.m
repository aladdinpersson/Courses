% RINTMWE1  Minimal working example for RINT
clear all; close all; clc;

% Point to differentiate
x=3;

% Function
f=@(x)exp(x); 

% Integration rule
% rule=@(y,a,b,N)trapezoid(y,a,b,N); 

% differentiation rule
fpapprox = @(f, x,h) (f(x+h)-f(x-h))./(2*h);

% Theoretical order of the method 
p=2; 

% initialize stepsize
h0=0.5; 

% Number of refinements
kmax=24; 

% True f'
df=@(x)exp(x);

% Apply Richardson's techniques
data=rdif(f,x,fpapprox,p,h0,kmax,df);

% Print the information nicely
rdifprint(data,p)

format longE
% Mh = data(2:end,2)+(data(2:end,2)-data(1:end-1,2))./(2^2 - 1)