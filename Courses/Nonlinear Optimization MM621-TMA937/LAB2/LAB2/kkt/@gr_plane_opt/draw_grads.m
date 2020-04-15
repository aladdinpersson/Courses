function gp1 = draw_grads( gp )
hold( 'on' );

l = length( gp.curact_con );
gp.con_grad_handles = zeros( 3, l );
con_grads = zeros(2,l+1);
for i = 1:l
  j = gp.curact_con( i );  
  f = con_grad( gp.op, j, [gp.curx; gp.cury] );
  con_grads(:,i) = f/norm(f);
end

if( l > 1 )
  %%% hint: use convhull!!!
  con_grads1 = con_grads + repmat([gp.curx; gp.cury],1,l+1);
  inds = convhull(con_grads1(1,:), con_grads1(2,:));
  gp.con_grad_patch = patch(con_grads1(1,inds), con_grads1(2,inds), ...
			    gp.patch_color);
  set( gp.con_grad_patch, 'LineStyle','none', ...
		    'HitTest', 'off', ...
		    'HandleVisibility', 'on' );
  clear('con_grads1');
end


for i = 1:l
  gp.con_grad_handles(:,i) = plot_grad( [gp.curx; gp.cury], con_grads(:,i) );
  set( gp.con_grad_handles(:,i), ...
       'Color', gp.actcon_color, ...
       'LineWidth', 4, ...
       'HitTest', 'off', ...
       'HandleVisibility', 'on' );
end

f = -obj_grad( gp.op, [gp.curx; gp.cury] ); 
gp.obj_grad_handle = plot_grad( [gp.curx; gp.cury], f );
set(gp.obj_grad_handle, ...
    'Color', gp.grad_color, ...
    'LineWidth', 2, ...
    'HitTest', 'off', ...
    'HandleVisibility', 'on' ); 


hold( 'off' );
gp1 = gp;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function h = plot_grad( x, dir )
thresh = 0.001;
n = norm( dir );

h = zeros(3,1);
if( n > thresh )
  y = x + dir/n;
  X1 = zeros(2,3);
  X2 = zeros(2,3);
  X1(:,1) = [x(1),y(1)];
  X2(:,1) = [x(2),y(2)];
  dir1 = rotate(-dir,pi/6);
  X1(:,2) = [y(1), y(1)+dir1(1)/(5*n)];
  X2(:,2) = [y(2), y(2)+dir1(2)/(5*n)];
  dir1 = rotate(-dir,-pi/6);
  X1(:,3) = [y(1), y(1)+dir1(1)/(5*n)];
  X2(:,3) = [y(2), y(2)+dir1(2)/(5*n)];
  
  
  
  h = line( X1, X2);
end
return;

function dir1 = rotate(dir, angle)
angle0 = atan2(dir(2),dir(1));
r = norm(dir);
dir1 = r*[cos(angle0+angle);sin(angle0+angle)];
return;