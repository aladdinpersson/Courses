% make sure nothing is saved in variables to potentially cause errors
clear all; close all; clc

% fixed number of successes r (arbitrary)
r = 50;

% prob of success p (arbitrary)
p=0.5;

% X represents the trial number of the r'th success.
% (Ex. the amount of throws to get r 1's or 2's etc)

% N represents the number of simulations
N = 1e5;

% Create vector X to store number of trial from each simulation
X = zeros(1,N);

for i = 1:N
    % initialize with number of trials 0, successes 0.
    n=0;
    successes=0;
    while successes < r
        u=rand;
        if u < p
            successes = successes+1;
        end
        
        n=n+1;
    end
    %store number of trials in X
    X(1,i)=n;
end

histogram(X,'Normalization','pdf')
xlabel('Amount of trials')
ylabel('Probability')