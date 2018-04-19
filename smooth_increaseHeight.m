% reduces height of the image by one pixel using seam carving
function [seam,im,c] = smooth_increaseHeight(im4,E)
   im4 = permute(im4,[2 1 3]);
   [seam, im, c] = smooth_increaseWidth(im4, E');
   im = permute(im,[2 1 3]);
end