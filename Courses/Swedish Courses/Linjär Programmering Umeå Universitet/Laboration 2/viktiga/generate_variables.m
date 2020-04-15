function [A,b,c] = generate_variables(n)
%generate_variables
c = [];

for i = 1:n
    c(end+1) = 2^(n-i);
end

A = zeros(n,n);
b = zeros(n,1);

for j = 1:n
   for i = 1:j-1
      A(j,i) = 2 * 2^(j-i); 
   end
   b(j,1) = 5^j;
   A(j,j) = 1;
end
end

