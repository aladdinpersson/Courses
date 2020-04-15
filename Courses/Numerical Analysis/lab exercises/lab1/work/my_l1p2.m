% L1P2  Script for Lab 1, Problem 2.
%
% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2018-11-01 Initial programming

% Load standard artillery shells
clear all; close all; clc

load shells

% Specify shell, drag function, atmosphere, gravity, and no wind as
% in the minimal working example for range_rk1
param=struct('mass',10,'cali',0.088,'drag',@(x)mcg7(x),'atmo',@(x)atmosisa(x),'grav',@(x)9.82,'wind',@(t,x)[0; 0]);

% Set the muzzle velocity 
v0=780;

% Set the elevation of the gun
theta=45*pi/180; 

% Select the basic time step size and the maximum number of time steps
dt=0.1; maxstep=2000;

% Fire the first shot using range_rk1
[r1, flag1, t1, tra1] = range_rk1(param, v0, theta, dt, maxstep);

% Print nice table headers
% TOI = Time Of Impact
fprintf('Flag    Range (meters)     TOI (seconds)\n');

% Print results, take note of the use of the end keyword
fprintf('  %d       %10.3f     %10.2f\n',flag1,r1,t1(end));

% Adjust the elevation for the second shot
theta=60*pi/180; 

% Select the basic time step size and the maximum number of time steps
dt=0.1; maxstep=2000;

% Fire the second shot using range_rk1
[r2, flag2, t2, tra2]= range_rk1(param, v0, theta, dt, maxstep);

% Plot the trajectory using the plot command with linewidth 2
plot(tra1(1,:), tra1(2,:), 'linewidth', 2)
hold on;
plot(tra2(1,:), tra2(2,:), 'linewidth', 2)

% Print more results
fprintf('  %d       %10.3f     %10.2f\n',flag2,r2,t2(end));   

% Adjust aspect ratio of the plot
axis equal;

% Add labels
xlabel('x coordinate (meters')
ylabel('y coordinate (meters')

% Add legend in the north west corner
legend({'Elevation 45 degrees','Elevation 60 degrees'},'Location','northoutside')

% Add grid
grid on;

% Adjust axis
xlim([0 18000])
ylim([0 10000])

% Print to eps and pdf files to the folder exercices/lab1/work
print('fig1','-depsc');
print('fig1','-dpdf');