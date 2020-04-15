function [parameters] = gradient_descent_momentum(gradients, parameters, learning_rate, beta)
global total_layers

for l = 1:total_layers
    W_l = parameters(strcat('W',num2str(l)));
    b_l = parameters(strcat('b',num2str(l)));
    
    dW_l = gradients(strcat('dW',num2str(l)));
    db_l = gradients(strcat('db',num2str(l)));
    
    v_dwl = parameters(strcat('v_dW', num2str(l)));
    v_dbl = parameters(strcat('v_db', num2str(l)));
    
    v_dwl = beta.*v_dwl + (1-beta).*dW_l;
    v_dbl = beta.*v_dbl + (1-beta).*db_l;
    
    W_l = W_l - learning_rate .* v_dwl;
    b_l = b_l - learning_rate .* v_dbl;
    
    parameters(strcat('v_dW', num2str(l))) = v_dwl;
    parameters(strcat('v_db', num2str(l))) = v_dbl;
    parameters(strcat('W', num2str(l))) = W_l;
    parameters(strcat('b', num2str(l))) = b_l;   
end
end