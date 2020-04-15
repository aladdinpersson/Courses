function gp1 = draw_fea( gp )
gp.is_fea = fea( gp.op, [gp.curx; gp.cury] );

%if( gp.is_fea )
%  set( gca, 'Color', gp.bcgd_color );
%else
%  set( gca, 'Color', gp.infea_color );
%end
gp1 = gp;
