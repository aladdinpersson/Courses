clear all; close all; clc
format long;
g = @(x) exp(x);
true = exp(1) - 1;

N = [1e2, 1e3, 1e4, 1e5, 1e6, 1e8];

est_error = [];
for k = 1:length(N)
    U = rand(1,N(k));
    approx = mean(g(U));
    est_error(k) = abs(true-approx);
    fprintf('for N = % 0.1e ', N(k));
    fprintf('we get estimated error of: % 2.8e \n', est_error(k))
end