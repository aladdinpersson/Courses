function gp = example02
%objective function

c = [1; 3];
A =  [[   -1,-1/10];
      [ -1/2, -1/9];
      [ -1/3, -1/8];
      [ -1/4, -1/7];
      [ -1/5, -1/6];
      [ -1/6, -1/5];
      [ -1/7, -1/4];
      [ -1/8, -1/3];
      [ -1/9, -1/2];
      [-1/10,   -1];
      [    0,   -1];
      [    1,    0]];

b = [-1; -1; -1; -1; -1; -1; -1; -1; -1; -1; 0; 20];

%domain
x1 = 0:0.25:20;
x2 = 0:0.25:20;

%starting point
x1_start = 2;
x2_start = 10;

%construct the optimization problem
gp = gr_lipa_opt( x1, x2, ...
		  lin_prob( c, A, b ), ...
		  x1_start, x2_start );
