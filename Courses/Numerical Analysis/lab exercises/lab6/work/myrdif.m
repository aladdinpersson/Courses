function data=rdif(f,x,D,p,h0,kmax,df)

% RDIF Applies Richardson's technique to numerical differentiation
% 
% INPUT:
%   f      a handler to a real function of a real variable
%   x      a single scalar in the domain of f
%   D      a handler to a difference operator
%   p      the order or the principal error term
%   h      the largest stepsize
%   kmax   the number of different stepsizes to explore
%   df     (optional) a handler to the exact derivative if known
%
% OUTPUT:
%   data   an array of information
%             data(i,1) = i
%             data(i,2) = D(f,x,h(i))
%             data(i,3) = Richardson's fraction
%             data(i,4) = Richardson's error estimate
%          if the exact derivative supplied as df, then
%             data(i,5) = exact error
%             data(i,6) = comparision of error estimate to exact error
%
% MINIMAL WORKING EXAMPLE: rdifmwe1
%
% See also: RINT, RODE

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%  2014-11-27  Initial coding completed. 
%  2014-12-02  Bug fixed in calculating number of significant digits
%              Added a list of operators and trial functions 
%  2016-06-30  Integrated displaytable().
%  2016-12-07  Removed unused output arguments
%  2016-12-07  Added variable count to output arguments
%  2018-11-28  Printing moved to MWE as a matter of principle

% Did the user supply a handler to the exact derivative in the input?
if ~exist('df','var')
    % No derivative was given
    flag=0;
     % Allocate space for the output
    data=zeros(kmax,4);
else
    % The exact derivative was specified
    flag=1;
    % Allocate space for the output
    data=zeros(kmax,6);
end

% Initialize the first column of data
for i=1:kmax
    data(i,1)=i-1;
end

% Compute kmax different approximations of the derivative
h=h0;
for i=1:kmax % (D(f,x,h)-D(f,x,2*h))./(2^p - 1)
    data(i,2)=D(f,x,h) ; h=h/2;
end

% Compute Richardsons fractions
for i=3:kmax
    data(i,3)=(data(i-1,2)-data(i-2,2))/(data(i,2)-data(i-1,2)); 
end

% Compute Richardson's error estimates assuming the order is correct
factor=2^p-1;
for i=2:kmax
    data(i,4)=(data(i,2)-data(i-1,2))/factor;
end

% If possible, then compute the error and compare it to the error estimate
if (flag==1)
    % Compute the target
    target=df(x);
    for i=1:kmax
        % Compute the exact error
        data(i,5)=target-data(i,2);
        % Compare the error estimate to the exact error
        data(i,6)=log10(abs((data(i,5)-data(i,4))./data(i,5)));
    end
end