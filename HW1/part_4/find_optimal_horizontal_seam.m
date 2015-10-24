function horizontalSeam = find_optimal_horizontal_seam(M)
    
    [height, width] = size(M);
    
    horizontalSeam = zeros(1, width);
        
    last_col = M(:, width);
    [~, min_index] = min(last_col);
    row = min_index;
    points = [[-1, -1];[0, -1];[1, -1];];

    horizontalSeam(1) = row;

    path_index = 2;

    for c = width - 1:-1:1

       smallest = flintmax;

        % Look at the three pixels on top of that pixel
        for i = 1:3                
            point_r = row + points(i, 1);
            point_c = c + points(i, 2);

            % A select the smallest of these three values
            if ~(point_r < 1 || point_r > height || point_c < 1 || point_c > width)   
                if M(point_r, point_c) < smallest
                    smallest = M(point_r, point_c);
                    row = point_r;
                end
            end     
        end  
        horizontalSeam(path_index) = row;
        path_index = path_index + 1;
    end
end
