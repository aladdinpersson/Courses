xx = [-4:0.2:4]';
yy = [-4:0.2:4]';
[x,y]=meshgrid(xx',yy'); 
meshd = (x).^3 + 2.*(y).^3 - 27.*(x) - 6.*(y); 
figure(2);
hold off
clf
set(fp, 'NumberTitle', 'off');
set(fp, 'Name', 'Funktion 4'); 
subplot(1,2,1)
mesh(xx,yy,meshd)
conts = 20;
hold on
