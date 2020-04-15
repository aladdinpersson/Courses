function gp = example01
%objective function

c = [1; 3];
A = [[-1 0]; ...
     [0 -1]; ...
     [-1 -2]; ...
     [1 -3]; ...
     [-1 3]];
b = [0; 0; -2; 2; 12];

%domain
x1 = -0.5:0.15:10;
x2 = -0.5:0.1:10;

%starting point
x1_start = 4;
x2_start = 4;

%construct the optimization problem
gp = gr_lipa_opt( x1, x2, ...
		  lin_prob( c, A, b ), ...
		  x1_start, x2_start );
