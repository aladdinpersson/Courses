function [dtheta_approx, dtheta] = gradient_checking(parameters, gradients, X_train, y_train, m_train, lambda, activation)
% This function is ugly coded: it was done quickly to check
% if the backpropagation was implemented correctly. Only used once.
% Should probably remove this function, but kept just incase.

h=1e-7;
global total_layers

for param_string=parameters.keys()
    param_string=string(param_string);
    dtheta_approx = [];
    dparam = gradients('d'+param_string);
    [r,c] = size(dparam);
    dtheta = reshape(dparam, [1,r*c]);
    for i = 1:r*c
        param = parameters(param_string);
        original_param = param;
        [r,c]=size(param);
        theta = reshape(param, [r*c,1]);
        int_var = theta;
        theta(i) = theta(i) + h;
        param = reshape(theta, [r,c]);
        parameters(param_string) = param;

        [~, loss1, ~] = forward_propogation(X_train, y_train, parameters, m_train, lambda, activation);

        int_var(i) = int_var(i) - h;
        param = reshape(int_var, [r,c]);
        parameters(param_string) = param;
        [~, loss2, ~] = forward_propogation(X_train, y_train, parameters, m_train, lambda, activation);

        dtheta_approx_i = (loss1-loss2)./(2*h);
        dtheta_approx(end+1)=dtheta_approx_i;
        parameters(param_string) = original_param;
    end
    value_gradcheck = norm(dtheta_approx - dtheta, 2)./(norm(dtheta_approx)+norm(dtheta));
    disp("Gradient check: " + string(value_gradcheck))
end

disp("done")
% norm(dtheta_approx(1:10) - dtheta(1:10))
norm(dtheta_approx - dtheta, 2);
% dtheta_approx(1:10)
end

