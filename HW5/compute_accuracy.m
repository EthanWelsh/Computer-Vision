function [acc] = compute_accuracy(probs_class, ground_truth_class)

    [~, overall_classes] = textread('classes.txt', '%u %s');
    [test_classes] = textread('testclasses.txt', '%s');
    
    [~, n_imgs] = size(probs_class);
    
    hits = 0;
    
    for i = (1 : n_imgs)
        
        [~, max_class] =  max(probs_class(:, i));
        predicted_label = overall_classes(ismember(overall_classes, test_classes{max_class}));
        
        if strcmp(ground_truth_class(i), predicted_label)
            hits = hits + 1;
        end
    end

    acc = (hits/n_imgs) * 100;
     
end

