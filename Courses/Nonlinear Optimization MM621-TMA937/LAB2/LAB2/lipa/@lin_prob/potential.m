function f = potential(lp,x,mu)
np = size(x,2);
f = zeros(1,np);
for i = 1:np
  r = lp.b-lp.A*x(:,i);
  if( any( r <= 0 ) )
    f(i) = inf;
  else
    f(i) = lp.c' * x(:,i) - mu*sum(log(r));
  end
end
return;
