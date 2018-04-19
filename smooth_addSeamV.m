function imOut = addSeamV2(im4,seam)
    r = size(im4, 1);
    c = size(im4, 2);
    imOut = zeros(r, c+1, size(im4, 3));
    

    for i = 1:r
        for j = 1:c
            if (j == 1)
                k = 1;
            end
            imOut(i, k, :) = im4(i, j, :);
            k = k + 1;
            if (j == seam(i))
                num1 = randi([0 3],1);
                num2 = randi([0 3],1);
                if ((j+num1 <= c && i+num1 <=r) && (i-num2 >= 1 && j-num2 >= 1))
                    avgValue = (im4(i, j, :) + im4(i-num2, j-num2, :) + im4(i+num1, j+num1, :))/3;
                else
                    avgValue = im4(i, j, :);
                end
                imOut(i, k, :) = avgValue;
                k = k + 1;
            end
          
        end
    end
end

