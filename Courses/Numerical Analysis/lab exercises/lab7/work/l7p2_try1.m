% Demonstrate Richardson's technique for a simple 1D problem

% Define the interval
a=0; b=2;

% Select the function which defines the differential equation
f=@(t,y) 1-y.^2; 

% Specify the initial condition
y0=0;

% Select the number of timesteps
N1=10; N2=100; 

% Select the number of approximations
kmax=7;

% Specify the method to use and the *correct* order
method='rk4'; p=1; 

% The exact solution can be computed 
sol=@(t)tanh(t);

% Apply Richardson's techniques to our initial value problem
[s, frac, est, err]=rode(f,a,b,y0,N1,N2,kmax,method,p,sol);











% clear all; close all; clc
% 
% % MWE for mypsi which implements runge kutta method for f(x)=e^x
% 
% f=@(t,y) exp(t);
% y0=exp(0);
% t0=0;
% tend=1;
% K=15;
% y_approx = zeros(K,2);
% y_approx(:,1)=0;
% dt=2;
% 
% for k = 1:K
%     N=(tend-t0)/dt;
%     y=0;
%     for i = 1:N
%         t=t0+dt*i;
%         y_approx(k,i+1)=mypsi(f,t,y_approx(k,i),dt);
%     end
%     dt=dt/2;
% end
% 
% rel=((exp(1)-1)-y_approx)./(exp(1)-1);
% plot(1:K,rel)
% 
