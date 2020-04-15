clear all; close all; clc;

U=[2,3,4;0,5,6;0,0,9]
F=[1,2;3,4;5,6];

X=inv(U)*F
X=MyBackward(U,F)


% rel_err=X-X2./(X);
% rel_residual= (F-(L*X))./(F);