clear all; close all; clc

N = 1e6;
x = zeros(1,N);
for i = 1:N
    u=rand;
    x(1,i) = log(u.*(exp(1)-1)+1);
end

histogram(x)