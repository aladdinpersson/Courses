clear all; close all; clc

% fixed number of successes r (arbitrary)
r = 50;

% prob of success p (arbitrary)
p=0.5;

% pr is P(X=r), the probability to get all "throws" correct 
pr = p.^r;

% Store all probabilities in a vector y
y = [pr];

%Initialize j to be amount of successes, r
j=r;

% Set y >= pr such that when the probability returns to equal that
% probability of which P(x=r) then stop generating new.

while sum(y)<=1
    y(1,j-r+2) = (j.*(1-p))./(j+1-r) .* y(1,j-r+1);
    j=j+1;
end

X=[r:length(y)+49];


% Cumulative sum makes it into the cdf F
F=cumsum(y);

plot(X,F)
% Now we have the cdf and we can generate N points x
% N=1e5;

%Simulated values of neg. binomial distribution X
% X_sim = zeros(1,N);
% 
% for k=1:N
%     u = rand;
%     X_sim(1,k)= X(max(find(u>F)));
% end

% Plot to see if correct
% histogram(X_sim,'Normalization','pdf')
% xlabel('Amount of trials')
% ylabel('Probability')