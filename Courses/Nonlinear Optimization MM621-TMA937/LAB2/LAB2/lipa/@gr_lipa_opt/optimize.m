function gp1 = optimize( gp, mu )
[x, xc] = optim( gp, mu );

gp.mu = mu;
%gp.path = sortrows( [gp.path;[mu, x(1), x(2)]], 1 );
%gp.c_path = sortrows( [gp.c_path;[mu, xc(1), xc(2)]], 1 );
gp.path = [gp.path;[mu, x(1), x(2)]];
gp.c_path = [gp.c_path;[mu, xc(1), xc(2)]];
gp.obj_val = obj_fun( gp.op, x );
gp.penalty = potential( gp.op, x, mu );


%%
%%some graphics go here
sx = length( gp.x );
sy = length( gp.y );
[X Y] = meshgrid( gp.x, gp.y );
X = reshape( X, 1, sx*sy );
Y = reshape( Y, 1, sx*sy );


f = potential( gp.op, [X;Y], mu );
ind = find( f == inf );
f(ind) = NaN;

X = reshape( X, sy, sx );
Y = reshape( Y, sy, sx );

hold( 'on' );
cla;
axis( [gp.xmin, gp.xmax, gp.ymin, gp.ymax] );
colormap('summer');
% $$$ hs = pcolor( X, Y, reshape( f, sy, sx ) );
% $$$ set( hs, ...
% $$$      'HitTest', 'off', ...
% $$$      'HandleVisibility', 'on' );


% $$$ fmax = max( f );
% $$$ fmin = min( f );
% $$$ fmult = exp(log(fmax-fmin)/(gp.n_of_levels-1));
% $$$ levels = zeros(gp.n_of_levels,1);
% $$$ for i = 1:gp.n_of_levels
% $$$   levels(i) = fmin*fmult^(i-1);
% $$$ end
fmin = min(f);
levels = fmin:1:(fmin+gp.n_of_levels);

[c_levels,h_levels] = contourf(X,Y, reshape(f, sy, sx), levels);
set(h_levels,'LineStyle','none', ...
	     'HitTest', 'off', ...
	       'HandleVisibility', 'on');

hs = plot( x(1), x(2), sprintf( '%sx', gp.path_color ) );
set( hs, ...
     'HitTest', 'off', ...
     'HandleVisibility', 'on', ...
     'LineWidth', 2 );

hs = plot( xc(1), xc(2), sprintf( '%so', gp.cpath_color ) );
set( hs, ...
     'HitTest', 'off', ...
     'HandleVisibility', 'on', ...
     'LineWidth', 2 );

hold( 'off' );

%%%%%%%%%%%%
% update
gp.x_start = x(1);
gp.y_start = x(2);
gp.x_cstart = xc(1);
gp.y_cstart = xc(2);
gp.max_penalty = mu;

gp1 = gp;
clear( 'X' );
clear( 'Y' );
clear( 'f' );

return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x, xc] = optim( gp, mu )
max_iter = 100;
tol = 1e-6;
x = lipa_step( gp.op, [gp.x_start; gp.y_start], mu );

xc0 = [gp.x_cstart; gp.y_cstart];
iter = 1;
while( iter <= max_iter)
  xc = lipa_step( gp.op, xc0, mu );
  if( norm( xc-xc0 ) <= tol )
    break;
  end
  
  xc0 = xc;
end

if( iter > max_iter )
  warning( 'The problem is probably unbounded' );
end

return