clear all; close all; clc;

f = @(x) exp(x)./(exp(1)-1);
g = @(y) 1;

c = (exp(1)/(exp(1)-1));
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
X
% histogram(X,'Normalization','pdf')