function [] = decision_boundary(parameters, lambda, activation, y, X)
min_x1 = floor(min(X(:,1)));
max_x1 = ceil(max(X(:,1)));
min_x2 = floor(min(X(:,2)));
max_x2 = max(X(:,2)) + 0.2;

[xx,yy]= meshgrid(min_x1:0.005:max_x1, min_x2:0.005:max_x2);
points = [xx(:), yy(:)];

gen_y = zeros(1, length(points));
[~, predictions] = check_accuracy(points, gen_y, parameters, lambda, activation);
predictions = reshape(predictions, size(xx));

figure(5)
contourf(xx, yy, predictions)

purple = [1 0.3 1];
blue = [0.3 0.3 1];
red = [1 0.3 0.3];
yellow = [1 1 0.2];

map = [purple; blue; red; yellow] * 0.7;
%map = [0.7 0.3 0.3; 0.3 0.3 0.7];
colormap(map)

indices_purple = find(y==0);
indices_blue = find(y==1);
indices_red = find(y==2);
indices_yellow = find(y==3);
hold on;
color_reduction = 0.95;
plot(X(indices_purple,1), X(indices_purple, 2), 'x', 'color', purple*color_reduction)
plot(X(indices_blue,1), X(indices_blue, 2), 'o', 'color', blue*color_reduction)
plot(X(indices_red,1), X(indices_red, 2), '.', 'color', red*color_reduction)
plot(X(indices_yellow,1), X(indices_yellow, 2), '+', 'color', yellow*color_reduction)

% hold on;

 %indices_blue = find(y==1);
 %indices_red = find(y==0);
 
 %plot(X(indices_red,1), X(indices_red,2), 'x', 'color', 'red')
 %plot(X(indices_blue,1), X(indices_blue,2), 'o', 'color', 'blue')
end

