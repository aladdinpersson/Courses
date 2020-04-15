function [accuracy,predictions] = check_accuracy(X, y, parameters, lambda, activation)
m = size(X,1);
[y_hat, ~, ~] = forward_propogation(X, y, parameters, m, lambda, activation);
[~, predictions] = max(y_hat,[], 2);

% MatLab is 1 indexed and y labels start from 0 so we have to subtract 1
predictions = predictions - 1;
accuracy = sum(y==predictions')/m;
end