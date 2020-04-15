function [gradients] = back_propogation(cache, t, parameters, m, lambda, ...
                                        activation)
%backward propogation
gradient_keys = {};
gradient_values = {};
global total_layers;
L = double(parameters.Count) / 4; % number of layers
probs = cache('probs');
dz_l = probs;
indices = sub2ind(size(dz_l), 1:m, t+1);
dz_l(indices) = (dz_l(indices) - 1);
dz_l = dz_l ./ m;

% Ignore this: dz_l = -(t-y) .* y .* (1- y);

for l = total_layers:-1:2
    h_prev = cache(strcat('h',num2str(l-1)));
    W_l = parameters(strcat('W',num2str(l)));
    
    dW_l = h_prev' * dz_l + lambda * W_l;
    db_l = sum(dz_l,1);
    
    dh_prev = dz_l * W_l';
    
    if activation == 'relu'
        dz_l = dh_prev .* (h_prev > 0);
    elseif activation == 'sigmoid'
        dz_l = dh_prev .* h_prev .* (1- h_prev); 
    end
    
    gradient_keys{end+1} = strcat('dW', num2str(l));
    gradient_values{end+1} = dW_l;
    
    gradient_keys{end+1} = strcat('db', num2str(l));
    gradient_values{end+1} = db_l;
end

h0 = cache('h0');
dW_1 = h0' * dz_l;
db_1 = sum(dz_l,1);

gradient_keys{end+1} = 'dW1';
gradient_values{end+1} = dW_1;

gradient_keys{end+1} = 'db1';
gradient_values{end+1} = db_1;

gradients = containers.Map(gradient_keys, gradient_values);
end