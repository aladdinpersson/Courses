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
 case 'go'
  dispatch_go;
 case 'click'
  dispatch_click;
 case 'kktYes'
  dispatch_kkt1( 'yep' );
  case 'kktNo'
  dispatch_kkt1( 'no' );
 case 'kkt2Yes'
  dispatch_kkt2( 'yep' );
 case 'kkt2No'
  dispatch_kkt2( 'no' );
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
  set( findobj( fighandle, 'Tag', 'X_coord_static' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'Y_coord_static' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'X_coord' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'Y_coord' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'go' ), 'Visible', 'off' );  
  set( findobj( fighandle, 'Tag', 'isKKT' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'kktYes' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'kktNo' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'kktYes' ), 'Enable', 'on' );
  set( findobj( fighandle, 'Tag', 'kktNo' ), 'Enable', 'on' );   
  set( findobj( fighandle, 'Tag', 'lagrange' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'multipliers' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'kktYes2' ), 'Enable', 'on' );
  set( findobj( fighandle, 'Tag', 'kktNo2' ), 'Enable', 'on' );
  set( findobj( fighandle, 'Tag', 'isKKT2' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'kktYes2' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'kktNo2' ), 'Visible', 'off' );
  set( findobj( fighandle, 'Tag', 'answer' ), 'Visible', 'off' );  
  set( findobj( fighandle, 'Tag', 'Plot' ), 'Visible', 'off' );  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function load_example
combo = findobj( gcbf, 'Tag', 'Examples' );
choices = get( combo, 'String' );
filename = choices{ get( combo, 'Value' ) };
try
  gp = feval( filename );
  if( ~isa( gp, 'gr_plane_opt' ) )
    warning( 'Invalid example' );
  else
    set( findobj( gcbf, 'Tag', 'Objectve' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'X_coord_static' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'Y_coord_static' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'X_coord' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'Y_coord' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'go' ), 'Visible', 'on' );  
    set( findobj( gcbf, 'Tag', 'isKKT' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'kktYes' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'kktNo' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'kktYes' ), 'Enable', 'on' );
    set( findobj( gcbf, 'Tag', 'kktNo' ), 'Enable', 'on' );     
    set( findobj( gcbf, 'Tag', 'lagrange' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'multipliers' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'isKKT2' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'kktYes2' ), 'Enable', 'on' );
    set( findobj( gcbf, 'Tag', 'kktNo2' ), 'Enable', 'on' );
    set( findobj( gcbf, 'Tag', 'kktYes2' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'kktNo2' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'answer' ), 'Visible', 'off' );  
    set( gca, 'UserData', gp );
    set( gca, 'ButtonDownFcn', 'dispatch(''click'');' );
    set( findobj( gcbf, 'Tag', 'Plot' ), 'Visible', 'off' );    %on
  end 
catch
  warning( 'Invalid example' );
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dispatch_click
pos = get( gca, 'CurrentPoint' );
dispatch_click_main( pos(1,1), pos(1,2) );
return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dispatch_go
Xstr = get( findobj( gcbf, 'Tag', 'X_coord' ), 'String' );
Ystr = get( findobj( gcbf, 'Tag', 'Y_coord' ), 'String' );
X = str2double(Xstr);
Y = str2double(Ystr);
dispatch_click_main( X, Y );
return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dispatch_click_main(x,y)
gp = get( gca, 'UserData' );
if( isa( gp, 'gr_plane_opt' ) )
  gp = set_pos( gp, x, y );

  gp = handle_click( gp );
  if( get_fea( gp ) )
    set( findobj( gcbf, 'Tag', 'Objectve' ), 'String', ...
		      sprintf( 'Objective value: %f', get_obj( gp ) ...
			       ), 'ForegroundColor', 'k' );
  else
    set( findobj( gcbf, 'Tag', 'Objectve' ), 'String', ...
		     'Infeasible point!', 'ForegroundColor', 'r' );    
  end
  [X,Y] = get_pos(gp);
  set( findobj( gcbf, 'Tag', 'X_coord' ), 'String', ...
		    sprintf( '%g', X));
  set( findobj( gcbf, 'Tag', 'Y_coord' ), 'String', ...
		    sprintf( '%g', Y));
  
  set( findobj( gcbf, 'Tag', 'Objectve' ), 'Visible', 'on' );   
  set( findobj( gcbf, 'Tag', 'X_coord_static' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'Y_coord_static' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'X_coord' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'Y_coord' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'go' ), 'Visible', 'on' );  
  set( findobj( gcbf, 'Tag', 'isKKT' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'kktYes' ), 'Enable', 'on' );
  set( findobj( gcbf, 'Tag', 'kktNo' ), 'Enable', 'on' ); 
  set( findobj( gcbf, 'Tag', 'kktYes' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'kktNo' ), 'Visible', 'on' );  
  set( findobj( gcbf, 'Tag', 'lagrange' ), 'Visible', 'off' );
  set( findobj( gcbf, 'Tag', 'multipliers' ), 'Visible', 'off' );
  set( findobj( gcbf, 'Tag', 'isKKT2' ), 'Visible', 'off' );
  set( findobj( gcbf, 'Tag', 'kktYes2' ), 'Enable', 'on' );
  set( findobj( gcbf, 'Tag', 'kktNo2' ), 'Enable', 'on' );
  set( findobj( gcbf, 'Tag', 'kktYes2' ), 'Visible', 'off' );
  set( findobj( gcbf, 'Tag', 'kktNo2' ), 'Visible', 'off' );
  set( findobj( gcbf, 'Tag', 'answer' ), 'Visible', 'off' );  
  set( findobj( gcbf, 'Tag', 'Plot' ), 'Visible', 'off' );   %on
  set( gca, 'UserData', gp );
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dispatch_kkt1( guess )
gp = get( gca, 'UserData' );
if( isa( gp, 'gr_plane_opt' ) )
  if( get_fea( gp ) )
    [l, gp] = lagrange( gp );
    if( any(isnan(l)) )
      s = 'No solution';
    else
      s = sprintf( '%f  ', l );
    end    
    set( findobj( gcbf, 'Tag', 'Objectve' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'X_coord_static' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'Y_coord_static' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'X_coord' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'Y_coord' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'go' ), 'Visible', 'on' );  
    set( findobj( gcbf, 'Tag', 'isKKT' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'kktYes' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'kktNo' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'kktYes' ), 'Enable', 'off' );
    set( findobj( gcbf, 'Tag', 'kktNo' ), 'Enable', 'off' );  
    set( findobj( gcbf, 'Tag', 'lagrange' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'multipliers' ), 'String', s );
    set( findobj( gcbf, 'Tag', 'multipliers' ), 'Visible', 'on' );  
    set( findobj( gcbf, 'Tag', 'kktYes2' ), 'Enable', 'on' );
    set( findobj( gcbf, 'Tag', 'kktNo2' ), 'Enable', 'on' );
    set( findobj( gcbf, 'Tag', 'isKKT2' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'kktYes2' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'kktNo2' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'answer' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'Plot' ), 'Visible', 'off' ); %on   
