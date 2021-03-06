function sigMapWithNeighbors = sigfdrwithneighbors(sigfdr,locations,slsize)
if sum(sigfdr)<=0 % nothing is signitficance
    sigMapWithNeighbors = sigfdr;
else
    % this function computes the neighbours and adds them to the map;
    sigMapWithNeighbors = double(sigfdr)';
    idx = knnsearch(locations,locations,'k',slsize);
    idxNonZeroVals = find(sigfdr > 0);
    rawNeibourIdxs = idx(idxNonZeroVals,:);
    rawNeibourIdxs = unique(rawNeibourIdxs(:)) ; % vectorize and get unq
    neghibourIdxs = setdiff(rawNeibourIdxs,idxNonZeroVals);
    sigMapWithNeighbors(neghibourIdxs) = 0.2; % set neibhbour indexes to 0.2
end
end