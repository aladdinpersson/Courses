clear all; close all; clc
%format long;
g = @(u) exp(16.*u.^2 - 12.*u + 2) .* 4;

n = 30:5:300;
N = [n, 300, 500, 1000, 2000];
estimated_values = zeros(1,length(N));
std_est_values = zeros(1,length(N));

for n = 1:length(N)
    U = rand(1,N(n));
    estimated_values(1,n) = mean(g(U));
    std_est_values(1,n) = std(g(U) / sqrt(N(n)));
end

lower_bound = estimated_values - 1.96 .* std_est_values;
upper_bound = estimated_values + 1.96 .* std_est_values;


plot(N, estimated_values)
hold on;
plot(N, lower_bound)
plot(N,upper_bound)
legend('estimated', 'lower bound', 'upper bound', 'Location', 'northoutside')
xlabel('number of iid uniform points from (0,1)')
ylabel('estimated value')