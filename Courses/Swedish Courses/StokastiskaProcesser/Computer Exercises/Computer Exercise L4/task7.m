clear all; close all; clc

rng(1)

N=1e2;
sell=zeros(1,N);

for k = 1:N
    % Initial values of geometric brownian motion
    S0=100;
    r=0.03;
    sigma=0.5;
    
    % Simulate on interval [0,T]
    T=50;
    
    % Discretisation step
    dt=0.01;
    t = 0:dt:T;
    
    % Number of points to simulate N
    N = T/dt;
    X = randn(1,N)*sqrt(dt);
    W = [0 cumsum(X)];
    S = S0 * exp((r-sigma.^2/2)*t + W*sigma);
    sell(1,k) = S(N+1);
    plot(t,S)
    hold on;
end

% Amount of times it was possible to earn 50 SEK
mean(sell>150)