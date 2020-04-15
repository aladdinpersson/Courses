function i = act_con( p, X )
%ACT_CON(p, X ) determines active constraints at x
s = size( X );
i = zeros( p.m, s(2) );

for k = 1:s(2)
  x = X(:,k);
  for j = 1:p.m
    jc = con_func( p, j, x );
    if( jc > -p.tol & jc <= 0)
      i( j, k ) = 1;
    end
  end
end

  
