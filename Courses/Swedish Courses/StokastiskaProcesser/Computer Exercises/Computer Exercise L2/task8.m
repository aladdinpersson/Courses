clear all; close all; clc
% Task:
% Pair of dice are to be rolled continuously until all possible values
% 2,3,4,5,...,12 outcomes have been rolled at least once. 

N = 1e4;
nv = zeros(1,N);
for k = 1:N
    n = 0;
    x = zeros(1,11);
    while any(x == 0)
        dice1 = ceil(rand * 6);
        dice2 = ceil(rand * 6);
        tot = dice1+dice2;
        x(tot-1) = 1;
        n = n + 1;
    end
    nv(k)=n;
end

mean(nv)

% A : about 61 rolls