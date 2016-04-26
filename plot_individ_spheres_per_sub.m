function plot_individ_spheres_per_sub(settings,params)
numranspheres = 10; 
rng(10); 
randsphers = 32234; 
%randsphers = randperm(52503,numranspheres); 
numshufs = 50; 
spheredir = 'sphers_for_jonathan_z_scored';
spherdirwrite = 'spheres';
figdir = 'figures'; 
for j = 1:length(randsphers)%:length(settings.experconds) % loop on experiment 
    start = tic;
    rawbetafn = findFilesBVQX(...
        fullfile(settings.datadir,...
        settings.experconds{1}),...
        [settings.datafileprefix '*.mat'],...
        struct('maxdepth',1));
    rng(j); % set seed 
    hfig = figure('Visible','off'); 
    hfig.Position = [-1919         281        1920        1083]; 
    for k = 1:length(rawbetafn) % loop on subjects 
        load(rawbetafn{k});
        idx = knnsearch(locations, locations, 'K', 27); % neighbours
        sphreidx = randsphers(j); 
        sphere = data(:,idx(sphreidx ,:));
        for m = 1:numshufs
            if m == 1 
                labelsuse = labels;
            else
                rng(m*k); 
                labelsuse = labels(randperm(length(labels))); 
            end
        x = sphere(labelsuse==1,:); y = sphere(labelsuse==2,:); 
        tmp = calcTstatMuniMengTwoGroup(x,y); 
        ansmat(m) = tmp(1); 
        end
        seclevel(k,:) = ansmat; 
        [pn, fn] = fileparts(rawbetafn{k});
        tmp1 = regexp(fn,'[0-9]+','match'); subnum = str2num(tmp1{1}); 
        spherename = sprintf('sub_%.3d_sphere_%d_tval_%.2f.txt',...
            subnum,randsphers(j),ansmat(1));
        spherefolder = fullfile(settings.resfold,spheredir,spherdirwrite); 
        csvwrite(fullfile(spherefolder,spherename),[labels, sphere]);
        subplot(4,5,k);hold on;
        histogram(ansmat(2:end));
        scatter(ansmat(1),0,100,'r','filled');
        xlabel('tval (2013)'); 
        ylabel('count'); 
        title(strrep(spherename(1:end-4),'_',' '),'FontSize',11); 
        set(gca,'FontSize',10);
    end
    spherefigfolder = fullfile(settings.resfold,spheredir,figdir); 
    hfigname = sprintf('individ_sub_sphere_%d.pdf',randsphers(j));
    printFigToPDFa4(hfig,fullfile(spherefigfolder,hfigname));
    
    realvals = mean(seclevel(:,1));
    % loop on second level to randomize 
    seclevelshuf = seclevel(:,2:end);
    for i = 1:size(seclevelshuf,1);
        idxs = randperm(size(seclevelshuf,2));
        shufsseclevel(:,i) = seclevelshuf(i,idxs);
    end
    % plot second levle 
    hfig = figure('Visible','off');hold on;
    histogram(shufsseclevel);
    scatter(realvals(1),0,100,'r','filled');
    xlabel('tval (2013)');
    ylabel('count');
    hfigname = sprintf('sec_level_sphere_%d.pdf',randsphers(j));
    figtitle = sprintf('sec level sphere %d', randsphers(j));
    title(strrep(figtitle,'_',' '),'FontSize',8);
    printFigToPDFa4(hfig,fullfile(spherefigfolder,hfigname));
    fprintf('sphere %d done in %f\n',randsphers(j),toc(start));
end


end