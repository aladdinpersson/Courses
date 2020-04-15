function [r, flag, t, tra]=range_rkx_sabotage(param,v0,theta,method,dt,maxstep)

% RANGE_RKX_SABOTAGE  Sloppy computation of final stepsize
%
% All time steps have the same size, except the last which is adjusted to
% put the shell exactly on the ground.
%
% CALL SEQUENCE: [r, flag, t, tra]=range_rkx(param,v0,theta,method,dt,maxstep)
%
% INPUT:
%   param    a structure describing of the environment and the shell
%                param.mass   the mass of the shell
%                param.cali   the caliber of the shell
%                param.drag   a function computing the drag coeffient
%                param.atmo   a function computing the atmosphere
%                param.grav   a function computing gravity
%                param.wind   a function computing the wind
%   v0       the muzzle velocity of the shell
%   theta    the elevation of the gun in radians
%   method   a string describing the method, see "help RK" for options
%   dt       the standard time step, the last step will be shorter
%   maxstep  the maximum number of time steps allowed, a safety valve.
%
% OUTPUT:
%   r        the computed range if flag=1;
%   t        the time instances where the trajectory was approximated
%   tra      the computed trajectory, y(:,i) corresponds to time t(i)
%               tra(1,i) is the x-component of the shells position
%               tra(2,i) is the y-component of the shells position
%               tra(3,i) is the x-component of the shells velocity
%               tra(4,i) is the y-component of the shells velocity
%    flag    flag=0 if the shell did not hit the ground
%            flag=1 if the shell hit the ground
%
% MNIMAL WORKING EXAMPLE: range_rkx_mwe1
%
% See also: COMPUTE_RANGE, COMPUTE_ELEVATION, FIRE, RANGE_RK1, TARGET

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%  Fall 2014   Initial programming and testing
%  2015-09-22  Globals m, k, and g integrated into structure CONST
%  2015-10-31  Replaced structure CONST with mandatory PARAM
%  2015-10-31  Minor error in the inline comments fixed during yearly review
%  2015-11-01  Extended the description of the initial condition
%  2015-12-08  Added support for wind to shell4.m
%  2016-06-22  Adapted routine to improved bisection method
%  2016-06-23  Added logical check for bad elevations
%  2016-09-09  Adapted to more flexible SHELL4A

% TODO: Prior to HT-2016
%    a) Add support for wind to shell8.m and target.m
%    b) Add shell data to the simulation using interpolation from tables
%    c) Investigate if a military grade 6 DOF model is feasible

%//////////////////////////////////////////////////////////////////////////
% Select the relative tolerance being use by the nonlinear solver
%//////////////////////////////////////////////////////////////////////////

% The default value of tol is the double precision unit round off.
%   ... change this value at your own peril
%   ... or if you are told to do so
%   ... or if you are feeling adventurous
tol=0.125;

% Select a shell model, feeding it the parameters of the simulation
shell=@(t,x)shell4a(param,t,x);

% Define the initial condition; must be compatible with the simple shell model
% There are four coordinates:
%  1st coor. is the x coordinate of the muzzle of the gun
%  2nd coor. is the y coordinate of the muzzle of the gun
%  3rd coor. is the x coordinate of the velocity of the shell when it exits
%  4th coor. is the y coordinate of the velocity of the shell when it exits
tra0=[0; 0; v0*cos(theta); v0*sin(theta)];

% Allocate space for trajectory
tra=zeros(4,maxstep+1);

% Initialize the trajectory
tra(:,1)=tra0;

% Allocate space to record the time instances
t=zeros(1,maxstep+1);

% Anticipate failure or bad input.
r=NaN; flag=0; 

% Check for bad elevation
if (sin(theta)<=0)
    % The shell is fired into the ground
    r=0; flag=1; t=0; tra=tra(:,1); 
    % Quick return
    return;
end

% Pickup the method to use.
switch lower(method)
    case 'rk1'
        phi=@phi1;
    case 'rk2'
        phi=@phi2;
    case'rk3'
        phi=@phi3;
    case 'rk4'
        phi=@phi4;
    otherwise   
        fprintf('Invalid method specified! Aborting\n'); return;
end

% Loop over the time steps
for it=1:maxstep
    % Advance the clock a single time step
    t(it+1)=it*dt;
  
    % Advance the solution a single step using the selected method.
    tra(:,it+1)=phi(shell,t(it),tra(:,it),dt);
    
    % Test to see if we are below ground level, tra(2,it+1)<0
    if (tra(2,it+1)<0)
        %------------------------------------------------------------------
        % We passed through the ground! Go back and compute the time step 
        % which will put the shell exactly on the ground.
        %------------------------------------------------------------------
        
        % Isolate the last point above ground level.
        z0=tra(:,it); t0=t(it);

        % Define the function psi(x) which isolates the y coordinate 
        % of the shell after a step of size x*dt.
        psi=@(x)[0 1 0 0]*phi(shell,t0,z0,x*dt);
        
        % Find the 'exact' timestep which will put the shell on the ground
        rho=bisection(psi,0,1,tra(2,it),tra(2,it+1),tol*t(it+1),tol*tra(1,it),60);
        
        % Calculate the 'exact' point of impact; 
        aux=phi(shell,t0,z0,rho*dt);
        
        % Save the time and point of impact
        t(it+1)=t0+rho*dt; tra(:,it+1)=aux;

        % The range has now been computed, signal succes ...
        flag=1; 
        
        % ... and break from the for-loop.
        break;
    end
end

% Remove any trailing zeros from output arrays
tra=tra(:,1:it+1); t=t(1,1:it+1);

% Only define the range if the shell hit the ground !!!
if flag==1
  % Isolate the range 
    r=tra(1,it+1);
end