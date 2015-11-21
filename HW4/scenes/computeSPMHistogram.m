function [pyramid] = computeSPMHistogram(im, codebook_centers)
    
    means = codebook_centers';
    [frames, descriptors] = vl_sift(single(im));
    histogram = getHistogram(descriptors, means);

    length(frames)
    length(descriptors)
    
    q1_descriptors = [];
    q2_descriptors = [];
    q3_descriptors = [];
    q4_descriptors = [];
    
    %frames
    %size(frames)
    %length(frames)
    
    
    for i = (1 : length(frames))
        x = frames(1, i);
        y = frames(2, i);
        
        if x <= 50 && y <= 50
            q1_descriptors = [q1_descriptors; descriptors(i)];
        elseif x > 50 && y <= 50
            q2_descriptors = [q2_descriptors; descriptors(i)];
        elseif x <= 50 && y > 50
            q3_descriptors = [q3_descriptors; descriptors(i)];
        elseif x > 50 && y > 50
            q4_descriptors = [q4_descriptors; descriptors(i)];
        end
    end
    
    size(q1)
    size(q2)
    size(q3)
    size(q4)
    
    pyramid = [];
   


end