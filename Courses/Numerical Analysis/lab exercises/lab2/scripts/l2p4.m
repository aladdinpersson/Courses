% /////////////////////////////////////////////////////////////////////////
%  Initial setup of the gun and the method used to compute trajectories
% ////////////////////////////////////////////////////////////////////////

% Load shells models
load shells.mat

% Specify shell and physical enviroment


% Define muzzle velocity


% Select the method which will be used to integrate the trajectory
method='rk2'; 

% Select the basic time step size and the maximum number of time steps


% Define the range function


% Define location of target
d=12345;

% Define the residual function res


% /////////////////////////////////////////////////////////////////////////
% Compute ballistics table using compute_range
% /////////////////////////////////////////////////////////////////////////

% Specify elevation in degress and convert to radian
deg=0:10:90; theta=deg*pi/180;

% Finally, compute and display the table of ranges using compute_range


% /////////////////////////////////////////////////////////////////////////
% Find brackets for the low and the high trajectory
% /////////////////////////////////////////////////////////////////////////

% Find the indicies of all elevations corresponding to shots which go too far
idx=find(table(2,:)>d);

% Find a bracket for the low trajetory
alow=theta(min(idx)-1); 
blow=

% Find a bracket for the high trajectory
ahigh=theta(max(idx+1)); 
bhigh=

% /////////////////////////////////////////////////////////////////////////
% Set parameters for bisection
% /////////////////////////////////////////////////////////////////////////

% We don't quite know a good value of maxit
maxit=60; 

% We do not care about the error on the elevation
delta=0; 

% However, We destroy the target when the abs(res(theta))< 1 (meter)
eps=1;

% /////////////////////////////////////////////////////////////////////////
%  Compute the firing solutions using bisection
% /////////////////////////////////////////////////////////////////////////

% Low trajectoy
[low, lflag]=

% High trajectory
[high, hflag]=

% /////////////////////////////////////////////////////////////////////////
%  Recompute and plot trajectories
% /////////////////////////////////////////////////////////////////////////

% Low trajectory
[~, ~, ~, tra1]=range_rkx();

% High trajectory
[~, ~, ~ , tra2]=range_rkx();

% Plot both trajectories in a single plot
plot(tra1(1,:),tra1(2,:));

% Add grid
grid; 

% Add suitable labels and legend
