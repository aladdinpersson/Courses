function y=viral(t,x)

    %%% This function is for modeling disease according to SIR-model
    
    % Initialization of important variables 
    % z = 'fraction of population that is immune to disease (vaccination)'
    % vaccination = 'If people are vaccinated true/false'
    z = 0.95;
    vaccination=1;
    
    %output for S,I,R needs 3 elements in y
    y=zeros(3,1);
    
    % constants:
    % alpha how fast disease spreads
    % beta how fast people recover
    alpha=0.5;beta=0.04;
    
    %y(1) represents S' - rate of change of suspectible individuals
    %y(2) represents I' - rate of change of infected individuals
    %y(3) represents R' - rate of change of recovered individuals
    if vaccination == 0
        y(1)= -alpha.*x(1).*x(2);
        y(2)= +alpha.*x(1).*x(2)-beta.*x(2);
        y(3)= beta.*x(2);
    elseif vaccination == 1
        y(1)=-alpha.*x(2).*(1-z).*x(1);
        y(2)=+alpha.*x(2).*(1-z).*x(1)-beta.*x(2);
        y(3)=beta.*x(2);
    end
end