% Purpose of this script is to evaluate polynomials p0,p1,q0,q1 and their 
% derivatives at specific values of t which are used in Hermite's 
% piece-wise approximation

% PROGRAMMED by Aladdin Persson (alhi0008@student.umu.se)
%   Initial programming 2018-12-08

clear all; close all; clc;
syms t

% Initialize polynomials p0(t),p1(t),q0(t),q1(t)
p0 = @(t)(1+2*t)*((1-t).^2);
p1 = @(t)(t.^2)*(3-2*t);
q0 = @(t) t.*((1-t).^2);
q1 = @(t)t.^2 .* (t - 1);

% Use MatLab built in differentiate function (diff) and evaluate derivative
% at val.
p0_prime = @(val) eval(subs(diff(p0,t),t,val));
p0_prime = @(val) eval(subs(diff(p0,t),t,val));

p1_prime = @(val) eval(subs(diff(p0,t),t,val));
p1_prime = @(val) eval(subs(diff(p0,t),t,val));

q0_prime = @(val) eval(subs(diff(p0,t),t,val));
q0_prime = @(val) eval(subs(diff(p0,t),t,val));

q1_prime = @(val) eval(subs(diff(p0,t),t,val));
q1_prime = @(val) eval(subs(diff(p0,t),t,val));

% Example p0(0), p0'(0), similarly to others.
p0(0)
p0_prime(0)