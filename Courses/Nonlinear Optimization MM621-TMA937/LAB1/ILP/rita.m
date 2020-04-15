%whiteallilp
if nytt == 1
  fp=figure('Position',[10 40 1000 400],'color','black');
  colordef none;
  set(fp,'CloseRequestFcn','avslutailp')
  set(fp,'menubar','none')  
  nytt = 0;
else
  figure(2);
  clf
%  men1= uicontrol('Parent',fp, ...
%        'Backgroundcolor',[0 0 0], ...
%	'Foreground',[1 0 0], ...
%	'Units','points', ...
%	'Position',[300 200 300 20], ...	
%	'Style','text', ...
% 	'Fontsize',20, ...
%	'string','FIGURPLOTT KOMMER!!!', ...
%	'Tag','StaticText1');
%  pause(3);
end
if fkn == 1
  enkel
  funktion = 'enkelf';
  grad = 'enkelg';
  hess = 'enkelh';
end
if fkn == 2
  rosen
  funktion = 'rosenf';
  grad = 'roseng';
  hess = 'rosenh';
end
if fkn == 3
  func1
  funktion = 'func1f';
  grad = 'func1g';
  hess = 'func1h';
end
if fkn == 4
  func4
  funktion = 'func4f';
  grad = 'func4g';
  hess = 'func4h';
end
if fkn == 5
  func3
  funktion = 'func3f';
  grad = 'func3g';
  hess = 'func3h';
end
if fkn == 6
  holm
  funktion = 'holmf';
  grad = 'holmg';
  hess = 'holmh';
end
if fkn == 7
  func2
  funktion = 'func2f';
  grad = 'func2g';
  hess = 'func2h';
end
if fkn == 8
  func5
  funktion = 'func5f';
  grad = 'func5g';
  hess = 'func5h';
end
if fkn < 9
  nyttmy = 0;
end
if fkn == 9
  whitecomnotmy
  if nyttmy == 0
    my = 0.005;
    mymeny;
    nyttmy = 1;
  end
  sumt;
  funktion = 'sumtf';
  grad = 'sumtg';
  hess = 'sumth';
end

title('3-D bild')
subplot(1,2,2)
contour(xx,yy,meshd,conts,'-');
hold on
xlabel('x1')
ylabel('x2')
title('Nivåkurvor')
%drawnow; % Draws current graph now

utanfor = 0;
if startpoint(1) < xx(1) | startpoint(1) > xx(size(xx,1))
  utanfor = 1;
end
if startpoint(2) < yy(1) | startpoint(2) > yy(size(yy,1))
  utanfor = 1;
end
if utanfor == 0
  figure(2);
  subplot(1,2,2) 
  plot(startpoint(1),startpoint(2),'wo','Erasemode','none')
  subplot(1,2,1)
  hold on
  if fkn < 9
    plot3(startpoint(1),startpoint(2),feval(funktion, startpoint),'wo','Erasemode','none')
  else 
    plot3(startpoint(1),startpoint(2),feval(funktion, startpoint,my),'wo','Erasemode','none')
  end
  x = startpoint;
else
  men1= uicontrol('Parent',men, ...
	'Backgroundcolor',[1 1 1], ...
	'Foreground',[1 0 0], ...
	'Units','points', ...
	'Position',[30 40 250 20], ...	
	'Style','text', ...
 	'Fontsize',12, ...
	'string','The starting point is outside the are choose a new !!', ...
	'Tag','StaticText1');
end







