function gp1 = handle_click( gp )

gp = draw_fea( gp );
gp = draw_actcon( gp, gp.actcon_color );
gp = draw_grads( gp );

gp1 = gp;