function [settings, params] = getparams()
%% settings 
settings.datadir         = fullfile('..','data','zscored'); 
settings.experconds      = {'ActivePassiveLH','ActivePassiveRH'}; 
settings.resfold         = fullfile('..','results_zscored'); 
settings.resfileprefix   = 'mt_results';
settings.datafileprefix  = 'ssub';
settings.behavdatafold   = 'behavdata';
settings.figfold         = 'figres_zscored';
settings.subsToUse       = 2:18;%[3000:3004 3006:3007 3011];
settings.incomsubsflag   = 0; 
settings.computeStzler   = 0; % use stelzer perms or not 
settings.seclevelprefix  = 'ND_FFX_';
settings.nameOfTempVMP   = 'blank_vmp_tal_3x3res.vmp';
%% params 
params.numstlzermap      = 2e3;
params.avgmode           = 'mean'; 
params.slsize            = 1; 

end