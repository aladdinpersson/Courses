function l = lagrange( p, X )
%LAGRANGE(p, X) Evaluate lagrange multipliers

s = size( X );
l = zeros( p.m, s(2) );

A = zeros( s(1), p.m );

for i = 1:s(2)
  x = X(:,i);
  f = -obj_grad( p, x );
  act_c = act_con( p, x );
  act_ind = find( act_c );
 
  for j = 1:p.m
    if( act_c( j ) )
      A(:,j) = con_grad( p, j, x );
    end    
  end
    
  l(act_ind,i) = A(:,act_ind)\f;
  if( norm( A(:,act_ind)*l(act_ind,i) - f ) > p.tol )    
    l(:,i) = ones( p.m, 1 ) * NaN;
  end 
end
