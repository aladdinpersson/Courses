% Task 2: Overture to asset pricing

%%% Purpose is to simulate the price evolution of an asset with geometric 
%%% brownian motion. We wish the probability that we will sell the asset
%%% before time step 10. We will sell whenever the price goes above 150.

% Clear everything in case of unecessary bugs.
clear all; close all; clc

% K amount of times to simulate the geometric brownian motion
K = 1e4;

% Initialize vector where we sell
sell=zeros(1,K);

for k=1:K
    % Initialize values, r-risk free rent, T = max time step, S0 initial price
    % and sigma, the volatility.
    r = 0.04;
    sigma=0.1;
    T=10;
    S0=100;

    % initialize dt, number of points N, t vector of all time points
    dt = 0.001;
    N = T/dt;
    t = 0:dt:T;

    % simulate standard brownian motion
    X = randn(1,N)*sqrt(dt);
    W = [0,cumsum(X)];

    % Transform standard brownian motion into geometric brownian motion
    S = S0*exp((r-sigma.^2/2)*t+W*sigma);

    %hold on
    %plot(t, S)
    %xlabel('Time, t')
    %ylabel('Price, S(t)')
    
    % find function with 1 means it finds the first index for which it is
    % true
    idx = find(S>150, 1, 'first');
  
    % Add if we sold at 150 else add at t=10
    if idx > 0
        sell(1,k) = S(idx);
    else
        sell(1,k) = S(end);
    end
end

% Create indicator function for when we sell early
I = ((sell>=150));

% What is the 95% confidence interval that we sell early?
% lower confidence interval sell early, mean sell early, upper confidence
% interval of sell early
lowerci_se = mean(I)-1.96*std(I)./(sqrt(K))
mean_se = mean(I)
upperci_se = mean(I)+1.96*std(I)./(sqrt(K))

% To calculate the profit we need to withdraw our initial investment
sell=sell-100;

% What is the 95% confidence interval of the expected profit?
lowerci_profit = mean(sell)-1.96*std(sell)./sqrt(K)
mean_profit = mean(sell)
upperci_profit = mean(sell)+1.96*std(sell)./sqrt(K)