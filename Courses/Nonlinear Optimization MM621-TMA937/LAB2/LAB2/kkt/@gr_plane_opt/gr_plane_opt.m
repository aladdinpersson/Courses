function gp = gr_plane_opt( varargin )
%GR_PLANE_OPT( x, y, op )  Constructor

%global color constants
gp.bcgd_color = 'black';
gp.infea_color = 'red';
gp.grad_color = 'g';
gp.actcon_color = 'r';
gp.pascon_color = 'w';
gp.patch_color = 'y';%[0.6, 0.1, 0.1];

switch nargin
 case 0
  gp.xmin = NaN;
  gp.xmax = NaN;
  gp.x = [];
  
  gp.ymin = NaN;
  gp.ymax = NaN;
  gp.y = [];
  
  gp.curx = NaN;
  gp.cury = NaN;
  gp.is_fea = 0;
  
  gp.curact_con = [];
  gp.cur_l = [];
  
  gp.op = opt_prob;
  
  %graphic_stuff
  gp.con_handles = {};
  gp.obj_grad_handle = [];
  gp.con_grad_handles = [];
  gp.con_grad_patch = [];
  
  gp = class( gp, 'gr_plane_opt' );
  
 case 1
  if( isa( varargin{1}, 'gr_plane_opt' ) )
    p = varargin{1};
  else
    error( 'Wrong argument type' );
  end
 
 case 3
  gp.xmin = min( varargin{1} );
  gp.xmax = max( varargin{1} );
  gp.x = varargin{1};
  
  gp.ymin = min( varargin{2} );
  gp.ymax = max( varargin{2} );
  gp.y = varargin{2};
  
  gp.curx = NaN;
  gp.cury = NaN;
  gp.is_fea = 0;
  
  gp.curact_con = [];
  gp.cur_l = [];
  
  if( isa( varargin{3}, 'opt_prob' ) )
    gp.op = varargin{3};
  else
    error( 'Wrong argument type' );
  end  
  
  %graphic_stuff
  gp.con_handles = cell(1, n_con( gp.op ));
  gp.obj_grad_handle = [];
  gp.con_grad_handles = [];
  gp.con_grad_patch = [];
  
  gp = class( gp, 'gr_plane_opt' );
    
  sx = length( gp.x );
  sy = length( gp.y );
  
  [X Y] = meshgrid( gp.x, gp.y );
  ograd = -obj_grad( gp.op, [reshape(X, 1, sx*sy); ...
		    reshape(Y, 1, sx*sy)] );

  
  %%%
  hold('off');
  ofunc = reshape( ...
      obj_func( gp.op, [reshape(X, 1, sx*sy); ...
		        reshape(Y, 1, sx*sy)] ), ...
      sy, sx );
%  FEA = reshape( ...
%      fea(gp.op, [reshape(X, 1, sx*sy); ...
%		  reshape(Y, 1, sx*sy)] ), ...
%      sy, sx );
%  IND = find(FEA == 0);
%  ofunc(IND) = -inf;
  
  colormap('summer');
  [c_levels,h_levels] = contourf(X,Y,ofunc,50);
  set(h_levels,'LineStyle','none', ...
	       'HitTest', 'off', ...
	       'HandleVisibility', 'off');
%  alpha(h_levels,0.3);
  hold('on');
  %%%
  
  %%hold( 'off' );
  hs = quiver( X, Y, ...
	  reshape( ograd(1,:), sy, sx), ...
	  reshape( ograd(2,:), sy, sx), ...
	  1, ...
	  gp.grad_color );

  set( hs, ...
	  'HitTest', 'off', ...
          'HandleVisibility', 'off' );

  
  
%  hold( 'on' );
%  hd = contour( X, Y, ...
%	reshape( obj_func( gp.op, [reshape(X, 1, sx*sy); ...
%		    reshape( Y, 1, sx*sy ) ] ), sy, sx ) );
%  colormap( gray );
%  shading( 'interp' );
%  set( hd, ...
%	  'HitTest', 'off', ...
%          'HandleVisibility', 'off' );
  
  set( gca, 'Color', gp.bcgd_color );
  axis( [gp.xmin, gp.xmax, gp.ymin, gp.ymax] );
  
  XY = [reshape(X, 1, sx*sy); reshape(Y, 1, sx*sy)];
  clear( 'X' ); clear( 'Y' );
  clear( 'ograd' );
  clear( 'ofunc' );
  
  for i = 1:n_con( gp.op )
    gp = plot_con( gp, i, XY, sx, sy );
  end
  
  
 otherwise
  error( 'Wrong number of arguments' );
end


function gp1 = plot_con( gp, i, XY, sx, sy )
c = reshape( con_func( gp.op, i,XY ), sy, sx );
c0 = contourc( gp.x, gp.y, c, [0 0] );
clear( 'c' );

start_ind = 1;
end_ind = length(c0);
j = 1;

hold( 'on' );
while ( start_ind <= end_ind )
  cur_length = c0( 2, start_ind );
  
  gp.con_handles{i}(j) = ...
      plot( c0(1, start_ind+1:start_ind+cur_length), ...
	    c0(2, start_ind+1:start_ind+cur_length), ...
	    gp.pascon_color, 'LineWidth', 2, ...
	    'HitTest', 'off', ...
	    'HandleVisibility', 'off' );
  j = j + 1;
  start_ind = start_ind + cur_length + 1;
end
hold( 'off' );
gp1 = gp;