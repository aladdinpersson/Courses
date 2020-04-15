clear all; close all; clc

% Repeat means how many times to re-run the same to get a mean value
% of the amount of iterations and time. To get a cleaner plot.

% Iter means to how large value of n we wish to count to.

% Simplexmethod to choose: 'normal_simplex', 'blands_simplex',
% 'bestcost_simplex'

repeat = 10;
iter = 18;

simplex_method = 'bestcost_simplex';
time_klees = zeros(repeat,iter);
time_random = zeros(repeat,iter);
tot_iter_klees = zeros(repeat,iter);
tot_iter_random = zeros(repeat,iter);

for i = 1:repeat
    for n = 1:iter
        tic % start time 
        [A,b,c] = generate_variables(n);
      
        if strcmp(simplex_method, 'normal_simplex')
            [maximum1, tableau, tot_iter] = mysimplex_example(A,b,c);
        elseif strcmp(simplex_method, 'blands_simplex')
            [maximum1, tableau, tot_iter] = mysimplex_blands(A,b,c);
        elseif strcmp(simplex_method, 'bestcost_simplex')
            [maximum1, tableau, tot_iter] = mysimplex_bestcost(A,b,c);
        else
            error('Simplex method not specified')
        end
        
        time_klees(i,n) = toc; % end time
        tot_iter_klees(i,n) = tot_iter; 
        
        tic
        [A,b,c] = generate_randomvariables(n);
           
%         if strcmp(simplex_method, 'normal_simplex')
%             [maximum1, tableau, tot_iter] = mysimplex_example(A,b,c);
%         elseif strcmp(simplex_method, 'blands_simplex')
%             [maximum1, tableau, tot_iter] = mysimplex_blands(A,b,c);
%         elseif strcmp(simplex_method, 'bestcost_simplex')
%             [maximum1, tableau, tot_iter] = mysimplex_bestcost(A,b,c);
%         else
%             error('Simplex method not specified.')
%         end
        
        
        time_random(1,n) = toc;
        tot_iter_random(i,n) = tot_iter;
    end
end

figure(1)
plot(mean(time_klees,1));
xlabel('n');
ylabel('Time Klees (seconds)');

figure(2)
plot(mean(time_random,1));
xlabel('n');
ylabel('Time Random (seconds)')

figure(3)
plot(mean(tot_iter_klees,1));
xlabel('n');
ylabel('Total iterations (klee-minty constants)');

figure(4)
plot(mean(time_random,1));
xlabel('n');
ylabel('Total iterations (random constants)')

v = [2,4,6,8,10,12,14,16,18];
v1 = mean(tot_iter_klees,1);
v1(v)


v = [2,4,6,8,10,12,14,16,18];
v1 = mean(tot_iter_random,1);
v1(v)