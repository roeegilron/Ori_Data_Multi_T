function MAIN()
%% calc and display stuff related to ori data analysis 
%% add path to code base 
p = genpath('D:\Roee_Main_Folder\1_AnalysisFiles\Poldrack_RFX\'); 
addpath(p); 
%% get setttings params 
[settings, params] = getparams();

%% plot individal subject raw beta values 
plot_raw_beta_vals_per_sub(settings,params); 

%% plot individual subjects pval 
plot_individ_pvals_per_sub(settings,params); 

%% compute stelzer perms (perhaps excluding some subjects (second level) 
compute_second_level(settings,params); 

%% create vmps of results second level 
create_vmp_from_second_level_files(settings,params); 

%% plot second level pvalues 
plot_pvals_from_all_second_level_tests(settings,params);

%% plot and save some spheres for Jonathan from each subject 
plot_individ_spheres_per_sub(settings,params); 


end