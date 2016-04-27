function params = get_and_set_params()
% This code gets and sets number of shuffels / sl size 
% params to use 
params.numShuffels   = 100;
params.regionSize    = 9;
params.analysismode  = 'svm'; % 'svm','multi-t'
params.crossVal      = '2fold'; % none, 'half','4' 

% run parallel
params.runSequential = false;

% data locations 
params.datafold      = fullfile('..','data','ActivePassiveLH'); 
params.matprefix     = 'ssubj%d_ForServer_n.mat' ;
params.substorun     = 2:18; 

% second level 
params.numMaps2ndlvl = 1e3; % stelzer maps 
params.avgType       = 'mean'; % 'mean' or 'median' (to avg maps across sub' voxelwise
params 
end