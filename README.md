How to run Mult-T data for data we prepare for servers - simple searchlight 
==============

Requiremens: 
--------------
Data: 
- .mat file for each subject named in consistent pattern. 
- Each .mat file has matrices: data (trials x voxels), labels (1/2), map 

Startup: 
--------------
- Create 3 directories: code, data, results. Put git code under directory named 'code'. 

Settings params: 
--------------
- see: get_and_set_params.m
- not the 'run_sequential' flag. If true - it lets you run in parallel on servers. 

Running 
--------------
- first level: run_multi_t_non_directional.m
- MAIN_compute_non_directional_second_level.m % second level 

