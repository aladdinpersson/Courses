function [x, flag, it, a, b, his, y, reb, res]=MyRoot(p,a0,b0,delta,eps,maxit)
% MyRoot  Finds roots of polynomials using the bisection method
%
% INPUT:
%   p        array of coefficients used by my_horner
%   a0, b0   the initial bracket
%   delta    return if current bracket is less than delta
%   eps      return if current residual is less than epsilon
%   maxit    return after maxit iterations
%   
% OUTPUT:
%   x      final approximation of the root
%   flag   a flag signaling succes or failure, 
%             flag  = -2  the initial bracket is bad
%             flag  = -1  the sign of f(a0) or f(b0) cannot be trusted
%             flag  =  0  maxit iterations completed without convergence
%             flag  >  0  then convergence has been achieved and if:
%                 flag = 1  then the last bracket is shorter than delta
%                 flag = 2  then the last function value is bounded by eps
%                 flag = 3  then the sign of the last function value cannot
%                           be trusted
%   it     the number of iterations completed
%   a, b   a(j) and b(j) form the jth bracket around his(j)
%   his    a vector containing all computed approximations of the root
%   y      the computed values of y=p(his)
%   reb    the running error bounds for y
%   res    the residuals (res = residual)
%
% MIMIMAL WORKING EXAMPLE: MyRootMWE1.m

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2018-11-14 Skeleton extracted from working code MyRoot

% PROGRAMMING by Aladdin Persson (alhi0008@ad.umu.se)
%   2018-11-17 Initial programming
%   2018-12-08 Minor improvements to code

% Initialize the flag.
flag=0;

% Dummy initialization of *all* output arguments
x=NaN; it=0; his=NaN; 
reb=zeros(maxit,1);
a=zeros(maxit,1); 
y=zeros(maxit,1);
b=zeros(maxit,1);
res=zeros(1,maxit);

% Initialize search bracket (alpha,beta) such that alpha <= beta
alpha=min(a0,b0);
beta=max(a0,b0);
    
% Compute fa=p(alpha) and fb=p(beta) and associated error bounds
[fa, ~, reb_alpha]= my_horner(p, alpha);
[fb, ~, reb_beta]= my_horner(p, beta);

% Investigate if the flag should be -2 or -1
if sign(fa)*sign(fb) > 0
    flag=-2;
elseif (abs(fa) <= reb_alpha) || (abs(fb) <= reb_beta)
    flag=-1;
end

% Stop if difference less than delta
if abs(beta-alpha) <= delta
    flag=-2;
end

% If the sign is the same, then we cannot run bisection
if sign(fa)*sign(fb) > 0
    flag=-2;
end

% In case flag is initially less than zero, there was something wrong
if (flag<0)
    % The initial bracket is either bad or cannot be judged
    return
end
    
% Main loop
for j=1:maxit
    % Record the current search bracket
    a(j)=alpha; b(j)=beta;
    
    % Carefully compute the midpoint c of the current search bracket
    c=alpha+(beta-alpha)/2;
    
    % Evaluate fc = p(c) and the running error bound for fc
    % priori error from my_horner is not necessary for bisection.
    [fc,~,rebfc]=my_horner(p,c);
    
    % Save the current values
    x=c; his(j)=c; y(j)=fc; reb(j)=rebfc; res(j)=fc;
    
    % Check for small bracket
    if abs(alpha-beta)<=delta
        flag=1;
    end
    
    % Check for small residual
    if abs(fc)<=eps
        flag=2;
    end
    
    % Check if the computed sign of the p(c) cannot be trusted
    if abs(fc) <= rebfc
        flag=3;
    end
    
    % Check if we can break out of the loop
    if flag>0
        % Yes, there is no reason to continue
        break
    end
    
    %----------------------------------------------------------------------
    % At this point we know that we need more iterations.
    %----------------------------------------------------------------------
    
    % Rebracket the root and recycle the old function values
    if sign(fa)*sign(fc)==-1
        beta=c; fb=fc;
    else
        alpha=c; fa=fc;
    end
end

% Shrink the output to avoid tails of unnecessary zeros
a=a(1:j); b=b(1:j); his=his(1:j); res=res(1:j); reb=reb(1:j); y=y(1:j);

% Return the number of iterations
it=j;