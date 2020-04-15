function [A,b,c] = generate_randomint(n)
%generate_variables
lowerb = 1;
upperb = 500;
c = [];

for i = 1:n
    c(end+1) = randi([lowerb, upperb]);
end

A = zeros(n,n);
b = zeros(n,1);

for j = 1:n
   for i = 1:j-1
      A(j,i) = randi([lowerb,upperb]); 
   end
   b(j,1) = randi([lowerb,upperb]);
   A(j,j) = randi([lowerb,upperb]);
end
end

