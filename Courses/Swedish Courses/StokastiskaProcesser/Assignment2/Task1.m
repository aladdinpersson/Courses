% Task 1
% Clear everything in case of unecessary bugs.
clear all; close all; clc

% Transition matrix
P = [0.5 0.3 0.2; 0.4 0.5 0.1; 0.4 0.2 0.4];

% Number of simulations
N = 1000;
% Number of days car will be rented (Steps in markvov chain)
T = 365;
% Creating a empty vector for memory allocation with 1 row and T kolonns
X = zeros(1,T);
% Randomly choosing a startlocation (state 1, state 2 or state 3)
X(1) = ceil(rand*3);

% Creating three empty vector for memory allocation with 1 row and N kolonns
a = zeros(1,N);
b = zeros(1,N);
c = zeros(1,N);

% Simutlate 1000 times
for i=1:N
    
    % Simulate 365 steps in the markov chain.
    for k=2:T
        X(k)=InverseTransform(P(X(k-1),:));
    end
    
    % For every simulated chain, count the amount of 1,2 and 3 and take the
    % mean of them each.
    a(i) = mean(X==1);
    b(i) = mean(X==2);
    c(i) = mean(X==3);
 
end

% Display the final result of the simulation.
SimulatedResult(1,1) = mean(a);
SimulatedResult(2,1) = mean(b);
SimulatedResult(3,1) = mean(c);

SimulatedResult


% Show the analytic answer to the problem. Most of the calculation is done
% by pen and paper. Using the invers to find the asymptotic distribution.
A = [-0.5 0.4 0.4; 0.3 -0.5 0.2; 1 1 1];
V = [0;0;1];
AnalyticResult = A\V