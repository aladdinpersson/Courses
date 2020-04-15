clear all; close all; clc
f=@(x) 30*(x.^2-2.*x.^3+x.^4);
% g=@(x) 1*exp(-1/2*x);
g=@(y) 1;

xv = 0:0.01:1;
c = 2.0;
N = 1e6;
X=zeros(1,N);

for i = 1:N
    while 1
        y = rand;
        u = rand;
        
        if c.*g(y)*u < f(y)
            x = y;
            break
        end
    end
    X(1,i)=x;
end

histogram(X,'Normalization','pdf')
hold on;
plot(xv,f(xv),'LineWidth',2)