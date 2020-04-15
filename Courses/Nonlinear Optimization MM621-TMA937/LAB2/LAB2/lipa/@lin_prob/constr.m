function f = constr(lp,x)
np = size(x,2);
f = zeros(lp.ncon,np);
for i = 1:np
  f(:,i) = lp.A * x(:,i) - lp.b;
end
return;