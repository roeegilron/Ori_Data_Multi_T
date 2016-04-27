function compare2ndlevel()
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
secondlevelresultsfolder = analysisfolder;
secondlevelresultsfolder = fullfile(analysisfolder,'2nd_level');

ff = findFilesBVQX(secondlevelresultsfolder,'*.mat',struct('depth',1)); 
for i = 1:length(ff)
    [~,fn] = fileparts(ff{i}); 
    load(ff{i}); 
%     avgAnsMat = ansMat;
    fprintf('%s:\n',fn);
    fprintf('first row:\n'); 
    fprintf('\t %f ',avgAnsMat(1,1:10));
    fprintf('\n');
    fprintf('first column:\n'); 
    fprintf('\t %f ',avgAnsMat(1:10,1));
    fprintf('\n \t');
    pval = calcPvalVoxelWise(avgAnsMat);
    sigfdr = fdr_bh(pval,0.05,'pdep','yes');
    fprintf('\n');
    fprintf('\n');
end
end