% Define the function
f=@(x)tan(x)-x;

% Define the initial bracket
a0=4.4; b0=4.7;

% Define the tolerance
delta=1e-12; epsilon=1e-12;

% Define the maximum number of iterations
maxit=25;

% Solve the equation f(x)=0
[x, it, a, b, his, res, stat, flag]=MyRobustSecant(f,a0,b0,delta,eps,maxit);



    
            
            
            
        
    


 