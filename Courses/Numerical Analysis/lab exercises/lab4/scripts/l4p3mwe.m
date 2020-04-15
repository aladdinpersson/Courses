% Define sample points
x=linspace(2,10,1001);

% Compute target values
T=

% Compute approximations
A=

% Compute relative error
R=

% Plot log10 of the absolute value of the relative error
plot(log10(x),log10(abs(R)));

% Compute the maximum of the absolute value of the relative error
mre=max(abs(R));

% Display mre
fprintf('Max. absolute value of the relative error = %10.4e\n',mre);