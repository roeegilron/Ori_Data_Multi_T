function MAIN_compute_non_directional_second_level()
% This function computes second levele results 
% get params 
params = get_and_set_params();
% load data / file naming / saving 
datadir = params.datafold;

results_dir = fullfile('..','results');
ffldrs = findFilesBVQX(results_dir,'results_*',...
    struct('dirs',1));
fprintf('The following results folders were found:\n'); 
for i = 1:length(ffldrs)
    [pn,fn] = fileparts(ffldrs{i});
    fprintf('[%d]\t%s\n',i,fn);
end
fprintf('enter number of results folder to compute second level on\n'); 
foldernum = input('what num? ');
analysisfolder = ffldrs{foldernum}; 
secondlevelresultsfolder = fullfile(analysisfolder,'2nd_level');
mkdir(secondlevelresultsfolder); 

computeFFXresults(secondlevelresultsfolder,params)
end
