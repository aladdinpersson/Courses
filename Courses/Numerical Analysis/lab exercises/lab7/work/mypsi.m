function z=mypsi(f,t,y,dt)

%mypsi for third order rungekutta
%input: f(t,v), time t, y(t), and stepsize dt
%output approximation for y(t+dt)

% Compute coefficients
k1=f(t,y); % obs v' = f(t,v), hence we use derivative at current point 
k2=f(t+0.5*dt,y+0.5*dt*k1);
k3=f(t+0.5*dt,y+0.5*dt*k2);

% Advance the solution a single step
z=y+(dt/6)*(k1+4*k2+1*k3);