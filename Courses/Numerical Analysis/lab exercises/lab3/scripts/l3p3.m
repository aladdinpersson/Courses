function y=l3p3(x)

% L3P3 Computes square roots using the bisection method
%
% CALL SEQUENCE: y=l3p3(x)
%
% INPUT:
%   x     an array of positive numbers
%   
% OUTPUT:
%   y     y = sqrt(x)
%
% MINIMAL WORKING EXAMPLE: Missing

% ALGORITHM: We compute the positive zero of p(x) = x^2 - alpha using
% the bisection method with or without a running error bound.


% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@c.umu.se)
%   2018-11-16  Initial programming and testing

% Transform x into a a row vector z for easy processing
m=numel(x); z=reshape(x,1,m);

% Set tolerances and maximum iteration count for bisection


% Isolate the significands and the exponents
% Why do we multiply with 2?
% Why do we subtract 1
[f, e]=log2(z); f=f*2; e=e-1;

% Loop over all entries of z
for i=1:m
    % Check to see if the exponent is odd
    if mod(e(i),2)==1
        % Yes! Make adjustment to the significand and the exponent
        f(i)=f(i)*2; e(i)=e(i)-1;
    end
    
    % At this point we are certain
    %   1) f(i) is between 1 and 4
    %   2) e(i) is even, i.e., divisible by 2.
    % Why is that?
    
    % Define the polynomial p(x) = x^2 - f(i) 
    p=
    
    % Find the positive root of p
    % Remember to pick a bracket which will always work!
    
end

% Integrate the exponents into the calculation
z=pow2(z,e/2);

% Format the output to match the shape of the input
y=reshape(z,size(x));