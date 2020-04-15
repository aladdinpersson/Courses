clear all; close all; clc

% set a specific seed, to analyse easier
rng(1)

N=1e3;
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
    
    if min(find(S>150))
        sell(1,k)=S(min(find(S>150)));
    end
%     plot(t,S)
%     hold on;
end

% Amount of times it was possible to earn 50 SEK
mean(sell>150)