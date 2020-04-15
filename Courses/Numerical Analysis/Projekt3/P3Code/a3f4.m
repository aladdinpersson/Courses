% A3F4  Physical parameters for firing a projectile

% Load standard shell models
load shells

% Set parameters.
param.mass=10;
param.cali=0.088;

% This drag coefficient is not constant
param.drag=@(x)mcg7(x);

param.atmo=@(x)atmosisa(x);
param.grav=@(x)9.82;

% Select muzzle velocity and elevation
v0=780; theta=45*pi/180;
