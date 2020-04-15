function fp=MyDerivs(y,h)

% MyDerivs  Computes approximations of derivatives
%
% CALL SEQUENCE: fp=MyDerivs(y)
%
% INPUT:
%   y     a one dimensional array of function values, y = f(x)
%   h     the spacing between the sample points x
%
% OUTPUT
%   fp    a one dimension array such that fp(i) approximates f'(x(i))
%
% ALGORITHM: Space central and asymmetric finite difference as needed
%
% MINIMAL WORKING EXAMPLE: MyDerivsMWE1

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2018-11-26 Extracted from a working code

% Programming by Aladdin Persson (alhi0008@student.umu.se)
%   2018-12-08 Initial programming

% Extract the number of points
m=numel(y);

% The exercise is pointless unless there are at least 3 points
if m < 3 
    return 
end

% Allocate space for derivatives
fp=zeros(size(y));

% Do asymmetric approximation of the derivative at the left endpoint
fp(1) = (-3*y(1)+4*y(2)-y(3))./(2*h);

% Do space central approximation of all derivatives at the internal points
% Do a for-loop *before* you attempt to do this as an array operation

% % Following code for using for-loops. Saved here for comparison to
% % vectorized code below.
% for i = 2:m-1
%     fp(i) = (y(i+1)-y(i-1))./(2*h);
% end

% Vectorized code
y1=y(3:m);y2=y(1:m-2);
fp(2:m-1)=(y1-y2)./(2*h);

% Do asymmetric approximation of the derivatives at the right endpoint
fp(m) = (3*y(m)-4*y(m-1)+y(m-2))./(2*h);