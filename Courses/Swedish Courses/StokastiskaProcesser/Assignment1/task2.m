% make sure nothing is saved in variables to potentially cause errors
clear all; close all; clc

% From calculations, found c = 1.52..., so c = 1.53 is safe choice.
% Can also be checked from graph f(x)/g(x)
c=1.53;
mu = 0;
sigma=1;

% f(x) normal distribution, specifically standard normal
f = @(x) 1./(sqrt(2.*pi).*sigma).*exp(-(x-mu).^2./(2.*sigma.^2));
% g(x) cauchy distribution
g = @(x) 1./pi .* (1./(1+x.^2));

% r(x) is ratio between f(x) and g(x), used to decide constant c.
% r=@(x) f(x)./g(x);

% generate x points to plot functions
x=-10:0.01:10;

figure(1)
plot(x,f(x),x,g(x),x,c.*g(x))
legend('f(x)', 'g(x)', 'c*g(x)')

% Can't figure out a good way to vectorize this part.
N = 1e6;
X = zeros(1,N);
for i = 1:N
    while 1
        u1 = rand;
        y = tan(u1.*pi-1./2.*pi);
        u = rand;
        
        if c.*g(y)*u < f(y)
            x = y;
            break
        end
    end
    X(1,i)=x;
end

figure(2)
histogram(X,'Normalization','pdf')