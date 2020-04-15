xx = [-10:0.5:10]';
yy = [-10:0.5:10]';
[x,y]=meshgrid(xx',yy');
meshd = 2*(x+1).^2 + 8*(y+3).^2 + 5*x + y; 
figure(2);
hold off
clf
set(fp, 'NumberTitle', 'off');
set(fp, 'Name', ' Funktion 1 (kvadratisk) '); 
subplot(1,2,1)
mesh(xx,yy,meshd)
conts = exp(3:10);
hold on


