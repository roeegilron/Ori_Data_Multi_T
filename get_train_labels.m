function labelsuse = get_train_labels(labels,cvo,itir); 
train_lbls = labels(cvo.training(1)); 
%don't shuffle first itiration
if itir ==1 % don't shuffle data
    labelsuse = train_lbls;
else % shuffle data
    labelsuse = train_lbls(randperm(length(train_lbls)));
end
end