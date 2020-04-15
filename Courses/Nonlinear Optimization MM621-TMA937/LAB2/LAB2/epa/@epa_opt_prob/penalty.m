function a = penalty( op, x, mu )
s = size( x );
a = zeros( 1, s(2) );

for i = 1:op.m
  a = a + mu * (max( [zeros( 1, s(2) ); con_func( op, i, x )], [], 1 )).^2;
end
