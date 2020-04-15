xx = [-15:0.5:15]';
yy = [-15:0.5:15]';
[x,y]=meshgrid(xx',yy');
RR = (x+2).^2 + (y+1).^2;
%R = sqrt(RR) + eps;
meshd = -4*exp(-RR./10)+4*exp(-RR./100)+0.01*RR+0.01*x;
figure(2);
hold off
clf
set(fp, 'NumberTitle', 'off');
set(fp, 'Name', 'Funktion 5'); 
subplot(1,2,1)
mesh(xx,yy,meshd)
conts = 20;
%conts = exp(3:20);
hold on

