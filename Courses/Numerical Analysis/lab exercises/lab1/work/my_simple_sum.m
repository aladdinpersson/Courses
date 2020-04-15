function [y, flag, mu]=simple_sum(a,n,precision,direction)
% SIMPLE_SUM Sums terms in ascending/descending order of magnitude
% And also computes U for the running error bound.
%
% Simple summation routine which computes the sum
%
%   s = a(1) + a(2) + .... + a(n)
%
% using the indicated precision and direction.
%
% CALL SEQUENCE:
% 
%   [y, flag]=simple_sum(a,n,precision,direction)
%
% INPUT:
%   a          a one dimensional array of numbers of length at least n
%   n          the number of terms to sum
%   precision  a string which sets the precision, valid options are
%               'single'    for single precision
%               'double'    for double precision
%   direction  there are two options:
%              'ascend'   the terms are summed smallest terms first
%              'descend': the terms are summed largest  terms first
%              
% OUTPUT:
%   y          an approximation of the sum s.
%   flag       signals succes/failure
%                flag=0 signals a certain failure
%                flag=1 indicates succes.
%
% MINIMAL WORKING EXAMPLE: simple_sum_mwe1


% Programming: Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2013-11-XX   Initial version and testing.
%   2014-11-03   Uniform formating enforced.
%   2015-11-05   Call sequence and minimal working example added.
%   2018-11-05   Updated documentation.

% Retrieve the number of elements in the array a.
m=numel(a);

% Set y to a dummy value and flag to failure
y=[]; flag=0;

% Test for elementary mistakes
if (n>m)
    % There are not enough elements in a array
    display('Error: n is too large');
    % Return to caller immediately
    return;
end

% Create a copy of the input as a row vector.
aux=reshape(a,1,m);

% Test to see if the direction argument was specified.
if exist('direction','var')
    switch lower(direction)
        case {'ascend','descend'}
            % Use MATLAB to sort the numbers
            aux=sort(aux,direction);
        otherwise
            display('Invalid direction specified, aborting!');
            return;
    end
end

% The numbers have been sorted if a correct direction was given.

% Now, test the requested precision. The MATLAB default is double, but we
% cannot be certain which format the input a is given in.

switch lower(precision)
    case 'single'
        % Force calculations to be done in single precision
        aux=single(aux); s=single(0);
    case 'double'
        % Force calculations to be done in double precision 
        aux=double(aux); s=double(0);
    otherwise
        display('Error: invalid precision specified, aborting!');
        return;
end

% We are finally ready for the actual computation!
mu = 0;
for i=1:n
    s=s+aux(i);
    mu = mu + abs(s);
end
% At this point an approximation has been computed!
y=s; flag=1;