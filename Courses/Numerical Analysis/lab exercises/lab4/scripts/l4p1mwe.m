% Select sample points
x=linspace(-3,3,1001);

% Compute target
T

% Compute approximation
A

% Compute relative error
R

% Plot log10 of the absolute value of the relative error
plot(x,log10(abs(R)));

% Compute the maximum of the absolute value of the relative error
mre=max(abs(R));

% Display mre
fprintf('Max. absolute value of the relative error = %10.4e\n',mre);