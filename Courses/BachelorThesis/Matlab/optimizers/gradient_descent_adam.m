function [parameters] = gradient_descent_adam(gradients, parameters, learning_rate, beta1, beta2, t)
epsilon = 1e-8; % in case of numerical errors
global total_layers;

for l = 1:total_layers
    W_l = parameters(strcat('W',num2str(l)));
    b_l = parameters(strcat('b',num2str(l)));
    
    dW_l = gradients(strcat('dW',num2str(l)));
    db_l = gradients(strcat('db',num2str(l)));
    
    v_dwl = parameters(strcat('v_dW', num2str(l)));
    v_dbl = parameters(strcat('v_db', num2str(l)));
    
    s_dwl = parameters(strcat('s_dW', num2str(l)));
    s_dbl = parameters(strcat('s_db', num2str(l)));
    
    % below is momentum equations
    v_dwl = beta1.*v_dwl + (1-beta1).*dW_l;
    v_dbl = beta1.*v_dbl + (1-beta1).*db_l;
    
    % below is RMSprop equations
    s_dwl = beta2.*s_dwl + (1-beta2).*dW_l.^2;
    s_dbl = beta2.*s_dbl + (1-beta2).*db_l.^2;
    
    % used for debugging
%     disp('Norm vdwl: ' + string(norm(v_dwl)))
%     disp('Norm vdbl: ' + string(norm(v_dbl)))
%     disp('Norm sdwl: ' + string(norm(s_dwl)))
%     disp('Norm sdbl: ' + string(norm(s_dbl)))
   
    % Adam calculations
    v_dwl_corrected = v_dwl ./ (1 - (beta1.^t));
    v_dbl_corrected = v_dbl ./ (1 - (beta1.^t));
    
    s_dwl_corrected = s_dwl ./ (1- (beta2.^t));
    s_dbl_corrected = s_dbl ./ (1- (beta2.^t));
    
    W_l = W_l - learning_rate .* (v_dwl_corrected ./ (sqrt(s_dwl_corrected) + epsilon));
    b_l = b_l - learning_rate .* (v_dbl_corrected ./ (sqrt(s_dbl_corrected) + epsilon));
    
    parameters(strcat('v_dW', num2str(l))) = v_dwl;
    parameters(strcat('v_db', num2str(l))) = v_dbl;
    parameters(strcat('s_dW', num2str(l))) = s_dwl;
    parameters(strcat('s_db', num2str(l))) = s_dbl;
    parameters(strcat('W', num2str(l))) = W_l;
    parameters(strcat('b', num2str(l))) = b_l;   
end
end