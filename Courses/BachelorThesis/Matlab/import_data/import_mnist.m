function [X_train, y_train] = mnist_data(all_examples, number_examples)

% load data mnist
if all_examples == true 
    data = csvread('mnist_train.csv');
    X_train = data(1:end, 2:end);
    y_train = data(1:end, 1)';
    disp("Loaded data")

else
    data = csvread('mnist_train.csv');
    X_train = data(1:number_examples, 2:end);
    y_train = data(1:number_examples, 1)';
    disp("Loaded data")
end
end
