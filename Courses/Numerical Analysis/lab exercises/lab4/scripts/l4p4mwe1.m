% Define the function
f=@(x)cos(x)-x;

% Define the initial bracket
a0=-5; b0=100;

% Define the tolerance
delta=1e-15; epsilon=1e-15;

% Define the maximum number of iterations
maxit=15;

% Solve the equation f(x)=0
[x, it, a, b, his, res, stat, flag]=MyRobustSecant(f,a0,b0,delta,eps,maxit);



    
            
            
            
        
    


 