function dh = func3h(x)
RR = (x(1)+2).^2 + (x(2)+1).^2;
rx1= x(1)+2;
rx2= x(2)+1;
ex1 = exp(-RR./10);
ex2 = exp(-RR./100);
fact1=4/5;
fact2=4/25;
fact3=2/25;
fact4=4/2500;
ddf11= fact1*ex1-fact2*ex1.*rx1.^2-fact3*ex2+fact4*ex2.*rx1.^2+0.02;
ddf12= -fact2*ex1.*rx1.*rx2+fact4*ex1.*rx1.*rx2;
ddf22= fact1*ex1-fact2*ex1.*rx2.^2-fact3*ex2+fact4*ex2.*rx2.^2+0.02;
dh=[ddf11, ddf12; ddf12, ddf22];

