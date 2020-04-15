function y=MySinh(x)

% MySinh  Computes hyperbolic sinus without catastropic cancellation

% THE ENTIRE HEADER IS MISSING


% Find the index of the points where subtractive cancellation is not an issue
% This is the points where a(x) = exp(x) and b(x) = exp(-x) satisfy that
%
%              |a| >= 2|b|    or       2|a| <= |b|
idx1=

% Identify the points where subtractive cancellation is an issue
idx2=

% Isolate good points separate array x1
x1=x(idx1);

% Isolate bad points into separate array x2
x2=x(idx2);

% Compute y1 = sinh(x1) using the built-in function exp
y1=exp(x1); y1=(y1-1./y1)/2;

% Compute y2 = sinh(x2) using a suitable Taylor polynomial
y2=zeros(size(x2)); 
term=

% Select the number of terms to use
n

% Evaluate the Taylor polynomial
for it=1:n 
    % Update y2
    y2=
    % Compute the next term
    term=
end

% Allocate space for the output
y=zeros(size(x));

% Copy the y1 and y2 into the right locations of the output array
y(idx1)=y1; y(idx2)=y2;