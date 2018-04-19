function outIm = applyFilter(im,F)


    [rows, cols] = size(im);
    outIm = zeros(size(im,1), size(im,2));
 
    im = padarray(im, [floor(size(F,1)/2),floor(size(F,2)/2)]);
    
    for x = 1:rows
        for y = 1:cols
            matrix = F .* im(x:size(F,1)+x-1, y:size(F,2)+y-1);
            outIm(x,y) = sum(matrix(:));
        end
    end
end
