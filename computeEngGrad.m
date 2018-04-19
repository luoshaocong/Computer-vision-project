function eng = computeEngGrad(im,F)
    imG = mean(im, 3) ;
    eng = sqrt(applyFilter(imG, F).^2 + applyFilter(imG, F').^2);
end
