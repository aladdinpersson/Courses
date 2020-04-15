%xx = [-5:0.2:4]';
%yy = [-5:0.2:3]';
xx = [-5:0.25:4]';
yy = [-5:0.25:3]';
[x,y]=meshgrid(xx',yy');
meshd = x + my*(max(0,((x-1).^2 + (y+2).^2 - 16)).^2 + max(0,(13 - x.^2 - y.^2)).^2); 
figure(2);
hold off
%clf
set(fp, 'NumberTitle', 'off')
set(fp, 'Name', ' SUMT (funk 1)');
subplot(1,2,1)
mesh(xx,yy,meshd)
%conts = exp(3:10);
conts = 100;
hold on




