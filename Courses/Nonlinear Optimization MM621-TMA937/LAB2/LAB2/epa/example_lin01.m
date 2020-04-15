function gp = example_lin01
%objective function
obj = '[1; 3]''*x';
obj_grad = '[1; 3]';

%constraints
cons = {'[-1; 0]''*x-0', ...
	'[0; -1]''*x-0', ...
        '[-1; -2]''*x+2', ...
        '[1; -3]''*x-2', ...
        '[-1; 3]''*x-12' };
cons_grad = {'[-1; 0]', ...
	     '[0; -1]', ...
	     '[-1; -2]', ...
	     '[1; -3]', ...
	     '[-1; 3]' };

%toleranse, connected with
%'mouse' errors
tol = 0.01;

%domain
x1 = -7:0.75:7;
x2 = -7:0.75:7;

%starting point
x1_start = 4;
x2_start = 4;


%construct the optimization problem
gp = gr_epa_opt( x1, x2, ...
    epa_opt_prob( obj, obj_grad, cons, cons_grad ), ...
		 x1_start, x2_start );
