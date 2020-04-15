function [l, u, sigma, flag]=factor(a)

% FACTOR  LU factorization routine for square matrices
%
% Compute a factorization of the form PA = LU, where A is a nonsingular
% square matrix
%
% CALL SEQUENCE: [l, u, sigma]=factor(a)
%   
% INPUT:
%   a    a nonsingular square matrix
%
% OUTPUT:
%   l      a unit lower triangular matrix
%   u      an upper triangular matrix
%   sigma  an array specifying the row permutations
%   flag   standard succes/failure indicator
%            flag= 1  if no pivots where zero
%            flag=-j  if a zero pivot was encountered in column j
%
% MINIMAL WORKING EXAMPLE: Compute an LU factorization of a small matrix
%
% a=5*eye(5,5)+rand(5,5);
% [l, u, sigma,flag]=factor(a);
%
% See also: backward, forward

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%    2012-XX-XX  Initial programming and testing
%    2016-08-09  Coding standard enforced
%    2019-01-04  Improved inline comments

% Obtain the dimension of the matrix
[m,n]=size(a); 

% Initialize L, U and sigma
l=eye(m,m); u=zeros(m,n); sigma=linspace(1,m,m); 

% Create a copy of the matrix A 
b=a;

% Assume succes
flag=1;

% Main loop
for j=1:m-1
    ii=j; piv=abs(b(ii,j));
    % Search for a better pivot in jth column.
    for i=j+1:m
        if (abs(b(i,j))>piv)
            ii=i; piv=abs(b(i,j));
        end
    end
    % Is the matrix singular?
    if (piv>0)
        if (ii>j)
            % Swap the physical rows
            % This is a slow operation which would not be done in HPC codes
            temp=b(ii,:); b(ii,:)=b(j,:); b(j,:)=temp;
            % Record the swap
            temp=sigma(ii); sigma(ii)=sigma(j); sigma(j)=temp;
        end
        % Update lower right corner of the matrix
        for i=j+1:m
            b(i,j)=b(i,j)/b(j,j); % Record the multipliers
            for k=j+1:n
                b(i,k)=b(i,k)-b(i,j)*b(j,k);
            end
        end
    else % Singular matrix
        fprintf('The matrix is singular \n\n'); 
        % Return the column number which triggered the breakdown
        flag=-j;
        % Break out of the main loop.
        break;
    end
end
% Extract the factors
l=l+tril(b,-1); u=triu(b,0);