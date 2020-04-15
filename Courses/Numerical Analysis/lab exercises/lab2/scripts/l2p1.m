function [y, reb, flag]=l2p1(a)

% MY_SUM  Sums terms in the order of increasing index
%
% Computes the sum
%
%   s = a(1) + a(2) + .... + a(n)
%
% using the algorithm
% 
%   s(1) = a(1),  
%   s(j) = s(j-1) + a(j),   j = 2,3,....,n
%
% CALL SEQUENCE:
% 
%   [y, aeb, reb, flag]=my_sum(a)
%
% INPUT:
%   a          a one dimensional array of numbers of length n >= 1.
%              
% OUTPUT:
%   y          an approximation of the sum s.
%   reb        a running error bound
%   flag       a error flag
%                flag = -1, if an error occurred
%                flag =  0, if no error was detected
%
% MINIMAL WORKING EXAMPLE: my_sum_mwe1

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2018-11-08   Adapted from simple_sum; automatic detection of precision

% Retrieve the number of elements in the array a.
n=numel(a);

% Initialize y as Not A Number and set the flag to indicate failure.
y=NaN; flag=-1;

% Check for user stupidity
if (n==0)
    return;
end

% Create a copy of the input as a row vector.
aux=reshape(a,1,n);

% Identify precision of input array
switch class(a)
    case 'single'
        % Set single precision unit round off
        u=2^(-24);
    case 'double'
        % Set double precision unit round off
        u=2^(-53);
    otherwise
        display('Error: invalid precision specified, aborting!');
        return;
end

% At this point we know that n >= 1 and the precision is valid
flag=0;

% We are now ready for the actual computation!
s=aux(1); mu=0; t=0;
for i=2:n
    % Update the sum
    s=s+aux(i);
    % Update the sum of absolute values
    
    % Update the running error bound
    mu=abs(s)+mu;
end
% At this point an approximation has been computed!
y=s; flag=1;

% Compute the correct gamma factor

% Obtain the a priori error bound

% Obtain the running error bound
reb=mu*u;