clear all; close all; clc

% amount of successes r, amount of simulations N, each with prob p
p = 0.5; % ex a coin
r = 50;
N = 1e5;

Ur=rand(N,r);
X=sum(floor(log(Ur)./(log(1-p))+1), 2);

figure(2)
histogram(X, 'Normalization', 'pdf')