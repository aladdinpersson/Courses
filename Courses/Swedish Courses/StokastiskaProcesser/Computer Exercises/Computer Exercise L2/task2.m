clear all; close all; clc
N = 1e6;
X = zeros(1,N);

for k = 1:N
    u = rand;
    if u < 0.1
        x = 1;
    elseif u < 0.3
        x = 2;
    elseif u < 0.6
        x = 3;
    elseif u < 1.0
        x = 4;
    end
    X(1,k) = x;
end

mu = 3; % Calculated expecteed value
mu_approx = mean(X) % Calculated mean
upper_bound = mean(X) + std(X) .* 1.96 ./ sqrt(N);
lower_bound = mean(X) - std(X) .* 1.96 ./ sqrt(N);

prob_1 = sum(X==1)/(sum(X==1)+sum(X==2)+sum(X==4)+sum(X==5)); % prob of X = 1
prob_2 = sum(X==2)/(sum(X==1)+sum(X==2)+sum(X==4)+sum(X==5)); % prob of X = 2
prob_3 = sum(X==3)/(sum(X==1)+sum(X==2)+sum(X==4)+sum(X==5)); % prob of X = 4
prob_4 = sum(X==4)/(sum(X==1)+sum(X==2)+sum(X==4)+sum(X==5)); % prob of X = 5
% hist(X, [1:6])
% X