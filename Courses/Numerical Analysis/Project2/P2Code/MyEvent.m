% MWE for range_rkx with the usage of Hermite's approximation

% Programming by Aladdin Persson (alhi0008@student.umu.se)
%  2018-12-09 Initial programming

clear all; close all; clc;

load shells.mat

% Specify shell and enviroment
param=struct('mass',10,'cali',0.088,'drag',@(x)mcg7(x),'atmo',@(x)atmosisa(x),'grav',@(x)9.82,'wind',@(t,x)[0, 0]);

% Set the muzzle velocity and the elevation of the gun
v0=780; theta=60*pi/180; 

% Select the method which will be used to integrate the trajectory
method='rk2'; 

% Select the basic time step size and the maximum number of time steps
dt=0.1; maxstep=2000;

% Compute the range of the shell
[r, flag, t, tra]=range_rkx(param,v0,theta,method,dt,maxstep);
flag;

% Below follows a long sequence of commands which demonstrates how to get
% a very nice plot of the trajectory automatically

% Obtain the coordinates of the corners of the screen
screen=get(groot,'Screensize'); 

% Isolate the width and height of the screen measured in pixels
sw=screen(3); sh=screen(4);

% Obtain a handle to a new figure
hFig=gcf;

% Set the position of the desired window
set(hFig,'Position',[0 sh/4 sw/2 sh/2]);

% Plot the trajectory of the shell.
plot(tra(1,:),tra(2,:)); 

hold on;

x=linspace(0.0e4,1.6e4,1e6);
plot(x,simple_landscape(x))

% We want to solve y(t) - h(x(t)) = 0, i.e shell hit ground.
% We can approx. y(t), x(t), with Hermite's piece-wise approximation.

y=tra(2,:);yp=tra(4,:);
x=tra(1,:);xp=tra(3,:);
s=t;

% Create function that generates any value t given points y,yp,x,xp and
% points s where y, y' is known.
y_approx=@(t) MyPiecewiseHermite(s,y,yp,t);
x_approx=@(t) MyPiecewiseHermite(s,x,xp,t);

% Create event function g(t) which is height position of shell - landscape
% height. When this is zero it means the shell has hit the ground.
g=@(t) y_approx(t)- simple_landscape(x_approx(t));

% Tolerances for bisection
delta=1e-12;eps=1e-12;maxit=100;

% By plotting g(t), we see that it switches sign ~between t=70, and t=80.
t0=70;t1=80;

% Find better approximation of time c, where shell collides with ground
[c, flag, it, a, b, his, res] = bisection(g,t0,t1,g(t0),g(t1),delta,eps,maxit,false);

% Plot the point where they collide
plot(x_approx(c), y_approx(c), 'k*')

% Add legend to make it easier to distinguish between landscape and traj.
legend('Trajectory of shell', 'Landscape', 'Striking point')

% Turn of the major grid lines and set the axis
grid ON; axis([0 16000 -2000 11000]); grid MINOR;

% Save plot as 'shelltrajectory.eps'
print('shelltrajectory','-depsc2');