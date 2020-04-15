function b = fea( p, X )
%FEA(p, X) Evaluate feasibility

s = size( X );
b = ones( 1, s(2) );

for i = 1:s(2)
  x = X(:,i);
  for j = 1:p.m
    if( con_func( p, j, x ) > p.tol )
      b( 1, i ) = 0;
      break;
    end      
  end    
end