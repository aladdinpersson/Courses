function gp = example03
%objective function
obj = 'x''*sin(x)';
obj_grad = 'sin(x) + (x.*cos(x))';

%constraints
cons = {'-x(1)+1/3', 'sin(x(2))-x(1)', '-x(2)/3+1/4', '(x-[1;1])''*(x-[1;1])/5-1'};
cons_grad = {'[-1, 0]''', '[-1,cos(x(2))]''', '[0, -1/4]''', 'x/5-[1/5;1/5]'};

%toleranse, connected with
%'mouse' errors
tol = 0.1;

%domain
x1 = -1:0.3:4.5;
x2 = -0.5:0.3:4.5;

%construct the optimization problem
gp = gr_plane_opt( x1, x2, ...
    opt_prob( obj, obj_grad, cons, cons_grad, tol ));
