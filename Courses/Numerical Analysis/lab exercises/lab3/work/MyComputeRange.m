function [table, flag]=MyComputeRange(r,param,v0,maxres,maxit,method,dt,maxstep)

% L3P4  Computes elevations for high and low trajectories to targets
%
% CALL SEQUENCE:
%   [table, flag,it]=L3P4(r,param,v0,maxres,maxit,method,dt,maxstep);
%
% INPUT:
%   r        r(j) is the range to the jth target
%   param    a structure describing of the environment and the shell
%               param.mass   the mass of the shell
%               param.drag   drag coefficient (function)
%               param.grav   a function computing gravity
%   v0       the muzzle velocity of the shell
%   maxres   the kill radius of the shells
%   maxit    the maximum number of test trajectories pr. target.
%   method   string describing the method used to compute the trajectories
%   dt       the typical timestep used
%   maxstep  maximum number of time steps allowed pr. trajectory
%
% OUTPUT:
%   table    a table of dimension m by 5, such that
%               table(j,1)   is the range to the jth target
%               table(j,2)   is the elevation for the low trajectory
%               table(j,3)   is the flight time along the low trajectory
%               table(j,4)   is elevation for the high trajectory
%               table(j,5)   is the flight time along the high trajectory
%  
%   flag     if flag =  1, then everything went smoothly
%            if flag =  0, then computing the maximum range failed         
%            if flag = -j, then the execution failed for the jth target
%
% MINIMAL WORKING EXAMPLE: Missing
%
% WARNING: Elevations are computed in radians not degrees
%
% See also: COMPUTE_RANGE, FIRE, RANGE_RK1, RANGE_RKX

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2018-11-14 Adapted from earlier code.

% Reshape r as a column vector and sort it in ascending order
m=numel(r); aux=reshape(r,m,1); aux=sort(aux,'ascend');

% Create a range function
range=@(theta)range_rkx(param,v0,theta,method,dt,maxstep);

% Save the CPU time
t0=cputime;

% Dummy initialization of output
table=[]; 

% Use golden section search to compute maximal range ...
% Terminate when length of the search interval is less than 1e-2 radian
[c, gssflag]=gss(range,0,pi/2, 1e-2,100);

if (gssflag<1)
    % Print failure message
    fprintf('Failure to compute maximal range\n\n'); 
    % Set flag
    flag=0;
    % Quick return
    return;
else
    fprintf('Maximal range of %8.2f meters achieved at elevation %6.2f degrees \n\n',range(c),c*180/pi);
end

% Initialize the output as a m by 5 table
table=zeros(m,5);

% This is a nontrivial computation, but we hope for the best
flag=1;

% Create a residual function such that
%   res(theta,d) = 0 if and only if a shot with elevation theta has range d
res=@(theta,d)range(theta)-d;

% Initialize search brackets, 
%    (low,c   ) for the low  trajetories 
%    (c  ,high) for the high trajectories
low=0; high=pi/2;

% low_traj=[low,c];
% high_traj=[c,high];

% Computing a large table can take time, especially if dt is small.
fprintf('Progress indicator ');

% Save the CPU time
t1=cputime;

% Main loop over the targets  
for j=1:m
    % Display a primitive progress indicator
    if (j>1)
        for zebra=1:9
            fprintf('\b'); 
        end
    end
    fprintf('%8.2f%%',j/m*100);
    
    % Record the range
    table(j,1)=aux(j); d=aux(j);
    
    % Compute the low angle using the bisection algorithm 
    % Search bracket is (low,c)
    
    [theta, bflag]=bisection(@(theta)res(theta,aux(j)),low,c,res(low,d),res(c,d),0,maxres,maxit); 
    if (bflag>0)  
        % Save the elevation in the table
        table(j,2)=theta; 
        % Update theta (it is critical that the ranges are sorted correctly)
        low=theta;
        % Recompute the flight time
        [~, ~, t]=range(theta);
        % Save the flight time
        table(j,3)=t(end);
    else
        % Signal failure for target j
        flag=-j; 
        % Save NaN, because humans forget to check flags
        table(j,2)=NaN; table(j,3)=NaN;
        % Break out of for-loop
        break;
    end
    
    % Compute the high angle using the bisection algoritm
    % Search bracket is (c,high)
    [theta, bflag]=bisection(@(theta)res(theta,aux(j)),c,high,res(c,d),res(high,d),0,maxres,maxit); 
    if (bflag>0)
        % Save the elevation in the table
        table(j,4)=theta;
        % Update high
        high=theta;
        % Recompute the flight time
        [~, ~, t]=range(theta);
        % Record the flight time
        table(j,5)=t(end);
   
    else
        % Signal failure at iteration j
        flag=-j; 
        % Save NaN, because humans forget to check flags
        table(j,4)=NaN; table(j,5)=NaN;
        % Break out of for-loop
        break;        
    end
end

% Compute elapsed time
t2=cputime;

% Remove any trailing zeros from output arrays
table=table(1:j,:); aux=aux(1:j);

% Display elapsed time
fprintf('\n');
fprintf('Computation of maximal range      %6.2f seconds\n',t1-t0);
fprintf('Computation of firing solution(s) %6.2f seconds\n',t2-t1);
fprintf('\n');