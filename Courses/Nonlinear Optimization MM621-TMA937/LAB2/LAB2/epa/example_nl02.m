function gp = example02
%objective function
obj = 'x(1)^2';
obj_grad = '[2*x(1);0]';

%constraints
cons = {'-x(1)+2', '-x(2)/3+1/3', 'x(1)/2+x(2)/4-2'};
cons_grad = {'[-1, 0]''', '[0, -1/3]''', '[1/2;1/4]'};

%toleranse, connected with
%'mouse' errors
tol = 0.05;

%domain
x1 = 1:0.3:5;
x2 = 0:0.3:5;

x1_start = 2;
x2_start = 2;

%construct the optimization problem
gp = gr_epa_opt( x1, x2, ...
    epa_opt_prob( obj, obj_grad, cons, cons_grad ), ...
		 x1_start, x2_start);
