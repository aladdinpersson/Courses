clear all; close all; clc

delta=2;
beta=3;
N=5e4;
X=zeros(1,N);
for j=1:N
    u=rand;
    x=nthroot(log(1-u),3).*(-delta);
    X(1,j)=x;
end

histogram(X)
mean(X<2)