else
    if( strcmp( guess, 'yep' ) )
      s = 'Incorrect: the point is infeasible';
    else
      s = 'Correct: the point is infeasible';
    end;
    
    set( findobj( gcbf, 'Tag', 'Objectve' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'X_coord_static' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'Y_coord_static' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'X_coord' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'Y_coord' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'go' ), 'Visible', 'on' );  
    set( findobj( gcbf, 'Tag', 'isKKT' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'kktYes' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'kktNo' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'kktYes' ), 'Enable', 'off' );
    set( findobj( gcbf, 'Tag', 'kktNo' ), 'Enable', 'off' );  
    set( findobj( gcbf, 'Tag', 'lagrange' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'multipliers' ), 'Visible', 'off' );  
    set( findobj( gcbf, 'Tag', 'kktYes2' ), 'Enable', 'on' );
    set( findobj( gcbf, 'Tag', 'kktNo2' ), 'Enable', 'on' );
    set( findobj( gcbf, 'Tag', 'isKKT2' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'kktYes2' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'kktNo2' ), 'Visible', 'off' );
    set( findobj( gcbf, 'Tag', 'answer' ), 'String', s );
    set( findobj( gcbf, 'Tag', 'answer' ), 'Visible', 'on' );
    set( findobj( gcbf, 'Tag', 'Plot' ), 'Visible', 'off' ); %on    
  end
  
  set( gca, 'UserData', gp );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dispatch_kkt2( guess )
gp = get( gca, 'UserData' );
if( isa( gp, 'gr_plane_opt' ) )
  l = get_lagrange( gp );
  bad_lagrange = any(isnan(l)) | any(l<0) | any(isinf(l));
  if( ( bad_lagrange & strcmp(guess, 'no') ) | ...
	( ~bad_lagrange & strcmp( guess, 'yep' ) ))
    s = 'Correct';
  else
    s = 'Incorrect';
  end
  
  set( findobj( gcbf, 'Tag', 'Objectve' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'X_coord_static' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'Y_coord_static' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'X_coord' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'Y_coord' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'go' ), 'Visible', 'on' );  
  set( findobj( gcbf, 'Tag', 'isKKT' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'kktYes' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'kktNo' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'kktYes' ), 'Enable', 'off' );
  set( findobj( gcbf, 'Tag', 'kktNo' ), 'Enable', 'off' );  
  set( findobj( gcbf, 'Tag', 'lagrange' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'multipliers' ), 'Visible', 'on' );  
  set( findobj( gcbf, 'Tag', 'isKKT2' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'kktYes2' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'kktNo2' ), 'Visible', 'on' );
  set( findobj( gcbf, 'Tag', 'kktYes2' ), 'Enable', 'off' );
  set( findobj( gcbf, 'Tag', 'kktNo2' ), 'Enable', 'off' );
  set( findobj( gcbf, 'Tag', 'answer' ), 'String', s );
  set( findobj( gcbf, 'Tag', 'answer' ), 'Visible', 'on' );  
  set( findobj( gcbf, 'Tag', 'Plot' ), 'Visible', 'off' ); %on    
  set( gca, 'UserData', gp );
end

function dispatch_showf
gp = get( gca, 'UserData' );
h = figure;
plot_f( gp  );
rotate3d( h, 'on' );
colormap( 'gray' );
shading( 'interp' );
set( h, ...
     'HitTest', 'off', ...
     'HandleVisibility', 'callback');
  