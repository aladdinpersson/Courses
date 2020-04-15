T=10;              % Time perspective, we simulate interval [0,T]
sigma=100;            % Variance parameter
dt=0.001;           % Discretisation step
t=0:dt:T;           % Simulated time steps vector.
N=T/dt;             % Number of discritisation points
mu=100/N;
Z=randn(1,N);       % Simulates N random numbers from N(0,1)
X=mu+sqrt(dt)*sigma*Z; % Transforming numbers to N(0,sigma^2*dt)

% Constructing Brownian motion approximation, 
%W(0)=0, and 
%W(k*dt)=sum_{i=1}^k X_i
W=[0, cumsum(X)];   
% Plot walk   
plot(t,W)