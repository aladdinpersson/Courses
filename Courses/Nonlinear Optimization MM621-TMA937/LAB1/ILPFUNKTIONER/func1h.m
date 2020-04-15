function dh = func1h(x)
R = x(1).^2 + x(2).^2;
R1 = ((x(1)-5).^2 + (x(2)+4).^2)/2;
R2 = ((x(1)+4).^2 + (x(2)-5).^2)/3;

r1x1= x(1)-5;
r1x2= x(2)+4;
r2x1= x(1)+4;
r2x2= x(2)-5;
xx1=x(1).^2;
xx2=x(2).^2;


ex1 = exp(-R/10);
ex2 = exp(-R/100);
ex3 = exp(-R1/10);
ex4 = exp(-R2/10);
ex5 = exp(-R2/100);

fact1=1/5;
fact2=2/25;
fact3=1/625;
fact4=1/2;
fact5=5/100;
fact6=1/3;
fact7=5/225;
fact8=2/75;
fact9=4/22500;

ddf11a= ex1-fact1*xx1.*ex1-fact2*ex2+fact3*xx1.*ex2;
ddf11b= fact4*ex3-fact5*ex3.*r1x1.^2+fact6*ex4-fact7*ex4.*r2x1.^2;
ddf11c= fact8*ex5-fact9*r2x1.*ex5;
ddf11=ddf11a+ddf11b+ddf11c;

ddf12a= -fact1*x(1).*x(2).*ex1+fact3*x(1).*x(2).*ex2;
ddf12b= -fact5*r1x1.*r1x2.*ex3-fact7*r2x1.*r2x2.*ex4;
ddf12c= fact9*r2x1.*r2x2.*ex5;
ddf12=ddf12a+ddf12b+ddf12c;

ddf22a= ex1-fact1*xx2.*ex1-fact2*ex2+fact3*xx2.*ex2;
ddf22b= fact4*ex3-fact5*ex3.*r1x2.^2+fact6*ex4-fact7*ex4.*r2x2.^2;
ddf22c= fact8*ex5-fact9*r2x2.*ex5;
ddf22=ddf22a+ddf22b+ddf22c;

dh=[ddf11, ddf12; ddf12, ddf22];
