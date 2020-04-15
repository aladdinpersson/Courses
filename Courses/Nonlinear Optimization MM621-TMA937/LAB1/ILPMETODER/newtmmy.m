function [x,slut,ww1,stlgd]= newtmmy(f,g,h,x,normavbrott,avstandavbrott,ww1,stlgd,my)
  stlgd = 1;
  slut = 0;

  lambda = min(eig(feval(h,x,my)));
  if lambda < 0
     stlgd = 0;
     return
  end

  d = feval(h,x,my)\(-feval(g,x,my));
  if sum(feval(h,x,my)) == 0
    ww1 = 0;
    return
  end

  if norm(feval(g,x,my)) < normavbrott
    slut = 1;
    return
  end

  oldx = x;
  x = x + d;

  if norm(oldx-x) < avstandavbrott
    slut = 1;
    return 
  end


