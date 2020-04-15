function z = func3f(x)
RR = (x(1)+2).^2 + (x(2)+1).^2;
z = -4*exp(-RR./10)+4*exp(-RR./100)+0.01*RR+0.01*x(1);
