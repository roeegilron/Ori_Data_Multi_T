function [dataout, labelsout] = doCrossVal(data,labels)
switch params.crossVal
    case 'none' % non has only train data 
        dataout.train = data; 
        dataout.labels = labels; 
    case '2fold'
        cvo = cvpartition(labels,'Kfold',2);
        dataout.train   = get_train_data(data,cvo);
        labelsout.train = get_train_labels(labels,cvo);
        dataout.test    = get_test_data(data,cvo);
        labelsout.test  = get_test_labels(labels,cvo);
end