clear all; close all; clc;

% Set trial function
f=@(x)exp(x); 

% Set point where we want to estimate the derivative
x=1; 

% Define the finite difference approximation
D1=@(f,x,h)(f(x+h)-f(x-h))./(2*h); 
M=@(f,x,h) D1(f,x,h) + (D1(f,x,h)-D1(f,x,2*h))./(4-1);

%+ (D(f,x,h)-D(f,x,2*h))./(2^2 - 1)

% Set the theoretical order of the method
p=4; 

% Set the basic stepsize
h0=0.125; 

% Set the number of times we will reduce the stepsize by a factor of 2
kmax=10; 

% Define the real derivative
df=@(x)exp(x);

% Apply Richardson's techniques
data=rdif(f,x,M,p,h0,kmax,df);

% Print the information nicely
rdifprint(data,p)