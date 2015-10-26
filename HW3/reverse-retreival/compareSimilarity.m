function [sim] = compareSimilarity(bow1, bow2)
    vocab_size = size(bow1);
    
    top = 0.0;
    left = 0.0;
    right = 0.0;
    
    for i = (1:vocab_size)
        top = top + (bow1(i) * bow2(i));
        left = left + (bow1(i)^2);
        right = right + (bow2(i)^2);
    end
    
    left = sqrt(left);
    right = sqrt(right);
    bottom = left*right;
    
    sim = max(0, top/bottom);
    
    return 
end