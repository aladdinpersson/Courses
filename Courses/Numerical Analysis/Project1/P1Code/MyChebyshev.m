function y=MyChebyshev(n,x)

% MyChebyshev Evaluates the first n Chebyshev polynomials
%
% CALL SEQUENCE: y=MyChebyshev(n,x)
%
% INPUT:
%   n    the number of polynomials
%   x    a vector of length m containing the sample points
%
% OUTPUT:
%   y     a matrix of dimension m by n such that y(i,j) = T(j,x(i))
%
% MINIMAL WORKING EXAMPLE: MyChebyshevMWE1.m

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.ume.se)
%  2018-11-14 Skeleton extracted from working function

% PROGRAMMING by Aladdin Persson (alhi0008@student.umu.se)
%  2018-11-17 Initial programming
%  2018-11-27 Minor improvements and added comments

% Determine number of element in x
m = length(x);

% Reshape x as a column vector 
x = reshape(x,[1,m]);

% Allocate space for output y
y = zeros(n, m);

% Initialize the first two columns of y
y(1,:)=1; y(2,:)=x(1,:);

% Calculate all remaining columns of y
for j = 3:n
    y(j, :) = 2.*x.*(y(j-1,:))-y(j-2,:);
end