function [x, it, a, b, his, res, stat, flag]=MyRobustSecant(f,a0,b0,delta,eps,maxit)
% MyRobustSecant  Combines bisection with the secant method
%
% CALL SEQUENCE: [x, it, a, b, his, res, stat, flag]=MyRobustSecant(f,a0,b0,delta,eps,maxit)
%
% INPUT:
%   f        a handler to the central function
%   a0, b0   the initial bracket
%   delta    return if current bracket is shorter than delta
%   eps      return if current residual is bounded by eps
%   maxit    return after at most maxit iterations
%
% OUTPUT:
%   x        the last approximation of the root
%   it       the number of iterations completed
%   a, b     a(j) and b(j) form the jth bracket
%   his      his(j) is the jth approximation of the root
%   res      res(j) is the jth residual
%   stat     records the decision process, stat(j) is 
%              0 if the jth iteration was a bisection step
%              1 if the jth iteration was a secant step
%   flag     a standard return flag
%              flag = -1  if the initial bracket was rejected
%              flag =  0  if the iteration did not converge
%              flag >  0  if the iteration did converge
%                 flag=1 is set if the final bracket is shorter than delta
%                 flag=2 is set if the final residual is bounded by eps
%
% MINIMAL WORKING EXAMPLE: TODO

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   2018-11-23  Skeleton extracted from working code

% PROGRAMMING by Aladdin Persson (alhi0008@student.umu.se)
%   2018-11-28 Initial programming

% Assume that the initial bracket cannot be accepted
flag=-1;

% Dummy initialization of all output
x=NaN; it=0; a=[]; b=[]; his=[]; res=[]; stat=[];

% Construct the initial bracket
alpha=min(a0,b0); beta=max(a0,b0);

% Evaluate f at the initial points alpha and beta
f0=f(alpha); f1=f(beta);

% Does f change sign from alpha to beta?
if sign(f0)*sign(f1)==-1
    % The initial bracket can be accepted
    flag=0;
else
    % The initial bracket can not be accepted
    return;
end

% /////////////////////////////////////////////////////////////////////////
% At this point, we have a proper bracket around the root
% /////////////////////////////////////////////////////////////////////////

% Do a proper initialization of all output data;
a=zeros(maxit,1); b=zeros(maxit,1); his=zeros(maxit,1); res=zeros(maxit,1);

% This assumes that all steps will be bisection step
stat=zeros(maxit,1);

% Use the initial bracket to initialize the secant method
x0=alpha; x1=beta;

% Save fa=f(alpha) and fb=f(beta); f0 = f(alpha), f1=f(beta)
fa=f0; fb=f1;

% Main loop
for it=1:maxit
    % Save the current bracket
    a(it)=alpha; b(it)=beta;
    
    % Will a secant step cause division by zero?
    if (f0~=f1)
        % No, it is safe to do an experimental secant step
        % Compute c as the result of one secant step from x0, x1
        numerical_deriv = (f1-f0)./(x1-x0);
        c = x1 - f1./(numerical_deriv);
        
        % Does c fall outside the interval (alpha, beta)?
        if (c <= alpha || c >= beta)
            % Yes, replace c with the midpoint of (alpha, beta)
            c = alpha + (beta - alpha)./2;
        else
            % Record the fact that we did a secant step
            stat(it)=1;            
        end
    else
        % Yes, a secant step will cause division by zero!
        % Compute c as the midpoint of (alpha, beta)
        c = alpha + (beta - alpha)./2;
    end
    
    % /////////////////////////////////////////////////////////////////////
    % At this point we have determine our next approximation c
    % /////////////////////////////////////////////////////////////////////
    
    % Compute f(c)
    fc=f(c);
    
    % Save the current approximation and residual
    x=c; his(it)=c; res(it)=fc;
    
    % Is the current bracket short enough?
    if abs(beta-alpha) <= delta
        flag=1; %flag=1 if delta
    end
    
    % Is the current residual small enough?
    if abs(fc)<=eps
        flag=2; %flag=2 if residual smaller than epsilon
    end
    
    % Do we need more iterations?
    if flag==0
        % Determine the next bracket
        if sign(fa)*sign(fc)==-1
            % Use (alpha, c) as the next bracket
            alpha=alpha; beta=c; %alpha unecessary but just to remind how it works
            fb=fc;
        else
            % Use (c, beta) as the next bracket
            alpha=c; beta=beta; 
            fa=fc;
        end
        % Prepare for the next iteration
        x0=x1; f0=f1;
        x1=c;  f1=fc;

     else
        % Break out of the for loop
        break;
    end
end

% Discard trailing zeros from all relevant output arrays
a=a(1:it); b=b(1:it); stat=stat(1:it); res=res(1:it);