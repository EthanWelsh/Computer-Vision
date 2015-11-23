function [labels] = findLabelsSVM(pyramids_train, pyramids_test, labels_train)
    
    train = [];
   
    for i = (1 : length(pyramids_train))
        train = [train; pyramids_train{i}(:)'];
    end
    
    model = fitcecoc(train, labels_train);
    labels = {};
    
    for i = (1 : length(pyramids_test))
        labels{i} = predict(model, pyramids_test{i}(:)');
    end
end