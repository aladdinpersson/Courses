function [l, gp1] = lagrange( gp )
gp.cur_l = lagrange( gp.op, [gp.curx; gp.cury] );
gp1 = gp;
l = gp.cur_l;