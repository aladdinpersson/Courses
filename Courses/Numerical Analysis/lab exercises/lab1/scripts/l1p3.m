% This script is incomplete

% Define the array of numbers
m=2^22; a=1:m; a=1./a;

% Compute all required sums
[s1, flag1]=my_simple_sum(a,m,'single','ascend');
[s2, flag2]=
[s3, flag3]=
[s4, flag4]=

% Compute accurate approximation of the sum using Kahan's method.
[t, flag]=

% Compute the errors 
e1=t-s1; 
e2=; 
e3=; 
e4=; 

% Print the output nicely
% The white space in the string '% 16.12e' is deliberate.
% What does it do to positive/negative numbers?
fprintf('Precision     Direction      Result                Error                Error bound\n');
fprintf('single        ascend        % 16.12e    % 16.10e\n',s1,e1);
fprintf('single        descend       % 16.12e    % 16.10e\n',s2,e2);
fprintf('double        ascend        % 16.12e    % 16.10e\n',s3,e3);
fprintf('double        descend       % 16.12e    % 16.10e\n',s4,e4);


 