function [seam,im,c] = reduceWidth(im4,E)
    [M,P] = seamV_DP(E);
    [seam,c] = bestSeamV(M,P);
    im = removeSeamV(im4, seam);
end
