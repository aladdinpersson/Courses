function z = sumtf(x,my)
z = x(1) + my*(max(0,((x(1)-1).^2 + (x(2)+2).^2 - 16)).^2 + max(0, 13 - (x(1)^2 + x(2)^2)).^2); 


