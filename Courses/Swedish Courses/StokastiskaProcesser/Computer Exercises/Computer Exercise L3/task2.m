clear all; close all; clc

% Declare initial amount
tot = 10;
a=1;
b=tot-a;

% Amount of simulations
N=1e5;

% probability p to win, q to lose each round
p=0.4;
q=1-p;

E=zeros(N,9);

for n=1:N
    for j = 1:tot-1
        a=j;
        b=10-a;
        r=0;
        while a ~= 0 && b ~= 0
            u=rand;
            if u < p
                a=a+1;
                b=10-a;
            else
                a=a-1;
                b=10-a;
            end
            r=r+1;
        end
        E(n,j)=r;
    end
end

mean(E)