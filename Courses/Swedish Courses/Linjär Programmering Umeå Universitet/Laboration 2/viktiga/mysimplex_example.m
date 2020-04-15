function [maximum,tableau,tot_it] = mysimplex_example(A,b,c)

%mysimplex_example Simplex solver for LP problems, with steepest ascent.
    %Tries to solve the LP-problem
        %max z = c * x,
        %subject to A*x<=b,
        %such that x>=0, and b>=0.
    %Returns the maximum value of the objective function z.
    

tableau=zeros(size(A,1)+1,size(A,2)+size(A,1)+1);%Initialize a tableau,
                                                 %with room for slack.
                                        
tableau(1,1:size(A,2))=-c;                %Fill the tableau
tableau(2:end,1:size(A,2))=A;
tableau(2:end,end)=b;
tableau(2:end,size(A,2)+1:end-1)=eye(size(A,1)); %Add slack
t=1;
tot_it = 0;

while t == 1
    if size(find(tableau(1,1:end-1)<0))>0
        [~,ind]=min(tableau(1,1:end-1));       %Find incoming variable
        
        
        minimum=inf*ones(1,size(tableau(2:size(A,1)+1,ind),1));
        for j=2:size(A,1)+1
            if tableau(j,ind)>0                        %Find candidates
                minimum(j)=tableau(j,end)/tableau(j,ind); 
            end                                      %for outgoing variable
        end
        [~, pivot]=min(minimum);                %Find outgoing variable
        
        
        
        %Perform row operations on the tableau
        tableau(pivot,:)=tableau(pivot,:)./tableau(pivot,ind);
        index=1:size(A,1)+1;
        index=index(index~=pivot);
        
        tot_it = tot_it + 1;
        for j=index
            tableau(j,:)=tableau(j,:)-tableau(j,ind)*tableau(pivot,:);
        end
    else
        t=0; %If no incoming variable found, we have the optimal value
    end
    
    
end
maximum=tableau(1,end); %Optimal value
