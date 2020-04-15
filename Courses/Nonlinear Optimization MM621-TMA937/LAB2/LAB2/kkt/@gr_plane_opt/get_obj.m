function f = get_obj( gp )
f = obj_func( gp.op, [gp.curx; gp.cury] );