
function s=a3int(g,t,tra)

% a3int  Integrates a function of the trajectory using trapezoidal rule.
%
% CALL SEQUENCE: s=a3int(g,t,tra)
% 
% INPUT:
%   g    a function of such that g(tra) is defined
%   t    the time instances corresponding to tra
%   tra  the trajectory in question
%
% OUTPUT:
%   s    an approximation of the the integral from t(1) to t(end)
%        of g(gamma(t)) where t -> gamma(t) is the true trajectory
%
% MINIMAL WORKING EXAMPLE: TODO

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs,umu.se)
%   2016-12-04 Initial programming and testing

% Determine the number of points on the trajectory
n=size(tra,2);

% Apply g to every point of the trajectory
aux=g(tra);

% Initialize
s=0;

% Loop over the points, trapezoidal style
for i=1:n-1
    % Compute time step
    dt=t(i+1)-t(i);
    % Add the contribution from the ith interva
    s=s+0.5*dt*(aux(i)+aux(i+1));
end

    
