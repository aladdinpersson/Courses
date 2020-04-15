% RINTMWE1  Minimal working example for RINT
clear all; close all; clc;

% Interval
a=-1; b=1; 

% Function
f=@(x) sqrt(1-x.^2); 

% Integration rule
rule=@(y,a,b,N)trapezoid(y,a,b,N); 

% Theoretical order of the method 
p=1.5; 

% Number of refinements
kmax=24; 

% True value of the integral 
val=pi/2;

% Apply Richardson's techniques
data=rint(f,a,b,rule,p,kmax,val);

% Print the information nicely
rdifprint(data,p)
