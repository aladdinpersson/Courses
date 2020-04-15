% a3low.m computes the low firing solution (i.e, the angle) to hit a target
% at 15000 meters. 

% PROGRAMMING by Aladdin Persson (alhi0008@student.umu.se)
%   2018-12-19 Initial programming
%   2019-01-08 Minor changes

clear all; close all; clc;

% run a3f4 which has param, theta, v0, etc needed for our shell simulation
a3f4

kmax=10;
a=zeros(kmax,1);
dt=1/4; maxstep=1e6;

m=["rk1","rk2","rk3","rk4"];
P = [1,2,3,4];

% Loop through each of the methods in m and perform the calculations using
% each one.

for rk = 1:4
    method = m(rk);
    dt=1; maxstep=1e7;
    
    for i=1:kmax
        % Compute approxmation
        [r, flag, t, tra] = range_rkx(param,v0,theta,method,dt,maxstep);
        a(i)=r;
        % Reduce step size
        dt=dt/2;
    end
    
    p = P(rk);
    
    % Apply Richardson's techniques
    data=MyRichardson(a,p);
    
    % Display results
    figure(rk)
    rdifprint(data,p)
    
    title(strcat('Method rk',num2str(rk)))
    
    a = abs((data(3:end-1,3)) - 2^p);
    b = abs((data(4:end,3)) - 2^p);
 
    % display how error of Richardon's fraction changes, simply for easier
    % visible inspection of the error decay rate
    error_quotient = a ./ b
end