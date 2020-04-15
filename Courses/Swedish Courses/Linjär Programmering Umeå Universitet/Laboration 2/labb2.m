clear all; close all; clc

% [A,b,c] = generate_variables(2);
% [maximum1,tableau] = mysimplex_example(A,b,c);
% tableau
% maximum1

iter = 15;
time_klees = zeros(1,iter);
time_random = zeros(1,iter);

for n = 1:iter
    tic
    [A,b,c] = generate_variables(n);
    [maximum1,tableau] = mysimplex_bestcost(A,b,c);
    tableau
%     tableau
%     maximum1
%     lb = zeros(1,n);
%     ub = [];
%     [X,Z] = linprog(c,A,b, [],[], lb, ub);

    time_klees(1,n) = toc;
    tic
    [A,b,c] = generate_randomint(n);
    [maximum2,tableau] = mysimplex_bestcost(A,b,c);
    time_random(1,n) = toc;
end

figure(1)
plot(time_klees);
xlabel('n');
ylabel('Time Klees (seconds)')

figure(2)
plot(time_random);
xlabel('n');
ylabel('Time Random (seconds)')