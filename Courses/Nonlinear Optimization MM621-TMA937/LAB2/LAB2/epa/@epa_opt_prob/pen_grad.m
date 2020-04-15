function a = pen_grad( op, x, mu )
s = size( x );
a = zeros( s );

for j = 1:s(2)
  for i = 1:op.m  
    a(:,j) = a(:,j) + 2 * mu * ...
	     max( 0, con_func( op, i, x(:,j) ) ) * ...
	     con_grad( op, i, x(:,j) );
  end
end

