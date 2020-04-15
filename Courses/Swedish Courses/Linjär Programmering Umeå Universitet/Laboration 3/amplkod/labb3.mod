# PART 1 - DECISION VARIABLES
var x1 >= 0;
var x2 >= 0;

# PART 2 OBJECTIVE FUNCTION
maximize z: 500*x1 + 100*x2;

# PART 3: CONSTRAINTS
s.t. M1: 2*x1 + 3*x2 <= 930;
s.t. M2: 3*x1 + 1*x2 <= 800;
s.t. M3: 1*x2 >= 100;