function x=myforwardupdate(l,f)

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
% MINIMAL WORKING EXAMPLE: Solve a small unit triangular linear system
% 
% l=tril(rand(5,5),-1); l=l+eye(5,5); f=rand(5,1); x=forward(l,f);
%
% See also: backward, factor

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%    2012-XX-XX  Initial programming and testing
%    2016-08-09  Coding standard enforced
%    2019-01-04  Improved inline comments

% Obtain the dimension of the problem and create a copy of the RHS f
% m=size(l,1); 
x=f;
[m,n]=size(f);
flops=0;

% Main loop
% for i=1:m
%    % Remove the contribution of x(i) from the right hand side
%    x(i+1:m)=x(i+1:m)-l(i+1:m,i).*x(i);
%    flops=flops+(m-i)*2;
% end

for i=1:m
    for j=1:n
    % Remove the contribution of x(i) from the right hand side
    x(i+1:m,j)=x(i+1:m,j)-l(i+1:m,i)*x(i,j);
    flops=flops+(m-i)*2;
    end
end