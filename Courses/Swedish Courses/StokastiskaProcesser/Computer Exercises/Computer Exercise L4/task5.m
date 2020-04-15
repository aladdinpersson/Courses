clear all; close all; clc

% Initial values of geometric brownian motion
S0=100;
r=0.0001;
sigma=0.001;

% Simulate on interval [0,T]
T=5;

% Discretisation step
dt=0.0001;
t = 0:dt:T;
mu=0.00001;


% Number of points to simulate N
N=T/dt;

step=exp((mu-sigma.^2/2)*dt)*exp(sigma*randn(1,N+1)*sqrt(dt));
W=S0*cumprod(step);
plot(t,W)