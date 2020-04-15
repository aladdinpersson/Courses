function [states,labels] = generate_linear_2d(points, a, b, c, noise_rate)

states = rand([points,2])*2 - 1; % to get between [-1,1]
labels = zeros(1,points);

for idx = 1:length(states)
    if [a,b] * states(idx, :)' + c > 0
        labels(1, idx) = 1;
    else
        labels(1, idx) = 0;
    end
end

alpha = 1 .* (rand([points,1])*2 - 1); % [-1,1]
% alpha = normrnd(0,3,[points,1]);

states(:,2) = states(:,2) + states(:,2) .* alpha .* noise_rate;
end