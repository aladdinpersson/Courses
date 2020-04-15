function y=MyLog(alpha)
% CALL SEQUENCE: y=MyNewtonSqrt(alpha)
%
% INPUT:
%   alpha : Number/vector of numbers which you want to compute natural log
%           of
% OUTPUT:
%   y     natural logarithm of alpha

% Isolate significand f and exponent e such that alpha=f*2^e
[f,e]=log2(alpha);

% Translate f, e into standard form such that 1<=f<2
f=f*2; e=e-1;

% Define coefficients for the initial guess
a=log(2); b = -(a + log(a) + 1)/2; 

% Define the initial guess
x=a*f+b;

% Define the number of Newton iterations
n=5;

% Do n Newton iterations for all components of x
for i=1:n
    % Determine exponential
    y = exp(x);
    % Do Newton step
    x= x - (y - f)./y; 
end

% Do the final adjustment of the output
y=x+e*log(2);