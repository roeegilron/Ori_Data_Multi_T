function compute_second_level(settings,params)

for j = 1:length(settings.experconds) % loop on experiment
    % find folders of results analysis within reuslts
    resfolders = findFilesBVQX(...
        fullfile(settings.resfold,settings.experconds{j}),...
        ['*' settings.experconds{j} '*'],...
        struct('dirs',1,'maxdepth',1));
    for m = 1:length(resfolders)
        rawmtres = findFilesBVQX(...
            resfolders{m},...
            [settings.resfileprefix '*.mat'],...
            struct('maxdepth',1));
    [pn,fn] = fileparts(rawmtres{1});
    tmp = regexp(fn,'SL[0-9]+','match');
    slsize = str2num(tmp{1}(3:end));
    fold = 1;
    computeFFXresults(settings.subsToUse,...
        fold,...
        settings.computeStzler,...
        pn,...
        pn,...
        params.numstlzermap,...
        slsize,...
        settings,...
        params)
    end
end


end