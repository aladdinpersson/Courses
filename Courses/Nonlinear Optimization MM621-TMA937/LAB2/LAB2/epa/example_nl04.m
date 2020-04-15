function gp = example_nl04
%objective function
obj = '(x(1)+1)^2 + 0.5*(x(2))^2';
obj_grad = '[2*(x(1)+1); (x(2))]';

%constraints
cons = {'x(1)-3', '-x(2)', '(x(2)-(0.5*x(1))^3)'};
cons_grad = {'[1;0]', '[0;-1]', '[-0.5*3*(0.5*x(1))^2;1]'};

%toleranse, connected with
%'mouse' errors
tol = 0.05;

%domain
x1 = -2:0.3:4;
x2 = -2:0.3:4;


x1_start = 2;
x2_start = 2;

%construct the optimization problem
gp = gr_epa_opt( x1, x2, ...
    epa_opt_prob( obj, obj_grad, cons, cons_grad ), ...
		 x1_start, x2_start);
