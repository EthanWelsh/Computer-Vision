function [ histogram ] = getHistogram(descriptors, means)

    descriptors = double(descriptors');
    
    [vocab_size, ~] = size(means);
    
    distance_matrix = dist2(descriptors, means);
    histogram = zeros(vocab_size, 1);
    
    for i = (1:size(distance_matrix,1))
        mindex = find(distance_matrix(i,:) == min(distance_matrix(i,:)));
        histogram(mindex) = histogram(mindex) + 1;
    end
end

