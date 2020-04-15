function [maximum,tableau,tot_it] = mysimplex_bestcost(A,b,c)

%mysimplex_bestcost Simplex solver for LP problems, with best objective
% function.
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
tol = 0;

while t == 1
    if size(find(tableau(1,1:end-1)<0))>0
        best_score = -inf;
        best_pivot = -inf;
        best_ind = -inf;
        indices = find(tableau(1,1:end-1) < 0);
        
        % ind är kolumn negativa värden,
        % pivot
        for ind=indices
            for pivot=2:size(A,1)+1
                if tableau(pivot,ind) > tol
                    tmp = tableau;
                    %Perform row operations on the tableau
                    tmp(pivot,:)=tmp(pivot,:)./tmp(pivot,ind); 
                    index=1:size(A,1)+1;
                    index=index(index~=pivot);

                    for j=index
                        tmp(j,:)=tmp(j,:)-tmp(j,ind)*tmp(pivot,:);
                    end

                    score = tmp(1,end);
                    
                    if score > best_score
                        best_score = score;
                        best_pivot = pivot;
                        best_ind = ind;
                    end
                    
                    tot_it = tot_it+1;
                end
            end
        end
        
        %Perform row operations on the tableau
        if best_pivot == -inf
            tableau
            best_score
            best_pivot
        end
        
        tableau(best_pivot,:)=tableau(best_pivot,:)./tableau(best_pivot,best_ind);
        index=1:size(A,1)+1;
        index=index(index~=best_pivot);
        
        tot_it = tot_it + 1;
        
        for j=index
            tableau(j,:)=tableau(j,:)-tableau(j,best_ind)*tableau(best_pivot,:);
        end        
        
    
    else
        t=0; %If no incoming variable found, we have the optimal value
    end
end
maximum=tableau(1,end); %Optimal value