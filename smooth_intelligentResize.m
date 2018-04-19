function [totalCost,imOut] = intelligentResize(im,v,h,W,mask,maskW)
    imOut = cat(3,im,mask);
    F = [-1,0,1];
    
    num_seams = abs(v) + abs(h);
    
    isHSeamRemove = h < 0;
    isVSeamRemove = v < 0;
    totalCost = 0;

    for i = 1:num_seams+1
        isHorizontal = eq(mod(i,2), 1);
        E = computeEng(imOut, F, W, maskW);
        if (isHorizontal && isHSeamRemove && h ~= 0)
            [seam, imOut, c] = reduceHeight(imOut, E);
            totalCost = c + totalCost;
            h = h + 1;
        elseif (isHorizontal && ~isHSeamRemove && h ~= 0)
            [seam, imOut, c] = smooth_increaseHeight(imOut, E);
            totalCost = c + totalCost;
            h = h - 1;
        elseif (~isHorizontal && isVSeamRemove && v ~= 0)
            [seam, imOut, c] = reduceWidth(imOut, E);
            totalCost = c + totalCost;
            v = v + 1;
        elseif (~isHorizontal && ~isVSeamRemove && v ~= 0)
            [seam, imOut, c] = smooth_increaseWidth(imOut, E);
            totalCost = c + totalCost;
            v = v - 1;      
        end
    end
end
