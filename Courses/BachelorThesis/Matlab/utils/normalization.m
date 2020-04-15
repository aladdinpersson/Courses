% Runs normalization on X, computes
% X <-- (X - mu) / sigma

function [X_train, X_test] = normalization(X_train, X_test)
mu = mean(X_train,1);
size(mu)
X_train = X_train - mu;
X_test = X_test - mu;
sigma_squared = sum(X_train.^2) ./ size(X_train,1);
size(sigma_squared)
X_train = X_train ./ (sqrt(sigma_squared) + 1e-6);
X_test = X_test ./ (sqrt(sigma_squared) + 1e-6);
disp("Data normalized")
end