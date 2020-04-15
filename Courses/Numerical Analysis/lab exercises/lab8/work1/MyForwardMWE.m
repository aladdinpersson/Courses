clear all; close all; clc;

L=[1,0,0;2,1,0;3,4,1];
F=[1,2;3,4;5,6];

X=inv(L)*F;
X2=myforwardupdate(L,F);

rel_err=X-X2./(X);
rel_residual= (F-(L*X))./(F);