function gp1 = optimize( gp, mu )
[x, flag, n_func] = optimize( gp.op, mu, [gp.x_start; gp.y_start] );
gp.mu = mu;
gp.n_eval = gp.n_eval + n_func;
%gp.path = sortrows( [gp.path;[mu, x(1), x(2)]], 1 );
gp.path = [gp.path;[mu, x(1), x(2)]];
gp.obj_val = obj_func( gp.op, x );
gp.penalty = penalty( gp.op, x, mu );


%%
%%some graphics go here
sx = length( gp.x );
sy = length( gp.y );
[X Y] = meshgrid( gp.x, gp.y );
X = reshape( X, 1, sx*sy );
Y = reshape( Y, 1, sx*sy );

f = obj_func( gp.op, [X;Y] ) + ...
    penalty( gp.op, [X;Y], mu ); 
%fgrad = -obj_grad( gp.op, [X;Y] ) - ...
%	pen_grad( gp.op, [X;Y], mu );

X = reshape( X, sy, sx );
Y = reshape( Y, sy, sx );
hold( 'on' );
cla;
axis( [gp.xmin, gp.xmax, gp.ymin, gp.ymax] );
%hs = quiver( X, Y, ...
%	     reshape( fgrad(1,:), sy, sx), ...
%	     reshape( fgrad(2,:), sy, sx), ...
%	     1, ...
%	     gp.grad_color );
%set( hs, ...
%     'HitTest', 'off', ...
%     'HandleVisibility', 'on' );

[c, hs] = contourf( X, ...
		    Y, ...
		    reshape( f, sy, sx ), ...
		    sortrows([min(f); gp.levels; max(f)]) );
%set( hs, 'LineStyle','none', ...
%     'HitTest', 'off', ...
%     'HandleVisibility', 'on' );

 clabel( c, hs, 'color', gp.clab_color );
set( hs, ...
    'HitTest', 'off', ...
     'HandleVisibility', 'on' );


hs = plot( x(1), x(2), sprintf( '%sx', gp.path_color ) );
set( hs, ...
     'HitTest', 'off', ...
     'HandleVisibility', 'on', ...
     'LineWidth', 2 );
     
hold( 'off' );

%%%%%%%%%%%%
% update
gp.x_start = x(1);
gp.y_start = x(2);
gp.min_penalty = mu;

gp1 = gp;
clear( 'X' );
clear( 'Y' );
clear( 'f' );
