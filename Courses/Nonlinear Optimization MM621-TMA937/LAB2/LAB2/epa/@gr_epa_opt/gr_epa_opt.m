function gp = gr_epa_opt( varargin )
%GR_PLANE_OPT( x, y, op, x_start, y_start )  Constructor

%global color constants
gp.bcgd_color = 'k';
gp.grad_color = 'g';
gp.con_color = 'w';
gp.obj_colormap = 'gray';
gp.path_color = 'm';
gp.clab_color = 'w';
gp.n_of_levels = 15;
gp.min_penalty = 0.1;
gp.max_penalty = 1e8;
gp.levels = [];

switch nargin
 case 0
  gp.xmin = NaN;
  gp.xmax = NaN;
  gp.x = [];
  
  gp.ymin = NaN;
  gp.ymax = NaN;
  gp.y = [];
  
  gp.x_start = NaN;
  gp.y_start = NaN;
  gp.obj_val = NaN;
  gp.penalty = NaN;
  gp.mu = NaN;
  gp.n_eval = 0;
  
  gp.path = zeros( 0, 3 );
    
  gp.op = opt_prob;
    
  gp = class( gp, 'gr_epa_opt' );
  
 case 1
  if( isa( varargin{1}, 'gr_epa_opt' ) )
    p = varargin{1};
  else
    error( 'Wrong argument type' );
  end
 
 case 5
  gp.xmin = min( varargin{1} );
  gp.xmax = max( varargin{1} );
  gp.x = varargin{1};
  
  gp.ymin = min( varargin{2} );
  gp.ymax = max( varargin{2} );
  gp.y = varargin{2};
  
  gp.x_start = varargin{4};
  gp.y_start = varargin{5};
  gp.obj_val = NaN;
  gp.penalty = NaN;
  gp.mu = NaN;
  gp.n_eval = 0;
  
  gp.path = zeros( 0, 3 );
  
  if( isa( varargin{3}, 'epa_opt_prob' ) )
    gp.op = varargin{3};
  else
    error( 'Wrong argument type' );
  end  
  
  gp = class( gp, 'gr_epa_opt' );
    
  sx = length( gp.x );
  sy = length( gp.y );
  
  %graphics stuff
  [X Y] = meshgrid( gp.x, gp.y );
  XY = [reshape(X, 1, sx*sy); reshape( Y, 1, sx*sy ) ];

  ofunc = reshape( obj_func( gp.op, XY ), sy, sx );
  
  hold( 'off' );
  colormap('summer');


  [c_levels] = contourf(X,Y, ofunc, gp.n_of_levels);
  
  h_levels = clabel(c_levels, 'color', gp.clab_color);
  set(h_levels,'LineStyle','none', ...
	       'HitTest', 'off', ...
	       'HandleVisibility', 'on');
  
  

  gp.levels = zeros( length( h_levels )/2, 1 );
  for i = 1:length( h_levels )/2
    gp.levels(i) = get( h_levels(i*2), 'UserData' );
  end
  set( gca, 'Color', gp.bcgd_color );
  axis( [gp.xmin, gp.xmax, gp.ymin, gp.ymax] );
  
  clear( 'X' ); clear( 'Y' );
  clear( 'ofunc' );
  
  for i = 1:n_con( gp.op )
    plot_con( gp, i, XY, sx, sy );
  end
  
  
 otherwise
  error( 'Wrong number of arguments' );
end


function plot_con( gp, i, XY, sx, sy )
c = reshape( con_func( gp.op, i,XY ), sy, sx );
c0 = contourc( gp.x, gp.y, c, [0 0] );

start_ind = 1;
end_ind = length(c0);

hold( 'on' );
while ( start_ind <= end_ind )
  cur_length = c0( 2, start_ind );
  
  plot( c0(1, start_ind+1:start_ind+cur_length), ...
	c0(2, start_ind+1:start_ind+cur_length), ...
	gp.con_color, 'LineWidth', 2, ...
	'HitTest', 'off', ...
	'HandleVisibility', 'off' );
  start_ind = start_ind + cur_length + 1;
end
hold( 'off' );
