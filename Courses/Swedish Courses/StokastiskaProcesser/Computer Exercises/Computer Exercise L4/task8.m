clear all; close all; clc
sigma=1;

% sim for amount of simulations
sim = 1e4;
maxval=zeros(1,sim);
for s = 1:sim
    % [0,T], stepsize, points
    T = 3;
    dt=0.001;
    t = 0:dt:T;
    N=T/dt;
    X = sigma*sqrt(dt)*randn(1,N);
    W = [0,cumsum(X)];
    maxval(1,s)=max(W);
end

mean(maxval>1)
