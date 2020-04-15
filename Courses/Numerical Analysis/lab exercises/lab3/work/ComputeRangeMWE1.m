% L3P4MWE  Computes artillery table for D20 152 mm howitzer
clc

% Load structure param corresponding to D20 152 mm howitzer.
d20;

% Select range to targets
r=(1:1:14)*1000;

% Set kill radius of shells in meters
maxres=10;

% Maximum number of iterations pr target
maxit=100;

% Set a constant head wind of 5 m/s
% param.wind=@(t,x)[-5 0];

% Compute firing table
[table, flag]=MyComputeRange(r,param,v0,maxres,maxit,method,dt,maxstep);
% [table, flag]=MyComputeElevation(r,param,v0,maxres,maxit,method,dt,maxstep);
if (flag>0)    
    %--------------------------------------------------------------------------
    % Prepare the output for printing converting radians to degrees
    %--------------------------------------------------------------------------
    
    % Select the data for printing converting radians to degrees
    data=[table(:,1) table(:,2)*180/pi table(:,3) table(:,4)*180/pi table(:,5)];
    
    % Define the column headings
    colheadings = {'Range', 'Low angle','Low flight time','High angle','High flight time'};
    
    % Set the widths of the columns
    wids=[10 10 16 10 16];
    
    % Define the format specification
    fms={'.2f','.2f','.2f','.2f','.2f'};
    
    % Print the data nicely
    displaytable(data,colheadings,wids,fms);    
end