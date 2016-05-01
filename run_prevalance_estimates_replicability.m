function run_prevalance_estimates_replicability()
% needs neureolf: 
p = genpath('D:\Roee_Main_Folder\1_AnalysisFiles\Poldrack_RFX\toolboxes\NE_5153'); 
addpath(p); 

analysisfolder = choose_results_folder(); 
allPvals = agregate_pvalues_from_results_folder(analysisfolder);
% get real values second level 
ff = findFilesBVQX(analysisfolder,'ND*.mat');
load(ff{1},'avgAnsMat','mask','locations');
realvals = avgAnsMat(:,1); 
% plotpvals of each subject 
figure;cnt =1;
for i = 1:size(allPvals,2)
    subplot(4,5,cnt); cnt = cnt + 1; 
    histogram(allPvals(:,i));
end
% allPvals = allPvals(:,randSubs);
uval = 0.85; 

n = size(allPvals,2); 
u = floor(uval *n);
df = 2 * (n-u+1);

% sum of pvals. 
Ps = [];
for i = 1:size(allPvals,1)
    pvals = allPvals(i,:);
    sortpvals = sort(pvals);
    upvals = sortpvals(u:end);
    upvalslog = log(upvals) * (-2);
    sumus = sum(upvalslog);
    Ps(i) = chi2cdf(sumus,df,'upper');
end
sigfdr = fdr_bh(Ps,0.05,'pdep','yes');
%% plot vmp 
mapcnt = 1; 
rawvmp = get_raw_vmp();
tosavevmp = rawvmp;
% plot real values vmp 
dataFromAnsMatBackIn3d = scoringToMatrix(mask,avgAnsMat(:,1),locations);
mapfn = 'real values'; 
tosavevmp = addmapTovmp(tosavevmp,rawvmp,dataFromAnsMatBackIn3d,mapfn,mapcnt);
% plot values that pass ruti u/v analysis 
mapcnt = 2; 
dataFromAnsMatBackIn3d = scoringToMatrix(mask,sigfdr',locations);
mapfn = sprintf('ruti analyssis u = %f',uval); 
tosavevmp = addmapTovmp(tosavevmp,rawvmp,dataFromAnsMatBackIn3d,mapfn,mapcnt);

tosavevmp.SaveAs(fullfile(analysisfolder,'outvmp.vmp'));
end