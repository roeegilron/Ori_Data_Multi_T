function params = get_and_set_params()
% This code gets and sets number of shuffels / sl size 
% params to use (first level) 
params.numShuffels   = 100;
params.regionSize    = 27;
params.analysismode  = 'multi-t'; % 'svm','multi-t'
params.crossVal      = 'none'; % none, '2fold'

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