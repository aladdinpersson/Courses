clear all; close all; clc;

% Amount of simulations N
N=1e4;

% Generate from standard normal
Z=randn(1,N);

% Initial values
S0=100;
r=0.01;
sigma=0.3;

% points
t = zeros(1,N) + 1;

% Simulate points from geometric brownian motion
S =@(t) exp(log(S0)+(r - sigma.^2 .* 1/2).*t + sigma .*sqrt(t).*Z);

% Calculate mean
xbar=mean(S(t))

% confidence interval
upper=xbar + 1.96*std(S(t))./sqrt(N);
lower=xbar - 1.96*std(S(t))./sqrt(N);