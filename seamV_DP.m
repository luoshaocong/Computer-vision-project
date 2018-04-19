function [M,P] = seamV_DP(E)
    M = zeros(size(E));
    P = zeros(size(E));
    
   M(1,:) = E(1,:);
   P(1,:) = -1;

    for r = 2:size(E,1)
        for c = 1:size(E,2)
            if (c == 1)
                cd1 = Inf;
            else
                cd1 = M(r-1,c-1);
            end
            
            cd2 = M(r-1,c);
            
            if (c > size(E,2)-1)
                 cd3 = Inf;
            else
                cd3 = M(r-1,c+1);
            end
            
            if (cd1 <= cd2 && cd1 <= cd3)
                M(r,c) = E(r,c) + M(r-1,c-1);
                P(r,c) = c-1;
            elseif (cd2 <= cd1 && cd2 <= cd3)
                M(r,c) = E(r,c) + M(r-1,c);
                P(r,c) = c;
            else
                M(r,c) = E(r,c) + M(r-1,c+1);
                P(r,c) = c+1;
            end
        end
    end
end