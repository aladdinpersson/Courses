xx = [-1:0.05:1.0]';
yy = [-1:0.05:1.0]';
[x,y]=meshgrid(xx',yy') ;
meshd = 2*(y-x.^3).^2 +0.1*(x+1).^2+0.5*y.^2 +(x.*y).^2;
figure(2);
hold off
clf
set(fp, 'NumberTitle', 'off');
set(fp, 'Name', 'Funktion 8'); 
subplot(1,2,1)
mesh(xx,yy,meshd)
conts = exp(-5:10);
hold on
