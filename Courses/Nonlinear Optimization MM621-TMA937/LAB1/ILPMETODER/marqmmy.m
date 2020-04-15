function [x,slut,ww1,stlgd]= marqmmy(f,g,h,x,normavbrott,avstandavbrott,ww1,stlgd,my)
  stlgd = 1;
  slut = 0;
  lambda = min(eig(feval(h,x,my)));
  if lambda > 0
    d = feval(h,x,my)\(-feval(g,x,my));
    if sum(feval(h,x,my)) == 0
      ww1 = 0;
      return
    end
  else
    if lambda < 0
      h = feval(h,x,my); 
      h = h - 2*lambda*eye(2);
      d = h\(-feval(g,x,my));
    end
    if lambda == 0
      h = 0.1*eye(2);
      d = h\(-feval(g,x,my));
    end
  end

  if norm(feval(g,x,my)) <= normavbrott 
    slut = 1;
    return
  end	

  d=d/norm(d);
  l = 0.01;
  basp = 0;
  j=0;
  while (j<50 & abs(l)>1e-5)
    j=j+1;
    if feval(f,x+d*basp+l*d,my) < feval(f,x+d*basp,my)
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




