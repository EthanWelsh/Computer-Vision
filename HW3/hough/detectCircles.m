function [centers] = detectCircles(im, edges, radius, top_k)

[edge_count, ~] = size(edges);

h = zeros(size(im));

for n = (1:edge_count)
    
    row = edges(n, 1);
    col = edges(n, 2);
    
    for degree = (1:360)
        a = abs(ceil(col - radius * cosd(degree))) + 1;
        b = abs(ceil(row - radius * sind(degree))) + 1;
        h(a, b) = h(a, b) + 1;
    end
end

h = imgaussfilt(h);

[~, sortIndex] = sort(h(:), 'descend');
maxIndex = sortIndex(1:top_k);

centers = [];
[R,C] = ind2sub(size(h), maxIndex);

for i = (1:top_k)
    
    centers(i, 1) = R(i);
    centers(i, 2) = C(i);
end

figure; imshow(im); viscircles(centers, radius * ones(size(centers, 1), 1));

end