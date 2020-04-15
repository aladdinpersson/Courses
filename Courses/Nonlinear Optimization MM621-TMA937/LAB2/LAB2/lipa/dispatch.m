function dispatch( varargin )
switch nargin
 case 0
  command = 'init';
 case 1
  command = varargin{1};
 otherwise
  error( 'Invalid number of arguments' );
end

switch command
 case 'init'
  init_figure;
 case 'load'
  load_example;
 case 'penaltyChange'
  penalty_change;
 case 'optimize'
  dispatch_optimize;
 case 'plot'
  dispatch_showf
 case 'close'
  close( gcbf );
 otherwise
  warning( 'Invalid command' );
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function init_figure
fighandle = gui;
combo = findobj( fighandle, 'Tag', 'Examples' );
examples_str = dir( 'example*.m' );


if( isempty( examples_str ) )
  close( fighandle );
  disp( 'No examples available! Shutting down...' );
else
  n = length( examples_str );
  examples_cell = cell( 1, n );
  
  for i = 1:n
    examples_cell{i} = examples_str(i).name(1:end-2);
  end
  
  set( combo, 'String', sort(examples_cell) );
  set( findobj( fighandle, 'Tag', 'Objectve' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'X_coord' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'Y_coord' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'Plot' ), 'Visible', 'off' );  
  set( findobj( fighandle, 'Tag', 'choosePenalty' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'penalty' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'Optimize' ), 'Visible', 'off' );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function load_example
combo = findobj( gcbf, 'Tag', 'Examples' );
choices = get( combo, 'String' );
filename = choices{ get( combo, 'Value' ) };
try
  axes( findobj( gcbf, 'Tag', 'penAxes' ) );
  cla;
  axes( findobj( gcbf, 'Tag', 'origAxes' ) );
  gp = feval( filename );
  set( gca, 'Tag', 'origAxes' );
  set( gcbf, 'UserData', gp );
  if( ~isa( gp, 'gr_lipa_opt' ) )
    warning( 'Invalid example' );
  else    
  set( findobj( gcbf, 'Tag', 'Objectve' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'X_coord' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'Y_coord' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'Plot' ), 'Visible', 'off' );  
  set( findobj( gcbf, 'Tag', 'choosePenalty' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'penalty' ), 'Value', 1 );
  set( findobj( gcbf, 'Tag', 'penalty' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'Optimize' ), 'Visible', 'on' );
  penalty_change;
  [x y] = get_x(gp);
  set( findobj( gcbf, 'Tag', 'X_coord' ), 'String', ...
		    sprintf('X: %8.8f', x));
  set( findobj( gcbf, 'Tag', 'Y_coord' ), 'String', ...
		    sprintf('Y: %8.8f', y));
  end 
catch
  warning( 'Invalid example' );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function c = eval_penalty( p, r )
min_c = r(1);
max_c = r(2);

c = min_c * exp(p*log(max_c/min_c));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function penalty_change
gp = get( gcbf, 'UserData' );
c = eval_penalty( ...
    get( findobj( gcbf, 'Tag', 'penalty' ), 'Value' ), ...
    penalty_range( gp ) );
set( findobj( gcbf, 'Tag', 'choosePenalty' ), ...
     'String', ...
     sprintf( 'Choose a penalty parameter: %8g', c ) );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dispatch_optimize
h = findobj( gcbf, 'Tag', 'penAxes' );
axes( h );

gp = get( gcbf, 'UserData' );
gp = optimize( gp, eval_penalty( ...
    get( findobj( gcbf, 'Tag', 'penalty' ), 'Value' ), ...
    penalty_range( gp ) ) );
set( findobj( gcbf, 'Tag', 'penalty' ), 'Value', 1 )

set( gcbf, 'UserData', gp );
set( gca, 'Tag', 'penAxes' );

axes( findobj( gcbf, 'Tag', 'origAxes' ) );
cla;
draw_path( gp );

[x y] = get_x(gp);
set( findobj( gcbf, 'Tag', 'X_coord' ), 'String', ...
		  sprintf('X: %8.8f', x));
set( findobj( gcbf, 'Tag', 'Y_coord' ), 'String', ...
		  sprintf('Y: %8.8f', y));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dispatch_showf
gp = get( gcbf, 'UserData' );
h = figure;
plot_f( gp  );
rotate3d( h, 'on' );
colormap( 'gray' );
shading( 'interp' );
set( h, ...
     'HitTest', 'off', ...
     'HandleVisibility', 'callback');
  