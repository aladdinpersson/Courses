function x=backward(u,f)

% BACKWARD Solves nonsingular upper triangular linear system
%
% CALL SEQUENCE: x=backward(u,f);
%
% INPUT:
%    u    a nonsingular upper triangular m by m matrix
%    f    a column vector with m components
% 
% OUTPUT:
%    x    the solution of the linear system u*x=f
%
% MINIMAL WORKING EXAMPLE: Solve a small upper triangular linear system
% 
% u=triu(rand(5,5)); u=u+eye(5,5)*0.01; f=rand(5,1); x=backward(u,f);
%
% See also: factor, forward

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%    2012-XX-XX  Initial programming and testing
%    2016-08-09  Coding standard enforced
%    2019-01-04  Improved inline comments

% Obtain the dimension of the problem and create a copy of the RHS f
x=f;
[m,n]=size(f);

% % Main loop
% for i=m:-1:1
%     Do the central division which computes x(i)
%     x(i)=x(i)/u(i,i);
%     Remove the contribution of x(i) from the right hand sidex
%     x(1:i-1)=x(1:i-1)-u(1:i-1,i)*x(i);
% end

for j=n:-1:1    
    for i=m:-1:1    
        % Do the central division which computes x(i)
        x(i,j)=x(i,j)/u(i,i);
        % Remove the contribution of x(i) from the right hand sidex
        x(1:i-1,j)=x(1:i-1,j)-u(1:i-1,i)*x(i,j);
    end
end