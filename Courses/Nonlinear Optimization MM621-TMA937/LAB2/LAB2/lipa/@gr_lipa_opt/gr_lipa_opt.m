function gp = gr_lipa_opt( varargin )
%GR_PLANE_OPT( x, y, op, x_start, y_start )  Constructor

%global color constants
gp.bcgd_color = 'k';
gp.grad_color = 'g';
gp.con_color = 'w';
gp.obj_colormap = 'gray';
gp.path_color = 'm';
gp.cpath_color = 'r';
gp.clab_color = 'w';
gp.n_of_levels = 30;
gp.min_penalty = 1e-8;
gp.max_penalty = 10;
% $$$ gp.levels = [];

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
  gp.x_cstart = NaN;
  gp.y_cstart = NaN;
  gp.obj_val = NaN;
  gp.penalty = NaN;
  gp.mu = NaN;
  gp.n_eval = 0;
  
  gp.path = zeros( 0, 3 );
  gp.c_path = zeros( 0, 3 );
    
  gp.op = lin_prob;
    
  gp = class( gp, 'gr_lipa_opt' );
  
 case 1
  if( isa( varargin{1}, 'gr_lipa_opt' ) )
    gp = varargin{1};
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
  gp.x_cstart = varargin{4};
  gp.y_cstart = varargin{5};
  gp.obj_val = NaN;
  gp.penalty = NaN;
  gp.mu = NaN;
  gp.n_eval = 0;
  
  gp.path = zeros( 0, 3 );
  gp.c_path = zeros( 0, 3 );
  
  if( isa( varargin{3}, 'lin_prob' ) )
    gp.op = varargin{3};
  else
    error( 'Wrong argument type' );
  end  
  
  gp = class( gp, 'gr_lipa_opt' );
    
  sx = length( gp.x );
  sy = length( gp.y );
  
  %graphics stuff
  [X Y] = meshgrid( gp.x, gp.y );

  XY = [reshape(X, 1, sx*sy); reshape( Y, 1, sx*sy ) ];

  ofunc = reshape( obj_fun( gp.op, XY ), sy, sx );
  
  hold( 'off' );
  colormap('summer');

  [c_levels,h_levels] = contourf(X,Y, ofunc, gp.n_of_levels);
  set(h_levels,'LineStyle','none', ...
	       'HitTest', 'off', ...
	       'HandleVisibility', 'off');
%  alpha(h_levels,0.3);
  
% $$$   gp.levels = zeros( length( hd ) );
% $$$   for i = 1:length( hd )
% $$$     gp.levels(i) = get( hd(i), 'UserData' );
% $$$   end

  set( gca, 'Color', gp.bcgd_color );
  axis( [gp.xmin, gp.xmax, gp.ymin, gp.ymax] );
  
  clear( 'X' ); clear( 'Y' );
  clear( 'ofunc' );
  
  plot_con( gp, XY, sx, sy );
  
  
 otherwise
  error( 'Wrong number of arguments' );
end


function plot_con( gp, XY, sx, sy )
c = constr( gp.op, XY );

for i = 1:size(c,1),
  c0 = contourc( gp.x, gp.y, reshape(c(i,:), sy, sx), [0 0] );
  
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
end

return
