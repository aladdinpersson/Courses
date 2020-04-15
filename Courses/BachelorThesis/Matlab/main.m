%% Main file, training of network and all hyperparameters etc decided here
clear all; close all; clc;

global total_layers; % make the amount of layers global, convenient.

%%%% ---------- Add all subfolders ----------%%%%
addpath('import_data/') % Functions to import the data, simulate. Makes code cleaner.
addpath('simulatedata/') % Functions to simulate data
addpath('neuralnet/') % All necessary functions for forward, backward, etc.
addpath('optimizers/') % Adam Optimizer, GD with momentum, vanilla GD
addpath('utils/') % Nice utilization functions, like get_accuracy etc.
addpath('activations/') % Nice utilization functions, like get_accuracy etc.

%%%% ---------- Import data ----------%%%%
% Below for mnist data
% all_examples = true; number_examples = -1;
% [X, y] = import_mnist(all_examples, number_examples);
% X_train = X(1:50000, :);
% y_train = y(:, 1:50000);
% X_test = X(50000:end, :);
% y_test = y(:, 1:50000);

% Below for simulation of linear 2D
% points = 120; a = 1; b = 1; c = 0; plot_data = true; noise_rate = 0.5;
% [X_train, y_train, X_test, y_test] = import_data(points, a, b, c, plot_data, noise_rate);

% Below for simulation of non-linear 2D
points_each_class = 50; D = 2; K = 4; noise_rate = 0.1; plot_data = true;
[X_train, y_train, X_test, y_test] = import_nonlinear_data(points_each_class, D, K, noise_rate, plot_data);

% Below for ISIC-dataset
% if isfile('cancer_data.csv')
%     disp("Loading csv")
%     data = csvread('cancer_data.csv');
% else
%     save_as_csv = 1;
%     data = import_ISIC(save_as_csv);
% end

disp("Data loaded")
%%
%%%% ---------- Run Normalization  ----------%%%%
[X_train,X_test] = normalization(X_train, X_test);
y_test = y_test';
y_train = y_train';

% disp("Data loaded")

%%  ---------- NN Hyperparameters & Training of NN ----------
epochs = 100;
learning_rate = 1e-4; % (most ?) important hyperparameter
mini_batch_size = 128;
lambda = 0.0;
nodes = [2, 250, 100, 50, 4]; % Layer node setup
total_layers = length(nodes) - 1;
activation = "relu";
reg_method = "";
beta1 = 0.9; % Adam hyperparam, keep beta1 = 0.9
beta2 = 0.99; % Adam hyperparam, keep beta2 = 0.99
adam_iterations = 1;

%%%% ---------- Run weight initialization  ----------%%%%
parameters = initialize_weights(nodes);

%%%% ---------- Training  ----------%%%%
m_train = size(X_train, 1);

for epoch = 1:epochs
    indices = randperm(m_train);
    X_train = X_train(indices, :);
    y_train = y_train(1, indices);
    
    if mod(epoch, 1) == 0
        [accuracy, ~] = check_accuracy(X_train, y_train, parameters, lambda, activation);
        disp('Train Accuracy is: ' + string(accuracy))
    end
    
    for batch = 0:floor(m_train/mini_batch_size)
        start_position = 1 + batch*mini_batch_size;
        end_position = min(start_position + mini_batch_size, m_train) - 1;
        
        batch_X = X_train(start_position:end_position, :);
        batch_y = y_train(1, start_position:end_position);
        m_batch = size(batch_X, 1);
        
        [~, loss, cache] = forward_propogation(batch_X, batch_y, parameters, m_batch, lambda, activation); 
        gradients = back_propogation(cache, batch_y, parameters, size(batch_X, 1), lambda, activation);
        parameters = gradient_descent_adam(gradients, parameters, learning_rate, beta1, beta2, adam_iterations);
        adam_iterations = adam_iterations + 1;
    end
end

[accuracy, ~] = check_accuracy(X_train, y_train, parameters, lambda, activation);
disp('Train Accuracy is: ' + string(accuracy))

[accuracy, ~] = check_accuracy(X_test, y_test, parameters, lambda, activation);
disp('Test Accuracy is: ' + string(accuracy))

% save('saved_parameters/parameters.mat', 'parameters')
% load('saved_parameters/parameters.mat', 'parameters')

%% Plot Decision Boundary: Only possible for 2D data
clc;
%decision_boundary(parameters, lambda, activation, y_train, X_train)
decision_boundary(parameters, lambda, activation, y_test, X_test)

[accuracy, ~] = check_accuracy(X_train, y_train, parameters, lambda, activation);
disp('Train Accuracy is: ' + string(accuracy))

[accuracy, ~] = check_accuracy(X_test, y_test, parameters, lambda, activation);
disp('Test Accuracy is: ' + string(accuracy))