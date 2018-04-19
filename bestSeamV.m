function [seam,c] = bestSeamV(M,P)
     [c,x] = min(M(end, :));
     
     seam = zeros(size(M,1),1);
     seam(end) = x;
     
     for i = 1:size(M,1)-1
        x = P(size(M,1)-i+1, x); 
        seam(size(M,1)-i) = x;
     end
     
     
end

