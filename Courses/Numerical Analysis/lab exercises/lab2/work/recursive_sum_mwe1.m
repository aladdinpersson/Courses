clear all; close all; clc

tic
%Specify number of terms
n=2^20;
m=2^10;
% m=1;

% Indices;
j=1:n;

% Initialize the arrays a and b
a = 1./j.^4; 
b = 1./j;

% multiply odd elements by -1 according to formula in pdf
b(1:2:end) = b(1:2:end)*(-1);

% Compute all sums and all error bounds
[s1, reb1]=my_recursive_sum(single(a), m);
[s2, reb2]=my_recursive_sum(a, m);

% Compute all sums and all error bounds for b
[s3, reb3 ]=my_recursive_sum(single(b), m);
[s4, reb4]=my_recursive_sum(b, m);

% Compute the best available approximations of the true sums
[ta, flag5]=kahan_sum(a,n,'double');
[ta2, flag6]=kahan_sum(b,n,'double');

% Compute errors
e1=ta-s1;
e2=ta-s2;
e3=ta2-s3;
e4=ta2-s4;

% Display all information
fprintf('Sequence   Precision   True sum                Error                  REB\n');
fprintf('  a        single      % 16.14e  % 16.14e  % 16.14e\n', s1,e1,reb1);
fprintf('  a        double      % 16.14e  % 16.14e  % 16.14e\n', s2,e2,reb2);
fprintf('  b        single      % 16.14e  % 16.14e  % 16.14e\n',  s3,e3,reb3);
fprintf('  b        double      % 16.14e  % 16.14e  % 16.14e\n',  s4,e4,reb4);

toc