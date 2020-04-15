clear all; close all; clc

% example case
p = [0.1, 0.1, 0.1, 0.1, 0.6];
n = length(p);
% u = 0.05;
N = 1e6;
X = zeros(1,N);

plot(cumsum(p))
for k = 1:N
    u=rand;
    for i = 1:n-1
        lower = sum(p(1:i));
        upper = sum(p(1:i+1));

        if u < p(1)
            x=1;
            break
        elseif (u < upper & u > lower & upper==1)
            x=n;
            break
        elseif lower <= u <= upper
            x=i;
            break
        end
    end
    X(1,k)=x;
end

% sum(p(1:4))
% sum(p(1:3))

% hist(X)