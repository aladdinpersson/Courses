function f = obj_func( p, X )
% OBJ_FUNC(p, x) Evaluate the objective
s = size( X );
f = zeros( 1, s(2) );

for i = 1:s(2)
  x = X(:,i);
  f(i) = eval( p.obj_func );
end

 