function b = fea(lp, x)
if( size(x) ~= [lp.nvar,1] )
  warning( 'Incompatible size of ''x''' );
  b = 0;
else
  b = all(lp.A*x <= lp.b);
end
return;