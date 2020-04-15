clear all; close all; clc;
n = 1000;
X = zeros(2,n);
Z = zeros(1,n);

for i = 1:n
    rng(i)
    A = [2,3;3,1;0,-1];
    b = [930,800,-100];

    Aeq = [];
    beq = [];
    lb = [0,0]; 
    ub = [inf,inf];

    c1 = normrnd(500,100);
    c2 = normrnd(650,50);

    f = -1 .* [c1,c2];
    [x, z] = linprog(f,A,b,Aeq,beq,lb,ub);
    X(:,i)=x;
    Z(1,i)=-z;
end

v1 = round(X) == [210;170];
v2 = round(X) == [0;310];

percentage_210_170 = length(find(all(v1 == 1)))/n
percentage_0_310 = length(find(all(v2 == 1)))/n
