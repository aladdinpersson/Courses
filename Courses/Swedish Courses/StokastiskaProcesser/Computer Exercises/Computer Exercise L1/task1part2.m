clear all; close all; clc

N = 1000;
x = zeros(1,N);
x(1,1) = 3;
a = 5;
c = 7;
for k = 1:N
    x(1,k+1) = mod(a.*x(k)+c,200);
end

%plot(x)
hist(x)