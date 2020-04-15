function [parameters] = gradient_descent_vanilla(gradients, parameters, learning_rate)
global total_layers;

for l = 1:total_layers
    W_l = parameters(strcat('W',num2str(l)));
    b_l = parameters(strcat('b',num2str(l)));
    
    dW_l = gradients(strcat('dW',num2str(l)));
    db_l = gradients(strcat('db',num2str(l)));
    
    W_l = W_l - learning_rate .* dW_l;
    b_l = b_l - learning_rate .* db_l;
    
    parameters(strcat('W', num2str(l))) = W_l;
    parameters(strcat('b', num2str(l))) = b_l;   
end
end

