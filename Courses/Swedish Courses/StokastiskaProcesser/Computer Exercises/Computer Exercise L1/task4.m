%% E[U]
clear all; close all; clc
N = 1e6;
U = rand(1,N);

mean(U)

%% V[U]
clear all; close all; clc
N = 1e6;
U = rand(1,N);

var(U)

%% cov(U, sqrt(1-U^2))
clear all; close all; clc
N = 1e3;
U= rand(1,N);
A=U;
B=sqrt(1-U.^2);
cov(A,B)

%% corr(U, 1-U)
clear all; close all; clc
N = 1e6;
U = rand(1,N)';
A = U;
B = 1-U;
K = corr(A,B);
K