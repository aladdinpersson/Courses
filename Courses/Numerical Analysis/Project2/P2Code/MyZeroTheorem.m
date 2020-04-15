clear all; close all; clc;

% Purpose of this script is to illustrate Rolle's theorem and the mean
% value theorem for differentiation.

% Programming by Aladdin Persson (alhi0008@student.umu.se)
%   2018-12-08 Initial programming

% Define a nice function
f=@(x)exp(x).*sin(x);

% Define the derivative fp (fprime) of f
fp=@(x) exp(x).*sin(x)+exp(x).*cos(x);

% Interval
a=0; b=pi;

% Number of subintervals
n=100;

% Sample points for plotting
x=linspace(a,b,n+1);

% Plot the graph
h=figure; plot(x,f(x));

% Hold the graph
hold on;

% Turn on grid
grid on;

% Axis tight
axis tight

% /////////////////////////////////////////////////////////////////////////
%  Illustration of Rolle's theorem
% /////////////////////////////////////////////////////////////////////////

% % Initial search bracket
x0=0;
x1=pi;

% The function values corresponding to the initial search bracket
% fp0, fp1 different signs means we can use bisection for this
fp0=fp(x0);
fp1=fp(x1);

% Tolerances and maxit for bisection.
delta=1e-8; eps=1e-8; maxit=1000; 

% Run the bisection algorithm to find the zero c of fp
[c,flag, it, a, b, his, res] = bisection(fp,x0,x1,fp0,fp1,delta,eps,maxit,false);

% Define the tangent at this point; this a constant function.
w=@(x)ones(size(x))*f(c);

% Plot the tangent
plot(x,w(x))
    
% /////////////////////////////////////////////////////////////////////////
%  Illustration of the mean value theorem
% /////////////////////////////////////////////////////////////////////////

% Define points for corde
x0=2; x1=pi;

% Compute corresponding function values
f0=f(x0);
f1=f(x1);

% Define the linear function which connects (x0,f0) with (x1,f1)
% Using point-slope formula
m = (f1-f0)./(x1-x0);
p = @(s) m*(x-x0) + f(x0);

% Plot the straight line between (x0,f0) with (x1,f1)
plot(x,p(x))
 
% Compute the slope of the corde
yp = m;

% Define an auxiliary function which is zero when fp equals yp
g=@(x) fp(x) - yp;

% Run the bisection algorithm to find a zero c of g
[c, flag, it, a, b, his, res] = bisection(g,x0,x1,g(x0),g(x1),delta,eps,maxit,false);

% Define the line which is tangent to the graph of f at the point (c,f(c))
% Using point slope formula
q = @(s) m.*(x - c) + f(c);

% % Plot the tangent line
plot(x,q(x));

% Labels
xlabel('x'); ylabel('y');

% legend
h=legend('$f(x) = e^xsin(x)$','Rolle''s $g''(c) = 0$','MVT $\frac{f(b)-f(a)}{b-a}$','MVT $f''(c)$', 'FontSize',14);
set(h,'Interpreter','latex');

% title
title('Rolle''s theorem and mean value theorem')

% Print the figure to a file
% print('MyZeroTheorems','-depsc2');