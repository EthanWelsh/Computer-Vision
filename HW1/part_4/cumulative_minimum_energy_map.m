function [M] = cumulative_minimum_energy_map(energyImage, seamDirection)
    [height, width] = size(energyImage);
    
    M = double(0);
    M(height, width) = M;
              
    energyImage(isnan(energyImage)) = 0;
     
    if strcmp(seamDirection, 'VERTICAL')
    
        points = [[-1, -1];[-1, 0 ];[-1, 1];];
        
        % For every pixel in the image
        for r = 2:height
            for c = 1:width        

                smallest = width*height;

                % Look at the three pixels on top of that pixel
                for i = 1:3                
                    point_r = r + points(i, 1);
                    point_c = c + points(i, 2);

                    % A select the smallest of these three values
                    if ~(point_r < 1 || point_r > height || point_c < 1 || point_c > width)   
                        smallest = min([smallest, M(point_r, point_c)]);
                    end                

                end

                % Set this pixel's seam energy to the smallest pixel on top of
                % it, plus its own energy value.
                M(r, c) = smallest + energyImage(r, c);
            end
        end
    end
	if strcmp(seamDirection, 'HORIZONTAL')
        
        points = [[-1, -1];[0, -1];[1, -1];];
        
        % For every pixel in the image
        for c = 2:width
            for r = 1:height        

                smallest = width*height;

                % Look at the three pixels on top of that pixel
                for i = 1:3                
                    point_r = r + points(i, 1);
                    point_c = c + points(i, 2);

                    % A select the smallest of these three values
                    if ~(point_r < 1 || point_r > height || point_c < 1 || point_c > width)   
                        smallest = min([smallest, M(point_r, point_c)]);
                    end                

                end

                % Set this pixel's seam energy to the smallest pixel on top of
                % it, plus its own energy value.
                M(r, c) = smallest + energyImage(r, c);
            end
        end
    end
   
    %figure;
    %subplot(2, 1, 1);
    %imshow(energyImage);
    %subplot(2, 1, 2);
    
    %M = uint8(mat2gray(M) * 255);
    %imagesc(M)
    return
    
end
