function params = get_and_set_params()
% This code gets and sets number of shuffels / sl size 
% params to use 
params.numShuffels   = 3;
params.regionSize    = 4;
params.analysismode  = 'multi-t'; % 'svm','multit'
params.crossVal      = 'none'; % none, 'half','4' 

% data locations 
params.datafold      = fullfile('..','data','ActivePassiveLH'); 
params.matprefix     = 'ssubj%d_ForServer_n.mat' ;

% second level 
params.numMaps2ndlvl = 1e2; % stelzer maps 

params 
end