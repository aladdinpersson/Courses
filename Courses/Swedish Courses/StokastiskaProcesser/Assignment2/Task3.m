% Task 3: "Lecture starts in 5"

%%% Purpose is to simulate a poission process that can be decomposed into
%%% a homogeneous and non-homogeneous part. We want to simulate both of
%%% them separately, and then combine them to simulate the poission
%%% process. Lastly we want to see the expected value of the poisson
%%% process at time step 10 and compare to theorethical value.

% clear everything in sake of unecessary bugs
clear all; close all; clc;



%% 3,a) Decompose by: lambda_homogeneous =3; lambda_nonhomogeneous = t*(10-t)/10

%% 3,b) Simulate the homogeneous component

% Initialize variables, K simulations, homogeneous lambda, non-homogeneous
% lambda, mean value function capital Lambda.

clc; close all;

lh = 3;
T=10;

I=0; t=0; S=[];

while 1
    u = rand;
    % Inverse transform method from exp. distribution gives following
    X=-1./lh.*log(u);
    
    t=t+X;
    
    if t > T
        break
    end
    
    I=I+1;
    S(I)=t;
end

stairs([0, S,T],0:I+1)

xlabel('Time step t')
ylabel('Number of arrivals')
title('Homogeneous poission process')

%% Simulate the non-homogeneous component

clc; close all;

% non-homogeneous part is lambda(t), whereas Lambda(t) is mean value func.
lambda = @(t) t.*(10-t)./10;
Lambda = @(t) t.^2/2 - t.^3/30;

% Maximum value of lambda(t)
lmax = 2.5;

% How many times to create the plot
N = 100;

for n=1:N
    % Initialize T for end time, I for arrivals, S for time points, t for
    % current time
    T=10; I=0; t=0; S=[];
    while 1
        u=rand;
        
        % Simulate time from test distribution, where test dist. is with
        % constant lambda, where lambda_max is max of lambda(t) interval [0,T]
        X=-1/lmax*log(u);
        
        % add time X from exponential distribution simulated above
        t=t+X;
        
        % if we jump out of max time we want to simulate->break
        if t>T
            break
        end
        
        u=rand;
        
        % Not entirely sure about this part
        if u<(lambda(t)/lmax)
            I=I+1;
            S(I)=t;
        end
    end
    
    stairs([0, S,T],0:I+1)
    hold on
end

% Plot mean value function
t_grid=0:0.01:T;
plot(t_grid,Lambda(t_grid),'b','LineWidth',2)

xlabel('Time step t')
ylabel('Amount of arrivals')
title('Non-homogeneous poission process')

%% 3,c)
clc; close all;

% Initialize how many simulations
K = 1e4;

% Vector to store total steps at time T
storevals=zeros(1,K);

for k=1:K
    totsteps=0;
    
    % set everything to zero before homogeneous part
    T=10; I=0; t=0; S=[];
    
    while 1
        u = rand;
        % Inverse transform method from exp. distribution gives following
        X=-1./lh.*log(u);
        
        t=t+X;
        
        if t > T
            break
        end
        
        I=I+1;
        S(I)=t;
    end
    
    totsteps=totsteps+I;
    
    % need to reset everything before non-homogeneous simulation
    T=10; I=0; t=0; S=[];
    while 1
        u=rand;
        
        % Simulate time from test distribution, where test dist. is with
        % constant lambda, where lambda_max is max of lambda(t) interval [0,T]
        X=-1/lmax*log(u);
        
        % add time X from exponential distribution simulated above
        t=t+X;
        
        % if we jump out of max time we want to simulate->break
        if t>T
            break
        end
        
        u=rand;
        
        % Not entirely sure about this part
        if u<(lambda(t)/lmax)
            I=I+1;
            S(I)=t;
        end
    end
    
    totsteps = totsteps+I;
    storevals(1,k)=totsteps;
end

% we get the mean to be ~46.6 which is very close to theorethical of
% approx. 46.666666667
mean(storevals)