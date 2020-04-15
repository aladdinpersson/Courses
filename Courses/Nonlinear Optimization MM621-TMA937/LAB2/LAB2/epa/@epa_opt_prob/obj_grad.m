function f = obj_grad( p, X )
% OBJ_GRAD(p, x) Evaluate the gradient
s = size( X );
f = zeros( s );

for i = 1:s(2)
  x = X(:, i);
  f(:, i) = eval( p.obj_grad );
end
