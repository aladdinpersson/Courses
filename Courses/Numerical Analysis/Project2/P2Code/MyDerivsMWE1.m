% MyDerivsMWE1  Minimal working example for MyDerivs function.

% Programming by Aladdin Persson (alhi0008@student.umu.se)
%   2018-12-08 Initial programming

clear all; close all; clc;

% Interval
a=0; b=1;

% Maximum number of iterations
maxit=20;

% Allocate space
n=zeros(maxit,1); mre=zeros(maxit,1);

% Loop over the number of sample points
for j=1:maxit
    
    % Number of sample points
    n(j)=100*j;
    
    % Sample points
    x=linspace(a,b,n(j)+1);
    
    % Function values
    y=exp(x).*sin(x);
    
    % Separation between points
    h=(b-a)/n(j);

    % Approximate first order derivative
    yp=MyDerivs(y,h);
    
    % Exact derivative
    z=exp(x).*sin(x) +exp(x).*cos(x);
    
    % Relative error
    re=(z-yp)./z;
    
    % Maximum relative error
    mre(j)=max(abs(re));
end

% Plot maximum relative error as a function of n
plot(log10(n),log10(mre)); 

% Grids
grid on; grid minor;

% Labels
xlabel('log_{10}(n)'); ylabel('log_{10}(max(abs(relative error)))');

% Print the figure to a file
% print('MyDerivs','-depsc2');