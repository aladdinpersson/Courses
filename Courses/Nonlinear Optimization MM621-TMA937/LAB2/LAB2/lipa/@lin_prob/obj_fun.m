function f = obj_fun(lp,x)
np = size(x,2);
f = zeros(1,np);
for i = 1:np
  f(i) = lp.c' * x(:,i);
end
return;