function run_multi_t_non_directional()
%% Run T2013 - Non directioanl multivariate T-test.
% This function will run a non-directional T-test on all subjects in the
% data set.
% for details re how this analysis is run see paper at XXXX
% output of the function is stored in the results folder.
% these results are later computed into group level .nii maps using
% function XXX
% Further note:
% This function was written such that it runs each subject on one core in
% parallel on a server. Set the flag for 'runSequential' = true if you do not
% wish to run in parallel.
%% first level 
runSequential = false;

substorun = 2:18; 
startmatlab = 'matlabr2015a -nodisplay -nojvm -r '; % matlab version used to run in parallel
for i = 1:length(substorun)
    if runSequential
        subnum = substorun(i);
        runprogram  = sprintf('"run MAIN_doSearchLightCrossValFolds_Ht2_NewT2013_subproc(%d); exit;" ',subnum);
        pause(0.1);
        unix([startmatlab  runprogram ' &'])
    else
        MAIN_doSearchLightCrossValFolds_Ht2_NewT2013_subproc(substorun(i));
    end
end


end