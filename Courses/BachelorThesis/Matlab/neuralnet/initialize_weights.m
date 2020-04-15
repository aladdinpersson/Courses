function [parameters] = initialize_weights(node_vec)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

keySet = {};
valueSet = {};

for i = 1:(length(node_vec) - 1)
    l0 = node_vec(i);
    l1 = node_vec(i+1);
    
    W_i = strcat('W', num2str(i));
    b_i = strcat('b', num2str(i));
    
    keySet{end + 1} = W_i;
    valueSet{end + 1} = randn(l0,l1).*sqrt(2 ./ l0);
    
    keySet{end + 1} = b_i;
    valueSet{end + 1} = zeros(1,l1);
    
    v_dw = strcat('v_dW', num2str(i));
    v_db = strcat('v_db', num2str(i));
    
    keySet{end + 1} = v_dw;
    valueSet{end + 1} = zeros(l0,l1);
    
    keySet{end+1} = v_db;
    valueSet{end + 1} = zeros(1,l1);
    
    s_dw = strcat('s_dW', num2str(i));
    s_db = strcat('s_db', num2str(i));
    
    keySet{end + 1} = s_dw;
    valueSet{end + 1} = zeros(l0,l1);
    
    keySet{end+1} = s_db;
    valueSet{end + 1} = zeros(1,l1);
end
disp("Weight Initialization complete")
parameters = containers.Map(keySet,valueSet);