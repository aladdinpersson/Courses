%Function for using Inverse Transform Method.
%Input: A vector with given state probabilities.
%Output: Simulated index.
function x=InverseTransform(p)
F=cumsum(p);
u=rand;
x=find(u<F,1,'first');
end
