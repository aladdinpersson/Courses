function [x,slut]= steepd (f,g,h,x,normavbrott,avstandavbrott)
  d = -feval(g,x);
  slut = 0;
  if norm(d) <= normavbrott
    slut = 1;
    return 
  end
  d=d/norm(d);
  l = 0.01;
  basp = 0;
  j=0;
  while (j<50 & abs(l)>1e-5)
    j=j+1;
    if feval(f,x+d*basp+l*d) < feval(f,x+d*basp)
      basp = basp + l;
      l = 2*l;
    else
      l = - l/4;
    end
  end;
  oldx = x;
  x = x + basp*d;
  if norm(oldx-x) < avstandavbrott
    slut = 1;
    return 
  end



