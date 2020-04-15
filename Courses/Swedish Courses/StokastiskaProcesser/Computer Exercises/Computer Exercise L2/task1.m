clear all; close all; clc
N = 1e6;
X = zeros(1,N);

for k = 1:N
    u = rand;
    if u < 0.3
        x = 1;
    elseif u < 0.5
        x = 2;
    elseif u < 0.85
        x = 4;
    elseif u < 1
        x = 5;
    end
    X(1,k) = x;
end

mu = 2.85; % Calculated expecteed value
mu_approx = mean(X); % Calculated mean
upper_bound = mean(X) + std(X) .* 1.96 ./ sqrt(N);
lower_bound = mean(X) - std(X) .* 1.96 ./ sqrt(N);

prob_1 = sum(X==1)/(sum(X==1)+sum(X==2)+sum(X==4)+sum(X==5)); % prob of X = 1
prob_2 = sum(X==2)/(sum(X==1)+sum(X==2)+sum(X==4)+sum(X==5)); % prob of X = 2
prob_4 = sum(X==4)/(sum(X==1)+sum(X==2)+sum(X==4)+sum(X==5)); % prob of X = 4
prob_5 = sum(X==5)/(sum(X==1)+sum(X==2)+sum(X==4)+sum(X==5)); % prob of X = 5
% hist(X, [1:6])
% X





