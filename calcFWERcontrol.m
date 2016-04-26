function [sigfwer, sigbonf,  clustdata] = calcFWERcontrol(avgAnsMat,mask,locations)
srealt = avgAnsMat(:,1);
srealt = sort(srealt);
cutofft = srealt(floor((length(srealt)*0.97)));
allclustsize = [];
for i = 1:size(avgAnsMat,2)
    dataFromAnsMatBackIn3d = scoringToMatrix(mask,avgAnsMat(:,i),locations);
    if i == 1 % real data 
        [rvals,rinstances,rrp] = getAllCc(dataFromAnsMatBackIn3d>cutofft,6,size(avgAnsMat,1));
    else % shuffle data
        if sum(dataFromAnsMatBackIn3d(:)>cutofft) > 0
            [vals,instances,rp] = getAllCc(dataFromAnsMatBackIn3d>cutofft,6,size(avgAnsMat,1));
        else
            vals = 0; instances = 1;
        end
        maxsizes(i-1) = max(vals); 
        clustsizes = [];
        for j = 1:size(vals,1)
            clustsizes = [clustsizes; repmat(vals(j),instances(j),1)];
        end
        allclustsize = [allclustsize ; clustsizes]; 
    end
    fprintf('map %d done \n',i);
end
%% fwer control 
sortedmaxsizes = sort(maxsizes);
cutoffmaxclusisze = sortedmaxsizes(floor((length(sortedmaxsizes)*0.95)));
idxsclusters =  find(rvals>=cutoffmaxclusisze); 
raw_idxspass_lnr_idxs = [];
for i = 1:length(rrp)
    if rrp(i).Area > cutoffmaxclusisze
        tmp = rrp(i).PixelIdxList;
        raw_idxspass_lnr_idxs = [tmp; raw_idxspass_lnr_idxs ];
    end
end
zerossig3d = zeros(size(dataFromAnsMatBackIn3d)); 
zerossig3d(unique(raw_idxspass_lnr_idxs)) = 1; 

%%% finish computing conforoni with cluster sizer property [rvals,rinstances,rrp
sigfwer  = reverseScoringToMatrix1rowAnsMat(zerossig3d,locations);
% xxxx finish work 

%% bonforoni control 
% XXXX finish work 
sigbonf = [] ;
%% export clust data 
dataFromAnsMatBackIn3d = scoringToMatrix(mask,avgAnsMat(:,1),locations);
clustdata.rvals = rvals;
clustdata.rinstances = rinstances;
clustdata.rrp = rrp;
clustdata.maxsizes = maxsizes;
clustdata.allclustsize = allclustsize;
clustdata.realdata = avgAnsMat(:,1);
clustdata.realdata3d = dataFromAnsMatBackIn3d;



end