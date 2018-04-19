% increases width of the image by n pixels using seam carving
function [seam,im,c] = smooth_increaseWidth(im4,E)
    [M,P] = seamV_DP(E);
    [seam,c] = bestSeamV(M,P);
    im = smooth_addSeamV(im4, seam);
end
