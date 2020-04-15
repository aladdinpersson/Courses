function x=myforward(l,f)

% FORWARD  Solves unit lower triangular linear system
%
% CALL SEQUENCE: x=forward(l,f)
%
% INPUT:
%   l  a unit lower triangular m by m matrix 
%   f  a column vector with m components
%
% OUTPUT:
%   x   the solution of the linear system l*x=y
%
% MINIMAL WORKING EXAMPLE: Solve a small upper triangular linear system
% 
% l=tril(rand(5,5)); l=l+eye(5,5)*0.01; f=rand(5,1); x=forward(l,f);
%
% See also: backward, factor

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%    2012-XX-XX  Initial programming and testing
%    2016-08-09  Coding standard enforced
%    2019-01-04  Improved inline comments

% Obtain the dimension of the problem and create a copy of the RHS f
m=size(l,1); x=f;
flops=0;

% Main loop
for i=1:m
   % Remove the contribution of x(i) from the right hand side
   x(i+1:m)=x(i+1:m)-l(i+1:m,i).*x(i);
   flops=flops+(m-i)*2;
end