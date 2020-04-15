% a3time.m computes flight time using MyRichardson, range_rkx and the shell
% given by a3f3.m. 

% PROGRAMMING by Aladdin Persson (alhi0008@student.umu.se)
%   2018-12-19 Initial programming
%   2019-01-08 Minor changes

clear all; close all; clc;

% run a3f3 which has param, theta, v0, etc needed for our shell simulation
a3f3

method='rk2';

% kmax chosen = 13 because this is exact time when method rk2 stops being
% reliable (we can't trust error estimates anymore)
kmax=13;

a=zeros(kmax,1);
dt=1; maxstep=1e7;

for i=1:kmax
    % Compute approxmation
    [r, flag, t, tra] = range_rkx(param,v0,theta,method,dt,maxstep);
    a(i)=t(end);
    % Reduce step size
    dt=dt/2;
end


% Necessary commands for plotting the trajectory of the shell below. Not
% necessary for computations but can be good for intuition about
% simulation.

% plot(tra(1,:),tra(2,:));
% % Turn of the major grid lines and set the axis
% grid ON; axis([0 25000 0 10000]); grid MINOR;
% title('Trajectory of shell')
% xlabel('range x'); ylabel('height y')

% Observed order for MyRichardson, p=2 since it converges to 2^2
p=2;

% Apply Richardson's techniques
data=MyRichardson(a,p);

% Display results
rdifprint(data,p)
title('a3time with rk2')

% Dummy variables for error quotient calculations. Not necessary either but
% help (at least me) in seeing error decay rate.
a = abs((data(3:end-1,3)) - 2^p);
b = abs((data(4:end,3)) - 2^p);
error_quotient = a./b