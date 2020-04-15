clear all; close all; clc;
tic
% run a3f3 which has param, v0 necessary
a3f3

%choose method
method='rk2';

%stepsize and maximum number of steps for range_rkx
dt=1/4; maxstep=1e7;

% for bisection
maxit=1e7;

maxk=6;
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
    
    idx=find(table(2,:)>d);
    
    alow=theta(min(idx)-1); % goes too short
    blow=theta(min(idx)); % goes too far
    
    eps=10^(-10); delta=0;
    
    %theta for low trajectory
    [thetalow, lflag]=bisection(res,alow,blow,res(alow),res(blow),delta,eps,maxit,0);
    
    a(k)=thetalow;
    
    dt=dt/2;
end

p=2;

% Apply Richardson's techniques
data=MyRichardson(a,p);

% Display results
rdifprint(data,p)
toc