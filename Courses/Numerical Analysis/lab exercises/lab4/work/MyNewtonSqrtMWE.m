clear all; close all; clc

MyNewtonSqrt(5)
% Define sample points
x=logspace(-3,3,1001);

% Compute target values
T = sqrt(x);

% % Compute approximations
A = MyNewtonSqrt(x);

% % Compute relative error
R = (T-A)./T;

% % Plot log10 of the absolute value of the relative error
plot(log10(x),log10(abs(R)));

% Compute the maximum of the absolute value of the relative error
mre=max(abs(R));

% % Display mre
fprintf('Max. absolute value of the relative error = %10.4e\n',mre);