function gp = example1
%objective function
obj = 'x''*x';
obj_grad = '2*x';

%constraints
cons = {'-x(1)+2', '-x(2)/3+1/3', 'x(1)/2+x(2)/4-2'};
cons_grad = {'[-1, 0]''', '[0, -1/3]''', '[1/2;1/4]'};

%toleranse, connected with
%'mouse' errors
tol = 0.05;

%domain
x1 = 1:0.3:5;
x2 = 0:0.3:5;

%construct the optimization problem
gp = gr_plane_opt( x1, x2, ...
    opt_prob( obj, obj_grad, cons, cons_grad, tol ));
