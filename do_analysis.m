function analysis_res = do_analysis(data,labels,params,sphrindxs,itir);

switch %
    case 'multi-t'
        if itir = 1 
        else 
        end
        dataX = data(idxX,idx(j,:));
        dataY = data(idxY,idx(j,:));
        [ansMat(j,i,:) ] = calcTstatMuniMengTwoGroup(dataX,dataY);
        
    case 'svm'
end
end
