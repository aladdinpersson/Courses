clear all; close all; clc

N = 1000;
x = zeros(1,N);
x(1,1) = 5;

for k = 1:N
    x(1,k+1) = mod(3.*x(k),150);
end

% plot(x)
hist(x)