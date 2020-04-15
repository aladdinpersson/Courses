function df = func1g(x)
R = x(1).^2 + x(2).^2;
R1 = ((x(1)-5).^2 + (x(2)+4).^2)/2;
R2 = ((x(1)+4).^2 + (x(2)-5).^2)/3;

r1x1= x(1)-5;
r1x2= x(2)+4;
r2x1= x(1)+4;
r2x2= x(2)-5;

ex1 = exp(-R/10);
ex2 = exp(-R/100);
ex3 = exp(-R1/10);
ex4 = exp(-R2/10);
ex5 = exp(-R2/100);

fact1=2/25;
fact2=1/2;
fact3=1/3;
fact4=4/150;

df1= x(1).*ex1-fact1*x(1).*ex2+fact2*r1x1.*ex3+fact3*r2x1.*ex4+fact4*r2x1.*ex5;
df2= x(2).*ex1-fact1*x(2).*ex2+fact2*r1x2.*ex3+fact3*r2x2.*ex4+fact4*r2x2.*ex5;
df = [df1; df2];
