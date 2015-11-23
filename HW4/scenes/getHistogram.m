function [ histogram ] = getHistogram(descriptors, means)

    [vocab_size, ~] = size(means);
    histogram = zeros(vocab_size, 1);
    
    if size(descriptors) ~= [0 0]
        descriptors = double(descriptors');    
        distance_matrix = dist2(descriptors, means);
    
        for i = (1:size(distance_matrix,1))
            mindex = find(distance_matrix(i,:) == min(distance_matrix(i,:)));
            histogram(mindex) = histogram(mindex) + 1;
        end
        
    end
end

