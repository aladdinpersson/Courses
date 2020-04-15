% clear all; close all; clc

% Simulate interval [0,T]
T=1;              

% Variance parameter
sigma=1;

% Discretisation step
dt=0.0001;

% Simulated time steps vector.
t=0:dt:T;           

% Amount of point simulated N
N=T/dt;

% Simulates N random numbers from N(0,1)
Z=randn(1,N);       

% Transforming numbers to N(0,t(1-t))
X=sqrt(dt).*Z;

% Constructing Brownian motion approximation
W=[0 cumsum(X)];

W1=W(end);

X=W-t*W1;

plot(t,X)
hold on;