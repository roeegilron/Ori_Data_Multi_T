function [dataout, labelsout] = doCrossVal(data,labels)
cvo = cvpartition(labels,'Kfold',2);
dataout.train   = get_train_data(data,cvo);
labelsout.train = get_train_labels(labels,cvo);
dataout.test    = get_test_data(data,cvo);
labelsout.test  = get_test_labels(labels,cvo);
end