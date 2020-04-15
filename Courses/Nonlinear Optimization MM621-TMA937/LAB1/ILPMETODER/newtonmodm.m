function [x,slut,ww1,stlgd]= newtonmodm(f,g,h,x,normavbrott,avstandavbrott,ww1,stlgd)
  stlgd = 1;
  slut = 0;

 % if min(eig(feval(h,x))) < 0
 %    stlgd = 0;
 %    return
 % end

  d = feval(h,x)\(-feval(g,x));
  if sum(feval(h,x)) == 0
    ww1 = 0;
    return
  end

  if norm(feval(g,x)) <= normavbrott 
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
  if basp < 0
    basp = 0;
    stlgd = 0;
    return
  end

  oldx = x;
  x = x + basp*d;
  if norm(oldx-x) < avstandavbrott
    slut = 1;
    return 
  end


