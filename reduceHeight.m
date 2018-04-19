function [seam,im,c] = reduceHeight(im4,E)
   [seam, im, c] = reduceWidth(permute(im4,[2 1 3]), E');
   im = permute(im,[2 1 3]);
end
