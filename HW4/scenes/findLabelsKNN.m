function [labels] = findLabelsKNN(pyramids_train, pyramids_test, labels_train, k)
    
    labels = {};

    for i = (1 : length(pyramids_test))
        
        distances = zeros(length(pyramids_train), 2);
        
        for j = (1 : length(pyramids_train))
            dist = dist2(pyramids_test{i}(:)', pyramids_train{j}(:)');
            distances(j, 1) = dist;
            distances(j, 2) = labels_train{j};
        end
        
        nearest = sortrows(distances, 1);
        labels{i} = mode(nearest(1:k, 2));
       
    end
    
end