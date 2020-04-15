% RINTMWE1  Minimal working example for RINT
clear all; close all; clc;

% Interval
a=0; b=1; 

% Function
f=@(x)exp(x) .* sin(x); 

% Integration rule
rule=@(y,a,b,N)trapezoid(y,a,b,N); 

% Theoretical order of the method 
p=2; 

% Number of refinements
kmax=24; 

% True value of the integral 
val=1/2*(1+ exp(1)*sin(1)- exp(1)*cos(1));

% Apply Richardson's techniques
data=rint(f,a,b,rule,p,kmax,val);

% Print the information nicely
rdifprint(data,p)

% 2^p - F_h <= logC + (q-p)*log(h)
% slope of line is 2, hence 2 = q-p, -->q=4
% points= 4 - data(:,3);
% K=log(abs(points));
% figure(2)
% plot(K)

% figure(2)
% plot(points)

% Rel.error ~= E_h / A_h, first element is k=0, second k=1, etc.
% data(:,4)./ data(:,2)