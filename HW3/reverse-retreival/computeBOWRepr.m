function [bow] = computeBOWRepr(descriptors, means)
    
    [~, vocab_size] = size(means);
    [descriptor_count, ~] = size(descriptors);
    
    bow = zeros(vocab_size, 1);
    
    % For every descriptor...
    for i = (1:descriptor_count)    
        descriptor = descriptors(i, :);
    
        min_distance = intmax;
        min_word_index = 1;
        
        % Look at every word...
        for j = (1:vocab_size)
            word = means(:, j)';
            
            % and find the word that has the minimum distance to the given
            % descriptor...
            distance_to_word = dist2(descriptor, word);     
            if distance_to_word < min_distance
                min_distance = distance_to_word;
                min_word_index = j;
            end
        end
        
        bow(min_word_index) = bow(min_word_index) + 1;
    end 
end

