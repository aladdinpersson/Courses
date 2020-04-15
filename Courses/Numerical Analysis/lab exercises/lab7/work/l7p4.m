clear all; close all; clc;

f=@(t,y) viral(t,y);
t0=0; 
t1=60;

% S I R - start
y0=[0.99; 0.01; 0.0];

N1=100; 
N2=1e3;
method='rk1';

[t, y]=rk(f,t0,t1,y0,N1,N2,method);
plot(t,y')
legend('S','I','R')
% R has more than 0.85 at this point which is at timepoint=60
y(:,end)
stepsize = (t1-t0)./(N1);
timepoint= find(y(1,:) < 0.08, 1, 'first');
time_ofinterest = stepsize * timepoint