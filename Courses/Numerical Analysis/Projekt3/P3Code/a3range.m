% This script uses range_rkx.m and MyRichardson.m using different
% runge_kutta and euler methods to calculate the range of a simulated
% shell. It prints the table for richardson and then also prints
% error_quotients simply to make looking for ratio changes in the error
% more easily visible to the user.

% PROGRAMMING by Aladdin Persson (alhi0008@student.umu.se)
%   2018-12-19 Initial programming
%   2019-01-08 Minor changes

clear all; close all; clc;

% run a3f3 which has param, theta, v0, etc needed for our shell simulation
a3f3

% kmax set to only 8, to be able to run relatively fast. This was increased
% to much higher when wanted to get the most accurate result stated in
% report.

kmax=8;

a=zeros(kmax,1);

m=["rk1","rk2","rk3","rk4"];
P = [1,2,3,4];

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

figure(rk+1)
% Plot the trajectory of the shell.
plot(tra(1,:),tra(2,:));

% Turn of the major grid lines and set the axis
grid ON; axis([0 25000 0 10000]); grid MINOR;

xlabel('x'); ylabel('y'); legend('Trajectory')
print('a3rangetrajectory','-depsc2');