function [probs_class] = compute_class_probs(models)
    
    [test_classes] = textread('testclasses.txt', '%s');
    [~, overall_classes] = textread('classes.txt', '%u %s');
    M = load('predicate-matrix-binary.txt');
    
    animals = {};
    features = [];
    
    for i = (1: length(test_classes))
        animal_string = test_classes{i};
        example_files = dir(['decaf/' animal_string]);

        indecies = randperm(length(example_files), 30);

        for j = (1 : length(indecies))
            example = example_files(indecies(j));

            if ~example.isdir
                feature = textread(['decaf/' animal_string '/' example.name], '%f');
                features = [features; feature'];
                animals{length(animals) + 1} = animal_string;
                
            end
        end    
    end
    
    if exist('test_probs.mat', 'file') == 0
        probs_attr = compute_attribute_probs(models, features);
        save('test_probs.mat', 'probs_attr');
    else
        load('test_probs.mat', 'probs_attr');
    end
           
    class_n = length(test_classes);
   
    [img_n, ~] = size(features);
    
    [~, feat_n] = size(M);
    
    probs_class = [];
    
    % For every image randomly selected from the test set
    for i = (1 : img_n)
        
        % Look at every class
        for j = (1 : class_n)
            p = 1;  
            
            % Find the animal's index in the overall dataset
            animal_index = find(ismember(overall_classes, test_classes{j}));

            % And check every feature
            for k = (1 : feat_n)
                
                if M(animal_index, k) == 1
                    p = p * probs_attr(k, i);
                else
                    p = p * (1 - probs_attr(k, i));
                end
            end
            probs_class(j, i) = p;
        end
        
    end
    
    acc = compute_accuracy(probs_class, animals)
     
end

