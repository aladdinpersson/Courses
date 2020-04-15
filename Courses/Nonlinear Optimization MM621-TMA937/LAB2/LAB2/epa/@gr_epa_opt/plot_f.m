function plot_f( gp )
[X, Y] = meshgrid( gp.x, gp.y );

sx = length( gp.x );
sy = length( gp.y );
 
Z = reshape( ... 
    obj_func( gp.op, [reshape(X, 1, sx*sy); ...
		    reshape(Y, 1, sx*sy)] ), ...
    sy, sx );

surfl( X, Y, Z ); 
%%axis( [gp.xmin, gp.xmax, gp.ymin, gp.ymax, -inf, inf ] );
clear( 'X' );
clear( 'Y' );
clear( 'Z' );