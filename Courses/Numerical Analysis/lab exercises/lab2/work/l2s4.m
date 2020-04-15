clear all; close all; clc
% /////////////////////////////////////////////////////////////////////////
%  Initial setup of the gun and the method used to compute trajectories
% ////////////////////////////////////////////////////////////////////////

% Load shells models
load shells.mat

% Specify shell and physical environment
param=struct('mass',10,'cali',0.088,'drag',@(x)mcg7(x),'atmo',@(x)atmosisa(x),'grav',@(x)9.82,'wind',@(t,x)[0; 0]);

% Define muzzle velocity
v0 = 780;

maxit=1000;

% Select the method which will be used to integrate the trajectory
method='rk2'; 

% Select the basic time step size and the maximum number of time steps
dt=0.1; maxstep=2000;

% Define the range function
range=@(theta)range_rkx(param,v0,theta,method,dt,maxit);

% Define location of target
d=12345;

% Define the residual function res
res=@(theta)range(theta)-d;

% /////////////////////////////////////////////////////////////////////////
% Compute ballistics table using compute_range
% /////////////////////////////////////////////////////////////////////////

% Specify elevation in degress and convert to radian
deg=0:10:90; theta=deg*pi/180;

% Finally, compute and display the table of ranges using compute_range
[table, flag]=compute_range(param,v0,theta,method,dt,maxstep,1);

% /////////////////////////////////////////////////////////////////////////
% Find brackets for the low and the high trajectory
% /////////////////////////////////////////////////////////////////////////

% Find the indicies of all elevations corresponding to shots which go too far
idx=find(table(2,:)>d);

% theta(idx)*180/pi
% Find a bracket for the low trajetory
alow=theta(min(idx)-1);
% alow*180/pi
blow=theta(min(idx));
% blow*180/pi
% Find a bracket for the high trajectory
ahigh=theta(max(idx+1)); % går för kort
bhigh=theta(max(idx)); % går för långt

% /////////////////////////////////////////////////////////////////////////
% Set parameters for bisection
% /////////////////////////////////////////////////////////////////////////

% We don't quite know a good value of maxit
maxit=1000; 

% We do not care about the error on the elevation
delta=0; 

% However, We destroy the target when the abs(res(theta))< 1 (meter)
eps=1;

% /////////////////////////////////////////////////////////////////////////
%  Compute the firing solutions using bisection
% /////////////////////////////////////////////////////////////////////////

% Low trajectoy
% range(alow*pi/180)
% range(10*pi/180)
% alow
% range(blow*pi/180)


% theta
% range(blow*pi/180)
% res(blow*pi/180)
% alow
% range(alow*pi/180)
% res(alow*pi/180)
% res(blow*pi/180)

[low, lflag]=bisection(res,alow,blow,res(alow),res(blow),delta,eps,maxit,1);
% low*180/pi
% [x, flag, it, a, b, his, res]=bisection(f,x0,x1,f0,f1,delta,eps,maxit,print)

% % High trajectory
[high, hflag]=bisection(res, ahigh, bhigh, res(ahigh),res(bhigh),delta,eps,maxit,1);

% % /////////////////////////////////////////////////////////////////////////
% %  Recompute and plot trajectories
% % /////////////////////////////////////////////////////////////////////////

% Low trajectory
[~, ~, ~, tra1]=range_rkx(param, v0, low, method, dt, maxit);

% range_rk1(param, v0, theta, dt, maxstep);

% % High trajectory
[~, ~, ~ , tra2]=range_rkx(param, v0, high, method, dt, maxit);
% 
% % Plot both trajectories in a single plot
plot(tra1(1,:),tra1(2,:));
hold on;
plot(tra2(1,:),tra2(2,:));
% % Add grid
grid; 
% 
% % Add suitable labels and legend
