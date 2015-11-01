function [centers] = detectCircles(im, edges, radius, top_k)

[edge_count, ~] = size(edges);

quant_value = 2;

[height, width] = size(im);
height = ceil(height/quant_value);
width = ceil(width/quant_value);


h = zeros(height, width);

for n = (1:edge_count)
    
    row = edges(n, 1);
    col = edges(n, 2);
    degree = edges(n, 4);
    
    a = abs(ceil(col - radius * cosd(degree))) + 1;
    b = abs(ceil(row - radius * sind(degree))) + 1;
        
    a = ceil(a / quant_value);
    b = ceil(b / quant_value);
        
    h(a, b) = h(a, b) + 1;
    
end

h = imgaussfilt(h);

[~, sortIndex] = sort(h(:), 'descend');
maxIndex = sortIndex(1:top_k);

centers = [];
[R,C] = ind2sub(size(h), maxIndex);

for i = (1:top_k)
    centers(i, 1) = R(i) * quant_value;
    centers(i, 2) = C(i) * quant_value;
end

figure; imshow(im); viscircles(centers, radius * ones(size(centers, 1), 1));

end