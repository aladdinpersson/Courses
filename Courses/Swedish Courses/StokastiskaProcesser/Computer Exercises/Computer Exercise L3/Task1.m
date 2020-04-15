clear all; close all; clc
% tic

% p for probability to take step forward
p = 0.7;

% q for probability to take step backward
q = 1-p;

% amount of steps to take
steps = 10;

% amount of simulations
N=1e4;

% Vector R to store the result
R = zeros(1,N);

% vector v with N simulations, 10 steps each simulation and probability
% p that each element is 1, q that each element is -1
v=ones(N,steps);
u=rand(N,10);
v(u<=q)=-1;

total_walk = cumsum(v,2);

reached_one = (sum(total_walk == 1, 2) >= 1) == 1;
prob_1 = mean(reached_one)

reached_five = (sum(total_walk == -5, 2) >= 1) == 1;
prob_neg5 = mean(reached_five)

reached_10 = (sum(total_walk == 10, 2) >= 1) == 1;
prob_10 = mean(reached_10)

% toc