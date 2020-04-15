function data=MyRichardson(a,p,t)

% MyRichardson Computational kernel for Richardson's technique
%
% Does Richardson extrapolation for a set of values assuming that the
% user has determined the order of the primary error term correctly
%
% CALL SEQUENCE: data=richardson(val,p);
%
% INPUT:
%   a       array of m approximations of t, such that if a(i) corresponds
%           stepsize h, then a(i+1) corresponds to stepsize h/2
%   p       the order of the primary order term
%   t       (optional) the target value of the approximations
%
% OUTPUT:
%   data   an array of information such that
%            data(i,1) = i
%            data(i,2) = a(i)
%            data(i,3) = Richardson's fraction for i > 2
%            data(i,4) = Richardson's error estimate for i > 1
%          if the exact target value is supplied, then
%            data(i,5) = exact error
%            data(i,6) = comparision of error estimate to exact error
% 
% MINIMAL WORKING EXAMPLE: A3F2

% PROGRAMMING by Carl Christian K. Mikkelsen (spock@cs.umu.se)
%   2015-12-10  Initial programming amd testing
%   2018-12-09  Printing moved to minimal working example
%   2018-12-09  Skeleton extracted from working code

% PROGRAMMING by Aladdin Persson (alhi0008@student.umu.se)
%   2018-12-19 Initial programming
%   2019-01-08 Minor changes

% Reshape the input array as a colum vector
m=numel(a); a=reshape(a,m,1);

% Is the target value known?
if ~exist('target','var')
    % Set a flag to indicate that the target value is unknown
    flag=0;
    % Allocate space for the table used to print the results
    data=zeros(m,4);
else
    % Set a flag to indicate that the the target value is known
    flag=1;
    % Allocate space for the table used to print the results
    data=zeros(m,6);
end

% Initialize the first and the second columns of data
for i=1:m
   data(i,1)=i-1;
   data(i,2)=a(i);
end

% Process the data, computing Richardson's fractions
for i=3:m
    data(i,3)=(data(i-1,2)-data(i-2,2))/(data(i,2)-data(i-1,2));
end

% Compute Richardson's error estimates assuming order p is correct!
for i=2:m
   data(i,4) = (data(i,2)-data(i-1,2))/(2^p - 1);
end

% If possible, then compute the error and compare it to the error estimate
if (flag==1)
    for i=1:m
        % Compute the exact error
        data(i,5)=t-data(i,2);
        % Compare the error estimate to the true error
        % i.e. log10(abs(relative error))
        data(i,6)=log2(abs((data(i,5)-data(i,4))./data(i,5)));
    end
end