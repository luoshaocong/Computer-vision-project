% reduces height of the image by one pixel using seam carving
function [seam,im,c] = increaseHeight(im4,E)
   [seam, im, c] = increaseWidth(permute(im4,[2 1 3]), E');
   im = permute(im,[2 1 3]);
end