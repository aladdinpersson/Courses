% A3F3  Physical parameters for firing a projectile

% Set parameters.
param.mass=10;
param.cali=0.088;

% Constant drag coefficient
param.drag=@(x)0.1873;

param.atmo=@(x)atmosisa(x);
param.grav=@(x)9.82;

% Select muzzle velocity and elevation
v0=780; theta=45*pi/180;