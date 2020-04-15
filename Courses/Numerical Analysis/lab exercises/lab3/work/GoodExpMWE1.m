clear all; close all; clc

% Generate points
x=linspace(-30,30,1025);

% Generate y-values for those points using BadExp
good_exp=GoodExp(x);

% For fun compare with true exp
matlab_exp=exp(x);

% Plot BadExp and MatLab
plotexps=0;
if plotexps
    figure(1);
    plot(x,good_exp)
    xlabel('x coordinate')
    ylabel('BadExp')
    hold on
    plot(x,matlab_exp)
    legend('BadExp','MatLabExp')
end

% Plot relative error
plotrelerror=0;
relerror=(matlab_exp-good_exp)./(matlab_exp);
R=log10(abs(relerror));
if plotrelerror
    figure(2);  
    plot(x,R)
    xlabel('x')
    ylabel('log10abs(relative error)')
end

% Check what the max value of the abs value of the relative error
max_relerror=max(abs(relerror));
U =2^(-53);
upperrel_bound=12*U;
upperrel_bound>=max_relerror