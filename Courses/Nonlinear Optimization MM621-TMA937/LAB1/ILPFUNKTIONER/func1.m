xx = [-20:0.5:20]';
yy = [-20:0.5:20]';
[x,y]=meshgrid(xx',yy');
R = x.^2 + y.^2;
R1 = ((x-5).^2 + (y+4).^2)/2;
R2 = ((x+4).^2 + (y-5).^2)/3;
meshd = -5*exp(-R/10)+4*exp(-R/100)-5*exp(-R1/10)-5*exp(-R2/10)-4*exp(-R2/100);
figure(2);
hold off
set(fp, 'NumberTitle', 'off');
set(fp, 'Name', 'Funktion 3'); 
clf
subplot(1,2,1)
mesh(xx,yy,meshd)
conts = 20;
%conts = exp(3:20);
hold on

