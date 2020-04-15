clear all; close all; clc

% Generate points
x=linspace(-30,30,1025);

% Generate y-values for those points using BadExp
bad_exp=BadExp(x);

% For fun compare with true exp
matlab_exp=exp(x);

% Plot BadExp and MatLab
plotexps=0;
if plotexps
    figure(1);
    plot(x,bad_exp)
    xlabel('x coordinate')
    ylabel('BadExp')
    hold on
    plot(x,matlab_exp)
    legend('BadExp','MatLabExp')
end

% Plot relative error
plotrelerror=1;
R=log10(abs((matlab_exp-bad_exp)./(matlab_exp)));
if plotrelerror
    figure(2);
    plot(x,R)
    xlabel('x')
    ylabel('log10abs(relative error)')
end

% Relative error less than one (relto)
re_lto = R<1;

% Find index where bad_exp returns negative values
idx = find(bad_exp<0);

% Find total amount of elements that are in fact negative
number_elements=numel(R(idx));

% Find out the values of x which create negative y-values
x_signs = sign(x(idx));