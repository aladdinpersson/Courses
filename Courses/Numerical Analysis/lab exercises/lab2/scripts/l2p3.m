function [y]=l2p3(a,x)

% MY_HORNER   An implementation of Horner's method
%
% CALL SEQUENCE:
%
% [y]=my_horner(a,x)
%
% INPUT:
%  a      array of cofficients determining p
%  x      array of arguments to pass to p
%
% OUTPUT:
%  y      the computed value of the polynomial
%
% MINIMAL RUNNING EXAMPLE: my_horner

% Isolate the number of coefficients
m=numel(a); 

% Isolate the degree of the polynomial
n=m-1;

% % Both a and x must be in double precision or MATLAB works in single
% if (strcmp(class(a),'double') && strcmp(class(x),'double'))
%     % Set u to double precision unit roundoff
%     u=2^-53;
% else
%     % Set u to single precision unit round off
%     u=2^-24;
% end

% Reshape the coefficient array as a row vector
aux=reshape(a,1,m); 

% Determine the size of the input array x
sx=size(x); 

% Initialize the output arrays
y=ones(sx)*aux(m); pt=ones(sx)*abs(aux(m)); 

% Initialize running error bound

% Main loop.
for j=1:n
    % Compute intermediate value
    z=y.*x;
    % Update polynomial p
    y=z+aux(m-j);
    % Update running error bound

    % Update polynomial pt

end

% Compute the relvant gamma factor
gamma=(2*n*u)/(1-2*n*u);

% Compute the apriori error bound

% Compute the running error bound