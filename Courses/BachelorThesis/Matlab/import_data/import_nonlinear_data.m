function [X_train, y_train, X_test, y_test] = import_nonlinear_data(points, D, K, noise_rate, plot_data)

[X_train, y_train] =  generate_nonlinear_2d(points,D,K,noise_rate);
[X_test, y_test] =  generate_nonlinear_2d(points,D,K,noise_rate);


if plot_data == true
    %  visualize the data:
    figure(1)
    scatter(X_train(:, 1), X_train(:, 2), [], y_train);
    title('Training data')
    
    figure(2)
    scatter(X_test(:, 1), X_test(:, 2), [], y_test);
    title('Test data')

end
disp("Loaded data")
end

