function [means] = getBOW(training_data)

    descriptors = [];
    
    for i = (1 : length(training_data))

        img = imread(training_data(i).path);
        
        if size(img, 3) == 3
            img = rgb2gray(img);
        end
        
        img = single(img);
        [~, img_descriptors] = vl_sift(img);

        descriptors = [descriptors img_descriptors];
    end
    
    [~, means, ~] = kmeansML(100, double(descriptors));
    
end

