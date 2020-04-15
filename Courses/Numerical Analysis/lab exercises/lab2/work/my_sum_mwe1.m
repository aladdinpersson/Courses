clear all; close all; clc

%Specify number of terms
n=2^20;

% Indices;
j=1:n;

% Initialize the arrays a and b
a = 1./j.^4; 
b = 1./j;

% multiply odd elements by -1 according to formula in pdf
b(1:2:end) = b(1:2:end)*(-1);

% Compute all sums and all error bounds
[s1, aeb1, reb1, flag1]=my_sum(single(a));
[s2, aeb2, reb2, flag2]=my_sum(a);

% Compute all sums and all error bounds for b
[s3, aeb3, reb3, flag3]=my_sum(single(b));
[s4, aeb4, reb4, flag4]=my_sum(b);

% Compute the best available approximations of the true sums
[ta, flag5]=kahan_sum(a,n,'double');
[ta2, flag6]=kahan_sum(b,n,'double');

% Compute errors
e1=abs(ta-s1);
e2=abs(ta-s2);
e3=abs(ta2-s3);
e4=abs(ta2-s4);

% Display all information
fprintf('Sequence   Precision   True sum               Error                 AEB                   REB\n');
fprintf('  a        single      %16.14e  % 16.14e  %16.14e  %16.14e\n',s1, e1,aeb1,reb1);
fprintf('  a        double      %16.14e  % 16.14e  %16.14e  %16.14e\n',s2, e2,aeb2,reb2);
fprintf('  b        single      %16.14e  % 16.14e  %16.14e  %16.14e\n',s3,e3,aeb3,reb3);
fprintf('  b        double      %16.14e  % 16.14e  %16.14e  %16.14e\n',s4,e4,aeb4,reb4);