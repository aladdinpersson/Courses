function display( p )
% DISPLAY(p) Display an optimization problem
disp([ 'min ', p.obj_func]);
if( p.m > 0 ) 
  disp(' s.t.');
  for i = 1:p.m
    disp( ['  ', p.con_func{ i }, ' <= 0'] );
  end
end

  