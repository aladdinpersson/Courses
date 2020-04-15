% Primal Potential - reduction Interior-Point Newton Step

function x = lipa_step(lp, x_old, mu)

r = lp.b - lp.A*x_old;
% test, if we are in the interior
if( any( r <= 0 ) )
  warning( 'Not an interior point. I give up.' );
  x = x_old;
  return;
end

% f(x) = < c, x > - mu * \sum log(b - Ax)
f = potential_r(lp.c, r, x_old, mu);

% calc the gradient
df = lp.c + mu*sum(lp.A ./ repmat(r,1,lp.nvar), 1)';

% calc the Hessian
ddf = mu*(lp.A'*(lp.A ./ repmat(r.^2,1,lp.nvar)));

% find the Newton dir
d = -ddf \ df;

% alphamax -- minimal-ratio test
Ad = lp.A*d;
ind = find(Ad>0);

if( isempty( ind ) )
  alphamax = 1;
else
  alphamax = min( 1, min( r(ind) ./ Ad(ind) ) );
end
  
% $$$ if( alphamax == Inf )
% $$$   %warning( 'The problem is unbounded! I give up.' );
% $$$   x = x_old + d;
% $$$   return;
% $$$ end


% do the Armijo linesearch
sigma = 0.5;
rho = 0.5;

alpha = 0.99*alphamax;
sdf = sigma*(df'*d);

while 1
  x = x_old + alpha*d;
  if( potential_r(lp.c, lp.b-lp.A*x, x, mu) <= f + alpha*sdf)
    break;
  end
  
  alpha = alpha*rho;
end

return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = potential_r(c, r, x, mu)
f = c'*x - mu * sum(log(r));
return;