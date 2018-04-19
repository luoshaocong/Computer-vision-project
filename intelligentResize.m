function [totalCost,imOut] = intelligentResize(im,v,h,W,mask,maskW)
    imOut = cat(3,im,mask);    
    totalCost = 0;
    for i = 1:abs(v) + abs(h)+1
        E = computeEng(imOut, [-1,0,1], W, maskW);
        c = 0;
        if ( mod(i,2) && h<0)
            [~, imOut, c] = reduceHeight(imOut, E);
            h = h + 1;
        elseif (mod(i,2) && h>0)
            [~, imOut, c] = increaseHeight(imOut, E);
            h = h - 1;
        elseif (mod(i,2) && v<0)
            [~, imOut, c] = reduceWidth(imOut, E);
            v = v + 1;
        elseif (mod(i,2) && v>0)
            [~, imOut, c] = increaseWidth(imOut, E);
            v = v - 1;      
        end
        totalCost = c + totalCost;
    end
end
