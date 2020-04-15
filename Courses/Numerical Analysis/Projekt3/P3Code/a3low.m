% a3low.m computes the low firing solution (i.e, the angle) to hit a target
% at 15000 meters. 

% PROGRAMMING by Aladdin Persson (alhi0008@student.umu.se)
%   2018-12-19 Initial programming
%   2019-01-08 Minor changes

clear all; close all; clc;
tic

% run a3f3 which has param, theta, v0, etc needed for our shell simulation
a3f3

%choose method
method='rk3';

%stepsize and maximum number of steps for range_rkx
dt=1; maxstep=1e7;

% maxit for bisection
maxit=1e7;

maxk=10;
a=zeros(maxk,1);

for k = 1:maxk

    % Define the range function, let everything be constant except we choose
    % the elevation of fire
    range=@(theta)range_rkx(param,v0,theta,method,dt,maxit);

    % Distance to target from gun
    d=15000;

    % residual function, we want res=0 for perfect hit
    res=@(theta)range(theta)-d;

    % Specify elevation in degress and convert to radian
    deg=0:10:90; theta=deg*pi/180;
    
    [table, flag]=compute_range(param,v0,theta,method,dt,maxstep,0);
    
 
    % Will be two angles which hit target at 15000 meters, this is why we
    % use the min() function in finding alow and blow
    idx=find(table(2,:)>d);
    
    % goes too short
    alow=theta(min(idx)-1); 
    % goes too far
    blow=theta(min(idx)); 
    
    eps=10^(-10); delta=0;
    
    %theta for low trajectory
    [thetalow, lflag]=bisection(res,alow,blow,res(alow),res(blow),delta,eps,maxit,0);
    
    a(k)=thetalow;
    dt=dt/2;
    
end

% guess for p
p = 3;

% Apply Richardson's techniques
data=MyRichardson(a,p);

% Display results
rdifprint(data,p)