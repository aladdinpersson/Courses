# PART 1 - DECISION VARIABLES
var x1 >= 0;
var x2 >= 0;
var x3 >= 0;
var x4 >= 0;

# PART 2 OBJECTIVE FUNCTION
minimize z: 330*x1+340*x2+285*x3+295*x4;

# PART 3: CONSTRAINTS
s.t. M1: 1*x1 + 1*x2 <= 200;
s.t. M2: 1*x3 + 1*x4 <= 100;
s.t. M3: 4*x1+2*x2+3*x3+2*x4 >= 1001;
s.t. M4: 4*x1+6*x2+3*x3+4*x4 >= 1100;