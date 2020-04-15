% RINTMWE1  Minimal working example for RINT

clear all; close all; clc;
% Interval
a=0; b=3; 

% Function
f=@(x) 1/(sqrt(pi)) * exp(-x.^2); 

% Integration rule
rule=@(y,a,b,N)trapezoid(y,a,b,N); 


% Theoretical order of the method 
p=2; 

% Number of refinements
kmax=24; 

% True value of the integral 
val=erf(3)/2;

% Apply Richardson's techniques
data=rint(f,a,b,rule,p,kmax,val);

% Print the information nicely
rdifprint(data,p)


% Rel.error ~= E_h / A_h, first element is k=0, second k=1, etc.
format shortE
data(:,4)./ data(:,2)