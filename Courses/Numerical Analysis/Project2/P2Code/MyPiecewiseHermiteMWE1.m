% Minimal working example for function MyPiecewiseHermiteMWE1

% Programming by Aladdin Persson (alhi0008@student.umu.se)
%   2018-12-08 Initial programming

clear all; close all; clc;

% Interval
a=0; b=1;

% Maximum number of iterations
maxit=20;

% Allocate space
n=zeros(maxit,1); mre=zeros(maxit,1);

% Points for comparison
t=linspace(a,b,100*maxit+1);

% Target function
f=@(x)exp(x).*sin(x);

% Derivative of target function
fp=@(x)exp(x).*sin(x)+exp(x).*cos(x);

% Loop over the number of sample points
for j=1:maxit
    
    % Number of sample points
    n(j)=10*j;
    
    % Sample points
    s=linspace(a,b,n(j)+1);
    
    % Separation between points
    h=(b-a)/n(j);
    
    % Evaluate y=f(s)
    y=f(s);
    
    % Evaluate yp=f'(s) exactly
    yp=fp(s);
    
    % Evaluate yp=f'(s) using an approximation
    % This has surprising consequences
    %yp=MyDerivs(y,h);
    
    % Define Hermite approximation
    z=@(t)MyPiecewiseHermite(s,y,yp,t);
    
    % Define relative error function
    R=@(t)(f(t)-z(t))./f(t);
    
    % Maximum relative error
    mre(j)=max(abs(R(t)));
end

% Plot a suitable transformation of the data 
plot(log10(n),log10(mre)); 

% Labels
xlabel('log_{10}(n)'); ylabel('log_{10}(max(abs(relative error)))');

% Turn on the grid 
grid on; grid minor;

% Print the figure to a file
% print('MyPiecewiseHermite','-depsc2');