function y=MyNewtonSqrt(alpha)
% MyNewtonSqrt  Computes square roots using Newton's method

% CALL SEQUENCE: y=MyNewtonSqrt(alpha)
%
% INPUT:
%   alpha : Number/vector of numbers which you want to compute the root of
%
% OUTPUT:
%   y     square root of alpha

% Isolate significand f and exponent e such that alpha = f*2^e
[f, e] = log2(alpha);

% Translate f, e into standard form where 1 <= f < 2;
f=f*2; e=e-1;

% Find all odd exponents
idx=find(mod(e,2)==1);

% Adjust all odd exponents
f(idx)=2*f(idx); e(idx)=e(idx)-1;

% At this point, all values of f satisfy that 1<=f<4.
% Define the coefficient for the initial guess

% Compute initial guess for sqrt(f)
% from specification: x0 = @(s) s/3 + 17/24;
x=1/3*f+17/24;

% Define the number of Newton iterations
n=10;

% Do n Newton iteration for all components of x
for i=1:n
    x = x - (x.^2-f)./(2*x);
end

% Complete the computation of sqrt(alpha)
y=pow2(x,e/2);