function p = opt_prob( varargin )
% OPT_PROB Optimization problem class constructor
% p = opt_prob(obj_func, obj_grad, con_func, con_grad, tol) 

switch nargin
 case 0
  p.m = 0;
  p.obj_func = inline( 'NaN' );
  p.obj_grad = inline( 'NaN' );
  p.con_func = {};
  p.con_grad = {};
  p.tol = 0;
  p = class(p, 'opt_prob');
 
 case 1
  if( isa( varargin{1}, 'opt_prob' ) )
    p = varargin{1};
  else
    error( 'Wrong argument type' );
  end
 
 case 5
  if( length( varargin{3} ) ~= length( varargin{4} ) )
    error( 'Invalid number of constraints' );
  else    
    p.m = length( varargin{3} );  
  end
  
  p.obj_func = inline( varargin{1}, 'x' );
  p.obj_grad = inline( varargin{2}, 'x' );
  p.con_func = cell( size( varargin{3} ) );
  p.com_grad = cell( size( varargin{4} ) );
  for i = 1:length( varargin{3} )    
    p.con_func{i} = inline( varargin{3}{i}, 'x' );
    p.con_grad{i} = inline( varargin{4}{i}, 'x' );
  end
  p.tol = varargin{5};
  p = class(p, 'opt_prob');
 
 otherwise
  error( 'Wrong number of arguments' );
end

  