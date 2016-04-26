function [data, labels] = doCrossVal(data,labels);
cvo = cvpartition(labels,'Kfold',2);
data.train   = get_train_data(data,cvo);
labels.train = get_train_labels(labels,cvo,i);
data.test    = get_test_data(data,cvo);
labels.test  = get_test_labels(labels,cvo);
end