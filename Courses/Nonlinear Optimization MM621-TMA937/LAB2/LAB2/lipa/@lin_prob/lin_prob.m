function p = lin_prob( varargin )
% LIN_PROB Optimization problem class constructor
% p = lin_prob(c, A, b) 

switch nargin
 case 0
  p.nvar = 0;
  p.ncon = 0;
  p.c = [];
  p.A = [];
  p.b = [];
  p = class(p, 'lin_prob');
 
 case 1
  if( isa( varargin{1}, 'lin_prob' ) )
    p = varargin{1};
  else
    error( 'Wrong argument type' );
  end
 
 case 3
  nvar = size( varargin{1}, 1 );
  ncon = size( varargin{3}, 1 );
  
  if( size( varargin{1} ) ~= [nvar,1] | ...
      size( varargin{2} ) ~= [ncon,nvar] | ...
      size( varargin{3} ) ~= [ncon,1] )
    error( 'Incompatible sizes of the arguments.' );
  end
  
  p.nvar = nvar;
  p.ncon = ncon;
  p.c = varargin{1};
  p.A = varargin{2};
  p.b = varargin{3};
  p = class(p, 'lin_prob');
 
 otherwise
  error( 'Wrong number of arguments' );
end
