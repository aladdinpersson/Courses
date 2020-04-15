function gp1 = big_clean( gp )
set( gca, 'ShowHiddenHandles', 'on' );
cla;
set( gca, 'ShowHiddenHandles', 'off' );

%gp.obj_grad_handle = NaN;
%gp.con_grad_handles = [];
gp = draw_actcon( gp, 'white' );
gp1 = gp;