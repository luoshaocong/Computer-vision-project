%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Performs foreground/background segmentation based on a graph cut
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% INPUT: 
%        im: input image  in double format 
%        scribbleMask: 
%               scribbleMask(i,j) = 2 means pixel(i,j) is a foreground seed
%               scribbleMask(i,j) = 1 means pixel(i,j) is a background seed
%               scribbleMask(i,j) = 0 means pixel(i,j) is not a seed
%        lambda: parameter for graph cuts
%        numClusters: parameter for kmeans
%        inftCost: parameter for infinity cost constraints
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% OUTPUT:   segm is the segmentation mask of the  same size as input image im
%           segm(i,j) = 1 means pixel (i,j) is the foreground
%           segm(i,j) = 0 means pixel (i,j) is the background
%
%           eng_finish: the energy of the computed segmentation
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [segm,eng_finish]  = segmentGC(im,scribbleMask,lambda,numClusters,inftyCost)
    

    [rows,cols, depth] = size(im);
    D_bg = zeros(rows, cols);
    D_fg = zeros(size(D_bg));

    save('param.mat', 'lambda', 'numClusters', 'inftyCost');
    
    if (numClusters > 0)
        flatIm = reshape(im, [], depth);
        
        clusters = kmeans(flatIm, numClusters, 'MaxIter', 150);
        clusters = reshape(clusters, rows, cols);
        
        fg_indices = scribbleMask == 2;
        bg_indices = scribbleMask == 1;
        binRange = 1:numClusters;
        fg_count = hist(clusters(fg_indices), binRange)+1;
        bg_count = hist(clusters(bg_indices), binRange)+1;
        
        total_fg = sum(fg_count);
        total_bg = sum(bg_count);
        
        norm_fg_count = fg_count/total_fg;
        norm_bg_count = bg_count/total_bg;
        
        fg_cost = -1*log(norm_fg_count);
        bg_cost = -1*log(norm_bg_count);
        
        D_bg = bg_cost(clusters);
        D_fg = fg_cost(clusters);
            
    else
        D_bg((scribbleMask == 2)) = inftyCost;
        D_fg((scribbleMask == 1)) = inftyCost;
    end
    
    
    indices = reshape(1:(rows*cols),rows,cols);
    horz_edges0 = reshape(indices(:,1:end-1),[],1);
    horz_edges = cat(2, horz_edges0, horz_edges0+rows);
    vert_edges0 = reshape(indices(1:end-1,:),[],1);
    vert_edges = cat(2, vert_edges0, vert_edges0+1);
    im_mean = mean(im, 3) ;
    W = cat(1, horz_edges, vert_edges);
    sigma = sum(( im_mean(W(:,1)) - im_mean(W(:,2)) ).^2)/(size(W,1));
    weights = repmat(lambda*exp(-1*(( im_mean(W(:,1)) - im_mean(W(:,2)) ).^2)/(2*sigma)),2,1);
    W = cat(1, horz_edges, vert_edges, fliplr(horz_edges), fliplr(vert_edges));
    [labels,~,eng_finish] = solveMinCut(reshape(D_bg, 1, []), reshape(D_fg, 1, []), cat(2, W, weights));
    segm = reshape(labels, rows, cols);

        