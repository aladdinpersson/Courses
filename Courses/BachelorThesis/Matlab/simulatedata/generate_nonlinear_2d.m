function [X,y] = generate_nonlinear_2d(N,D,K,noise_rate)
clc;

X = zeros(N*K,D);
y = zeros(N*K,1);

for j = 0:(K-1)
    indices = (N*(j) + 1: N*(j+1)); % generate N points for this specific class
    size(indices)
    r = linspace(0, 1, N); % radius of circle
    t = linspace(j*4, (j+1)*4, N); % + randn([1,N])*0.2
    X(indices,:) = [r.*sin(t); r.*cos(t)]';
    y(indices) = j;
end

% (X: exempel, dim), y: (dim, exempel)
X(:,2) = X(:,2) + 1;
X(:,1) = X(:,1) + 1;

alpha = 1 .* (rand([N*(K),1])*2 - 1); % [-1,1]
X(:,2) = X(:,2) + X(:,2) .* alpha .* noise_rate;
end

% N = 100 # number of points per class
% D = 2 # dimensionality
% K = 3 # number of classes
% X = np.zeros((N*K,D)) # data matrix (each row = single example)
% y = np.zeros(N*K, dtype='uint8') # class labels
% for j in range(K):
%     ix = range(N*j, N*(j+1))
%     r = np.linspace(0,1,N) # radius
%     t = np.linspace(j*4,(j+1)*4,N) + np.random.randn(N)*0.2
%     X[ix] = np.c_[r*np.sin(t), r*np.cos(t)]
%     y[ix] = j
% # lets visualize the data:
% plt.scatter(X[:, 0], X[:, 1], c=y, s=40, cmap=plt.cm.Spectral)
% plt.show()