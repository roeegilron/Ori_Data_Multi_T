function computeFFXresults(ffxResFold,params)
numMaps = params.numMaps2ndlvl; 

cnt = 1;
%% extract results from each subject
[firstlevelfold,~] = fileparts(ffxResFold);
firslevelfiles = findFilesBVQX(firstlevelfold,'*.mat',struct('depth',1));
for i = 1:length(firslevelfiles)
    start = tic;
    load(firslevelfiles{1})
    if exist('map','var') % hack for Ori data; 
        mask = map;
    end
    fprintf('B = sub %d has %d nans\n',i,sum(isnan(median(ansMat,2))))
    modeuse = 'equal-min'; % modes to deal with zeros also 'equal-zero', 'equal-min' and 'weight'
    ansMat = squeeze(ansMat(:,:,1)); % first val is multi t 2013
    fixedAnsMat = fixAnsMat(ansMat,locations,modeuse); % fix ansMat for zeros
    ansMatOut(:,:,cnt) = fixedAnsMat;
    cnt = cnt + 1;
    fprintf('A = sub %d has %d nans\n\n',i,sum(isnan(median(fixedAnsMat,2))))
end
% find out how many shufs you have
numshufs = size(ansMatOut,2)-1;


%% compute the MSCM maps
params = get_and_set_params();
[avgAnsMat,stlzerPermsAnsMat] = createStelzerPermutations(ansMatOut,numMaps,params.avgType);
clear ansMat;

%% save the file
numsubs = size(ansMatOut,3);
fnTosave = sprintf(...
    'ND_FFX_VDS_%d-subs_%d-slsze_%d-shufs_%d-stlzer_anlssmode-%s_avgtype-%s.mat',...
    numsubs,...
    params.regionSize,...
    numshufs,...
    numMaps,...
    params.analysismode,...
    params.avgType);
save(fullfile(ffxResFold,fnTosave),...
    'avgAnsMat','locations',...
    'stlzerPermsAnsMat',...
    'mask','fnTosave','params');

end
