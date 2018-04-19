function eng = computeEngColor(im,W)
    eng = W(1,1)*im(:,:,1) + W(1,2)*im(:,:,2) + W(1,3)*im(:,:,3);
end
