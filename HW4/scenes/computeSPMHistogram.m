function [pyramid] = computeSPMHistogram(im, codebook_centers)
    
    [height, width] = size(im);

    means = codebook_centers';
    [frames, descriptors] = vl_sift(single(im));
        
    level_0 = getHistogram(descriptors, means);
    
    q1_descriptors = [];
    q2_descriptors = [];
    q3_descriptors = [];
    q4_descriptors = [];
    
    for i = (1 : length(frames))
        x = (frames(1, i)/width) * 100.00;
        y = (frames(2, i)/height) * 100.00;
        
        if x <= 50 && y <= 50
            q1_descriptors = [q1_descriptors descriptors(:, i)];
        elseif x > 50 && y <= 50
            q2_descriptors = [q2_descriptors descriptors(:, i)];
        elseif x <= 50 && y > 50
            q3_descriptors = [q3_descriptors descriptors(:, i)];
        elseif x > 50 && y > 50
            q4_descriptors = [q4_descriptors descriptors(:, i)];
        end
    end
        
    level_1 = [getHistogram(q1_descriptors, means) getHistogram(q2_descriptors, means) getHistogram(q3_descriptors, means) getHistogram(q4_descriptors, means)];
    
    size(level_0)
    size(level_1)
    
    pyramid = [level_0 level_1];
    size(pyramid)
   
end