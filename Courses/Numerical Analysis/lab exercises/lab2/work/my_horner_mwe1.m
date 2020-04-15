clear all; close all; clc
p = @(x)(x-2).^3;
q = @(x)x.^3 - 6.*x.^2 + 12.*x - 8;
x = linspace(-1,1,101).*2.^(-15) + 2;

[y,aeb,reb] = my_horner([-8, 12, -6, 1], x);

figure(1)
plot(x,aeb)
hold on;
plot(x,reb)
plot(x,p(x))
plot(x,y)
legend('aeb', 'reb', 'p(x)', 'q(x)')


figure(2)
plot(x, abs(y))
hold on;
plot(x,reb)
plot(x,aeb)

indx=find(abs(y)>reb)
safe_sign_y = y(indx)

figure(3)
plot(x(indx),abs(safe_sign_y))