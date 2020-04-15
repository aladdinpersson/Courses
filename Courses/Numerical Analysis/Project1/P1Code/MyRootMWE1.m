% Minimal working example for finding roots to polynmials using 
% MyRoot.m which uses the bisection method.

% PROGRAMMING by Aladdin Persson (alhi0008@student.umu.se)
% 2018-11-21 Initial code
% 2018-11-24 Included relative error check

% clear variables for the sake of uneccessary bugs
clear all; close all; clc

% declare delta, eps which are used for bisection algorithm
delta=1e-13;
eps=1e-13;

% if not stopped by delta or eps, stop by maxiteration so that it does
% not run forever.
maxit=100;

% Initialize vector corresponding to polynomial coefficients in ascending 
% order of exponent of x. Chebyshev polynomial for n = 10 (T_10)
p = [-1, 0, 50, 0, -400, 0, 1120, 0, -1280, 0, 512];

% declare potential points a, b for bisection
m = linspace(-1,1,102);

% Following initiaizations for using function displaydata
colheadings = {'flag','iter','a','b','root', 'residual', 'REB', ...
                'R.E', 'trust'};
rowheadings={};
wid = [6 8,16,16,16,16,16,16, 5];
fms = {'d'};
colsep = ' | ';
rowending = ' ';
fileID=1;
data = [];

% Loop through all points declared by m and check if bisection algorithms
% find any roots between these two points.
relerror = [];

for j = 1:length(m)-1
    a0 = m(j); b0 = m(j+1);
    [x, flag, it, a, b, his, y, reb,res]=MyRoot(p,a0,b0,delta,eps,maxit);
    
    % if sign of computed cannot be trusted then trust = 0, else trust=1
    if flag == 3 || flag == -1
        trust=0;
    else
        trust=1;
    end
    
    % Only if there was something found from MyRoot do we which to store
    % the results
    if ~isnan(x) && it ~= 0 
        
        % If the resulting bracket [a,b] are of different signs
        % we cannot trust the relative error as root=0 is a possibility.
        if sign(b(it))*sign(a(it))==-1
            trust=0;
            reler=NaN;
        else
            reler=1/2*(abs(b(it)-a(it)))/min(abs(a(it)),abs(b(it)));
        end
        
        % Concatenating the new information to data matrix
        data = [data; flag, it, a(it), b(it), x, res(it), reb(it),  ...
                reler, trust];
    end
end

% Only if we found roots can we display, hence first check so we have data
if size(data)>0
    displaytable(data,colheadings,wid,fms,rowheadings,fileID,...
                 colsep,rowending);
end