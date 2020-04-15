% This script is incomplete
clear all; close all; clc

% Define the array of numbers
m=2^22; a=1:m; a=1./a;

% Compute all required sums
[s1, flag1, u1] = my_simple_sum(a,m,'single','ascend');
[s2, flag2, u2] = my_simple_sum(a,m,'single','descend');
[s3, flag3, u3] = my_simple_sum(a,m,'double','ascend');
[s4, flag4, u4] = my_simple_sum(a,m,'double','descend');

% Compute accurate approximation of the sum using Kahan's method.
precision = 'double';
[t, flag] = kahan_sum(a,m,precision);

% Compute the errors 
e1=t-s1; 
e2=t-s2;
e3=t-s3;
e4=t-s4; 
%e2=1;e3=1;e4=1;
%s2=1;s3=1;s4=1;

ure_single = 2^-24;
ure_double = 2^-53;

error_bound1 = u1 * ure_single;
error_bound2 = u2 * ure_single;
error_bound3 = u3 * ure_double;
error_bound4 = u4 * ure_double;

% Print the output nicely
% The white space in the string '% 16.12e' is deliberate.
% What does it do to positive/negative numbers?
fprintf('Precision     Direction      Result                Error                Error bound\n');
fprintf('single        ascend        % 16.12e    % 16.10e    % 16.10e\n',s1,e1, error_bound1);
fprintf('single        descend       % 16.12e    % 16.10e    % 16.10e\n',s2,e2, error_bound2');
fprintf('double        ascend        % 16.12e    % 16.10e    % 16.10e\n',s3,e3, error_bound3');
fprintf('double        descend       % 16.12e    % 16.10e    % 16.10e\n',s4,e4, error_bound4');


 