clear all; close all; clc

req = readtable('vitamin_mineraler.xlsx');
foods = readtable('livsmedel.xlsx');

% clean, remove unecessary data
foods(:,[2,4,9,10,11,12,13,14,15,16,17:35,37,45,56,57,60,61]) = [];
req([1,2,14,15,17,24,25,27,28], :) = [];

% make rows, columns match with foods and requirements
req(1:25,:) = req([21,22,23,24,25,1,2,3,4,6,7,5,8,9,11,10,14,20,15,13,12,18,16,19,17],:);

% A matrix remove unecessary column and make table->array
A = foods(1:end, 2:end);
A = table2array(A);

% linprog requires Ax <= b and make all NaNs to 0
A = A' .* (-1);
A(isnan(A)) = 0;

b = req(1:end, 2:end);
b = str2double(table2array(b)) .* (-1);

% linprog
f = ones(1,2111);
Aeq = [];
beq = [];
lb = zeros(1,2111);
ub = [];
[x, fval] = linprog(f,A,b,Aeq,beq,lb,ub);

% in column 1 of foods we have the food names
food_names = table2array(foods(:,1));

% find the names of the foods we should eat
food_names(find(x))