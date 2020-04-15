function gp1 = draw_actcon( gp, color )
gp.curact_con = find(act_con( gp.op, [gp.curx;gp.cury] ));

for i = 1:length( gp.curact_con )
    j = gp.curact_con( i );
    
    for k = 1:length(gp.con_handles{j})
      set( gp.con_handles{j}(k), ...
	   'Color', color );
    end
  end

gp1 = gp;