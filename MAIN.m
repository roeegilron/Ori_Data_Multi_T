function MAIN()
%% calc and display stuff related to ori data analysis 
%% add path to code base 
p = genpath(pwd);
addpath(p); 
%% run multi t non directional new version (split sample + SVM) 
run_multi_t_non_directional() % first level 

%% run second level 
MAIN_compute_non_directional_second_level() % second level 


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