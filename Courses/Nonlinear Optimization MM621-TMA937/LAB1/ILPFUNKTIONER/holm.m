xx = [-1.0:0.05:1.0]';
yy = [-1.0:0.05:1.0]';
[x,y]=meshgrid(xx',yy') ;
meshd = (x.^3-y).^2 + 2*(x-y).^4';
figure(2);
hold off
clf
set(fp, 'NumberTitle', 'off');
set(fp, 'Name', 'Funktion 6 (Holmbergs funktion)'); 
subplot(1,2,1)
mesh(xx,yy,meshd)
conts = exp(-5:10);
xx = [-1.1:0.02:1.1]';
yy = [-1.1:0.02:1.1]';
[x,y]=meshgrid(xx',yy') ;
meshd = (x.^3-y).^2 + 2.*(x-y).^4; 
hold on
