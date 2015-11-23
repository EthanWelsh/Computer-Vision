function [labels] = findLabelsSVM(pyramids_train, pyramids_test, labels_train)
    
    train = [];
   
    training_labels = [];
    
    for i = (1 : length(pyramids_train))
        train = [train; pyramids_train{i}(:)'];
        training_labels = [training_labels; labels_train{i}];
    end
    
    model = fitcecoc(train, training_labels);
    labels = {};
    
    for i = (1 : length(pyramids_test))
        labels{i} = predict(model, pyramids_test{i}(:)');
    end
end