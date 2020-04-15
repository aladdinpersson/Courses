function f = con_func( p, k, X )
% CON_FUNC(p, i, x) Evaluate the kth constraint
s = size( X );
f = zeros( 1, s(2) );

for i = 1:s(2)
  x = X(:,i);
  f(i) = eval( p.con_func{k} );
end
