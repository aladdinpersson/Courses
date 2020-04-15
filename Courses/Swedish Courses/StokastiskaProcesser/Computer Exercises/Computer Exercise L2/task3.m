clear all; close all; clc
u = rand;
n = 10;

xv = [5:14];
p = repmat([0.11,0.09],1,5);
c = 1.10;
N = 1e6;
X = zeros(1,N);
for k = 1:N
    while 1
        j= ceil(n*u);
        y = xv(j);
        u = rand;
        if u < p(j)/(c.*0.10)
            X(1,k) = y;
            break
        end
    end
end

hist(X)




