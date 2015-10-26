function [inds] = matchRawDescriptors(d1, d2)

    [feature_count_d1, ~] = size(d1);
    
    for i = (1: feature_count_d1)
        feat1_vector = d1(i, :);
        distances = dist2(feat1_vector, d2);
        [~, index] = min(distances, [], 2);
        inds(i) = index;
    end
    
    return
    
end