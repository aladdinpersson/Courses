function [s, reb]=my_recursive_sum(a,m)

% MY_RECURSIVE_SUM   Computes a sum of numbers using recursion.
%
% CALL SEQUENCE: [s, reb]=my_recursive_sum(a,m)
%  
% INPUT:
%   a        a one dimensional array of n numbers
%   m        recursion threshold
%              compute the sum using straight summation if n <=m
% 
% OUTPUT:
%   s        the computed sum
%   reb      the running error bound
%

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2018-11-08  Initial programming and testing

% PROGRAMMING by Aladdin Persson
% 2018-11-14 Included running error bound


% Identify length of array
n=length(a); 

% Initialize dummy values
s=NaN; reb=NaN;

% Check for user stupidity
if (n==0)
    return;
end

% Identify precision
switch class(a)
    case 'single'
        % Set single precision unit roundoff
        u=2^(-24);
    case 'double'
        % Set double precision unit roundoff
        u=2^(-53);
    otherwise
        display('Error: invalid precision specified, aborting!');
        return;
end

% At this point we know that there are at least n >= 1 numbers 
% and the precision has been identified

if (n<=m)
    % The current vector is short, so we do straight summation.
    [s, ~, reb]=my_sum(a);
else
    % Find the midpoint of the array
    k=floor(n/2);
    % Compute the sum and the running error bound for the left  half 
    [s1, reb1] = my_recursive_sum(a(1:k),m);
    % Compute the sum and the running error bound for the right half
    [s2, reb2] = my_recursive_sum(a(k+1:end),m);
    % Add the two sums together
    s=s1+s2;
    % Compute the reb for s using reb1, reb2, abs(s) and u
    reb=abs(s)*u+reb1+reb2; % how to calculate this?
    %mu=abs(s)+mu - from my_sum running error bound
end