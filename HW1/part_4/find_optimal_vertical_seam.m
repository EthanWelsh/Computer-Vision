function verticalSeam = find_optimal_vertical_seam(M)
    
    [height, width] = size(M);
    verticalSeam = zeros(1, height);

    last_row = M(height, :);
    [~, min_index] = min(last_row);
    col = min_index;
    points = [[-1, -1];[-1, 0 ];[-1, 1];];
    
    verticalSeam(1) = col;
    path_index = 2;

    for r = height - 1:-1:1
       smallest = flintmax;

        % Look at the three pixels on top of that pixel
        for i = 1:3                
            point_r = r + points(i, 1);
            point_c = col + points(i, 2);

            % A select the smallest of these three values
            if ~(point_r < 1 || point_r > height || point_c < 1 || point_c > width)   
                if M(point_r, point_c) < smallest
                    smallest = M(point_r, point_c);
                    col = point_c;
                end
            end     
        end  
        verticalSeam(path_index) = col;
        path_index = path_index + 1;
    end
end

