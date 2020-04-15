% Specify number of terms
n=2^20;

% Indices;
j=1:n;

% Initialize the arrays a and b
a=1./j.^4; 


% Compute all sums and all error bounds
[s1, aeb1, reb1, flag1]=my_sum(single(a));
[s2, aeb2, reb2, flag2]=my_sum(a);

% Compute the best available approximations of the true sums
[ta, flag5]=kahan_sum(a,n,'double');

% Compute errors
e1=ta-s1;
e2=ta-s2;

% Display all information
fprintf('Sequence   Precision   True sum               Error                 AEB                   REB\n');
fprintf('  a        single      %16.14e  % 16.14e  %16.14e  %16.14e\n',);
fprintf('  a        double      %16.14e  % 16.14e  %16.14e  %16.14e\n',);
fprintf('  b        single      %16.14e  % 16.14e  %16.14e  %16.14e\n',);
fprintf('  b        double      %16.14e  % 16.14e  %16.14e  %16.14e\n',);