%% Problem 1

%% 1,a)

% Q: How is the correct value of the unit roundoff identified?

% A: The correct value of the unit round-off is identified by looking at
% what the input vector has been specified to. If the input vector is 
% single then u = 2^(-24) and if double then u = 2^(-53). This is a little
% bit different to my_simple_sum as the input vector is forced into either
% single or double.

%% 1,b)

% Q : What is the effect of the reshape command?

% A : The effect of the reshape command is essentially to reconstruct the original matrix, 
% and force it to become into a row vector (1xm), where m is total amount of elements
% to make it easier to index when summing in for-loop.

%% 1,c)

% Q : How is user stupidity handled?

% A : It is checked to see if the user inputs a vector which has zero elements
% and if it is so then the function call is returned prematurely.

%% 3,6)

% Q : 6. Which technique gives the best error bounds?
% A : The technique that gives the best error is the running error bound with double precision.


%% 3,7)

% Q : Why is it reasonable that the running er ror bounds are smaller than the a priori error
% bounds? Hint: Which technique draws on the largest body of relevant information?

% A : The running error bound is calculated throughout the for-loop and
% calculates it for each step. Whereas the priori error bound can just be
% calculated beforehand ....  not sure about this one.

%% Problem 2

%% 5,a)

% Sequence   Precision   True sum                Error                  REB
%   a        single       1.08232319355011e+00   4.01610265043928e-08   1.29022976125270e-06
%   a        double       1.08232323371114e+00   0.00000000000000e+00   2.40324034830572e-15
%   b        single      -6.93146765232086e-01   6.15090698374843e-08   8.26295547540212e-07
%   b        double      -6.93146703723014e-01   0.00000000000000e+00   1.53909485983264e-15


% Sequence   Precision   True sum                Error                  REB
%   a        single       1.08232212066650e+00   1.11304461825057e-06   6.66384366923012e-05
%   a        double       1.08232323371114e+00  -1.77635683940025e-15   1.24123210639647e-13
%   b        single      -6.93145155906677e-01  -1.54781628225464e-06   4.28946259489749e-05
%   b        double      -6.93146703723016e-01   1.99840144432528e-15   7.98976101292830e-14


%% 5,b)


% Elapsed time is 26.088727 seconds
% Elapsed time is 0.420474 seconds.

% Error is greatly decreased but running time greatly increased.