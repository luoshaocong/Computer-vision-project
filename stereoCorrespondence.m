function bestDisparity = stereoCorrespondence(left, right, wSize,maxDisp )
    [r, c] = size(left);
    bestWindCost = Inf(r,c);
    bestDisparity = zeros(r,c);
    wpad = floor(wSize/2);

    for d = 0:maxDisp
        leftShifted = left(:, d+1:end);
        rightShifted = right(:, 1:end-d);
        
        padding = zeros(r,d);
        
        AD = abs(leftShifted-rightShifted);
        AD = [padding, AD];
        
        integralAD = integralImage(AD);
        integralAD = integralAD(2:end, 2:end);
        I = padarray(integralAD, [wpad+1, wpad+1]);
        
        for x = 2:r
            for y = 2:c
                x2 = wSize+x-1;
                y2 = wSize+y-1;
                
                cost = I(x2, y2) - I(x-1, y2) - I(x2, y-1) + I(x-1, y-1);
                
                if (cost < bestWindCost(x-1, y-1))
                    bestWindCost(x-1, y-1) = cost;
                    bestDisparity(x-1, y-1) = d;
                end
            end
        end
    end
end

