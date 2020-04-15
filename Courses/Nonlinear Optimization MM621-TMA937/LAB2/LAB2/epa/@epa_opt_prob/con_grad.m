function f = con_grad( p, k, X )
% CON_GRAD(p, x) Evaluate the constraints gradient
s = size( X );
f = zeros( s );

for i = 1:s(2)
  x = X(:, i);
  f(:, i) = eval( p.con_grad{k} );
end
