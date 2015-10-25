function [inds] = matchRawDescriptors(d1, d2)

    [feature_count_d1, ~] = size(d1);
    [feature_count_d2, ~] = size(d2);
       
    distances = [];
    inds = [];
    
    threshold = 0;
    inds_index = 1;
    
    for i = (1:feature_count_d2)
        
        distances(i, 1) = 1;
        distances(i, 2) = intmax;
        
        for j = (1:feature_count_d1)
            distance = distSqr(d1(j), d2(i));
            
            if distance == 0
                distances(i, 1) = j;
                distances(i, 2) = distance;
                break;
            elseif distance < distances(i, 2)
                distances(i, 1) = j;
                distances(i, 2) = distance;
            end
        end
        
        if distances(i, 2) <= threshold
            inds(inds_index, :) = d1(distances(i, 1), :);
            inds_index = inds_index + 1;
        end
        
        
    end
    
    return
    
end