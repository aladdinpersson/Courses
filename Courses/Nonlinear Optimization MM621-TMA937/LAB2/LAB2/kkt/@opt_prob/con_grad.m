function f = con_grad( p, k, X )
% CON_GRAD(p, x) Evaluate the constraints gradient
s = size( X );
f = zeros( s );

for i = 1:s(2)
  f(:, i) = feval( p.con_grad{k}, X(:,i) );
end

