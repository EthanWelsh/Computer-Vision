function visualizeEdges(edges)

    height = max(edges(:, 1));
    width = max(edges(:, 2));
    
    disp = zeros(height, width, 'double');
    
    [edges_count, ~] = size(edges);
    
    for n = (1:edges_count)
        row = edges(n, 1);
        col = edges(n, 2);

        disp(row, col) = 1;
        
        
    end
   
imshow(disp);
    
end