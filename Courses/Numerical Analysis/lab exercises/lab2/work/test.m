f=@(x)x.^2-2; x0=0; x1=2; maxit=60; delta=1e-15; eps=1e-15;
[x, flag, it, a, b, his, res]=bisection(f,x0,x1,f(x0),f(x1),delta,eps,maxit,1);

x