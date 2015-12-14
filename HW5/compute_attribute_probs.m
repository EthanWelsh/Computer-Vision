function [probs_attr] = compute_attribute_probs(models, feats)

    %the j-th attribute is present in the l-th image
    
    probs_attr = zeros(length(models), length(feats)); 
    size(probs_attr)
    
    [feat_len, ~] = size(feats);
   
    for i = (1 : feat_len)
        fprintf('%d: \t%f\n',i, (i/feat_len) * 100);
      
        img = feats(i, :);
        
        for j = (1 : length(models))
            [~, scores] = predict(models{j}, img);
            probs_attr(j, i) = scores(2);
        end
    end
    
    size(probs_attr)



end

