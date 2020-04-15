function [x,slut,ww1,stlgd]= newtm(f,g,h,x,normavbrott,avstandavbrott,ww1,stlgd)
  stlgd = 1;
  slut = 0;

%  lambda = min(eig(feval(h,x)));
%  if lambda < 0
%     stlgd = 0;
%     return
%  end

  d = feval(h,x)\(-feval(g,x));
  if sum(feval(h,x)) == 0
    ww1 = 0;
    return
  end
  if norm(feval(g,x)) <= normavbrott 
    slut = 1;
    return
  end

  oldx = x;
  x = x + d;

  if norm(oldx-x) < avstandavbrott
    slut = 1;
    return 
  end


