function imOut = removeSeamV(im4,seam)
    imOut = zeros(size(im4,1), size(im4,2)-1, size(im4,3));
    
    for i = 1:size(im4, 1)
        k = 1;
        for j = 1:size(im4, 2)
            if (j == seam(i))
                continue
            end
                imOut(i, k, :) = im4(i, j, :);
                k = k +1;
        end
    end
    
end
