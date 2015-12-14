function [models] = train_attribute_models()
    
    if exist('train_data.mat', 'file') == 0
        
        M = load('predicate-matrix-binary.txt');

        [train_classes] = textread('trainclasses.txt', '%s');
        animal_folders = dir('decaf');

        [~, overall_classes] = textread('classes.txt', '%u %s');

        attributes = [];
        features = [];

        for i = (1: length(train_classes))
            animal_string = train_classes{i};
            animal_index = ismember(overall_classes, animal_string);

            example_files = dir(['decaf/' animal_string]);

            animal_string
            
            indecies = randperm(length(example_files), 30);

            for j = (1 : length(indecies))
                example = example_files(indecies(j));

                if ~example.isdir
                    feature = textread(['decaf/' animal_string '/' example.name], '%f');
                    features = [features; feature'];

                    attributes = [attributes; M(animal_index, :)];
                end
            end    
        end 
        save('train_data.mat', 'attributes', 'features');
    else
        load('train_data.mat', 'attributes', 'features');
    end
    
    models = {};

    [~, number_of_attributes] = size(attributes);    
        
    for i = (1 : number_of_attributes)
        model = fitcsvm(features, attributes(:, i));
        models{i} = fitSVMPosterior(model);
    end
end

