% Demonstrate Richardson's technique for a simple 1D problem

% Define the interval
a=0; b=2;

% Select the function which defines the differential equation
f=@(t,y) 1-y.^2; 

% Specify the initial condition
y0=0;

% Select the number of timesteps
N1=10; N2=100; 

% Select the number of approximations
kmax=7;

% Specify the method to use and the *correct* order
method='rk1'; p=1; 

% The exact solution can be computed 
sol=@(t)tanh(t);

% Apply Richardson's techniques to our initial value problem
[s, frac, est, err]=rode(f,a,b,y0,N1,N2,kmax,method,p,sol);