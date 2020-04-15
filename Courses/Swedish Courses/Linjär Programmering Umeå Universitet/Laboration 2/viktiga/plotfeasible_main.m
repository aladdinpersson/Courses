% Plot region

A=[-1, 0; -4, -1; 1 0 ; 0 1];
b = [-5; -25; 0; 0];
plotregion(A,b,[],[], 'black');
xlim([0 8])
ylim([0 30])
hold on
plot(0,0,'ro','MarkerFaceColor', 'red')  % marking the 10th data point of x and y
plot(5,5,'ro','MarkerFaceColor', 'red')  % marking the 10th data point of x and y
plot(0,25,'ro','MarkerFaceColor', 'red')  % marking the 10th data point of x and y
plot(5,0,'ro','MarkerFaceColor', 'red')  % marking the 10th data point of x and y
xlabel('x_{1}')
ylabel('x_{2}')
legend('Tillåtet område','Extrempunkter');

% Save file to eps format
% print('MyRegion','-depsc2')