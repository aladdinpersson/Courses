%% Run at start to initialize variables

% make sure nothing is saved in variables to potentially cause errors
clear all; close all; clc

% Use formula that mean = 1/lambda
lambd=1/800;

% probability density function (pdf) for exponential distribution
f = @(x) lambd.*exp(-lambd.*x);

% cumulative distribution function (cdf) for exponential distribution
F=@(x) 1 - exp(-(x./800));

% generate points x in vector xv
xv=0:0.01:5000;

%% 3,a)
N=1000;

% N IID uniform (0,1) elements in vector v 
U = rand(1,N);

% Use inverse-transform method to obtain X for given U (vectorized)
claims = log(1-U).*(-800);

histogram(claims,'Normalization','pdf')
hold on

plot(xv,f(xv),'LineWidth', 2)

%% 3,b)
clc

% generate 1000 policyholders
policy_holders=rand(1,1000);

% we know that one policy holder makes a claim per month is p=0.05
% so if we sum all we get a simulation of number of claims in a month
number_of_claims = sum(policy_holders<0.05)
U = rand(1,1000);

%% 3,c)
clc;

% Generate 1000 IID uniform numbers (0,1)
% Obs! Need two of them so that claims and number_of_claims are indepedent
U1=rand(1,1000);
U2=rand(1,1000);

% from 3,a) we calculate claims
claims = log(1-U1).*(-800);

% from 3,b) we calculate number of claims
number_claims = (U2<0.05);

total_claim = sum(claims.*number_claims)


%% 3,d)
clear all; close all; clc

% K number of simulations
K=1e4;

% Create vector total_dollars to store the total amount of dollars claimed
% over an entire month.
total_dollars=zeros(1,K);

% For each k:th simulation we need to do a simulation of 1000 individuals 
N=1e3;

% Generate K amount of simulations each having 1000 individuals
U1=rand(K,N);
U2=rand(K,N);

% Generate claims for each KxN individuals
claims=log(1-U1).*(-800);

% Generate number of claims for each KxN simulation
number_of_claims=(U2<0.05);

% Indicator function 
I=sum(claims.*number_of_claims,2)>50000;
percentage = mean(I);

lower=mean(I)-1.96.*std(I)./sqrt(N);
upper=mean(I)+1.96.*std(I)./sqrt(N);

fprintf('The lower bound for 95%% confidence interval is %3.3d%%\n', lower*100)
fprintf('The percentage for all %d simulations is %3.3d%%\n', K, percentage*100)
fprintf('The upper bound for 95%% confidence interval is %3.3d%%', upper*100)