clear all; close all; clc;
f=@(t,y) y; 
t0=0; 
t1=1; 
y0=1;
N1=10; 
N2=1; 
method='rk1';
K=14;
y_vals=[];

for k=1:K
    N2=N2*2;
    [~, y] = rk(f,t0,t1,y0,N1,N2,method);
    y_vals=[y_vals; y];
end

y_true=exp(ones(14,11));

rel_err=log(max(abs((y_true-y_vals)./(y_true))));
plot(0:0.1:1,rel_err)