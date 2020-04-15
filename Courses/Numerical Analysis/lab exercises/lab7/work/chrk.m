function [t, y]=rk(f,t0,t1,y0,N1,N2,method)

% RK Solves ODEs using explicit Runge-Kutta methods
%
% An implementation of some common methods for the initial value problem
%
%   y'(t) = f(t,y(t)),
%   y(t0) = y0
%
% The routine can handle systems of ODEs as well, so y can be a vector.
%
% CALL SEQUENCE:
%
%    [t y]=rk(f,t0,t1,y0,N1,N2,method)
%
% INPUT:
%   f         a handler to the function f, see below.
%   t0, t1    the time interval is [t0,t1]          
%   y0        is the initial condition, i.e. y(t0) = y0
%   N1, N2    the total number of time steps is N1*N2, see below.
%   method    a string which specifies the method
%               'rk1' : the explicit Euler method
%               'rk2' : Heun's method aka the improved Euler method
%               'rk3' : a third order accurate Runge-Kutta method.
%               'rk4' : the classical 4th order Runge-Kutta method.
% 
% OUTPUT:
%    t    a vector of length N1+1 such that t(i)=t0+(i-1)*h.
%    y    y(:,i) is the approximation of the solution at time t(i).
%
% NOTES:
%   a) It is assumed that the function f returns a COLUMN vector!
%   b) We only record the approximations every N2 steps.
%   c) The stepsize dt used to compute the solution is
% 
%      dt = length of interval / total number of steps = (t1-t0)/N
%
% MINIMAL WORKING EXAMPLE 1: The initial value problem
%
%   y'(t) = -0.1*sin(t)*y(t)
%   y(0)  = 5
%
% can be solved as follows
%
% f=@(t,y)-0.1*sin(t)*y; t0=0; t1=1; y0=5; N1=10; N2=2; method='rk4';
% [t, y]=rk(f,t0,t1,y0,N1,N2,method);
%
% MINIMAL WORKING EXAMPLE 2: The initial value problem 
% 
%    y'(t) = y^2 - 1
%    y(0)  = 0
% 
% can be solved as follows
%
% f=@(t,y)y.^2-1; t0=0; t1=3; y0=0; N1=30; N2=10; method='rk2';
% [t, y]=rk(f,t0,t1,y0,N1,N2,method);
% 
% See also: PHI1, PHI2, PHI3, PHI4

% Programming: CCKM (spock@cs.umu.se) 
%   Apr 2014   : Initial programming.
%   Oct 2014   : Minor streamlining. 
%   2014-12-18 : A third order Runge-Kutta method has been added
%   2014-12-18 : Documentation reformatted to conform with the standard
       
% Force the initial condition to be a COLUMN vector; 
s=numel(y0); y0=reshape(y0,s,1); 

% Define the total number of steps N and the stepsize dt;
N=N1*N2; dt=(t1-t0)/N;

% The instances where we record approximations are stored in t
t=zeros(1,N1+1); 

% Allocate space for storing the solution
y=zeros(s,N1+1); y(:,1)=y0;

% Initialize t, y, and aux
t(1)=t0; y(:,1)=y0; aux=y0;

% Choose the appropriate method to integrate the ODE
switch lower(method)
    case 'rk1'
        phi=@phi1;
    case 'rk2';
        phi=@phi2;
    case 'rk3';
        phi=@phi3;
    case 'rk4';
        phi=@phi4;
    case 'testphi'
        phi=@testphi;
    otherwise
        disp('Unknown method specified. RK1 selected by default');
        phi=@phi1;
end

for i1=1:N1
    for i2=1:N2
        % Calculate the current time
        tau=t0+dt*((i1-1)*N2+i2-1); 
        % Advance the current approximation a single time step 
        aux=phi(f,tau,aux,dt);
    end
    % Record the current time and the current approximation for future use
    y(:,i1+1)=aux; t(i1+1)=t0+i1*N2*dt;
end
