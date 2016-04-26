function MAIN_doSearchLightCrossValFolds_Ht2_NewT2013_subproc(subnum)
% get params 
prms = get_and_set_params();
% load data / file naming / saving 
datadir = prms.datafold;
fn = sprintf(prms.matprefix,subnum);
load(fullfile(datadir,fn));
params_ori = params; 
params = prms; 
fnTosave = sprintf('results_FFX_ND_norm_%d-shuf_SLsize-%d_anlyssmode-%s_sub_-%.3d_',...
                    params.numShuffels,params.regionSize,params.analysismode,subnum);
[~,subpn] = fileparts(datadir);
resultsdir = fullfile('..','results',subpn); 
resultsDirName = fullfile(resultsdir,sprintf('results_FFX_ND_norm_%d-shuf_SLsize-%d-anylssMd-%s',...
                            params.numShuffels,params.regionSize,params.analysismode));
mkdir(resultsDirName);
% pre compute values 
start = tic;
idx = knnsearch(locations, locations, 'K', params.regionSize); % find searchlight neighbours 
shufMatrix = createShuffMatrixFFX(data,params);

%% loop on all voxels in the brain to create T map
for i = 1:(params.numShuffels + 1) % loop on shuffels 
    %don't shuffle first itiration
    if i ==1 % don't shuffle data
        labelsuse = labels;
    else % shuffle data
        labelsuse = labels(shufMatrix(:,i-1));
    end
    idxX = find(labelsuse==1);
	idxY = find(labelsuse==2);
    for j=1:size(idx,1) % loop on voxels 
        dataX = data(idxX,idx(j,:));
        dataY = data(idxY,idx(j,:));
        [ansMat(j,i,:) ] = calcTstatMuniMengTwoGroup(dataX,dataY);
    end
    timeVec(i) = toc(start); reportProgress(fnTosave,i,params, timeVec);
end
fnOut = [fnTosave datestr(clock,30) '_.mat'];
save(fullfile(resultsDirName,fnOut));
msgtitle = sprintf('Finished sub %.3d ',subnum);
end
