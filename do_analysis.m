function analysis_res = do_analysis(data,labels,params,sphrindxs,itir)

if strcomp(params.crossVal,'none') % no crosee val you only have train, no test 
    if itir == 1 % don't shuffle train
        dataX = data.train(labels.train==1,sphrindxs);
        dataY = data.train(labels.train==2,sphrindxs);
    else % always shuffle test for multi-t
        labelsuse = labels.train;
        labelsuse = labelsuse(randperm(length(labelsuse)));
        dataX = data.train(labelsuse==1,sphrindxs);
        dataY = data.train(labelsuse==2,sphrindxs);
    end
else % do cross validatio n
    switch params.analysismode
        case 'multi-t'
            if itir == 1 % don't shuffle train
                dataX = data.train(labels.train==1,sphrindxs);
                dataY = data.train(labels.train==2,sphrindxs);
            else % always shuffle test for multi-t
                labelsuse = labels.test;
                labelsuse = labelsuse(randperm(length(labelsuse)));
                dataX = data.test(labelsuse==1,sphrindxs);
                dataY = data.test(labelsuse==2,sphrindxs);
            end
            analysis_res = calcTstatMuniMengTwoGroup(dataX,dataY);
        case 'svm'
            if itir == 1 % don't shuffle first itir
                labelsuse = labels.train;
            else
                labelsuse = labels.train;
                labelsuse = labelsuse(randperm(length(labelsuse)));
            end
            model = svmtrainwrapper(labelsuse,data.train(:,sphrindxs));
            [predicted_label, acc, third] = ...
                svmpredictwrapper(labels.test, data.test(:,sphrindxs), model);
            analysis_res = acc(1)/100;
    end
end

end
