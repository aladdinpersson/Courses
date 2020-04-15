%% Triangle
clear all; close all; clc;

% Initialize transition matrix
P = [0, 1/2, 1/2;
    1/2, 0, 1/2;
    1/2, 1/2, 0];


% Initial state
p0 = [0,0,1];

p = p0 * P^10000

%% Square
clear all; close all; clc

% Initialize transition matrix
P = [0,1/2,1/2,0;1/2,0,0,1/2;1/2,0,0,1/2;0,1/2,1/2,0];

% Initial state
p0 = [1,0,0,0];

p = p0 * P^10001