clear all; close all; clc;
% Set trial functiop
f=@(x)exp(x)*sin(x); 

% Set point where we want to estimate the derivative
x=2; 

% Define the finite difference approximation
D2=@(g,x,h)(g(x+h)-g(x-h))./(2*h); 

% Set the theoretical order of the method
p=2; 

% Set the basic stepsize
h0=0.125; 

% Set the number of times we will reduce the stepsize by a factor of 2
kmax=20; 

% Define the real derivative
df=@(x)exp(x)*sin(x)+exp(x)*cos(x);

% Apply Richardson's techniques
data=rdif(f,x,D2,p,h0,kmax,df);

% Print the information nicely
rdifprint(data,p);



