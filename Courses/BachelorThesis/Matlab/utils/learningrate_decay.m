function [learning_rate] = exponential_decay(learning_rate, epoch_num)
learning_rate = 0.99999^(epoch_num) * learning_rate;
%decay_rate = 1;
%learning_rate = 1/(1+decay_rate*epoch_num) * learning_rate;

end