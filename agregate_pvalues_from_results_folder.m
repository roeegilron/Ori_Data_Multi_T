function allpvals  = agregate_pvalues_from_results_folder(analysisfolder)
ff = findFilesBVQX(analysisfolder,'mt*.mat',struct('depth',1));
for i = 1:length(ff)
    load(ff{i},'ansMat');
    if ndims(ansMat) == 3 
        ansMat = squeeze(ansMat(:,:,1));
    end
    pval = calcPvalVoxelWise(ansMat);
    allpvals(:,i) = pval;
end
end