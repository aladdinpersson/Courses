function y=simple_landscape(x)

% simple_landscape - Computes the height of a simple landscape given x.

% CALL SEQUENCE: y=simple_landscape(x)
%
% INPUT:
%   length x
%
% OUTPUT:
%   height y     
%
% EXAMPLE: Used in MyEvent.m

% Programming by Aladdin Persson (alhi0008@student.umu.se)
%  2018-12-09 Initial programming

% Fill the array y with zeros
y=zeros(size(x));

% Isolate all the indices of x values between 13000 and 15000
idx=14000<=x & x<=16000;

% Define a half-circle with center at 14000 and radius 1000
% Admittedly, this is an odd hill ...
y(idx)=sqrt(1e6-(x(idx)-15000).^2);