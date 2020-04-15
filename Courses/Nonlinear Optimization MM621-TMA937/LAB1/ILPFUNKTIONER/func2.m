xx = [-10:0.5:10]';
yy = [-10:0.5:10]';
[x,y]=meshgrid(xx',yy');
meshd = -5*cos(0.2*(1+(y.^2-0.5)./(x.^2+0.5)))+0.001*y.^4+0.003*x.^4+2*x;
figure(2);
hold off
clf
set(fp, 'NumberTitle', 'off');
set(fp, 'Name', 'Funktion 7'); 
subplot(1,2,1)
mesh(xx,yy,meshd)
conts = 16;
%conts = exp(3:20);
hold on

