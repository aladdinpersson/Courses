function [X_train, y_train, X_test, y_test] = import_lineardata(points, a, b, c, plot_data, noise_rate)
%  Define linear model to separate data: ax + by + c = 0

[X_train, y_train] = generate_linear_2d(points, a, b, c, noise_rate);
[X_test, y_test] = generate_linear_2d(points, a, b, c, noise_rate);
% [X_validation, y_validation] = generate_data_2d(0.1*points, a, b, c, noise_rate);

if plot_data == true
    figure(1)
    indices_blue = find(y_train==1);
    indices_red = find(y_train==0);
    plot(X_train(indices_red,1), X_train(indices_red,2), 'x', 'color', 'red')
    hold on;
    plot(X_train(indices_blue,1), X_train(indices_blue,2), 'o', 'color', 'blue')
    title('Training data')

    indices_blue = find(y_test==1);
    indices_red = find(y_test==0);
    figure(2)
    plot(X_test(indices_red, 1), X_test(indices_red,2), 'x', 'color', 'red')
    hold on;
    plot(X_test(indices_blue,1), X_test(indices_blue,2), 'o', 'color', 'blue')
    title('Test data')
end
disp("Loaded data")
end

