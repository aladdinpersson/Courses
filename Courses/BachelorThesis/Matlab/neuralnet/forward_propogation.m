function [probs, loss, cache] = forward_propogation(h0, t, parameters, m, ...
                                                    lambda, activation)
%forward propogation

global total_layers;
h_l = h0;
cache_keys = {'h0'};
cache_values = {h0};
regularization = 0;

for l = 1:total_layers
    W_l = parameters(strcat('W',num2str(l)));    
    b_l = parameters(strcat('b',num2str(l)));
    
    regularization = regularization + sum(W_l .* W_l, 'all');
    z_l = h_l*W_l + b_l;
    
    if activation == 'relu'
        h_l = relu(z_l);
    elseif activation == 'sigmoid'
        h_l = sigmoid(z_l);
    end
    
    cache_keys{end+1} = strcat('h', num2str(l));
    cache_values{end+1} = h_l;
end

probs = exp(z_l) ./ (sum(exp(z_l), 2));
cache_keys{end+1} = 'probs';
cache_values{end+1} = probs;

indices = sub2ind(size(probs), 1:m, t+1);
noreg_loss = sum(-log(probs(indices)), 2) ./ m;
reg_loss = 0.5 .* lambda .* regularization;
loss = noreg_loss + reg_loss;

% loss= noreg_loss;
% data for balancing principle L2 regularization
psi = regularization;
cache_keys{end+1} = 'psi';
cache_values{end+1} = psi;
cache_keys{end+1} = 'noreg_loss';
cache_values{end+1} = noreg_loss;

cache = containers.Map(cache_keys, cache_values);
end

