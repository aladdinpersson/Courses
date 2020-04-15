function gp1 = small_clean( gp )

delete( gp.obj_grad_handle );

delete( gp.con_grad_handles );
gp.con_grad_handles = [];

delete( gp.con_grad_patch );
   gp.con_grad_patch= [];

gp = draw_actcon( gp, gp.pascon_color );
gp1 = gp;