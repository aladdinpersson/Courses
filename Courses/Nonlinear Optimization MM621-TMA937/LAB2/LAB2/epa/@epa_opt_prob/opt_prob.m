function p = epa_opt_prob( varargin )
% OPT_PROB Optimization problem class constructor
% p = opt_prob(obj_func, obj_grad, con_func, con_grad, tol) 

switch nargin
 case 0
  p.m = 0;
  p.obj_func = 'NaN';
  p.obj_grad = 'NaN';
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
  
  p.obj_func = varargin{1};
  p.obj_grad = varargin{2};
  p.con_func = varargin{3};
  p.con_grad = varargin{4};
  p.tol = varargin{5};
  p = class(p, 'opt_prob');
 
 otherwise
  error( 'Wrong number of arguments' );
end

  