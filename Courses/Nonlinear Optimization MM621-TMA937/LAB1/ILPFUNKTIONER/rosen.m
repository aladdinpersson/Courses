xx = [-2:0.125:2]';
yy = [-1:0.125:3]';
[x,y]=meshgrid(xx',yy');
meshd = 100*(y-x.*x).^2+(1-x).^2; 
figure(2);
hold off
clf
set(fp, 'NumberTitle', 'off');
set(fp, 'Name', 'Funktion 2 (Rosenbrocks funktion)'); 
subplot(1,2,1)
mesh(xx,yy,meshd)
conts = exp(3:20);
hold on

