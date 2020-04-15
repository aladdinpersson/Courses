%% Vectorized

clear all; close all; clc
tic
% amount of successes r, amount of simulations N, each with prob p
p = 0.5; % ex a coin
r = 50;
N = 5e5;

U=rand(N,r);

% Inverse transform method geometric
X=sum(floor(log(U)./(log(1-p))+1), 2);

% figure(2)
% histogram(X, 'Normalization', 'pdf')
toc
%% Loops
clear all; close all; clc
tic
% amount of successes r, amount of simulations N, each with prob p
p = 0.5; % ex a coin
r = 50;
N = 5e5;
X = zeros(1,N);

Ur=rand(1,r);

for j = 1:N
    t=0;
    for i = 1:r
        u = rand;
        x = floor(log(u)./(log(1-p)))+1;
        t=t+x;
    end
    X(1,j)=t;
end

% figure(2)
% histogram(X, 'Normalization', 'pdf')
toc
%% Extra

% Plot for geometric distribution to understand how it looks like
% p=1/6;
% x=1:0.01:10;
% geometric = (1-p).^(x-1).*p;
% figure(1)
% plot(x,geometric)